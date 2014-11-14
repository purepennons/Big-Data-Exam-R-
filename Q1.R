library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")
avg_flow_data = subset(flowdata, select = c(datetime, avg_flow, weekday))
attach(avg_flow_data)
avg_flow_data[avg_flow>-1,]

##	split time

temptime <- read.table(textConnection(as.character(avg_flow_data$datetime)))
avg_flow_data$datetime <- temptime$V2

#week1 = avg_flow_data[weekday==1,]
#week1[order(as.Date(week1$datetime, format="%H:M")),]
#temp1 = aggregate(avg_flow ~ datetime, week1, mean)

temp1 = aggregate(avg_flow_data[2:2], by=list(avg_flow_data$weekday, avg_flow_data$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_flow")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q1.csv")

ggplot(temp1, aes(datetime, avg_flow, color=weekday)) + geom_line(aes(group = weekday))
