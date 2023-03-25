python -m onnxruntime.tools.convert_onnx_models_to_ort %1 --enable_type_reduction || exit /b
del /s /f /q .\model
mkdir .\model
python -m bin2c -o ./model/model.ort model.ort
