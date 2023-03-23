#!/usr/bin/env bash

set -xeuf -o pipefail

ORT_VERSION=v1.14.1
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

clone() {
	git clone -b $ORT_VERSION --depth 1 --shallow-submodules https://github.com/microsoft/onnxruntime
}

if ! test -d ./onnxruntime; then
	clone
fi
if test -n "$(git -C ./onnxruntime status --porcelain)"; then
	rm -rf onnxruntime
	clone
fi
if test "$(git -C ./onnxruntime describe --always --tags)" != "$ORT_VERSION"; then
	git -C ./onnxruntime checkout "$ORT_VERSION"
fi

set -e
dir="onnxruntime-${version}-${os}-${arch}"
test -n "$dir"
rm -rf "./$dir"
./convert-model-to-ort.sh "model.onnx"
"./$builder" model.required_operators_and_types.with_runtime_opt.config "${version}"

(
	cp -rf include "./$dir/include"
	cp model.with_runtime_opt.ort "./$dir/"
	tar -czf "onnxruntime-${version}-${os}-${arch}.tar.gz" "$dir"
	rm -rf "./$dir/include" "./$dir/model.with_runtime_opt.ort"
)
