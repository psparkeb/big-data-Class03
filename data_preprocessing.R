#분석을 위한 데이터 로드하기
df_web<-read.csv('https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/my_lib.csv')

summary(df_web)
#데이터 분석 목표: 전국 도서관의 시도명, 시군구명, 도서관 유형을 그룹화하기

#각 칼럼에 대한 정보 확인, 결측치 확인
str(df_web)
is.na(df_web)
sum(is.na(df_web))
table(is.na(df_web))

#데이터 분석을 위해 외부 라이브러리 설치
install.packages('dplyr')
library(dplyr)

#filer():행 추출/ select():열 추출/arrange():정렬/mutate():열 추가/group_by():그룹 묶기

head(select(df_web,'시도명'))
df_lib_g<-select(df_web,c('시도명','시군구명','도서관유형'))
select(df_web,c(2,3,4))
subset(df_web,select = c('시도명','시군구명','도서관유형')) #위와 같은 것임.

#시도명으로 그룹화
#group_by(data,key1,key2...)
group_by(df_lib_g,시도명) #''감싸지 않고 그냥 써야 함.
sido_g<-group_by(df_lib_g,시도명)
sido_g
a<-count(sido_g)

#정렬하기
a[order(a$n),]
a[order(-a$n),]

#시도명, 시군구명, 도서관유형으로 그룹화하기
df_lib_g
names(df_lib_g)<-c('sido','sigungu','type')
head(df_lib_g)

b<-group_by(df_lib_g,sido,sigungu,type)
lib_b<-count(b)

#파일 저장
#write.csv(데이터, 파일 경로)
getwd()
write.csv(lib_b,'lib.csv')

#실습하기: 시군구별 도서관 개수 조회하기
table(df_lib_g$sigungu)
