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
<h1 id="post"> REMOVE</h1>
<div id="formArea">
	<form action="/board/removepage/${remove.id}" method="post">
		 제목 : <input type="text" name="title" size=40 value="${remove.title}"> 
		 <br>
		<textarea name="contents" rows="10" cols="50">${remove.contents} </textarea>
		<br>
		<input type="submit" value="수정할껍니다">
		<input type="reset" value="지웁니다">
	</form>
</div>
</div>

</body>
</html>