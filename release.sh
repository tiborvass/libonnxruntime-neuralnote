#!/usr/bin/env bash

set -euf -o pipefail

version="${1-}"
if test -z "$version"; then
	rev=$(git describe --always --abbrev=7 --dirty | tr '-' '.')
	version="neuralnote.git$rev"
fi

arch=$(uname -m)
os="windows"
builder="build-win.bat"
file="onnxruntime.lib"
if test "$(uname)" = "Darwin"; then
	os="macOS"
	builder="build-mac.sh"
	arch=universal
	file="libonnxruntime.a"
elif test "$(uname)" = "Linux"; then
	os="linux"
	builder="build-linux.sh"
fi

./convert-model-to-ort.sh "model.onnx"
"./$builder" model.required_operators_and_types.with_runtime_opt.config
(
	mkdir include
	for f in cpu_provider_factory.h onnxruntime_c_api.h onnxruntime_cxx_api.h onnxruntime_cxx_inline.h onnxruntime_run_options_config_keys.h onnxruntime_session_options_config_keys.h provider_options.h tensorrt_provider_factory.h; do
		found=
		for m in $(find ./onnxruntime/include -name "$f"); do
			if test $found; then
				echo "Unexpected: found more than one header matching: $f"
				exit 1
			fi
			cp "$f" ./include/
			found=true
		done
	done
	cd "./libs/${os}-${arch}"
	tar -czf "../../onnxruntime-${version}-${os}-${arch}.tar.gz" ../../model.with_runtime_opt.ort ../../include "${file}"
)
