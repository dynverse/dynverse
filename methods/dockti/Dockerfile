FROM rocker/tidyverse
ADD . /code
RUN R -e "devtools::install_deps('/code/')"
RUN R CMD INSTALL --no-multiarch --with-keep.source code
ENTRYPOINT Rscript /code/run.R
