#!/bin/bash

pushd ../methods/
for m in ti_*; do
  #cp .travis.yml $m
  pushd $m	
  #git add .travis.yml
  #git commit -m "Add dyneval to .travis.yml"
  git push
  popd
done
popd
