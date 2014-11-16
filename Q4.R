library(ggplot2)

raindata = read.table(file="raindata.csv",  header=TRUE, sep=",")
attach(raindata)
raindata[rainfall>0,]

##	split time
temptime <- read.table(textConnection(as.character(raindata$datetime)))
raindata$datetime <- temptime$V2

temp1 = aggregate(raindata[3:3], by=list(raindata$weekday, raindata$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_rainfall")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q4_rainfall.csv")

ggplot(temp1, aes(datetime, avg_rainfall, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q4_rainfall.pdf")