
Add a new submodule:
```bash
git submodule add -b devel git@github.com:dynverse/mfa.git methods/mfa
```

===========================================================

Initialise all submodules:
```bash
git submodule update --init --recursive
```

===========================================================

To remove a submodule you need to:

```bash
vim .gitmodules                              # remove relevant section
git add .gitmodules
vim .git/config                              # remove relevant section
git rm --cached path_to_submodule            # no trailing slash
rm -rf .git/modules/path_to_submodule        # no trailing slash
git commit -m "Removed submodule "
rm -rf path_to_submodule
```

===========================================================

Update all repositories:

```bash
git add *
git commit -m "updated repositories"
git push
```

===========================================================

Check out all devel branches, if they exist:

```bash
git submodule foreach 'if [ `git branch --list devel | wc -l` = 1 -o `git status | grep detached | wc -l` = 1 ]; then git checkout devel; else echo no devel branch; fi'
```

===========================================================

Update all remote urls to git@github.com/dynverse/...:

```bash
git submodule foreach 'git remote set-url origin `pwd | sed "s#.*/\(.*\)#git@github.com:dynverse/\1.git#"`'
cd methods/monocle; git remote set-url origin git@github.com:dynverse/monocle-release.git; cd ../..
```

===========================================================

Remove large files from a repository

First clone the repo -- don't forget the "--mirror" argument!
```bash
git clone --mirror git@github.com:dynverse/dynbenchmark.git
java -jar ~/Downloads/bfg-1.13.0.jar --strip-blobs-bigger-than 100K --protect-blobs-from master,devel --delete-files '*.{png,pdf,svg,rds,RData,csv,txt,tsv,ods,xls,xlsx}' dynbenchmark.git
cd dynbenchmark.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push
```

At each users laptop
```bash
git pull
git reset --hard origin/devel
git checkout master
git reset --hard origin/master
git checkout devel
```

===========================================================

Apply a sed over all R files in all repositories

```bash
find . -type f -regex ".*.Rm?d?" -print0 | xargs -0 sed -i 's#ALL YOUR BASE#ARE BELONG TO US#g'
```

===========================================================

Encrypt a file on travis

Create a file in a folder that is in your PATH variable (e.g. `~/bin/travis_enc_all`) containing:
```bash
travis encrypt-file ~/credentials --add
```

Create a file with your common credentials:
```bash
DOCKER_USERNAME=dynverseorg
DOCKER_PASSWORD=73...rK
GITHUB_PAT=dc...29
```
