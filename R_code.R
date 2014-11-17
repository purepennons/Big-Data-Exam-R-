##	Q1

library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")

##	choose datetime, avg_flow and weekday columns from flowdata and asign to avg_flow_data.
avg_flow_data = subset(flowdata, select = c(datetime, avg_flow, weekday))
attach(avg_flow_data)

##	filter the avg_flow data which is less than -1
avg_flow_data[avg_flow>-1,]

##	split time: 2013/1/1  01:00:00 AM => 01:00
## 	And sets datetime like "%H:%M" formate

temptime <- read.table(textConnection(as.character(avg_flow_data$datetime)))
avg_flow_data$datetime <- temptime$V2

##	aggregate avg_flow to mean values by weekday and datetime
temp1 = aggregate(avg_flow_data[2:2], by=list(avg_flow_data$weekday, avg_flow_data$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_flow")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid i to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q1.csv")

##	use ggplot2 to draw the image.
ggplot(temp1, aes(datetime, avg_flow, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q1.pdf")


###########################################################

##	Q2_small_sedan

library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")

##	choose datetime, avg_small_flow and weekday columns from flowdata and asign to avg_small_flow_data.
avg_small_flow_data = subset(flowdata, select = c(datetime, avg_small_flow, weekday))
attach(avg_small_flow_data)

##	filter the avg_flow data which is less than 0.
avg_small_flow_data[avg_small_flow>0,]

##	split time: 2013/1/1  01:00:00 AM => 01:00
## 	And sets datetime like "%H:%M" formate

temptime <- read.table(textConnection(as.character(avg_small_flow_data$datetime)))
avg_small_flow_data$datetime <- temptime$V2

##	aggregate avg_small_flow to mean values by weekday and datetime
temp1 = aggregate(avg_small_flow_data[2:2], by=list(avg_small_flow_data$weekday, avg_small_flow_data$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_small_flow")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q2_small.csv")

##	use ggplot2 to draw the image.
ggplot(temp1, aes(datetime, avg_small_flow, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q2_small.pdf")

###########################################################

##	Q2_bigger_car

library(ggplot2)

flowdata = read.table(file="flowdata.csv",  header=TRUE, sep=",")

##	choose datetime, avg_big_flow and weekday columns from flowdata and asign to avg_big_flow_data.
avg_big_flow_data = subset(flowdata, select = c(datetime, avg_big_flow, weekday))
attach(avg_big_flow_data)

##	filter the avg_flow data which is less than 0.
avg_big_flow_data[avg_big_flow>0,]

##	split time: 2013/1/1  01:00:00 AM => 01:00
## 	And sets datetime like "%H:%M" formate

temptime <- read.table(textConnection(as.character(avg_big_flow_data$datetime)))
avg_big_flow_data$datetime <- temptime$V2

##	aggregate avg_big_flow to mean values by weekday and datetime
temp1 = aggregate(avg_big_flow_data[2:2], by=list(avg_big_flow_data$weekday, avg_big_flow_data$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_big_flow")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q2_big.csv")

##	use ggplot2 to draw the image.
ggplot(temp1, aes(datetime, avg_big_flow, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q2_big.pdf")

###########################################################

##	Q3

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

print("Max: ")
print(temp1[temp1$avg_flow==max(temp1$avg_flow),])
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
print("Max: ")
print(temp1[temp1$avg_flow==max(temp1$avg_flow),])
print("Min: ")
print(temp1[temp1$avg_flow==min(temp1$avg_flow),])

###########################################################

##	Q4

library(ggplot2)

raindata = read.table(file="raindata.csv",  header=TRUE, sep=",")
attach(raindata)

##	filter the rainfall which is less than 0.
raindata[rainfall>0,]

##	split time: 2013/1/1  01:00:00 AM => 01:00
## 	And sets datetime like "%H:%M" formate

temptime <- read.table(textConnection(as.character(raindata$datetime)))
raindata$datetime <- temptime$V2

##	aggregate rainfall to mean values by weekday and datetime
temp1 = aggregate(raindata[3:3], by=list(raindata$weekday, raindata$datetime), mean)

##	rename col names.
colnames(temp1) <- c("weekday", "datetime", "avg_rainfall")

##	sort by weekday
temp1 = temp1[with(temp1, order(temp1$weekday)),]

##	rename content of weekday in order to avoid to become continuous values.
temp1$weekday <- paste("Day ", temp1$weekday)

##	output temp1 to .csv
write.csv(temp1, file = "Q4_rainfall.csv")

##	use ggplot2 to draw the image.
ggplot(temp1, aes(datetime, avg_rainfall, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q4_rainfall.pdf")

###########################################################

## Q5_mean_by_hour

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

##	aggregate withRain and withoutRain to mean values by weekday and datetime.
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

##	combine withRainAgg and withoutRainAgg together by row.
combineData = rbind(withRainAgg, withoutRainAgg)

##	output combineData to .csv
write.csv(combineData, file = "Q5_mean_by_hour.csv")

ggplot(combineData, aes(datetime, avg_flow, color=weekday)) + geom_line(aes(group = weekday))

ggsave(file="Q5_mean_by_hour.pdf")

###########################################################

##	Q5_mean_ALL

library(ggplot2)
library(plyr)
library(reshape2)

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

##	aggregate withRain and withoutRain to mean values by weekday.
withRainAgg = aggregate(withRain[2:2], by=list(withRain$weekday), mean)
withoutRainAgg = aggregate(withoutRain[2:2], by=list(withoutRain$weekday), mean)

##	Add With_Rain column to withRainAgg and withoutRainAgg which content show that is raining or not.
withRainAgg = dplyr::mutate(withRainAgg, With_Rain="True")
withoutRainAgg = dplyr::mutate(withoutRainAgg, With_Rain="False")

##	combine withRainAgg and withoutRainAgg together by row.
rbindAgg = rbind(withRainAgg, withoutRainAgg)

##	rename col names.
colnames(rbindAgg) <- c("weekday", "avg_flow", "With_Rain")

##	rename content of weekday in order to avoid to become continuous values.
rbindAgg$weekday <- paste("Day ", rbindAgg$weekday)

##	output rbindAgg to .csv
write.csv(rbindAgg, file = "Q5_mean_all.csv")

qplot(x=weekday, y= avg_flow, fill= With_Rain, data=rbindAgg, geom="bar", stat="identity", position="dodge")

ggsave(file="Q5_mean_all.pdf")
