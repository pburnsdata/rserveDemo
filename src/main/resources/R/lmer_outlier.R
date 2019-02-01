# Longitudinal check

detect_outlier <- function(data_string, cutoff) {
  
  # Read in String passed from Java client
  data  <- read.csv(text=data_string)
  
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