<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/newWrite.css" />
<style>
</style>
</head>
<body>
<div id="wrap">
<div id="formArea">
	<form action="/board" method="post" enctype="multipart/form-data"> <!--파일은 이진데이터이다. 그래서 전송시에 다른 형태의 데이터임을 명
	시해주어야 한다. 그게 enctype이고, 폼에 인코딩 타입을 표시해주는 것이다.-->
		 제목 : <input type="text" name="title" size=40> <br />
		 
		<textarea name="contents" rows="10" cols="50">글자를 미리 넣어보자</textarea>
		<br>
		<input type ="file" name ="file" size = "50"/>  <!-- 서버로 전송되는 것은 name뒤에 있는 명칭이다. -->
		<br>
		<div class="buttenoutline">
		<input type="submit" value="보내기">
		<input type="reset" value="지웁니다">
		</div>
	</form>
</div>
</div>

</body>
</html>