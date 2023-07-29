#######################################
###########   ggplot2    ##############
#######################################


######Initiate packages

#If you don't have ggplot2 installed then use:
install.packages(c("ggplot2", "plyr", "reshape"))
install.packages("Hmisc")
install.packages("Rtool")

#Initiate ggplot2
library(ggplot2)
library(reshape)
library(plyr)
library(dplyr)


#--------Scatterplots----------#two variables, continuous

examData <- read.delim("Exam Anxiety.dat",  header = TRUE)
names(examData)
str(examData)

##"aes" : 그래프별로 별도 지정하거나, 한꺼번에 지정할 수 있음
ggplot(examData, aes(Anxiety, Exam))+
  geom_point()+
  geom_smooth()+
  
  
  
  ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam))

# or

ggplot(examData, aes(Anxiety, Exam))+
  geom_point()

#Simple scatter

ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam, colour = Gender))

ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam), shape=19, size=1, colour="black")

ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam, colour = Gender), size=1, shape=10)

#plot symbol(points) +refer to cheetsheet
help(pch)


#Simple scatter / labs(x=“x축 이름”, y=“y축이름“) /ggtitle("title")


ggplot(examData)+ 
  geom_point(aes(x=Anxiety, y=Exam)) + 
  labs(title="exam", x = "Exam Anxiety", y = "Exam Performance %")

#data labeling 
ggplot(examData)+ 
  geom_point(aes(x=Anxiety, y=Exam)) + 
  labs(title="exam", x = "Exam Anxiety", y = "Exam Performance %")+
  geom_text(aes(label=Code, size=10, vjust=2, hjust=0))#vjust : 위로, hjust : 오른쪽

#shape별 value를 알고 싶을때
help(geom_text)

##집단별 색깔을 달리한 scatter plot
scatter <- ggplot(examData, aes(x=Anxiety, y=Exam, colour=Gender))
scatter + 
  geom_point() + 
  labs(x = "Exam Anxiety", y = "Exam Performance %") + 
  ggtitle("exam anxiety")

##집단별 층위를 나누어서 산포도를 그릴때
str(examData)
examData1<-examData
examData$Gender<-factor(examData$Gender,
                        levels=c(Male,Female)

ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam)) + 
  facet_grid(Gender~.)+ #row로 구분. 점의 위치를 확인할것
  labs(title= "exam anxiety", x = "Exam Anxiety", y = "Exam Performance %")


ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam)) + 
  facet_grid(.~Gender)+ #column으로 구분
  labs(title= "exam anxiety", x = "Exam Anxiety", y = "Exam Performance %") 


#Simple scatter with smooth/ 
ggplot(examData, aes(Anxiety, Exam))+
  geom_point() + 
  geom_smooth() +  # 데이터를 잘설명할 수 있는 smooth line 생성
  labs(title= "exam anxiety", x = "Exam Anxiety", y = "Exam Performance %") 


#Simple scatter with regression line(red)
ggplot(examData, aes(Anxiety, Exam))+
  geom_point() + 
  geom_smooth(method = "lm", colour = "Red", se = F) + #se=standard error(표준오차)
  labs(title= "exam anxiety", x = "Exam Anxiety", y = "Exam Performance %") 


#Grouped scatter with regression line + CI
ggplot(examData)+
  geom_point(aes(x=Anxiety, y=Exam, colour = Gender)) +
  geom_smooth(method = "lm", color="grey", aes(x=Anxiety, y=Exam, fill = Gender), alpha = 0.1) +
  labs(x = "Exam Anxiety", y = "Exam Performance %", colour = "Gender") 


#Simple scatter with regression line + coloured CI (alpha=transparancy)
ggplot(examData, aes(Anxiety, Exam))+ 
  geom_point() + 
  geom_smooth(method = "lm", colour = "Red", fill="Red", alpha = 0.1) + 
  labs(title= "exam anxiety", x = "Exam Anxiety", y = "Exam Performance %") 


#--------HISTOGRAM------------------------------------------------------

##Load the data file into R. This is a tab-delimited file hence use of read.delim

festivalData <- read.delim("DownloadFestival.dat",  header = TRUE)
str(festivalData)

##Histogram with Outlier

ggplot(festivalData) + 
  geom_histogram(aes(day1), binwidth = 0.1) + #binwidth를 0.2, 0.3등으로 변경해보자
  labs(legend.position="none")+ 
  labs(x = "Hygiene (Day 1 of Festival)", y = "Frequency")


#1 outlier cased문에 그래프가 이상한걸 확인
festivalData %>% 
  arrange(-day1) ->festvalData_a


festivalData2 = read.delim("DownloadFestival(No Outlier).dat",  header = TRUE)

ggplot(festivalData2)+
  geom_histogram(aes(day1), binwidth=0.4, color="red")+
  labs(x="Hygiene of Day 1", y="Frequency")

#Density without outlier(추가)
ggplot(festivalData2)+
  geom_density(aes(day1), color="red") +
  labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")


#집단별로 색깔 다르게, alpha=투명도
ggplot(festivalData2) + 
  geom_density(aes(x=day1, fill = gender), alpha = 0.3) + 
  labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")

ggplot(festivalData2)+
  geom_histogram(aes(day1, fill=gender), alpha=0.3) +
  labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")


##면분할을 해보면(facet_grid)

ggplot(festivalData2)+
  geom_histogram(aes(day1), alpha=0.3) +
  facet_grid(.~gender)
labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")

#--------BOXPLOTS----------

ggplot(festivalData)+
  geom_boxplot(aes(x=gender, y=day1)) + 
  labs(x = "Gender", y = "Hygiene (Day 1 of Festival)")

#with outlier removed

festivalData2 = read.delim("DownloadFestival(No Outlier).dat",  header = TRUE)

ggplot(festivalData2)+
  geom_boxplot(aes(x=gender, y=day1)) + 
  labs(x = "Gender", y = "Hygiene (Day 1 of Festival)")

##(학생실습과제) days 2 and 3 각각 box plot 그려보기##



#--------Bar Charts(stat_summary)

chickFlick = read.delim("ChickFlick.dat",  header = TRUE)
str(chickFlick)

ggplot(chickFlick)+
  geom_point(aes(film, arousal))+
  labs(x = "Film", y = "Arousal") 

ggplot(chickFlick)+
  geom_boxplot(aes(film, arousal))+
  labs(x = "Film", y = "Arousal") 


ggplot(chickFlick)+
  stat_summary(
    aes(film, arousal), 
    fun.y = mean, 
    geom = "bar", 
    fill = "pink", 
    colour = "Black")+
  geom_point(aes(film, arousal))+
  labs(x = "Film", y = "Arousal") 


#stat과 geom의 관계를 이해. 모든 geom에서 stat을 쓸수도, 모든 stat에서 geom을 쓸수도, 아니면 stat_summary를 이용하는 방법도 있음
str(examData)
ggplot(examData)+
  stat_count(aes(Gender))

ggplot(examData)+
  geom_bar(aes(Gender))

?geom_bar  #기본stat이 count인것을 확인할 수 있음

ggplot(examData)+
  geom_bar(aes(x=Gender, y=Exam), stat="identity")


ggplot(chickFlick)+
  stat_summary(
    aes(film, arousal), 
    fun.y = mean, 
    geom = "bar", 
    fill = "pink", 
    colour = "Black")+
  geom_point(aes(film, arousal))+
  labs(x = "Film", y = "Arousal") 


ggplot(chickFlick, aes(film, arousal))+
  stat_summary(
    fun.y = mean, 
    geom = "bar",
    width=0.4,
    fill = "White", 
    colour = "Black") + 
  stat_summary(
    fun.data = mean_cl_normal, 
    geom = "errorbar", 
    width=0.4, 
    color="Red") +
  labs(x = "Film", y = "Mean Arousal") 


install.packages("Hmisc", dependencies=TRUE, repos="https://cran.rstudio.com")
library(Hmisc)
##position dodge


##ggplot 안에 aes(colour=gender)를 두었을때와 외부에 두었을때의 차이
ggplot(chickFlick, aes(film, arousal, fill=gender))+
  stat_summary(
    fun.y = mean, 
    geom = "bar", 
    position="dodge") +
  stat_summary(
    fun.data = mean_cl_normal, 
    geom = "errorbar", 
    position=position_dodge(width=0.90),   
    width = 0.1) +
  labs(x = "Film", y = "Mean Arousal", fill = "Gender")


##facet_wrap과 facet_grid의 차이
#facet grid : combinations of two var. display all facet even if some are empty
#facet_wrap : 1 var. 만일 two variable일때는 rectangular facet으로 각각 구분

ggplot(chickFlick, aes(film, arousal, fill = film))+
  stat_summary(
    fun.y = mean, 
    geom = "bar") + 
  stat_summary(
    fun.data = mean_cl_normal, 
    geom = "errorbar", 
    width = 0.2) + 
  facet_wrap(~gender) + #facet_wrap(~) : 변수로 감싸주는 방식으로 그래프 분리
  labs(x = "Film", y = "Mean Arousal") + 
  theme(legend.position="none")##theme : legend, axis, panel 등 다양한 옵션 변경 가능

ggplot(chickFlick, aes(film, arousal, fill = film))+
  stat_summary(
    fun.y = mean, 
    geom = "bar") + 
  stat_summary(
    fun.data = mean_cl_normal, 
    geom = "errorbar", 
    width = 0.2) + 
  facet_grid(gender~.) + #facet_wrap(~) : 변수로 감싸주는 방식으로 그래프 분리
  labs(x = "Film", y = "Mean Arousal") + 
  theme(legend.position="none")##theme : legend, axis, panel 등 다양한 옵션 변경 가능
    
    
    #--------Line Charts------------------------------------------
    
    hiccupsData <- read.delim("Hiccups.dat",  header = TRUE)
    hiccups<-stack(hiccupsData)
    str(hiccups)
    names(hiccups)<-c("Hiccups","Intervention")
    
    hiccups$Intervention=factor(hiccups$Intervention, levels=c("Carotid", "Rectum", "Tongue", "Baseline"))
    str(hiccups)
    hiccups$Intervention_Factor<-factor(hiccups$Intervention, levels(hiccups$Intervention)[c(1, 4, 2, 3)])
    str(hiccups)
    
    
    
    line <- ggplot(hiccups,  aes(Intervention_Factor, Hiccups))
    line + stat_summary(fun.y = mean, geom = "point")
    + stat_summary(fun.y = mean, geom = "line", aes(group = 1),colour = "Red", linetype = "dashed")
    + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2)
    + labs(x = "Intervention", y = "Mean Number of Hiccups")
    
    
