// 'console.log == dd' Shortcut
window.dd = console.log.bind(console);

// Cannon.js Collision Group Constants
const COLLISION_GROUP1 = 1;
const COLLISION_GROUP2 = 2;
const COLLISION_GROUP3 = 4;

// Three.js Renderer Size Constants
const RENDER_WIDTH = 800;
const RENDER_HEIGHT = 600;

// Cannon.js Variables
var world;

// Three.js Variables
var balls = [];

// Tensorflow.js Variables
var tfController;
var tfData = [];

// Define Element Variables
var $container = document.getElementById('CONTAINER');
var $info = document.getElementById('INFO');

// Define Counters
var totalCnt = 0;
var goalCnt = 0;

// Initalize Modules
(async () => {
	await initTensorflow();
	initCannon();
	initThree();
})();

// Initalize Tensorflow
async function initTensorflow() {
	const model = await tf.loadGraphModel('python/converted_model/model.json');
	
	async function predict(dist) {
		var iTensor = tf.tensor([dist / 100]);
		var oTensor = model.predict(iTensor);
		
		var output = await oTensor.data();
		
		return Array.from(output).pop();
	}
	
	tfController = {predict};
}

// Initalize Cannon.js
function initCannon() {
	world = new CANNON.World();
	world.quatNormalizeSkip = 0;
	world.quatNormalizeFast = false;
	world.defaultContactMaterial.contactEquationStiffness = 1e7;
	world.defaultContactMaterial.contactEquationRelaxation = 5;
	world.broadphase = new CANNON.NaiveBroadphase();
	world.gravity.set(0,-20,0);
	
	var solver = new CANNON.GSSolver();
	solver.iterations = 50;
	solver.tolerance = 0;
	world.solver = new CANNON.SplitSolver(solver);
	
	var physicsMaterial = new CANNON.Material('slipperyMaterial');
	var physicsContactMaterial = new CANNON.ContactMaterial(physicsMaterial, physicsMaterial, 0.0, 0.3);
	world.addContactMaterial(physicsContactMaterial);
	
	var groundShape = new CANNON.Plane(0);
	var groundBody = new CANNON.Body({ mass: 0 });
	groundBody.addShape(groundShape);
	groundBody.collisionFilterGroup = COLLISION_GROUP1 | COLLISION_GROUP2;
	groundBody.quaternion.setFromAxisAngle(new CANNON.Vec3(1, 0, 0), -Math.PI / 2);
	world.add(groundBody);
}

