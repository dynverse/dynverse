#/bin/bash

git submodule foreach 'if [ `git branch --list devel | wc -l` = 1 -o `git status | grep detached | wc -l` = 1 ]; then git checkout devel; else echo no devel branch; fi'


