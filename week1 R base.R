

print("hello world!")
print("hello world!")
print("hello world!")

#모든 계산 가능
1*2
3*4
2/4

#변수(variable) 만들기
#왼쪽이 객체, 오른쪽은 투입할 데이터 (순서에 유의하세요)
a<-2
a
a<-3
a

#concatenate의 약자 c, 연결의 의미
a<-c(3,5)
a

a<-c(3,5) 
a

###########################################################################
###      <1. scalar, vector, array, list, dataframe의 이해>       #######
##############################################################################


#scalar: 하나의 원소(element)
scalar<-1
scalar
scalar<-"bts"
scalar

#vector : 여러개의 원소들이나 하나의 row
vector <-c(1,2,3)
vector
vector <-c("v", "rm", "suga")
vector

#matrix : 2*2, 2*3의 행렬 (vector를 여러개의 row로 쌓은형태)


matrix <-matrix(c(1,2,3,4,5,6), nrow=3)
matrix
matrix <-matrix(c(1,2,3,4,5,6), nrow=2)
matrix
matrix <-matrix(c(1,2,3,4,5,6), nrow=2, byrow=TRUE)
matrix
matrix <-matrix(c(1:20), nrow=4, ncol=5, byrow=TRUE)
matrix  

mat1 <-c(1:3)
mat2 <-c(4:6)
matrix<-c(mat1, mat2)
matrix

matrix <-cbind(mat1, mat2)  #cbind : column을 기준으로 종으로 붙이기
matrix
matrix <-rbind(mat1, mat2)  #rbind : row을 기준으로 횡으로 붙이기
matrix

##특정 위치의 요소 추출 및 치환
matrix[1,2]
matrix[1:2]
matrix[1:3]
matrix[1:4]
matrix[2:4]

matrix[1,] #첫번째 row의 모든 원소를 추출
matrix[,1] #첫번째 col의 모든 원소를 추출
matrix[c(1,2),] #1,2번째 row의 모든 원소를 추출
matrix[1,2]=100
matrix

##array : matrix를 여러층으로 쌓은것
matrix1<- matrix(c(1:9), nrow=3)
matrix1
matrix2<- matrix(c(10:18), nrow=3)
matrix3<- matrix(c(19:27), nrow=3)
matrix2
matrix3
array <-array(c(matrix1, matrix2, matrix3), dim=c(3,3,3))
array
 
##data.frame
btsname <-c("RM", "Jin", "suga","jhope", "jimin", "V", "JK")
btsyear <-c(1994, 1992, 1993, 1994, 1995, 1995, 1997)
btsposition <-c("rap", "vocal", "rap", "rap", "vocal", "vocal","vocal")
bts <-data.frame(btsname, btsyear, btsposition)
bts   
str(bts)
# $ btsname    : chr  "RM" "Jin" "suga" "jhope" ...
# $ btsyear    : num  1994 1992 1993 1994 1995 ...
# $ btsposition: chr  "rap" "vocal" "rap" "rap" ...


## factor로 level 부여 및 stringsasfactor

bts <-data.frame(btsname, btsyear, btsposition, stringsAsFactors = TRUE)
str(bts)
# $ btsname    : Factor w/ 7 levels "jhope","jimin",..: 5 3 6 1 2 7 4
# $ btsyear    : num  1994 1992 1993 1994 1995 ...
# $ btsposition: Factor w/ 2 levels "rap","vocal": 1 2 1 1 2 2 2

gender=factor(c("male", "female", "female", "male"))
gender
str(gender) # : 2112

#level 바꾸기 : levels=c()

gender=factor(gender, levels=c("male", "female"))
gender
str(gender) # : 1221

#dataframe 활용
#변수 선택 $표시 활용
bts$age <- 2021-bts$btsyear+1
bts
bts$null <-NULL
bts
bts$na <-NA
bts
dim(bts)

#na=not available의 약자. 결측치를 의미함
#NULL=존재하지 않는 값
#na와 null의 차이는 mean 산출시 확인 가능
#null은 자동으로 무시되어 mean 산출
#na는 평균에 영향을 미침. 따라서 na.rm=TRUE 옵션을 통해 na를 무시하고 평균을 구할 수 있음

bts
bts[1,5]<-3
bts[2,5]<-5
bts[3,5]<-1
mean(bts$na) # -> NA
mean(bts$na,na.rm = TRUE) # -> 3

bts[1,4]<-NA    #대괄호는 indexing, [row, column] 순서를 기억하자
mean(bts$age)
mean(bts$na, na.rm=TRUE)
bts

###########################################################################
###      <2. 자료 입출력 및 기초통계>       #######
##############################################################################


#작업 디렉토리 설정하기 -> r project를 쓰지않고 script를 개별 저장관리할 경우
getwd()
setwd("C:\\Users\\Owner\\Documents\\new") ##자료 저장 directory 설정


#package 불러오기(install)와 열기(library)
install.packages("readxl")
install.packages("foreign")
library(readxl)
library(foreign)

#자료 입력 및 출력
#외부자료 가져오기. excel은 csv 파일로 가져오기 추천
data_csv <- read.table("data_csv.csv", header = T, sep=",") 
data_spss <- read.spss("data_sav.sav", use.value.labels=T, to.data.frame=T)
#외부자료 내보내기. excel은 csv 파일로 내보내기 추천
write.table(data_csv, "data_csv2.csv", sep=",", row.names = F, quote=F)
write.foreign(data_spss, "data_spss2.dat", "data_spss2.sav", package="SPSS")


#기초통계 (summary)
View(data_csv)
str(data_csv)

#score2가 character변수이므로 numeric으로 변경
data_csv$score2 <- as.numeric(data_csv$score2)

####!!!!!!!!!쉼표때문에 missing이 생기는걸 확인했습니다. !!!!!!!!!!#####
####gsub 함수를 활용해 쉼표를 없애겠습니다
#방법 : gsub(“제거할 내용“, “제거방식”, 객체$변수)


data_csv$score2 <- gsub(",", "", data_csv$score2)
data_csv$score2 <- as.numeric(data_csv$score2)
#edu와 employment도 factor로 변환하겠습니다
data_csv$edu=factor(data_csv$edu, 
                    levels=c("elementry", "middle", "high"))
data_csv$employment=factor(data_csv$employment, 
                           levels=c("employed", "unemployed"))

summary(data_csv)
summary(data_csv$score)


table(data_csv$edu)
addmargins(table(data_csv$edu))

table(data_csv$edu, data_csv$employment)
addmargins(table(data_csv$edu, data_csv$employment))





