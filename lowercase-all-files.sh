#!/bin/bash

set -e
# set -x

this_dir=$(realpath $(dirname ${0}))

cd "${this_dir}"

echo "INFO: This script is about to rename all files in this directory to be lowercase:"
echo
echo "    ${this_dir}"
echo
echo "INFO: Press Enter to proceed, Ctrl-C to cancel..."
read go

for f in $(ls *.dds); do
    # Don't rename files that are already lowercase
    if [ "${f}" != "$(echo "${f}" | tr [:upper:] [:lower:])" ]; then
        mv -v "${f}" $(echo "${f}" | tr [:upper:] [:lower:])
    fi
done
