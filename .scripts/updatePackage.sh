#!/bin/sh

set -e

node ./src/scripts/BuildManager/index.js $1
cd $PWD/dist/$1
cpack
cpush
