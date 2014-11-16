library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")
avg_flow_data = subset(flowdata, select = c(datetime, avg_flow, weekday))
attach(avg_flow_data)
avg_flow_data =avg_flow_data[avg_flow>-1&weekday<6,]

##	split time
temptime <- read.table(textConnection(as.character(avg_flow_data$datetime)))
avg_flow_data$datetime <- temptime$V2

temp1 = aggregate(avg_flow_data[2:2], by=list(avg_flow_data$datetime), mean)

##	rename col names.
colnames(temp1) <- c("datetime", "avg_flow")

print(temp1[temp1$avg_flow<37,])