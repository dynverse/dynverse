
<!-- README.md is generated from README.Rmd. Please edit that file -->
dynverse <img src="docs/logo.png" align="right" width="156" height="156" />
===========================================================================

**dynverse** is created to support the development, execution, plotting and benchmarking of trajectory inference methods. Check out our preprint on bioRxiv:

Wouter Saelens\*, Robrecht Cannoodt\*, Helena Todorov, Yvan Saeys. “A comparison of single-cell trajectory inference methods: towards more accurate and robust tools”. bioRxiv (Mar. 2018). DOI: [10.1101/276907](https://doi.org/10.1101/276907).

\*: Equal contribution

Subpackages
-----------

dynverse consists of several subpackages:

| Package                                                    | Status                                                                                                                          | Code coverage                                                                                                                          | Description                                      |
|:-----------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| [dyno](https://github.com/dynverse/dyno)                   | [![Build status](https://travis-ci.org/dynverse/dyno.svg?branch=master)](https://travis-ci.org/dynverse/dyno)                   | [![codecov](https://codecov.io/gh/dynverse/dyno/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dyno)                   | User-friendly trajectory inference functionality |
| [dynwrap](https://github.com/dynverse/dynwrap)             | [![Build status](https://travis-ci.org/dynverse/dynwrap.svg?branch=master)](https://travis-ci.org/dynverse/dynwrap)             | [![codecov](https://codecov.io/gh/dynverse/dynwrap/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynwrap)             | Common trajectory wrapping functionality         |
| [dynmethods](https://github.com/dynverse/dynmethods)       | [![Build status](https://travis-ci.org/dynverse/dynmethods.svg?branch=master)](https://travis-ci.org/dynverse/dynmethods)       | [![codecov](https://codecov.io/gh/dynverse/dynmethods/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynmethods)       | Wrappers for trajectory inference methods        |
| [dyneval](https://github.com/dynverse/dyneval)             | [![Build status](https://travis-ci.org/dynverse/dyneval.svg?branch=master)](https://travis-ci.org/dynverse/dyneval)             | [![codecov](https://codecov.io/gh/dynverse/dyneval/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dyneval)             | Metrics and evaluation pipeline                  |
| [dyngen](https://github.com/dynverse/dyngen)               | [![Build status](https://travis-ci.org/dynverse/dyngen.svg?branch=master)](https://travis-ci.org/dynverse/dyngen)               | [![codecov](https://codecov.io/gh/dynverse/dyngen/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dyngen)               | Generator of synthetic datasets                  |
| [dynfeature](https://github.com/dynverse/dynfeature)       | [![Build status](https://travis-ci.org/dynverse/dynfeature.svg?branch=master)](https://travis-ci.org/dynverse/dynfeature)       | [![codecov](https://codecov.io/gh/dynverse/dynfeature/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynfeature)       | Extracting relevant features (genes)             |
| [dynnormaliser](https://github.com/dynverse/dynnormaliser) | [![Build status](https://travis-ci.org/dynverse/dynnormaliser.svg?branch=master)](https://travis-ci.org/dynverse/dynnormaliser) | [![codecov](https://codecov.io/gh/dynverse/dynnormaliser/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynnormaliser) | Common normalisation functionality               |
| [dynplot](https://github.com/dynverse/dynplot)             | [![Build status](https://travis-ci.org/dynverse/dynplot.svg?branch=master)](https://travis-ci.org/dynverse/dynplot)             | [![codecov](https://codecov.io/gh/dynverse/dynplot/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynplot)             | Common visualisation functionality               |
| [dynalysis](https://github.com/dynverse/dynalysis)         | [![Build status](https://travis-ci.org/dynverse/dynalysis.svg?branch=master)](https://travis-ci.org/dynverse/dynalysis)         | [![codecov](https://codecov.io/gh/dynverse/dynalysis/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynalysis)         | Scripts to reproduce manuscript                  |
| [dyntoy](https://github.com/dynverse/dyntoy)               | [![Build status](https://travis-ci.org/dynverse/dyntoy.svg?branch=master)](https://travis-ci.org/dynverse/dyntoy)               | [![codecov](https://codecov.io/gh/dynverse/dyntoy/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dyntoy)               | Quick generator of small toy datasets            |
| [dynutils](https://github.com/dynverse/dynutils)           | [![Build status](https://travis-ci.org/dynverse/dynutils.svg?branch=master)](https://travis-ci.org/dynverse/dynutils)           | [![codecov](https://codecov.io/gh/dynverse/dynutils/branch/master/graph/badge.svg)](https://codecov.io/gh/dynverse/dynutils)           | Various common functions                         |

Datasets
--------

We include the following datasets. When using any of these datasets, please also cite our preprint: [![DOI](https://zenodo.org/badge/DOI/10.1101/276907.svg)](https://doi.org/10.1101/276907)

-   [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1211533.svg)](https://doi.org/10.5281/zenodo.1211533) Single-cell -omics datasets, both real and synthetic, used to evaluated the trajectory inference methods
-   **Coming soon** Main results of the evaluation, used to rank the methods and construct practical guidelines

Installation
------------

### Linux

First you need to install a few packages:

-   Debian / Ubuntu / Linux mint: `sudo apt-get install libudunits2-dev imagemagick`
-   Fedora / CentOS: `sudo dnf install udunits2-devel ImageMagick-c++-devel`

Next, install the dyn\* packages

``` r
# install.packages("devtools")
dyn_packages <- paste0("dynverse/dyn", c("wrap", "methods", "eval", "normaliser", "toy", "gen", "plot"))
devtools::install_github(dyn_packages)
```

### Windows and Mac OS X

``` r
# install.packages("devtools")
dyn_packages <- paste0("dynverse/dyn", c("wrap", "methods", "eval", "normaliser", "toy", "gen", "plot"))
devtools::install_github(dyn_packages)
```

### Development version

You can install the development branches of these packages by adding a '@devel' at the end:

``` r
dyn_packages <- paste0("dynverse/dyn", c("wrap", "plot", "methods", "eval", "feature", "guidelines", "normaliser", "toy", "gen", "o"), "@devel")
devtools::install_github(dyn_packages, dependencies = TRUE)
```
