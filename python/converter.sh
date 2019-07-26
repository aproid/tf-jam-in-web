#!/usr/bin/env bash

source ~/tensorflowjs/bin/activate

tensorflowjs_converter --input_format=tf_saved_model --output_format=tfjs_graph_model 'saved_model' 'converted_model'