<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/showcss.css" />
<script>
function initPage() { 
	countComment();
	registerEvents();
}
function countComment() //comment의 개수를 카운트하는 함수. 
{	
	var commentListNumber = document.querySelector('.commentlist').querySelectorAll('.listupload'); // 모든 commentlist클래스를 배열로 받아온다.
	for(var i = 0 ; i<commentListNumber.length; i++) //배열의 길이만큼 돌리면
	{
		commentNumber = commentListNumber[i].querySelectorAll('p').length; //각 클래스의 'p'의 길이만큼 넘버로 받아온다.
		var commentContainer = commentListNumber[i].parentNode.querySelector('h3'); //그거를 h3로 옮겨
		commentContainer.innerText += commentNumber; // innerText로 넣는다.
	}
	
} 
function registerEvents() {
	var eleList = document.getElementsByClassName('showlist'); //showlist라는 클래스를 가져온다.
	for(var i=0; i<eleList.length; i++)
		{
			eleList[i].addEventListener('click', toggleComments, false); //addEventListener(이벤트명, 실행할함수, false)
		} //다 돌면서, 이걸 클릭하면...? 이벤트가 발생하지.
		var formList = document.querySelectorAll('.commentWrite input[type=submit]');
		for(var j=0; j<formList.length; j++) {
			formList[j].addEventListener('click', writeComments, false);
		}
}
function toggleComments(e) {
	var commentBodyNode = e.target.parentNode.querySelector('.commentlist');
	var style = window.getComputedStyle(commentBodyNode);
	var display = style.getPropertyValue('display');
	if(display === 'none')
		commentBodyNode.style.display = 'block';
	else if(display === 'block')
		commentBodyNode.style.display = 'none';
}
function writeComments(e) {
	e.preventDefault();
	var eleForm = e.currentTarget.form; //form element
	var oFormData = new FormData(eleForm); //form data 들을 자동으로 묶어준다.
	
	var sID = eleForm[0].value; // 현재페이지의 id 값을 확인한다.
	var url = "/board/" + sID + "/comments.json"; // 서버로 보낼 주소 
	
	var request = new XMLHttpRequest();
	request.open("POST", url, true);
	request.send(oFormData);
	
	request.onreadystatechange = function() {
		if(request.readyState == 4 && request.status == 200) {
			var obj = JSON.parse(request.responseText);
			var eleCommentList = eleForm.parentNode.parentNode.querySelector('.commentlist').querySelector('.listupload');
			eleCommentList.insertAdjacentHTML("beforeend", "<p>"+obj.contents+"</p>");
		} 
	}
}

window.onload = initPage;
</script>
</head>
<body>
<h3>제목 : ${board.title}</h3> 
<c:if test ="${empty board.fileName}">
<p>안보임</p>
</c:if>
그림 : <img src=/images/${board.fileName} /> 
내용 : ${board.contents} 
<a href="javascript:void(0)" class="showlist">댓글보셈</a>
<div class="commentlist">
<h3>댓글 : </h3> 
<div class="listupload">
<c:forEach items ="${board.comments}" var = "comment">
<p>
${comment.contents}
</p>
</c:forEach>
</div>
</div>
<div class="commentWrite">
<form action="/board/${board.id}/comments" method="post">
<input type="hidden" name="id" value="${board.id}">
	<textarea name="contents" rows="10" cols="50">댓글을 입력하세요</textarea>
	<input type="submit" value="전송하기">
</form>
</div>
</body>
</html>