library(dockti)
library(tidyverse)

expression <- read.csv("/input/expression.csv", row.names=1) %>%
  as.matrix()
params <- jsonlite::read_json("/input/params.json", simplifyVector = TRUE)
start_cells <- jsonlite::read_json("/input/start_cells.json", simplifyVector = TRUE)

pca <- prcomp(expression)

pseudotimes <- pca$x[, params$component]

# flip pseudotimes using start_cells
if (!is.null(start_cells)) {
  if(mean(pseudotimes[start_cells]) > 0.5) {
    pseudotimes <- 1-pseudotimes
  }
}

tibble(
  cell_id = names(pseudotimes),
  pseudotime = pseudotimes
) %>%
  write_csv("/output/pseudotimes.csv")
