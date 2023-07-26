getwd()

install.packages("readxl")
install.packages("foreign")
library(readxl)
library(foreign)

### <2. 전략분야>####

data2<-read.csv("asdf11.csv",header=T, fileEncoding = "euc-kr")
data2


x<-data2$category
y<-data2$rating

class(x)

result<-data.frame(category = x, rating = y)
result

table(result)

install.packages("gmodels")
library(gmodels)

CrossTable(result$category, result$rating)
chisq.test(result$category, result$rating)
