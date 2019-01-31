# Load R Packages

packages <- c(
    #rserve
    "Rserve",
    #longitudinal
    "purrr","lme4"
  )

lapply(packages, require, c = T)

run.Rserve()