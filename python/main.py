import os
import shutil
import numpy as np
import pandas as pd
import tensorflow as tf

tf.enable_resource_variables()

data = pd.read_csv("tfjam.csv", sep=",")
x_data = data['dist'].values / 100
y_data = data['power'].values

W = tf.Variable(tf.random_uniform([1], 0.0, 1.0))
b = tf.Variable(tf.random_uniform([1], 0.0, 1.0))

X = tf.placeholder(tf.float32)
Y = tf.placeholder(tf.float32)

hypothesis = W * X + b;

cost = tf.reduce_mean(tf.square(hypothesis - Y))
optimizer = tf.train.GradientDescentOptimizer(0.1)
train = optimizer.minimize(cost)

with tf.Session() as sess:
	sess.run(tf.global_variables_initializer())
	
	for step in range(1000):
		sess.run(train, feed_dict={X: x_data, Y: y_data})
	
	if os.path.isdir("saved_model"):
		shutil.rmtree('saved_model')
	
	tf.saved_model.simple_save(sess, 'saved_model', inputs={"X": X}, outputs={"Result": hypothesis})