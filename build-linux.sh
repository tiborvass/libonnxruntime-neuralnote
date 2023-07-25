#!/bin/bash

# get onnx_config from parameter, or use default
onnx_config="${1:-model.required_operators_and_types.config}"

./onnxruntime/build.sh \
--config=MinSizeRel \
--build_shared_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config "$onnx_config" \
--enable_reduced_operator_type_support \
--skip_tests

# make-archive.sh expects the build process to put files in the ./lib directory
# which is included in the archive.
mkdir -p "lib"
# ar will create a single static library (libonnxruntime.a) in  ./lib
ar -M <libonnxruntime.mri
# also copy shared libary (for now?) into ./lib while we figure out linker errors in NeuralNote
# using find to avoid cp stat errors with wildcards
find ./onnxruntime/build/Linux/MinSizeRel -name "libonnxruntime.so*" -exec cp {} lib/ \;
