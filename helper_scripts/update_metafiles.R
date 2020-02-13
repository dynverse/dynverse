#!/usr/bin/Rscript

library(tidyverse)
library(desc)
library(fs)

descriptions <- list.files(path = ".", pattern = "DESCRIPTION", recursive = TRUE, full.names = TRUE) %>%
  {.[!grepl("revdep", .)]} %>%
  {.[!grepl("Rcheck", .)]}

for (desc_file in descriptions) {
  if (!file.exists(gsub("DESCRIPTION", "LICENSE", desc_file))) {
    folder <- gsub("DESCRIPTION", "", desc_file)

    cat("Adding LICENSE to ", folder, "\n", sep = "")
    fs::file_copy("LICENSE", paste0(folder, "/LICENSE"))
    fs::file_copy("LICENSE.md", paste0(folder, "/LICENSE.md"))

    des <- desc(desc_file)
    des$set("License", "MIT + LICENSE file")
    des$write()

    system(paste0("pushd '", folder, "' && git add DESCRIPTION LICENSE LICENSE.md && git commit -m 'update license' && git push && popd"))
  }
}

# find local repositories
subrepos <-
  readr::read_lines(".gitmodules") %>%
  .[grepl("path = ", .)] %>%
  gsub(".* = ", "", .)

for (repo in subrepos) {
  if (!file.exists(paste0(repo, "/LICENSE"))) {
    cat("Adding LICENSE to ", repo, "\n", sep = "")
    fs::file_copy("LICENSE", paste0(repo, "/LICENSE"))
    fs::file_copy("LICENSE.md", paste0(repo, "/LICENSE.md"))

    system(paste0("pushd '", repo, "' && git add LICENSE LICENSE.md && git commit -m 'update license' && git push && popd"))
  }
}

