# Builds a LaTeX table of mean arrests by race and gender.
# See the pivoting vignette for how to use pivot functions.
# vignette("pivot")
# Documentation for the kableExtra package is here:
# https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_pdf.pdf

setwd("~/Desktop/causalinferencesp22/causal-inference-2022")
read_csv("data/NLSY97_clean_new.csv") %>%
  
  # summarize arrests by race and gender
  group_by(race, gender) %>%
  summarize(mean_incarc_length = mean(incarc_length)) %>%
  
  # pivot the values from race into columns
  pivot_wider(names_from = race, values_from = mean_incarc_length) %>%
  
  # rename columns using snakecase
  rename_with(to_title_case) %>%
  
  # create the kable object. Requires booktabs and float LaTeX packages
  kbl(
    caption = "Mean incarceration length in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "tab:summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>%
  
  write_lines("tables/incarc_length_by_racegender.tex")
  