getwd()

install.packages("readxl")
install.packages("foreign")
library(readxl)
library(foreign)

###################################################
###             <1. 대중소상생형 카이제곱 분석>         ####
###################################################


data1<-read.csv("1. 대중소상생형.csv",header=T, fileEncoding = "euc-kr")
data1
data1<-data1[-c(72,73,74,75),]
data1

x<-data1$category
y<-data1$rating

class(x)

result1<-data.frame(category = x, rating = y)
result1

table(result1)

install.packages("gmodels")
library(gmodels)

CrossTable(result1$category, result1$rating)
chisq.test(result1$category, result1$rating)

###################################################
###               <2. 전략분야 카이제곱 분석>         ####
###################################################

data2<-read.csv("2. 전략분야.csv",header=T, fileEncoding = "euc-kr")
data2


x<-data2$category
y<-data2$rating

class(x)

result2<-data.frame(category = x, rating = y)
result2

table(result2)

install.packages("gmodels")
library(gmodels)

CrossTable(result2$category, result2$rating)
chisq.test(result2$category, result2$rating)

