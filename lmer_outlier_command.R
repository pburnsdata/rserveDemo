# Command line version of longitudinal check for comparison
#
# Uses csvs instead of Rserve
#
# On windows could run command like this for benchmarking:
# Powershell -Command "Measure-Command {Rscript lmer_outlier_r.R [PATH]\data.csv 3}" 
# (About 19x slower)

library("lme4")
library("purrr")

args = commandArgs(trailingOnly=TRUE)

detect_outlier <- function(data, cutoff) {

  # Enforce types
  data$site <-as.factor(data$site)
  data$subject <-as.factor(data$subject)
  data$time <-as.numeric(data$time)
  data$val <-as.numeric(data$val)
  
  # Build mixed model 
  model <- lmer(val ~ site + (1|subject), data)

  # Calculate Standardized Residuals
  res <- residuals(model)
  H <- hatvalues(model)
  sigma <- summary(model)$sigma
  res <- map_dbl(1:length(res), ~ res[[.]]/(sigma*sqrt(1-H[[.]])))  
  data$residuals <- abs(res) # being loose here but its a demo
  
  # Label points as outliers if residuals are above cut off
  data$outlier <- ifelse(data$residuals >= cutoff, 1, 0)

  return(data)
  
}

data  <- read.csv(args[1])

results <- detect_outlier(data, args[2])

write.csv(results, "C:/Users/spburns/Desktop/longitudinal/fake_long_data_output.csv")