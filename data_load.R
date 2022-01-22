#파일 불러오기, 정형, 비정형 데이터 불러오기
#상대 경로:역삼에서 삼성은 오른쪽, 잠실에서는 왼쪽~기준점에 따라 변함. 
#          R에서 현재 나의 경로를 알아내는 방법
#          getwd() 겟워킹디렉토리
getwd()
readLines('day03/korea.txt' ) #컨트롤 +스페이스

#절대 경로:삼성 주소를 주면 됨. 좌표값 같은~변하지 않는 것. 전체 경로 표시되어 있음.
readLines('C:/R/workspace/day03/korea.txt')
# 내 컴 주소로 해외에서 들어올 수는 없음. 보안 때문에. 그러나 누구에게나 열려있는 곳을 서버라고 함.
# 네이버 사이트가 보임ㅎㅎhtml이라는 언어로 웹을 만들어놓은 것일 뿐. 그래서 URL 주소를 알면
# 절대 경로로 웹 데이터를 불러올 수 있는 것.
# https://github.com/luxdolorosa/data_set

#실습하기 무비 리뷰 01 읽어오기
txt1<-readLines('https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/movie_review_01.txt')
txt1 #비정형 데이터이자(열이 없음) 벡터 형태(10줄의 문자열을 가진)

#실습하기 txt1의 데이터 중 영화가 포함된 데이터 검색
grep('영화',txt1)
txt1[grep('영화',txt1)]

#txt1에서 40글자 이상인 데이터만 검색하기
#grep('.............',txt1) #점이 글자를 대체할 수 있음. 점을 40번ㅋㅋ
grep(strrep('.',40),txt1)

#두 가지 조건을 동시에 이용해서 검색하기, 그랩을 집합 함수랑 같이 이용
a<-grep(strrep('.',20),txt1)
b<-grep('영화',txt1)
intersect(a,b)
txt1[intersect(a,b)]

#pdf에서 데이터 읽기, pdf, docx, xlsx, pptx x가 붙으면 마이크로소프트 꺼. 외부 패키지가 필요
# docx, pptx 는 안 읽어드리는 것이 나음. 차라리 pdf로 읽는 것이 나음. 

install.packages('pdftools')
library(pdftools)

#pdf_text(파일의 경로+파일명), pdf는 다운로드 후 내 pc에서 읽어야 함.
pdf1<-pdf_text('C:/R/workspace/day03/movie_review_02.pdf')
pdf1
#개행문자로 나누기=엔터값(\n\n)으로 나누기
txt_pdf<-strsplit(pdf1,'\n') #리스트로 나옴.

#실습: 5번째 방을 보여주세요
txt_pdf[[1]][5]
txt_pdf<-txt_pdf[[1]]
txt_pdf
txt_pdf[5]
#벡터에서 필요없는 방 삭제하기(삭제된 상태로 조회하기)
txt_pdf[c(-2,-4,-7)]
txt_pdf<-txt_pdf[c(-2,-4,-7)]
txt_pdf
#3번방과 4번방 합치기
paste(txt_pdf[3],txt_pdf[4])
txt_pdf[3]<-paste(txt_pdf[3],txt_pdf[4])
txt_pdf<-txt_pdf[-4]
txt_pdf

#테이블 구조(구조화된)를 가진 데이터 로드하기, read.table은 자동으로 열 이름이 지정됨.
readLines('https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/member_no_title.txt')
mem1<-read.table('https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/member_no_title.txt')
class(mem1)

#실습하기: 열 이름을 이름, 성적, 평균으로 바꾸기
names(mem1)<-(c('이름','성적','평균'))
names(mem1)
mem1

#데이터를 읽어온 후 기본적으로 해야하는 작엄: 요약 정보 확인하기
summary(mem1)

#헤더 정보(열이름, 메타 정보)가 있는 데이터 로드하기, 무조건 1번째 행이 헤더로 잡힘.
mem2<-read.table(header = T,'https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/member_yes_title.txt')
mem2

#데이터가 많은 경우 한 눈에 파악하기 어렵기 때문에~head, tail 위 아래 6개씩
head(mem2)
tail(mem2)
#R을 파이썬 언어로 번역? 만들어 놓은 것이 판다스~! 여기서는 5개씩 나옴ㅋㅋ

#실습하기 mem2의 평균열의 데이터 중에서 전체 평균점수 이상인 데이터만 조회
mem2$'평균'
mean(mem2$'평균')

mem2[mem2$'평균'>=mean(mem2$'평균'),]

read.table(skip=3,header = T,'https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/member_noise.txt')

read.table(sep=',',header=T,'https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/member_yes_sep2.txt')

#csv(콤마 세퍼레이트 밸류) 파일 읽기, 보통 구조화되어 있음. 콤마 구분자, 헤더 정보를 가지고 있음. 
f<-read.csv(row.names = '순번','https://raw.githubusercontent.com/luxdolorosa/data_set/master/etc/fruits.csv')
f
#f의 종류, 열의 데이터를 과일은 1, 채소는 2로 변경
f$'종류'
#f[f$'종류'=='과일','종류']<-1
#f[f$'종류'=='채소','종류']<-2

#펙터를 이용하여 수정하기
factor(f[,4])
as.numeric(factor(f[,4]))
f$'종류'<-as.numeric(factor(f[,4]))
f

#데이터 가공하기
f
#종류별로 데이터 split하기
s<-split(f,f$'종류')
s[[1]]
s[[2]]
sum(s[[1]]$'가격')
sum(s[[2]]$'가격')

data.frame(a=sum(s[[1]]$'가격'),b=sum(s[[2]]$'가격'))
a<-c(sum(s[[1]]$'가격'),sum(s[[2]]$'가격'))
names(a)<-c('a','b')
a
