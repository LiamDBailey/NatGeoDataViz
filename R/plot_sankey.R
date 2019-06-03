## NatGeoDataViz - Sankey Diagram

library(tidyverse)
library(networkD3)
library(extrafont)

extrafont::loadfonts()

df_plastic <- readr::read_csv("https://raw.githubusercontent.com/LiamDBailey/NatGeoDataViz/master/inst/extdata/sectors_plastic.csv")

links <- as.data.frame(df_plastic) %>%
  mutate(
    plastic = if_else(plastic == "Other", "Misc", plastic),  ## to avoid same name in both groups
    sectorID = as.numeric(as.factor(sector)) - 1,  ## ID needs to start with 0
    plasticID = as.numeric(as.factor(plastic)) + 6  ## to have unique IDs across groups
  )

nodes <- data.frame(name = c(sort(unique(links$sector)), sort(unique(links$plastic))))

sankeyNetwork(Links = links,
              Nodes = nodes,
              Source = "sectorID",
              Target = "plasticID",
              Value = "prop",
              NodeID = "name",
              sinksRight = FALSE)

