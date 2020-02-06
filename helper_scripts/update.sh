#!/bin/bash
git pull
git submodule foreach git pull
pushd dynbenchmark/results
git pull
popd
