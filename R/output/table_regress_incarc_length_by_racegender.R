# Builds a LaTeX table of regression output using the stargazer package.

setwd("~/Desktop/causalinferencesp22/causal-inference-2022")

model <- 
  read_csv("data/NLSY97_clean_new.csv") %>%
  lm(incarc_length ~ race + gender, data = .)

# Here we supply our own standard errors b/c we want to 
# use heteroskedasticity-robust errors.
se <- model %>% vcovHC %>% diag %>% sqrt

# this is unnecessary, but tidies the coefficient names,
# so that you have "Male" instead of "genderMale" in the table.
# Note that stargazer treats the intercept differently so we drop it (the [-1] part)
covariate.labels <- names(coef(model))[-1] %>% str_replace("(^race)|(^gender)", "")

stargazer(
  model,
  se = list(se),
  covariate.labels = covariate.labels,
  dep.var.labels = "Incarceration length in 2002",
  out = ("tables/regress_incarc_length_by_racegender.tex"),
  title = "Regression Output. Omitted category is Black Females.",
  label = "tab:regression"
)
