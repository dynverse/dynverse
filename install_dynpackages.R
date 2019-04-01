#!/usr/bin/Rscript

library(tidyverse)
requireNamespace("igraph")
requireNamespace("desc")
requireNamespace("devtools")

# find local repositories
files <- 
  list.files(path = ".", pattern = "DESCRIPTION", recursive = TRUE, full.names = TRUE) %>% 
  discard(grepl("revdep", .))

packages <- map_df(files, function(file){
  descr <- desc::desc(file = file)
  package <- descr$get("Package")
  version <- descr$get("Version")
  tibble(package, version, file, dir = gsub("/DESCRIPTION", "", file))
}) %>%
  as_tibble() %>% 
  mutate(
    colour = dynplot:::milestone_palette(name = "rainbow", n = n())
  )

dependencies <- map_df(packages$file, function(file){
  descr <- desc::desc(file = file)
  
  package <- descr$get("Package")
  deps <- descr$get_deps()
  
  deps %>%
    rename(dependency = package) %>%
    mutate(package) %>%
    select(package, dependency, version, type) %>%
    as_tibble()
})

dyndependencies <- 
  dependencies %>% 
  inner_join(packages %>% select(package), by = "package") %>% 
  inner_join(packages %>% select(dependency = package), by = "dependency")

# packages %>% write_tsv("~/packages_info.tsv")
# dyndependencies %>% write_tsv("~/packages_dependencies.tsv")

# create dependency graph between dyn-packages
depgr <- igraph::graph_from_data_frame(
  d = dyndependencies,
  directed = TRUE,
  vertices = packages
)

# calculate which nodes are connected to which, taking directionality into account
dist <- igraph::distances(depgr, mode = "in")
dist[is.infinite(dist)] <- 0
dist[dist > 0] <- 1

# determine installation order
selected_ix <- c()
to_select_ix <- seq_len(ncol(dist))

while (length(to_select_ix) > 0) {
  wts <- colSums(dist[to_select_ix, to_select_ix, drop = FALSE])
  ix <- which(wts == 0)
  selected_ix <- c(selected_ix, to_select_ix[ix])
  to_select_ix <- to_select_ix[-ix]
}
ordered_packages <- packages[selected_ix,]

# install each package individually
walk(seq_len(nrow(ordered_packages)), function(i) {
  cat("Installing ", i, "/", nrow(ordered_packages), ": ", ordered_packages$package[[i]], "\n", sep = "")
  devtools::install(pkg = ordered_packages$dir[[i]], dependencies = FALSE, quiet = TRUE)
})
