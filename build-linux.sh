#!/bin/bash
./onnxruntime/build.sh \
--config=MinSizeRel \
--build_shared_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--skip_tests

# make-archive.sh expect the build process to but files in a lib directory s
# that is included in the archive.
mkdir -p "lib"
# using find to avoid cp stat errors with wildcards
find ./onnxruntime/build/Linux_x86_64/MinSizeRel -name "libonnxruntime.so*" -exec cp {} lib/ \;
