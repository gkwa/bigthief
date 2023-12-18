#!/usr/bin/env bash

set -e

tmp=$(mktemp -d bigthief.XXXXX)

if [ -z "${tmp+x}" ] || [ -z "$tmp" ]; then
    echo "Error: \$tmp is not set or is an empty string."
    exit 1
fi

{
    rg --files . \
        | grep -v $tmp/filelist.txt \
        | grep -vE 'bigthief$' \
        | grep -v README.org \
        | grep -v make_txtar.sh \
        | grep -v go.sum \
        | grep -v go.mod \
        | grep -v Makefile \
        | grep -v cmd/main.go \
        | grep -v logger.go \
        # | grep -v bigthief.go \

} | tee $tmp/filelist.txt
tar -cf $tmp/bigthief.tar -T $tmp/filelist.txt
mkdir -p $tmp/bigthief
tar xf $tmp/bigthief.tar -C $tmp/bigthief
rg --files $tmp/bigthief
txtar-c $tmp/bigthief | pbcopy

rm -rf $tmp
