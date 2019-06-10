## NatGeoDataViz - Sankey Diagram

library(tidyverse)
library(ggforce)
library(svglite)
library(extrafont)

extrafont::loadfonts()

df_plastic <- readr::read_csv("https://raw.githubusercontent.com/LiamDBailey/NatGeoDataViz/master/inst/extdata/sectors_plastic.csv")

df_plastic %>%
  filter(sector == "Packaging") %>%
  mutate(plastic = if_else(plastic %in% c("Other", "PUR"), "Other", plastic)) %>%
  group_by(sector, plastic) %>%
  summarize(prop = sum(prop)) %>%
  gather_set_data(1:2) %>%
  ungroup() %>%
  ggplot(aes(x, id = id, split = y, value = prop)) +
    geom_parallel_sets(fill = "#7D96AF", axis.width = 0.15, alpha = 1) +
    geom_parallel_sets_axes(fill = "transparent", axis.width = 0.5) +
    geom_parallel_sets_labels(colour = "black", family = "Poppins",
                              size = 8, angle = 0, vjust = 0) +
    coord_flip() +
    theme_void()

ggsave("sankey_packaging.svg", width = 12, height = 10)
