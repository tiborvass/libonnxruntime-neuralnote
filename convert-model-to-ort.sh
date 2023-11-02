#!/usr/bin/env bash

#python -m tf2onnx.convert --saved-model model --output model.onnx --opset 13
python -m onnxruntime.tools.convert_onnx_models_to_ort $1 --enable_type_reduction
rm -rf ./model/
mkdir -p ./model
# python verify_model.py
python -m bin2c -o ./model/model.ort model.ort || bin2c > ./model/model.ort < model.ort
