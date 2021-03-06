#Setting working directory
setwd("/Users/vatsalmandalia/DataScienceBootcamp")
#Reading the data
sales <- read.csv("sales.csv")

#What kind of data we have
help(plot)

plot(sales$sales,type="l")
head(sales)
tail(sales)
#Create time series from the input data, [,1] is for first column and all rows. freq = 12, is for 12 months. For quarters it will be freq = 4
sales <- ts(sales[,1],start=1995,freq=12)

#Let's view, what is the output
sales

#Plot Time Series
plot(sales)

#Divides into Seasonal, Trend and Remainder. S.Window controls how rapidly the seasonal component can change
#STL means Seasonal Trend Decomposition using Loess
decom<-stl(sales,s.window="periodic")
decom
#-14893.3261688 +209568.2689  -9633.9427329
#185041

#Plot sales time series into three components - seasonal, trend and remainder
plot(decom)

#Access each component
decom$time.series[,'seasonal']

#Single Exponential Seasoning, coefficient tells you the level
hws1<-HoltWinters(sales)  #building the model

#Predict SES, Prediction interval gives me upper and lower bound of the confidence interval
sales.pred1<-predict(hws1,n.ahead=12,prediction.interval=TRUE)

#Predicted values
sales.pred1

#MAPE calculation
length(hws1$fitted[,1])
length(sales)
act <- sales[-c(1:12)]
prd <- hws1$fitted[,1]
mean(abs((act-prd)/act))

#Plot the base level graph, giving limits to x
plot.ts(sales, xlim = c(2005,2014))

#Historical Fitted values, no trend so both columns are same
hws1$fitted  #prediction on the actual/existing data

#Fit the historical fitted values
lines(hws1$fitted[,1],col="green")

#Fit the future predicted values
lines(sales.pred1[,1],col="blue")

#Fit the upper interval predicted values
lines(sales.pred1[,2],col="red")
lines(sales.pred1[,3],col="red")

#Can't see the upper bound, need to have y limit
plot.ts(sales, xlim = c(1995,2014),ylim=c(150000,400000))

#Fit the historical fitted values
lines(hws1$fitted[,1],col="green")

#Fit the future predicted values
lines(sales.pred1[,1],col="blue")

#Fit the upper interval predicted values
lines(sales.pred1[,2],col="red")

#Fit the upper interval predicted values
lines(sales.pred1[,3],col="red")

#Subset time series variable
window(sales, 2010, c(2010, 4))
