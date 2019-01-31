detect_outlier <- function(data_string, cutoff) {

  
  data  <- read.csv(text=data_string)

  #enforce types
  data$site <-as.factor(data$site)
  data$subject <-as.factor(data$subject)
  data$time <-as.numeric(data$time)
  data$val <-as.numeric(data$val)
  
  
  
  model <- lmer(val ~ site + (1|subject), data)

  # res <- residuals(model)
  # H <- hatvalues(model)
  # sigma <- summary(model)$sigma
  # res <- map_dbl(1:length(res), ~ res[[.]]/(sigma*sqrt(1-H[[.]])))  #standardize
   
  # data$residuals <- res # being loose here but its a demo
   
  # data$outlier <- ifelse(data$residuals >= cutoff, 1, 0)

return(data)
}

# data <- fread("C:/Users/spburns/Desktop/longitudinal/fake_long_data.csv")
# 
# d<- read.csv("C:/Users/spburns/Desktop/longitudinal/fake_long_data.csv")
# detect_outlier(d, 3)
