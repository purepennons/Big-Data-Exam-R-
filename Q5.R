library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")
raindata = read.table(file="raindata.csv",  header=TRUE, sep=",")

##	choose datetime, avg_flow and weekday columns from flowdata and asign to avg_flow_data.
avg_flow_data = subset(flowdata, select = c(datetime, avg_flow, weekday))

##	merge avg_flow_data and raindata by "datetime"
mergedata = merge(avg_flow_data, raindata, by="datetime")

mergedata = subset(mergedata, select = c(datetime, avg_flow, rainfall, weekday.x))

##	rename col names.
colnames(mergedata) <- c("datetime", "avg_flow", "rainfall", "weekday")

attach(mergedata)

##	filter the mergedata which is less than -1 and asign it to mergedataExist
mergedataExist = mergedata[avg_flow>-1,]

detach(mergedata)
attach(mergedataExist)

##	split time: 2013/1/1  01:00:00 AM => 01:00
## 	And sets datetime like "%H:%M" formate
temptime <- read.table(textConnection(as.character(mergedataExist$datetime)))
mergedataExist$datetime <- temptime$V2

##	divide mergedataExist to two parts.
##	withRain => rainfall > 0
##	withoutRain => rainfall == 0
withRain = mergedataExist[rainfall>0,]
withoutRain = mergedataExist[rainfall==0,]

withRainAgg = aggregate(withRain[2:2], by=list(withRain$weekday, withRain$datetime), mean)
withoutRainAgg = aggregate(withoutRain[2:2], by=list(withoutRain$weekday, withoutRain$datetime), mean)

##	rename col names.
colnames(withRainAgg) <- c("weekday", "datetime", "avg_flow")
colnames(withoutRainAgg) <- c("weekday", "datetime", "avg_flow")

##	sort by weekday
withRainAgg = withRainAgg[with(withRainAgg, order(withRainAgg$weekday)),]
withoutRainAgg = withoutRainAgg[with(withoutRainAgg, order(withoutRainAgg$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
withRainAgg$weekday <- paste("Day", withRainAgg$weekday, "_with_rain")
withoutRainAgg$weekday <- paste("Day", withoutRainAgg$weekday, "_without_rain")

combineData = rbind(withRainAgg, withoutRainAgg)

##	output combineData to .csv
write.csv(combineData, file = "Q5.csv")

ggplot(combineData, aes(datetime, avg_flow, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q5.pdf")
