library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")
avg_small_flow_data = subset(flowdata, select = c(datetime, avg_small_flow, weekday))
attach(avg_small_flow_data)
avg_small_flow_data = avg_small_flow_data[avg_small_flow>0,]

##	split time

temptime <- read.table(textConnection(as.character(avg_small_flow_data$datetime)))
avg_small_flow_data$datetime <- temptime$V2

temp1 = aggregate(avg_small_flow_data[2:2], by=list(avg_small_flow_data$weekday, avg_small_flow_data$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_small_flow")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q2_small.csv")

ggplot(temp1, aes(datetime, avg_small_flow, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q2_small.pdf")