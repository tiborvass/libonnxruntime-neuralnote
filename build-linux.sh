#!/usr/bin/env bash
set -euf -o pipefail

onnx_config="${1:-model.required_operators_and_types.config}"

build_arch() {
	onnx_config="$1"
	arch="$2"

	CMAKE_BUILD_TYPE=MinSizeRel

	python onnxruntime/tools/ci_build/build.py \
	--build_dir "onnxruntime/build/linux_${arch}" \
	--config=${CMAKE_BUILD_TYPE} \
	--parallel \
	--minimal_build \
	--disable_ml_ops --disable_exceptions --disable_rtti \
	--include_ops_by_config "$onnx_config" \
	--enable_reduced_operator_type_support \
	--cmake_extra_defines CMAKE_OSX_ARCHITECTURES="${arch}" \
	--skip_tests

    ar -M << EOF
CREATE libonnxruntime.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/re2-build/libre2.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/google_nsync-build/libnsync_cpp.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/container/libabsl_hashtablez_sampler.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/numeric/libabsl_int128.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/time/libabsl_civil_time.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/time/libabsl_time_zone.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/time/libabsl_time.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/profiling/libabsl_exponential_biased.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_malloc_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_log_severity.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_base.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_spinlock_wait.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/debugging/libabsl_debugging_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/debugging/libabsl_symbolize.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/debugging/libabsl_demangle_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/debugging/libabsl_stacktrace.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_city.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/synchronization/libabsl_synchronization.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/synchronization/libabsl_graphcycles_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/types/libabsl_bad_variant_access.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/types/libabsl_bad_optional_access.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_strings.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_cordz_info.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_cordz_handle.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_cord_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_cord.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_cordz_functions.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/strings/libabsl_strings_internal.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/protobuf-build/libprotobuf.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/protobuf-build/libprotoc.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/protobuf-build/libprotobuf-lite.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/flatbuffers-build/libflatbuffers.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/pytorch_cpuinfo-build/libcpuinfo.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/_deps/pytorch_cpuinfo-build/deps/clog/libclog.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnx_test_runner_common.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_framework.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_providers.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/lib/libgtest.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/lib/libgmock.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_optimizer.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_flatbuffers.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_test_utils.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnx_test_data_proto.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_graph.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_mlas.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnx.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_common.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_session.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_util.a
ADDLIB ./onnxruntime/build/linux_${arch}/${CMAKE_BUILD_TYPE}/libonnx_proto.a
SAVE
EOF
}
    
build_arch "$onnx_config" x86_64

mkdir -p "lib"
mv libonnxruntime.a lib

rm -f libonnx-neuralnote.tar.gz
tar czf libonnxruntime-neuralnote.tar.gz include lib model.with_runtime_opt.ort model.ort
