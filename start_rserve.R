# Load R Packages

packages <- c(
    #rserve
    "Rserve",
    #longitudinal
    "purrr","lme4"
  )

lapply(packages, require, c = T)

#run.RServe allows you to continue your current session. 
#This prevents it from clearing the packages that were just loaded
run.Rserve()