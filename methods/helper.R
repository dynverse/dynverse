library(tidyverse)

method = "recat"

dynwrap::create_ti_method_definition(
  paste0("ti_", method, "/definition.yml"),
  script = ""
)

traj <- dynutils::read_h5(paste0("ti_", method, "/output.h5"))
dynplot::plot_graph(traj)
