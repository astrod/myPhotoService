<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/listPageCss.css" />
<link rel="stylesheet" media="screen" type="text/css" href="/stylesheets/cssReset.css" />
<link href='http://fonts.googleapis.com/css?family=Ribeye' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Days+One' rel='stylesheet' type='text/css'>

<title>Insert title here</title>
</head>
<body>
<div class="mainTopBar">
    <p>Just Buy It</p>
    <span>${sessionScope.userid}님의 방문을 환영합니다</span>
    <a href="http://localhost:8080/board/logout">로그아웃</a>
    </div>
    
    <div id="wrap">
<div id="formArea">
	<form action="/board" method="post" enctype="multipart/form-data"> <!--파일은 이진데이터이다. 그래서 전송시에 다른 형태의 데이터임을 명
	시해주어야 한다. 그게 enctype이고, 폼에 인코딩 타입을 표시해주는 것이다.-->
		 <input type="text" name="title" size=40> <br />
		 
		<textarea name="contents" rows="10" cols="50"></textarea>
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
    
    
<c:forEach items="${boards}" var="board"> <!-- model을 통해, 보드 리퍼지터리의 인스턴스가 리스트로 전달되었다. 이제 그 값에 접근하려면
그걸 저장할 때의 key값으로 접근한다. 보드에 있는 key 값은 id, title, contents, filename이다. 이 하나의 인스턴스에 접근하려면 board.title같이
접근하면 된다. 아래의 ${board.title } 같이 선언하면, 보드 클래스의 gettitle();을 호출하게 되고, 값으로 타이틀을 리턴하게 된다.  -->

    
<div class="warp">

<div class="warpTopBar">
    <span>${board.title}</span>
    </div>
${board.contents} <br>
<img src=/images/${board.fileName} width="600px" height="450px" class="image">
<form action="/board/${board.id}/remove" method="post">
<input type="submit" value="수정" class="remove">
</form>
<form action="/board/${board.id}/delete" method="post">
<input type="submit" value="삭제" class="delete">
</form>
</div>
<div class="commentWarp">
<a href="javascript:void(0)" class="showlist">댓글</a> <br>
<span> </span>개의 댓글이 있습니다.
<div class="commentlist">
<div class="listupload">
<c:forEach items ="${board.comments}" var = "comment">
<p>
${sessionScope.userid} : ${comment.contents}
<span class="deleteButten"></span> <a href="board/${comment.id}/commentDelete">삭제</a> 
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
    </div>
</c:forEach>
<!-- foreach문의 문법은 item 에는 배열등의 데이터를 삽입한다. var은 데이터에서 할당된 값이다. begin은 시작값, end는 끝값, step은 그 사이의 절차이다.
괄호를 닫고 그 안에는 루프를 돌릴 데이터를 삽입한다. -->
	<script>
	function initPage() { 
		countComment();
		registerEvents();
	}
	function countComment() //comment의 개수를 카운트하는 함수. 
	{	
		var commentListNumber = document.querySelectorAll('.listupload'); // 모든 commentlist클래스를 배열로 받아온다.
		for(var i = 0 ; i<commentListNumber.length; i++) //배열의 길이만큼 돌리면
		{
			commentNumber = commentListNumber[i].querySelectorAll('p').length; //각 클래스의 'p'의 길이만큼 넘버로 받아온다.
			var commentContainer = commentListNumber[i].parentNode.parentNode.querySelector('span'); //그거를 옮겨
			commentContainer.innerText = commentNumber; // innerText로 넣는다.
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
		var eleForm = e.currentTarget.form; //form element. 클릭한 지점에서의 form을 eleForm에 저장한다.
		var oFormData = new FormData(eleForm); //form data 들을 자동으로 묶어준다. xml의  sand 메소드를 이용해서 전송할 수 있게 일련의 키벨류값을 만든다.
		
		var sID = eleForm[0].value; // 현재페이지의 id 값을 확인한다.
		var url = "/board/" + sID + "/comments.json"; // 서버로 보낼 주소 
		
		var request = new XMLHttpRequest(); //객체생성 
		request.open("POST", url, true); // open; method : 요청타입(get or post); url : 서버에 있는 파일의 위치; async : true(비동기) or false(동)
 		request.send(oFormData); // 서버로 요청을 보낸다 (POST시 안의 파라미터 사용)
		
		request.onreadystatechange = function() {
			if(request.readyState == 4 && request.status == 200) {
				var obj = JSON.parse(request.responseText);
				var eleCommentList = eleForm.parentNode.parentNode.querySelector('.commentlist').querySelector('.listupload');
				eleCommentList.insertAdjacentHTML("beforeend", "<p>"+obj.contents+"</p>");
				countComment();
				/* var deleteCommentList = document.querySelectorAll('.deleteButten');
				for(var count=0; count<deleteCommentList.length; count++) {
					deleteCommentList.innerHTML = "<a href="board/${comment.id}/commentDelete">삭제</a>";
				} */
			} 
		}
		
	}

	window.onload = initPage;
	</script>
</body>
</html>