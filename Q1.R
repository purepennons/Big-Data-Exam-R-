flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")
avg_flow_data = subset(flowdata, select = c(datetime, avg_flow, weekday))
attach(avg_flow_data)
avg_flow_data[avg_flow>-1,]
temptime <- read.table(textConnection(as.character(avg_flow_data$datetime)))
avg_flow_data$datetime <- temptime$V2