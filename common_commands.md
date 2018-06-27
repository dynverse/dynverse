
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
 ``
