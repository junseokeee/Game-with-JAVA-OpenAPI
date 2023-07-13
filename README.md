 # 내가 그린 Green 그림

<img width="1470" alt="스크린샷 2023-07-04 오후 1 53 00" src="https://github.com/junseokeee/Game-with-JAVA-OpenAPI/assets/88473134/7eea5714-2daa-4bbd-b525-a87781f40b3b">
<img width="1470" alt="스크린샷 2023-07-04 오후 1 53 14" src="https://github.com/junseokeee/Game-with-JAVA-OpenAPI/assets/88473134/560dd19f-0142-4829-bbbb-e38c2fab0ada">

<br/>

 - 단어 배열에서 10개의 값 추출
 - 10개의 값에서 3개의 단어 추출
 - 3개의 단어를 Papago API 사용해 번역(Karlo API가 영문만 지원)
 - 번역된 단어를 Karlo API에 전달
 - 전달받은 단어로 이미지 생성
 - 추출된 10개의 단어에서 이미지를 보고 3개의 단어를 유추
 - 정답을 맞히면 카운트가 올라감
   
<br/>

# Papago API
 - 파파고의 인공 신경망 기반 기계 번역 기술(NMT, Neural Machine Translation)로 텍스트를 번역한 결과를 반환하는 RESTful API

<br/>

# Karlo API
 - 요청: image 파라미터에 이미지 파일 Base64 인코딩한 값 전달
 - 응답: image 값을 Base64 디코딩 후 웹에서 이미지 출력

<br/>

# 개발툴 환경
 - JDK 1.8+
 - IntelliJ Community Edition(or Eclipse)
