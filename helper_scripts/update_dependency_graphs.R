#!/usr/bin/Rscript

library(tidyverse)
library(ggraph)
library(tidygraph)
requireNamespace("igraph")
requireNamespace("desc")
requireNamespace("devtools")
requireNamespace("fs")

# find local repositories
files <- list.files(path = ".", pattern = "DESCRIPTION", recursive = TRUE, full.names = TRUE)

packages <- map_df(files, function(file){
  descr <- desc::desc(file = file)
  package <- descr$get("Package")
  tibble(package, file, dir = gsub("/DESCRIPTION", "", file))
}) %>%
  filter(!grepl("revdep", dir)) %>%
  as_tibble()

dependencies <- map_df(packages$file, function(file){
  descr <- desc::desc(file = file)

  package <- descr$get("Package")
  deps <- descr$get_deps()

  deps %>%
    rename(dependency = package) %>%
    mutate(package) %>%
    select(package, dependency, type) %>%
    as_tibble()
}) %>%
  filter(dependency %in% packages$package)


# create dependency graph between dyn-packages
depgr <- igraph::graph_from_data_frame(
  d = dependencies,
  directed = TRUE,
  vertices = packages
)

color_type <- c("Depends" = "#001f3f", "Imports" = "#0074D9", "Suggests" = "#39CCCC")
graph <- tidygraph::as_tbl_graph(depgr)
ggraph(graph, layout = "sugiyama") +
  geom_edge_diagonal(aes(color = type)) +
  geom_node_point() +
  ggrepel::geom_label_repel(
    aes(x = x, y = y, label = name),
    nudge_y = 0.1,
    label.size = 0,
    fill = "#FFFFFF22",
    min.segment.length = 0
  ) +
  scale_edge_color_manual("Dependency type", values = color_type) +
  scale_edge_width_manual(values = c(`TRUE` = 1.5, `FALSE` = 0.5), guide = FALSE) +
  theme_graph() +
  theme(legend.position = "bottom")



pmap(packages, function(package_oi, dir, ...) {
  packages <- packages %>%
    filter(package %in% c(dependencies$package, dependencies$dependency)) %>%
    mutate(
      oi = package == package_oi
    )

  dependencies <- dependencies %>%
    mutate(
      oi = (package == package_oi) | (dependency == package_oi),
      upstream = (dependency == package_oi)
    )

  packages$oi_connected <- packages$package %in% (dependencies %>% filter(oi) %>% select(package, dependency) %>% unlist())

  # create dependency graph between dyn-packages
  depgr <- igraph::graph_from_data_frame(
    d = dependencies,
    directed = TRUE,
    vertices = packages
  )

  color_type <- c("Depends" = "#001f3f", "Imports" = "#0074D9", "Suggests" = "#39CCCC")
  linetype_upstream <- c(`TRUE` = "solid", `FALSE` = "dashed")
  alpha_oi <- c(`TRUE` = 1, `FALSE` = 0.2)

  graph <- tidygraph::as_tbl_graph(depgr)
  plot <- ggraph(graph, layout = "sugiyama") +
    geom_edge_diagonal(aes(color = type, alpha = oi, width = oi, linetype = upstream)) +
    geom_node_point(aes(alpha = oi_connected)) +
    ggrepel::geom_label_repel(
      aes(x = x, y = y, label = name, alpha = oi_connected),
      nudge_y = 0.1,
      label.size = 0,
      fill = "#FFFFFF22",
      min.segment.length = 0
    ) +
    scale_edge_color_manual("Dependency type", values = color_type) +
    scale_edge_alpha_manual(values = alpha_oi, guide = FALSE) +
    scale_alpha_manual("", values = alpha_oi, guide = FALSE) +
    scale_edge_linetype_manual("", values = linetype_upstream, labels = c(`TRUE` = "upstream", `FALSE` = "downstream")) +
    scale_edge_width_manual(values = c(`TRUE` = 1.5, `FALSE` = 0.5), guide = FALSE) +
    theme_graph() +
    theme(legend.position = "bottom")

  folder <- paste0(dir, "/man/figures/")
  if (!fs::dir_exists(folder)) fs::dir_create(folder)
  ggsave(paste0(folder, "dependencies.png"), plot, width = 12, height = 7)
})
