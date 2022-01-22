#벡터: 같은 자료형 일렬로 나열한 구조, 컴파인 많이 사용
vec1 <-c(1,2,3)
vec2 <-4:6
vec3 <-c(1:4)

vec1
vec2
vec3

#벡터와 궁합이 좋은 함수: 합집합 union
union(vec1,vec2)
union(vec1,vec3) #중복되는 것은 하나로 나옴. 집합set과 비슷

#실습: 벡터 1, 벡터 3을 중복있게 합치기
c(vec1,vec3)

#: 차집합 setdiff
setdiff(vec3,vec1)
setdiff(vec1,vec3)

#: 교집합 intersect
intersect(vec3,vec1)

#: 연결하기 paste(값1,값2,sep): 값1과 값2를 연결, sep 구분자
paste(1,2)  #"1 2" 띄어쓰기로 구분됨
paste(1,2,sep=",")
paste('a','b','c')
paste('a','b','c',sep="")
paste0('a','b','c') #sep없이 그냥 붙일 수 있음.

#실습하기: x1, x2, x3, x4, x5
x<-c(rep('x',5))
x
paste0(x,c(1:5))
paste0(x,1:5)
paste0(1:5,x)

#벡터 만들기
fruit <- c('apple','mango','banana','orange','Apple','pineapple')
fruit

#특정 조건 검색 grep(조건, 값)
grep('apple',fruit) # 1번이 애플, 6번이 파인애플이라 이렇게 나옴.
grep('apple',fruit,ignore.case=T) #1,5,6 나옴

fruit[grep('apple',fruit)] #데이터가 나옴.

grep('^a',fruit) # a로 시작하는 값 찾기
grep('e$',fruit) # e로 끝나는 값 찾기

#fruit 에 숫자, 논리형을 1개씩 추가하기
fruit<-c(fruit,TRUE,123)
fruit

#정규식을 이용하여 grep에서 검색하기
#숫자만 검색
grep('\\d',fruit)
fruit[grep('\\d',fruit)]
#문자만 검색
grep('\\D',fruit)
fruit[grep('\\D',fruit)]

#정렬 sort : 인덱스 번호가 아닌 값 자체를 정렬시킴
nums <-c(2,1,500,4)
nums
sort(nums) #오름차순으로 정렬
sort(nums,decreasing = T) #내림차순으로 정렬

# order :똑같이 정렬이나 인덱스 값이 나옴.
order(nums)
nums[order(nums)]

#data.frame 에서의 정렬, sort는 데이터 프레임에서 사용 불가. 
df<-data.frame(name=c('a','a','b','b'),nums)
df
order(df)
order(df$name)
order(df$nums)

order(df$name,df$nums)
df[order(df$name,df$nums),] #nums 내림차순, 기본 문자에는 순서가 없으므로 팩터로 바꿔서 해야 함.
df[order(df$name,-df$nums),] #nums 오름차순

#with(데이터 프레임, 명령문): R명령문이 한 줄인 경우 사용 가능!!
df$name
with(df,name) #name이라고 써도 df$name이라고 인식함.

length(df$name)
with(df,length(name))

#within(): with()와 비슷하지만 수정이 가능한 함수
df
x<-c(1,NA,3,NA)
df<-data.frame(df,x)
df
within(df,{x<-ifelse(is.na(x),0,x)}) #x의 값이 결측이면 0, 아니면 x넣어라

#attach, detach: with와 비슷하지만 한 줄이 아니어도 사용 가능
attach(df) #df 데이터 프레임 활성화
name # $를 안 붙여도 df에 있는 네임 열을 가져다 쓸 수 있음. detach가 호출되기 전까지~
length(name)
detach(df) #df 데이터 프레임 비활성화
name #비활성화되었으므로 이제 사용 안됨.
