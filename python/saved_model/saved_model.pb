иа
нБ
:
Add
x"T
y"T
z"T"
Ttype:
2	
B
AssignVariableOp
resource
value"dtype"
dtypetypeИ
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
8
Const
output"dtype"
valuetensor"
dtypetype
S
DynamicStitch
indices*N
data"T*N
merged"T"
Nint(0"	
Ttype
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
?
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
9
FloorMod
x"T
y"T
z"T"
Ttype:

2	
.
Identity

input"T
output"T"	
Ttype
;
Maximum
x"T
y"T
z"T"
Ttype:

2	Р
Н
Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(И
=
Mul
x"T
y"T
z"T"
Ttype:
2	Р
.
Neg
x"T
y"T"
Ttype:

2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
Н
Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	И
a
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:	
2	
)
Rank

input"T

output"	
Ttype
@
ReadVariableOp
resource
value"dtype"
dtypetypeИ
>
RealDiv
x"T
y"T
z"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
}
ResourceApplyGradientDescent
var

alpha"T

delta"T" 
Ttype:
2	"
use_lockingbool( И
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0И
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
O
Size

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
1
Square
x"T
y"T"
Ttype:

2	
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	
М
Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshapeИ
9
VarIsInitializedOp
resource
is_initialized
И"serve*1.13.12b'v1.13.1-0-g6612da8951'ЩВ
^
random_uniform/shapeConst*
valueB:*
dtype0*
_output_shapes
:
W
random_uniform/minConst*
valueB
 *    *
dtype0*
_output_shapes
: 
W
random_uniform/maxConst*
valueB
 *  А?*
dtype0*
_output_shapes
: 
О
random_uniform/RandomUniformRandomUniformrandom_uniform/shape*
_output_shapes
:*
seed2 *

seed *
T0*
dtype0
b
random_uniform/subSubrandom_uniform/maxrandom_uniform/min*
T0*
_output_shapes
: 
p
random_uniform/mulMulrandom_uniform/RandomUniformrandom_uniform/sub*
_output_shapes
:*
T0
b
random_uniformAddrandom_uniform/mulrandom_uniform/min*
_output_shapes
:*
T0
Ц
VariableVarHandleOp*
shared_name
Variable*
_class
loc:@Variable*
	container *
shape:*
dtype0*
_output_shapes
: 
a
)Variable/IsInitialized/VarIsInitializedOpVarIsInitializedOpVariable*
_output_shapes
: 
g
Variable/AssignAssignVariableOpVariablerandom_uniform*
_class
loc:@Variable*
dtype0
~
Variable/Read/ReadVariableOpReadVariableOpVariable*
_output_shapes
:*
_class
loc:@Variable*
dtype0
`
random_uniform_1/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Y
random_uniform_1/minConst*
dtype0*
_output_shapes
: *
valueB
 *    
Y
random_uniform_1/maxConst*
valueB
 *  А?*
dtype0*
_output_shapes
: 
Т
random_uniform_1/RandomUniformRandomUniformrandom_uniform_1/shape*
T0*
dtype0*
_output_shapes
:*
seed2 *

seed 
h
random_uniform_1/subSubrandom_uniform_1/maxrandom_uniform_1/min*
T0*
_output_shapes
: 
v
random_uniform_1/mulMulrandom_uniform_1/RandomUniformrandom_uniform_1/sub*
_output_shapes
:*
T0
h
random_uniform_1Addrandom_uniform_1/mulrandom_uniform_1/min*
_output_shapes
:*
T0
Ь

Variable_1VarHandleOp*
dtype0*
_output_shapes
: *
shared_name
Variable_1*
_class
loc:@Variable_1*
	container *
shape:
e
+Variable_1/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_1*
_output_shapes
: 
o
Variable_1/AssignAssignVariableOp
Variable_1random_uniform_1*
_class
loc:@Variable_1*
dtype0
Д
Variable_1/Read/ReadVariableOpReadVariableOp
Variable_1*
_class
loc:@Variable_1*
dtype0*
_output_shapes
:
P
PlaceholderPlaceholder*
dtype0*
_output_shapes
:*
shape:
R
Placeholder_1Placeholder*
dtype0*
_output_shapes
:*
shape:
S
ReadVariableOpReadVariableOpVariable*
dtype0*
_output_shapes
:
J
mulMulReadVariableOpPlaceholder*
T0*
_output_shapes
:
Y
add/ReadVariableOpReadVariableOp
Variable_1*
dtype0*
_output_shapes
:
F
addAddmuladd/ReadVariableOp*
_output_shapes
:*
T0
A
subSubaddPlaceholder_1*
_output_shapes
:*
T0
8
SquareSquaresub*
T0*
_output_shapes
:
5
RankRankSquare*
T0*
_output_shapes
: 
M
range/startConst*
_output_shapes
: *
value	B : *
dtype0
M
range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
_
rangeRangerange/startRankrange/delta*#
_output_shapes
:         *

Tidx0
Y
MeanMeanSquarerange*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
X
gradients/grad_ys_0Const*
_output_shapes
: *
valueB
 *  А?*
dtype0
o
gradients/FillFillgradients/Shapegradients/grad_ys_0*
T0*

index_type0*
_output_shapes
: 
h
gradients/Mean_grad/ShapeShapeSquare*#
_output_shapes
:         *
T0*
out_type0
Ъ
gradients/Mean_grad/SizeSizegradients/Mean_grad/Shape*
T0*
out_type0*,
_class"
 loc:@gradients/Mean_grad/Shape*
_output_shapes
: 
Ы
gradients/Mean_grad/addAddrangegradients/Mean_grad/Size*
T0*,
_class"
 loc:@gradients/Mean_grad/Shape*#
_output_shapes
:         
▓
gradients/Mean_grad/modFloorModgradients/Mean_grad/addgradients/Mean_grad/Size*
T0*,
_class"
 loc:@gradients/Mean_grad/Shape*#
_output_shapes
:         
а
gradients/Mean_grad/Shape_1Shapegradients/Mean_grad/mod*
_output_shapes
:*
T0*
out_type0*,
_class"
 loc:@gradients/Mean_grad/Shape
П
gradients/Mean_grad/range/startConst*
_output_shapes
: *
value	B : *,
_class"
 loc:@gradients/Mean_grad/Shape*
dtype0
П
gradients/Mean_grad/range/deltaConst*
_output_shapes
: *
value	B :*,
_class"
 loc:@gradients/Mean_grad/Shape*
dtype0
▌
gradients/Mean_grad/rangeRangegradients/Mean_grad/range/startgradients/Mean_grad/Sizegradients/Mean_grad/range/delta*,
_class"
 loc:@gradients/Mean_grad/Shape*#
_output_shapes
:         *

Tidx0
О
gradients/Mean_grad/Fill/valueConst*
value	B :*,
_class"
 loc:@gradients/Mean_grad/Shape*
dtype0*
_output_shapes
: 
╦
gradients/Mean_grad/FillFillgradients/Mean_grad/Shape_1gradients/Mean_grad/Fill/value*
T0*

index_type0*,
_class"
 loc:@gradients/Mean_grad/Shape*#
_output_shapes
:         
А
!gradients/Mean_grad/DynamicStitchDynamicStitchgradients/Mean_grad/rangegradients/Mean_grad/modgradients/Mean_grad/Shapegradients/Mean_grad/Fill*
T0*,
_class"
 loc:@gradients/Mean_grad/Shape*
N*#
_output_shapes
:         
Н
gradients/Mean_grad/Maximum/yConst*
value	B :*,
_class"
 loc:@gradients/Mean_grad/Shape*
dtype0*
_output_shapes
: 
─
gradients/Mean_grad/MaximumMaximum!gradients/Mean_grad/DynamicStitchgradients/Mean_grad/Maximum/y*,
_class"
 loc:@gradients/Mean_grad/Shape*#
_output_shapes
:         *
T0
╝
gradients/Mean_grad/floordivFloorDivgradients/Mean_grad/Shapegradients/Mean_grad/Maximum*
T0*,
_class"
 loc:@gradients/Mean_grad/Shape*#
_output_shapes
:         
К
gradients/Mean_grad/ReshapeReshapegradients/Fill!gradients/Mean_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
Р
gradients/Mean_grad/TileTilegradients/Mean_grad/Reshapegradients/Mean_grad/floordiv*

Tmultiples0*
T0*
_output_shapes
:
j
gradients/Mean_grad/Shape_2ShapeSquare*
T0*
out_type0*#
_output_shapes
:         
^
gradients/Mean_grad/Shape_3Const*
valueB *
dtype0*
_output_shapes
: 
c
gradients/Mean_grad/ConstConst*
valueB: *
dtype0*
_output_shapes
:
Ц
gradients/Mean_grad/ProdProdgradients/Mean_grad/Shape_2gradients/Mean_grad/Const*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
e
gradients/Mean_grad/Const_1Const*
dtype0*
_output_shapes
:*
valueB: 
Ъ
gradients/Mean_grad/Prod_1Prodgradients/Mean_grad/Shape_3gradients/Mean_grad/Const_1*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
a
gradients/Mean_grad/Maximum_1/yConst*
_output_shapes
: *
value	B :*
dtype0
Ж
gradients/Mean_grad/Maximum_1Maximumgradients/Mean_grad/Prod_1gradients/Mean_grad/Maximum_1/y*
T0*
_output_shapes
: 
Д
gradients/Mean_grad/floordiv_1FloorDivgradients/Mean_grad/Prodgradients/Mean_grad/Maximum_1*
T0*
_output_shapes
: 
А
gradients/Mean_grad/CastCastgradients/Mean_grad/floordiv_1*

SrcT0*
Truncate( *
_output_shapes
: *

DstT0
}
gradients/Mean_grad/truedivRealDivgradients/Mean_grad/Tilegradients/Mean_grad/Cast*
_output_shapes
:*
T0
~
gradients/Square_grad/ConstConst^gradients/Mean_grad/truediv*
valueB
 *   @*
dtype0*
_output_shapes
: 
e
gradients/Square_grad/MulMulsubgradients/Square_grad/Const*
T0*
_output_shapes
:
}
gradients/Square_grad/Mul_1Mulgradients/Mean_grad/truedivgradients/Square_grad/Mul*
_output_shapes
:*
T0
d
gradients/sub_grad/ShapeShapeadd*
T0*
out_type0*#
_output_shapes
:         
p
gradients/sub_grad/Shape_1ShapePlaceholder_1*
T0*
out_type0*#
_output_shapes
:         
┤
(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*2
_output_shapes 
:         :         *
T0
д
gradients/sub_grad/SumSumgradients/Square_grad/Mul_1(gradients/sub_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*
	keep_dims( *

Tidx0
И
gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*
_output_shapes
:*
T0*
Tshape0
и
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Z
gradients/sub_grad/NegNeggradients/sub_grad/Sum_1*
T0*
_output_shapes
:
М
gradients/sub_grad/Reshape_1Reshapegradients/sub_grad/Neggradients/sub_grad/Shape_1*
_output_shapes
:*
T0*
Tshape0
g
#gradients/sub_grad/tuple/group_depsNoOp^gradients/sub_grad/Reshape^gradients/sub_grad/Reshape_1
╦
+gradients/sub_grad/tuple/control_dependencyIdentitygradients/sub_grad/Reshape$^gradients/sub_grad/tuple/group_deps*
_output_shapes
:*
T0*-
_class#
!loc:@gradients/sub_grad/Reshape
╤
-gradients/sub_grad/tuple/control_dependency_1Identitygradients/sub_grad/Reshape_1$^gradients/sub_grad/tuple/group_deps*/
_class%
#!loc:@gradients/sub_grad/Reshape_1*
_output_shapes
:*
T0
d
gradients/add_grad/ShapeShapemul*
T0*
out_type0*#
_output_shapes
:         
d
gradients/add_grad/Shape_1Const*
valueB:*
dtype0*
_output_shapes
:
┤
(gradients/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_grad/Shapegradients/add_grad/Shape_1*
T0*2
_output_shapes 
:         :         
┤
gradients/add_grad/SumSum+gradients/sub_grad/tuple/control_dependency(gradients/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
И
gradients/add_grad/ReshapeReshapegradients/add_grad/Sumgradients/add_grad/Shape*
_output_shapes
:*
T0*
Tshape0
╕
gradients/add_grad/Sum_1Sum+gradients/sub_grad/tuple/control_dependency*gradients/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Р
gradients/add_grad/Reshape_1Reshapegradients/add_grad/Sum_1gradients/add_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:
g
#gradients/add_grad/tuple/group_depsNoOp^gradients/add_grad/Reshape^gradients/add_grad/Reshape_1
╦
+gradients/add_grad/tuple/control_dependencyIdentitygradients/add_grad/Reshape$^gradients/add_grad/tuple/group_deps*-
_class#
!loc:@gradients/add_grad/Reshape*
_output_shapes
:*
T0
╙
-gradients/add_grad/tuple/control_dependency_1Identitygradients/add_grad/Reshape_1$^gradients/add_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_grad/Reshape_1*
_output_shapes
:
b
gradients/mul_grad/ShapeConst*
valueB:*
dtype0*
_output_shapes
:
n
gradients/mul_grad/Shape_1ShapePlaceholder*
T0*
out_type0*#
_output_shapes
:         
┤
(gradients/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_grad/Shapegradients/mul_grad/Shape_1*
T0*2
_output_shapes 
:         :         
z
gradients/mul_grad/MulMul+gradients/add_grad/tuple/control_dependencyPlaceholder*
T0*
_output_shapes
:
Я
gradients/mul_grad/SumSumgradients/mul_grad/Mul(gradients/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
К
gradients/mul_grad/ReshapeReshapegradients/mul_grad/Sumgradients/mul_grad/Shape*
T0*
Tshape0*
_output_shapes
:

gradients/mul_grad/Mul_1MulReadVariableOp+gradients/add_grad/tuple/control_dependency*
_output_shapes
:*
T0
е
gradients/mul_grad/Sum_1Sumgradients/mul_grad/Mul_1*gradients/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
О
gradients/mul_grad/Reshape_1Reshapegradients/mul_grad/Sum_1gradients/mul_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:
g
#gradients/mul_grad/tuple/group_depsNoOp^gradients/mul_grad/Reshape^gradients/mul_grad/Reshape_1
═
+gradients/mul_grad/tuple/control_dependencyIdentitygradients/mul_grad/Reshape$^gradients/mul_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/mul_grad/Reshape*
_output_shapes
:
╤
-gradients/mul_grad/tuple/control_dependency_1Identitygradients/mul_grad/Reshape_1$^gradients/mul_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/mul_grad/Reshape_1*
_output_shapes
:
b
GradientDescent/learning_rateConst*
valueB
 *═╠╠=*
dtype0*
_output_shapes
: 
ы
<GradientDescent/update_Variable/ResourceApplyGradientDescentResourceApplyGradientDescentVariableGradientDescent/learning_rate+gradients/mul_grad/tuple/control_dependency*
_class
loc:@Variable*
use_locking( *
T0
є
>GradientDescent/update_Variable_1/ResourceApplyGradientDescentResourceApplyGradientDescent
Variable_1GradientDescent/learning_rate-gradients/add_grad/tuple/control_dependency_1*
use_locking( *
T0*
_class
loc:@Variable_1
Ч
GradientDescentNoOp=^GradientDescent/update_Variable/ResourceApplyGradientDescent?^GradientDescent/update_Variable_1/ResourceApplyGradientDescent
2
initNoOp^Variable/Assign^Variable_1/Assign
Y
save/filename/inputConst*
_output_shapes
: *
valueB Bmodel*
dtype0
n
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
_output_shapes
: *
shape: 
e

save/ConstPlaceholderWithDefaultsave/filename*
_output_shapes
: *
shape: *
dtype0
Д
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_5bce483b50bd4093bb9992d4b94c08f6/part*
dtype0*
_output_shapes
: 
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
\
save/ShardedFilename/shardConst*
_output_shapes
: *
value	B : *
dtype0
}
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards*
_output_shapes
: 
u
save/SaveV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
g
save/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:
│
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesVariable/Read/ReadVariableOpVariable_1/Read/ReadVariableOp*
dtypes
2
С
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2*
_output_shapes
: *
T0*'
_class
loc:@save/ShardedFilename
Э
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency*
T0*

axis *
N*
_output_shapes
:
}
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const*
delete_old_dirs(
z
save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency*
T0*
_output_shapes
: 
x
save/RestoreV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
j
save/RestoreV2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueBB B 
Х
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
_output_shapes

::*
dtypes
2
N
save/Identity_1Identitysave/RestoreV2*
T0*
_output_shapes
:
Q
save/AssignVariableOpAssignVariableOpVariablesave/Identity_1*
dtype0
P
save/Identity_2Identitysave/RestoreV2:1*
_output_shapes
:*
T0
U
save/AssignVariableOp_1AssignVariableOp
Variable_1save/Identity_2*
dtype0
L
save/restore_shardNoOp^save/AssignVariableOp^save/AssignVariableOp_1
-
save/restore_allNoOp^save/restore_shard "<
save/Const:0save/Identity:0save/restore_all (5 @F8"═
trainable_variables╡▓
S

Variable:0Variable/AssignVariable/Read/ReadVariableOp:0(2random_uniform:08
[
Variable_1:0Variable_1/Assign Variable_1/Read/ReadVariableOp:0(2random_uniform_1:08"
train_op

GradientDescent"├
	variables╡▓
S

Variable:0Variable/AssignVariable/Read/ReadVariableOp:0(2random_uniform:08
[
Variable_1:0Variable_1/Assign Variable_1/Read/ReadVariableOp:0(2random_uniform_1:08*d
serving_defaultQ

X
Placeholder:0
Result
add:0tensorflow/serving/predict