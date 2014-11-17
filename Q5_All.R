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

# withRainAgg = aggregate(withRain[2:2], by=list(withRain$weekday, withRain$datetime), mean)
# withoutRainAgg = aggregate(withoutRain[2:2], by=list(withoutRain$weekday, withoutRain$datetime), mean)
withRainAgg = aggregate(withRain[2:2], by=list(withRain$weekday), mean)
withoutRainAgg = aggregate(withoutRain[2:2], by=list(withoutRain$weekday), mean)

withRainAgg = dplyr::mutate(withRainAgg, With_Rain="True")
withoutRainAgg = dplyr::mutate(withoutRainAgg, With_Rain="False")

rbindAgg = rbind(withRainAgg, withoutRainAgg)
colnames(rbindAgg) <- c("weekday", "avg_flow", "With_Rain")

rbindAgg$weekday <- paste("Day ", rbindAgg$weekday)

##	output rbindAgg to .csv
write.csv(rbindAgg, file = "Q5_mean_all.csv")

qplot(x=weekday, y= avg_flow, fill= With_Rain, data=rbindAgg, geom="bar", stat="identity", position="dodge")

ggsave(file="Q5_mean_all.pdf")
