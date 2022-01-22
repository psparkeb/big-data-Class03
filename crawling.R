#크롤링: 반정형 데이터인 html을 통해 웹 상의 비정형, (반정형), 정형 데이터 등을 긁어오는 것
#      : 데이터를 수집하는 상위 기법(고난이도)
install.packages('rvest')
library(rvest)

#읽어올 페이지(url,경로,주소) 지정
url <-'https://en.wikipedia.org/wiki/World_Tourism_rankings#cite_note-WTO_Tourism_Highlights_2019_Edition-1'
url

#html파일은 <head>, <body>로 구성되어 있음. 헤드: 페이지를 꾸미는 설정들
#                                           바디: 페이지에서 눈에 보이는 부분들
# 꼭 기억해야 할 부분: 크롤링에서 id는 #, class는 . 을 외우기!

tour_rank<-read_html(url)

#html에서 원하는 데이터 긁어오기
tables<-html_nodes(tour_rank,'.wikitable')

#html데이터 중 구조적인 데이터 읽기
tables[1]
df<-html_table(tables[1])[[1]]
df

#데이터 정보 확인
str(df)
head(df)
summary(df)

select(df,'Rank')
df<-df[,c(1,2,3)]

#보기 편하게 열 이름 수정

names(df)<-c('rank','des','tour')
df

#tour 열에서 million제거
df$tour
#gsub(치환할 값, 치환될 값, 데이터)
df$tour<-gsub(' million','',df$tour)
df

#프랑스의 결측치를 2위보다 +1 시키는 방법으로 해보기~
df[2,'tour']
max(df$tour)
df<-as.data.frame(df)
as.numeric(max(df$tour))+1
df[1,'tour']<-as.numeric(max(df$tour))+1
df
df$tour<-as.numeric(df$tour)
df
sum(df$tour)

#시각화
barplot(df$tour)
barplot(df$tour,names.arg=df$des,col=1:10)
