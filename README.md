# ONNX Runtime static library builder for NeuralNote

This is a fork of [https://github.com/olilarkin/ort-builder](https://github.com/olilarkin/ort-builder#readme) specialized for [NeuralNote](https://github.com/DamRsn/NeuralNote).

For a general purpose static library builder please go to the upstream repo.

## Instructions to build ONNX Runtime static library for NeuralNote

1. Create a [virtual environment](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) `$ python3 -m venv venv`

2. Activate it `$ source ./venv/bin/activate` for Mac or `.\venv\Scripts\activate.bat` for Windows.

3. Install dependencies `$ pip install -r requirements.txt`

4. For Mac or Linux, run `./convert-model-to-ort.sh model.onnx`. For Windows, run `.\convert-model-to-ort.bat model.onnx`

5. Run `./build-mac.sh model.required_operators_and_types.with_runtime_opt.config` on Mac or `.\build-win.bat model.required_operators_and_types.with_runtime_opt.config` on Windows, or `./build-linux.sh` on Linux

6. The following files are ready to be used by consumer:

	- include/*
	- lib/*
	- model.with_runtime_opt.ort
	- model.ort

7. OPTIONAL: they can be packaged in a tar.gz with: `./make-archive.sh v1.14.1-neuralnote.0`

# TODO

- cross platform build
- linux
