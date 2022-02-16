# Builds a bar graph with total arrests on the y axis and race/gender on the
# x axis. Refer to my presentation on graphing for more detail.
library(tidyverse)
setwd("~/Desktop/causalinferencesp22/causal-inference-2022")
read_csv("data/NLSY97_clean_new.csv") %>%
  group_by(race, gender) %>%
  summarize(mean_incarc_length = mean(incarc_length)) %>%
  ggplot(aes(race, mean_incarc_length, fill = gender)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(
      x = "Race", 
      y = "Mean Incarceration Length (months)", 
      fill = "Gender",
      title = "Mean Incarceration Length in 2002 by Race and Gender") +
    theme_minimal() +
    scale_fill_economist()

ggsave("figures/incarc_length_by_racegender.png", width=8, height=4.5)