#!/bin/bash

# for each submodule: 
# # git submodule add -b master git@github.com:dynverse/mfa.git methods/mfa
git submodule update --init --recursive

git submodule foreach git checkout master
git submodule foreach git pull
