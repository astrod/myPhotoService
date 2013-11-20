<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/loginPageCss.css" />
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/cssReset.css" />
<title>Insert title here</title>
</head>
<body>
    <div class="topBar">
    <h3>로그인</h3>
    </div>
    
    
<div class="warp">    
<form action="/board/loginPage" method="post">
<span>아이디       : </span><input type="text" name="userid" size=30><br>
<span>비밀번호 :</span> <input type="password" name="userpsd" size=30><br>
<div class="buttenWarp">
<input type="submit" value="로그인">
<input type="reset" value="비우기">
    </div>
    </form>
</div>
    
</body>
</html>