# Mean-variance portfolio optimization

library(tidyquant) # To download the data
library(plotly) # To create interactive charts
library(timetk) # To manipulate the data series
library(tibble)

#input the covar and mu manually

col1 = c(0.04,0.05,0.02) # R does the data from up-down, i.e. in columns. Input values from given var-covar matrix
  col2 = c(0.05,0.25,-0.1)
    col3 = c(0.02, -0.1, 0.1)
cov_mat =  array(c( col1, col2, col3), dim = c(3,3)) #merge the columns together to replicate the var-covar matrix


mu = t(t(c(0.05, 0.25, 0.1))) #matrix of the expected returns


wts <- runif(n = length(col1), min=-1,max=2) # generating random weights first for each stock, just a placeholder

wts <- wts/sum(wts) # just scaling by itself to sum up to 1

port_returns <- (sum(wts * mu))  # portfolio returns 

port_risk <- sqrt(t(wts) %*% (cov_mat %*% wts)) # portfolio risk

sharpe_ratio <- port_returns/port_risk  # Calculate the Sharpe Ratio

#### Running the optimizatoin by brute force

num_port <- 5000

# Creating a matrix to store the weights

all_wts <- matrix(nrow = num_port,
                  ncol = length(col1))

# Creating an empty vector to store
# Portfolio returns

port_returns <- vector('numeric', length = num_port)

# Creating an empty vector to store
# Portfolio Standard deviation

port_risk <- vector('numeric', length = num_port)

# Creating an empty vector to store
# Portfolio Sharpe Ratio

sharpe_ratio <- vector('numeric', length = num_port)

for (i in seq_along(port_returns)) {
  
  wts <- runif(length(col1))
  wts <- wts/sum(wts)
  
  # Storing weight in the matrix
  all_wts[i,] <- wts
  
  # Portfolio returns
  
  port_ret <- sum(wts * mu)
 
  
  # Storing Portfolio Returns values
  port_returns[i] <- port_ret
  
  
  # Creating and storing portfolio risk
  port_sd <- sqrt(t(wts) %*% (cov_mat  %*% wts))
  port_risk[i] <- port_sd
  
  # Creating and storing Portfolio Sharpe Ratios
  # Assuming 0% Risk free rate
  
  sr <- port_ret/port_sd
  sharpe_ratio[i] <- sr
  
}

# Storing the values in the table
portfolio_values <- tibble(Return = port_returns,
                           Risk = port_risk,
                           SharpeRatio = sharpe_ratio)


# Converting matrix to a tibble and changing column names
all_wts <- tk_tbl(all_wts)

colnames(all_wts) <- colnames(mu)

# Combing all the values together
portfolio_values <- tk_tbl(cbind(all_wts, portfolio_values))

min_var <- portfolio_values[which.min(portfolio_values$Risk),]
max_sr <- portfolio_values[which.max(portfolio_values$SharpeRatio),]

head(portfolio_values)

min_var <- portfolio_values[which.min(portfolio_values$Risk),]
max_sr <- portfolio_values[which.max(portfolio_values$SharpeRatio),]

p <- min_var %>%
  gather(1:3, key = Asset,
         value = Weights) %>%
  mutate(Asset = as.factor(Asset)) %>%
  ggplot(aes(x = fct_reorder(Asset,Weights), y = Weights, fill = Asset)) +
  geom_bar(stat = 'identity') +
  theme_minimal() +
  labs(x = 'Assets', y = 'Weights', title = "Minimum Variance Portfolio Weights") +
  scale_y_continuous(labels = scales::percent) 

ggplotly(p)

