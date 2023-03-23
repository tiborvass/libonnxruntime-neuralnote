# ONNX Runtime static library builder for NeuralNote

This is a fork of [https://github.com/olilarkin/ort-builder](https://github.com/olilarkin/ort-builder#readme) specialized for [NeuralNote](https://github.com/DamRsn/NeuralNote).

For a general purpose static library builder please go to the upstream repo.

## Instructions to build ONNX Runtime static library for NeuralNote

1. Create a [virtual environment](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) `$ python3 -m venv venv`

2. Activate it `$ source ./venv/bin/activate`

3. Install dependencies `$ pip install -r requirements.txt`

4. Run `./release.sh v1.14.1-neuralnote.1`

5. See platform specific tarballs.

# TODO

- cross platform build
- linux
