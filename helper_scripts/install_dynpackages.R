#!/usr/bin/Rscript

library(dplyr, warn.conflicts = FALSE)
library(purrr, warn.conflicts = FALSE)
library(desc, warn.conflicts = FALSE)
library(devtools, warn.conflicts = FALSE)
requireNamespace("igraph", quietly = TRUE)

setRepositories(ind=1:4)

# find local repositories
files <-
  list.files(path = ".", pattern = "DESCRIPTION", recursive = TRUE, full.names = TRUE) %>%
  discard(grepl("revdep|Rcheck", .))

packages <- map_df(files, function(file){
  descr <- desc::desc(file = file)
  package <- descr$get("Package")
  version <- descr$get("Version")
  tibble(package, version, file, dir = gsub("/DESCRIPTION", "", file))
}) %>%
  as_tibble() %>%
  mutate(
    colour = rainbow(n())
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

# detect circular dependencies
circular_dependencies <- dist * t(dist) > 0
if (any(circular_dependencies)) {
  # create dependency graph between dyn-packages
  depgr1 <- igraph::graph_from_data_frame(
    d = dyndependencies %>% filter(type != "Suggests"),
    directed = TRUE,
    vertices = packages
  )

  # calculate which nodes are connected to which, taking directionality into account
  dist1 <- igraph::distances(depgr1, mode = "in")

  # fix circular dependencies
  dist[circular_dependencies] <- dist1[circular_dependencies]
}

dist[is.infinite(dist)] <- 0
dist[dist > 0] <- 1


# check for circular dependencies
if (any(dist * t(dist) > 0)) {
  stop("Circular dependencies detected")
}

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