// Initalize Three.js
function initThree() {
	var camera = new THREE.PerspectiveCamera(60, RENDER_WIDTH / RENDER_HEIGHT, 0.01, 1000);
	camera.position.set(0, 30, 80);
	
	var scene = new THREE.Scene();
	
	var ambient = new THREE.AmbientLight(0xFFFFFF);
	scene.add(ambient);
	
	var directionalLight = new THREE.DirectionalLight(0xFFFFFF, 0.2);
	directionalLight.position.set(-50, 100, 100);
	directionalLight.castShadow = true;
	directionalLight.shadow.mapSize.width = 1024;
	directionalLight.shadow.mapSize.height = 1024;
	directionalLight.shadow.camera = new THREE.OrthographicCamera(-100, 100, 100, -100, 0.5, 1000);
	scene.add(directionalLight);
	
	var planeGeometry = new THREE.PlaneGeometry(200, 200);
	var planeMaterial = new THREE.MeshLambertMaterial({color: 0xE0E4CC, side: THREE.FrontSide});
	var planeMesh = new THREE.Mesh(planeGeometry, planeMaterial);
	planeMesh.rotation.x = -Math.PI / 2;
	planeMesh.castShadow = true;
	planeMesh.receiveShadow = true;
	scene.add(planeMesh);
	
	var boxHalfExtents = new CANNON.Vec3(2, 4, 2);
	var boxShape = new CANNON.Box(boxHalfExtents);
	var boxBody = new CANNON.Body({ mass: 0 });
	var boxGeometry = new THREE.BoxGeometry(boxHalfExtents.x * 2, boxHalfExtents.y * 2, boxHalfExtents.z * 2);
	var boxMaterial = new THREE.MeshLambertMaterial({color: 0xFA6900});
	var boxMesh = new THREE.Mesh(boxGeometry, boxMaterial);
	boxBody.position.set(0, boxHalfExtents.y, 0);
	boxMesh.position.set(0, boxHalfExtents.y, 0);
	boxBody.addShape(boxShape);
	boxMesh.castShadow = true;
	boxMesh.receiveShadow = true;
	world.add(boxBody);
	scene.add(boxMesh);
	
	var basket = createBasket();
	
	var renderer = new THREE.WebGLRenderer({antialias: true, alpha: true});
	renderer.domElement.id = 'RENDER';
	renderer.shadowMap.enabled = true;
	renderer.shadowMap.type = THREE.PCFSoftShadowMap;
	renderer.shadowMap.renderSingleSided = false;
	renderer.setSize(RENDER_WIDTH, RENDER_HEIGHT);
	$container.appendChild(renderer.domElement);
	
	var pt = 0, ct = 0;
	var dt = 1/30;
	
	animate();
	
	window.exportResult = exportResult;
	
	function animate(t) {
		requestAnimationFrame(animate);
		
		world.step(dt);
		
		boxMesh.position.copy(boxBody.position);
		boxMesh.quaternion.copy(boxBody.quaternion);
		
		basket.mesh.position.copy(basket.body.position);
		basket.mesh.quaternion.copy(basket.body.quaternion);
		
		ct = Math.floor(t / 100);
		
		if(ct > pt) {
			pt = ct;
			
			boxBody.position.x = (Math.random() * 40) - 20;
			
			shootBall(boxMesh.position, basket.mesh.position);
		}
		
		for(var i in balls) {
			const [body, mesh] = balls[i];
			
			// Simple Continuous Collision Detection(CCD)
			if(body.isBall) {
				var velocity = body.velocity.clone().mult(dt);
				var current = body.position;
				var next = body.position.clone().vadd(velocity);
				
				var ray = new CANNON.Ray(current, next);
				ray._updateDirection();
				ray.checkCollisionResponse = false;
				ray.collisionFilterMask = COLLISION_GROUP3;
				ray.intersectBody(basket.body);
				
				if(!ray.result.hasHit) {
					ray.collisionFilterMask = -1;
					
					for(var i in basket.triggers) {
						ray.result.reset();
						ray.intersectBody(basket.triggers[i]);
						
						if(ray.result.hasHit) {
							collideBall(body, ray.result.body.triggerName);
						}
					}
				}
			}
			
			body.position.z = 0;
			mesh.position.copy(body.position);
			mesh.quaternion.copy(body.quaternion);
			mesh.material.color.setHex(body.isBall ? 0xF38630 : 0xA8DBA8);
		}
		
		renderer.render(scene, camera);
	}
	
	function createBasket() {
		var btmSize = new CANNON.Vec3(.35, 15, .35);
		var backSize = new CANNON.Vec3(.35, 5, 6);
		var sRingSize = new CANNON.Vec3(2, .7, .35);
		var fRingSize = new CANNON.Vec3(.35, .7, 2);
		
		var backTranslate = new CANNON.Vec3(0, btmSize.y + backSize.y, 0);
		var lRingTranslate = new CANNON.Vec3(-sRingSize.x, btmSize.y + backSize.y / 1.5, fRingSize.z);
		var rRingTranslate = new CANNON.Vec3(-sRingSize.x, btmSize.y + backSize.y / 1.5, -fRingSize.z);
		var fRingTranslate = new CANNON.Vec3(-sRingSize.x * 2, btmSize.y + backSize.y / 1.5, 0);
		
		var btmShape = new CANNON.Box(btmSize);
		var backShape = new CANNON.Box(backSize);
		var sRingShape = new CANNON.Box(sRingSize);
		var fRingShape = new CANNON.Box(fRingSize);
		sRingShape.collisionFilterGroup = COLLISION_GROUP1 | COLLISION_GROUP2 | COLLISION_GROUP3;
		fRingShape.collisionFilterGroup = COLLISION_GROUP1 | COLLISION_GROUP2 | COLLISION_GROUP3;
		
		var basketBody = new CANNON.Body({mass: 0});
		basketBody.addShape(btmShape);
		basketBody.addShape(backShape, backTranslate);
		basketBody.addShape(sRingShape, lRingTranslate);
		basketBody.addShape(sRingShape, rRingTranslate);
		basketBody.addShape(fRingShape, fRingTranslate);
		basketBody.collisionFilterGroup = COLLISION_GROUP1 | COLLISION_GROUP2;
		
		var triggerShape = new CANNON.Box(new CANNON.Vec3(sRingSize.x - .35, .35, fRingSize.z - .35));
		var topTriggerTranslate = new CANNON.Vec3(-sRingSize.x, fRingTranslate.y + .35, 0);
		var btmTriggerTranslate = new CANNON.Vec3(-sRingSize.x, fRingTranslate.y - .7, 0);
		
		var topTriggerBody = new CANNON.Body({mass: 0});
		topTriggerBody.addShape(triggerShape, topTriggerTranslate);
		topTriggerBody.collisionResponse = 0;
		topTriggerBody.triggerName = 'rimTop';
		topTriggerBody.position = basketBody.position;
		topTriggerBody.collisionFilterGroup = COLLISION_GROUP2;
		topTriggerBody.addEventListener('collide', collideEvent, false);
		
		var btmTriggerBody = new CANNON.Body({mass: 0});
		btmTriggerBody.addShape(triggerShape, btmTriggerTranslate);
		btmTriggerBody.collisionResponse = 0;
		btmTriggerBody.triggerName = 'rimBtm';
		btmTriggerBody.position = basketBody.position;
		btmTriggerBody.collisionFilterGroup = COLLISION_GROUP2;
		btmTriggerBody.addEventListener('collide', collideEvent, false);
		
		world.add(basketBody);
		world.add(topTriggerBody);
		world.add(btmTriggerBody);
		
		var btmGeometry = new THREE.BoxGeometry(btmSize.x * 2, btmSize.y * 2, btmSize.z * 2);
		var backGeometry = new THREE.BoxGeometry(backSize.x * 2, backSize.y * 2, backSize.z * 2);
		var sRingGeometry = new THREE.BoxGeometry(sRingSize.x * 2, sRingSize.y * 2, sRingSize.z * 2);
		var fRingGeometry = new THREE.BoxGeometry(fRingSize.x * 2, fRingSize.y * 2, fRingSize.z * 2);
		backGeometry.translate(backTranslate.x, backTranslate.y, backTranslate.z);
		sRingGeometry.translate(lRingTranslate.x, lRingTranslate.y, lRingTranslate.z);
		fRingGeometry.translate(fRingTranslate.x, fRingTranslate.y, fRingTranslate.z);
		
		var ringMatrix = new THREE.Matrix4().makeTranslation(0, 0, -lRingTranslate.z * 2);
		
		var basketGeometry = new THREE.Geometry();
		basketGeometry.merge(btmGeometry);
		basketGeometry.merge(backGeometry);
		basketGeometry.merge(sRingGeometry);
		basketGeometry.merge(sRingGeometry, ringMatrix);
		basketGeometry.merge(fRingGeometry);
		
		var basketMaterial = new THREE.MeshLambertMaterial({color: 0x3B8686});
		
		var basketMesh = new THREE.Mesh(basketGeometry, basketMaterial);
		basketMesh.castShadow = true;
		basketMesh.receiveShadow = true;
		basketMesh.position.set(50, 0, 0);
		basketBody.position.set(50, 0, 0);
		
		scene.add(basketMesh);
		
		return {
			body: basketBody,
			geometry: basketGeometry,
			material: basketMaterial,
			mesh: basketMesh,
			triggers: [topTriggerBody, btmTriggerBody]
		}
	}
	
	async function shootBall(originPosition, targetPosition) {
		var radius = 1.5;
		var arch = 0.5;
		var dist = originPosition.distanceTo(targetPosition);
		var closeness = Math.min(10, dist) / 10;
		var dir = new THREE.Vector3().copy(targetPosition);
		dir.sub(originPosition);
		dir.normalize();
		
		var force = await tfController.predict(dist);
		
		var shape = new CANNON.Sphere(radius);
		var body = new CANNON.Body({mass: 1});
		body.addShape(shape);
		body.collisionFilterMask = COLLISION_GROUP2;
		body.position.set(originPosition.x, 10, originPosition.z);
		body.velocity.set(dir.x * arch * closeness, force, dir.z * arch * closeness);
		body.velocity.scale(40, body.velocity);
		body._position = new CANNON.Vec3().copy(body.position);
		body._velocity = new CANNON.Vec3().copy(body.velocity);
		body._force = force;
		body._dist = dist;
		body.isBall = true;
		
		world.add(body);
		
		var geometry = new THREE.SphereGeometry(radius, 32, 32);
		var material = new THREE.MeshLambertMaterial({color: 0xF38630});
		var mesh = new THREE.Mesh(geometry, material);
		mesh.castShadow = true;
		mesh.receiveShadow = true;
		
		scene.add(mesh);
		
		var id = balls.push([body, mesh]) - 1;
		
		setTimeout(function() {
			var [body, mesh] = balls[id];
			
			world.remove(body);
			scene.remove(mesh);
			
			if(body.isBall) {
				totalCnt++;
			}
				
			updateInfo();
			
			delete balls[id];
		}, 5000);
	}
	
	function collideEvent(e) {
		collideBall(e.body, this.triggerName);
	}
	
	function collideBall(body, type) {
		if(body.isBall) {
			if(type === 'rimTop') {
				body.isPassedTop = true;
			} else if(body.isPassedTop) {
				body.isBall = false;
				body.isPassedTop = false;
				
				tfData.push([
					body._velocity.y / 40,
					body._dist
				]);
				
				totalCnt++;
				goalCnt++;
				
				updateInfo();
			}
		}
	}
	
	function exportResult(offset=0) {
		var result = ['id', 'power', 'dist'].join(',') + '\n';
		
		result += tfData.map((cur, idx) => {
			return (offset + idx) + ',' + cur.join(',') + '\n';
		}).join('');
		
		console.info(result);
	}
	
	function updateInfo() {
		var ratio = goalCnt / totalCnt;
		var rounded = Math.round(ratio * 10000) / 100;
		
		$info.innerText = rounded + '%';
	}
}