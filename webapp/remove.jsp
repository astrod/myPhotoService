
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/removePageCss.css" />
<style>
</style>
</head>
<body>
<div id="wrap">
<h2>수정하는 페이지</h2>
<div id="formArea">
	<form action="/board/removepage/${remove.id}" method="post">
		 제목 : <input type="text" name="title" size=40 value="${remove.title}"> <br/>
		 
		<textarea name="contents" rows="10" cols="50">${remove.contents}</textarea>
		<br>
		<input type ="file" name ="file" size = "50"/> 
		<br>
		<div class="buttenoutline">
		<input type="submit" value="수정할껍니다">
		<input type="reset" value="지웁니다">
		</div>
	</form>
</div>
</div>

</body>
</html>