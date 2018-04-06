library(tidyverse)
library(xml2)

hover_info <- tribble(
  ~id, ~url,
  "dynreal", "https://zenodo.org/record/1211533",
  "dyngen", NA,
  "dynalysis", NA,
  "dynnormaliser", NA,
  "dynmethods", NA,
  "dynwrap", NA,
  "dynparam", NA,
  "dyneval", NA,
  "dynguidelines", NA,
  "dynqc", NA

) %>%
  mutate(hover_id = paste0(id, "_hover"), url=ifelse(is.na(url), glue::glue("https://github.com/dynverse/{id}"), url))

xml <- read_xml("docs/overview_evaluation_expanded_v2.svg")

hovers <- xml %>%
  xml_find_first(".//svg:g[@id='hover_boxes']") %>%
  xml_find_all("svg:rect") %>%
  xml_attr("id") %>%
  tibble(hover_id = .)

left_join(hovers, hover_info, by="hover_id") %>%
  write_csv("docs/hovers.csv")
