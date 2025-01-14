#!/bin/bash
CMAKE_BUILD_TYPE=MinSizeRel

./onnxruntime/build.sh \
--config=${CMAKE_BUILD_TYPE} \
--build_shared_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--skip_tests

mkdir -p lib
# create the static library
ar -M <<EOF
create lib/libonnxruntime.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnx_proto.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnx_test_data_proto.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnx_test_runner_common.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnx.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_common.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_flatbuffers.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_framework.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_graph.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_mlas.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_optimizer.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_providers.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_session.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_test_utils.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/libonnxruntime_util.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_base.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_log_severity.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_malloc_internal.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_spinlock_wait.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/container/libabsl_hashtablez_sampler.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_city.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/google_nsync-build/libnsync_cpp.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/protobuf-build/libprotobuf-lite.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/protobuf-build/libprotoc.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/flatbuffers-build/libflatbuffers.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/pytorch_cpuinfo-build/deps/clog/libclog.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/pytorch_cpuinfo-build/libcpuinfo.a
addlib ./onnxruntime/build/Linux/${CMAKE_BUILD_TYPE}/_deps/re2-build/libre2.a
save
end
EOF
