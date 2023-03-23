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
	cd "./libs/${os}-${arch}"
	tar -czf "../../onnxruntime-${version}-${os}-${arch}.tar.gz" ../../model.with_runtime_opt.ort ../../include "${file}"
)
