#!/usr/bin/env bash
set -e
set -x
url=http://download.eclipse.org/jdtls/snapshots/jdt-language-server-0.66.0-202011271325.tar.gz
tar_file=jdt-language-server-0.66.0-202011271325.tar.gz
mkdir -p out
if ! [[ -f ${tar_file} ]]; then
    curl --silent ${url} -o ${tar_file}
fi
if ! [[ -f out/plugins ]]; then
    tar -xf ${tar_file} -C out
fi
source_files=(
    .no-sublime-package
    LICENSE
    LSP-jdtls.sublime-commands
    LSP-jdtls.sublime-settings
    NOTICE
    plugin.py
    README.md
    sublime-package.json
)
for file in ${source_files[@]}; do
    rsync $file out/
done
if ! [[ -f out/release.zip ]]; then
    cd out && zip -q -r release.zip .
fi
