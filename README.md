
<!-- README.md is generated from README.Rmd. Please edit that file -->
dynverse
========

**dynverse** is created to support the development, execution, and benchmarking of trajectory inference methods. Check out our preprint on bioRxiv:

Wouter Saelens\*, Robrecht Cannoodt\*, Helena Todorov, Yvan Saeys. “A comparison of single-cell trajectory inference methods: towards more accurate and robust tools”. bioRxiv (Mar. 2018). DOI: [10.1101/276907](https://doi.org/10.1101/276907).

\*: Equal contribution

Subpackages
-----------

dynverse consists of several subpackages:

| Package                                                    | Status                                                                                                                          | Description                               |
|:-----------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------|
| [dynalysis](https://github.com/dynverse/dynalysis)         | Coming soon                                                                                                                     | Scripts to reproduce manuscript           |
| [dynwrap](https://github.com/dynverse/dynwrap)             | [![Build status](https://travis-ci.org/dynverse/dynwrap.svg?branch=master)](https://travis-ci.org/dynverse/dynwrap)             | Common wrapping functionality             |
| [dynmethods](https://github.com/dynverse/dynmethods)       | [![Build status](https://travis-ci.org/dynverse/dynmethods.svg?branch=master)](https://travis-ci.org/dynverse/dynmethods)       | Wrappers for trajectory inference methods |
| [dyneval](https://github.com/dynverse/dyneval)             | [![Build status](https://travis-ci.org/dynverse/dyneval.svg?branch=master)](https://travis-ci.org/dynverse/dyneval)             | Metrics and evaluation pipeline           |
| [dyngen](https://github.com/dynverse/dyngen)               | [![Build status](https://travis-ci.org/dynverse/dyngen.svg?branch=master)](https://travis-ci.org/dynverse/dyngen)               | Generator of synthetic datasets           |
| [dynnormaliser](https://github.com/dynverse/dynnormaliser) | [![Build status](https://travis-ci.org/dynverse/dynnormaliser.svg?branch=master)](https://travis-ci.org/dynverse/dynnormaliser) | Common normalisation functionality        |
| [dyntoy](https://github.com/dynverse/dyntoy)               | [![Build status](https://travis-ci.org/dynverse/dyntoy.svg?branch=master)](https://travis-ci.org/dynverse/dyntoy)               | Quick generator of small toy datasets     |
| [dynplot](https://github.com/dynverse/dynplot)             | [![Build status](https://travis-ci.org/dynverse/dynplot.svg?branch=master)](https://travis-ci.org/dynverse/dynplot)             | Common visualisation functionality        |
| [dynutils](https://github.com/dynverse/dynutils)           | [![Build status](https://travis-ci.org/dynverse/dynutils.svg?branch=master)](https://travis-ci.org/dynverse/dynutils)           | Various common functions                  |

Datasets
--------

We include the following datasets. When using any of these datasets, please also cite our preprint: [![DOI](https://zenodo.org/badge/DOI/10.1101/276907.svg)](https://doi.org/10.1101/276907)

-   [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1211533.svg)](https://doi.org/10.5281/zenodo.1211533) Single-cell -omics datasets, both real and synthetic, used to evaluated the trajectory inference methods
-   **Coming soon** Main results of the evaluation, used to rank the methods and construct practical guidelines

Installation
------------

Supported platforms are Linux and Mac OS X. Windows users *could* use [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) in order to run these packages on a Windows machine.

### Debian / Ubuntu / Linux Mint

First you need to install a few packages:

``` bash
sudo apt-get install libudunits2-dev libgsl-dev libsdl1.2-dev libreadline-dev imagemagick libfftw3-dev libudunits2-dev librsvg2-dev -y
```

The installation of dynmethods is sped up by preinstalling several Python libraries:

``` bash
sudo apt-get install python2.7-dev python3-dev python3-pip
pip3 install --user virtualenv numpy matplotlib pandas six jinja2 python-dateutil pytz pyparsing cycler tqdm python-igraph rpy2 Cython scipy statsmodels sklearn seaborn h5py anndata
```

Finally, you can install the dynverse packages with devtools:

``` r
install.packages("devtools")
library(devtools)
install_github("dynverse/dynwrap", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynmethods", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dyneval", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynnormaliser", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dyntoy", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynplot", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynutils", dependencies = TRUE, build_vignettes = TRUE)
```

### Fedora / CentOS

First you need to install a few packages:

``` bash
sudo dnf install openssl-devel libcurl-devel udunits2-devel libxml2-devel gsl-devel SDL2-devel readline-devel ImageMagick-c++-devel SDL-devel openblas-devel lapack-devel librsvg2-devel
```

The installation of dynmethods is sped up by preinstalling several Python libraries:

``` bash
sudo dnf install python2-devel python3-devel python3-pip python3-matplotlib-tk
pip3 install --user virtualenv numpy matplotlib pandas six jinja2 python-dateutil pytz pyparsing cycler tqdm python-igraph rpy2 Cython scipy statsmodels sklearn seaborn h5py anndata
Rscript -e 'install.packages("udunits2", configure.args =  c(udunits2 = '--with-udunits2-include=/usr/include/udunits2'))'
```

Finally, you can install the dynverse packages as follows:

``` r
install.packages("devtools")
library(devtools)
install_github("dynverse/dynwrap", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynmethods", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dyneval", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynnormaliser", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dyntoy", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynplot", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynutils", dependencies = TRUE, build_vignettes = TRUE)
```

### Mac OS X

First you will need to install the runtime binary of [SDL1.2](https://www.libsdl.org/download-1.2.php) and the development binary of [SDL2](https://www.libsdl.org/download-2.0.php) manually. Also install `librsvg` with brew.

The installation of dynmethods is sped up by preinstalling several Python libraries:

``` bash
pip3 install --user virtualenv numpy matplotlib pandas six jinja2 python-dateutil pytz pyparsing cycler tqdm python-igraph rpy2 Cython scipy statsmodels sklearn seaborn h5py anndata
```

Finally, you can install the dynverse packages as follows:

``` r
install.packages("devtools")
library(devtools)
install_github("dynverse/dynwrap", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynmethods", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dyneval", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynnormaliser", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dyntoy", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynplot", dependencies = TRUE, build_vignettes = TRUE)
install_github("dynverse/dynutils", dependencies = TRUE, build_vignettes = TRUE)
```
