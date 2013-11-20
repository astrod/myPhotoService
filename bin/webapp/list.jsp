<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${boards}" var="board"> <!-- model을 통해, 보드 리퍼지터리의 인스턴스가 리스트로 전달되었다. 이제 그 값에 접근하려면
그걸 저장할 때의 key값으로 접근한다. 보드에 있는 key 값은 id, title, contents, filename이다. 이 하나의 인스턴스에 접근하려면 board.title같이
접근하면 된다. 아래의 ${board.title } 같이 선언하면, 보드 클래스의 gettitle();을 호출하게 되고, 값으로 타이틀을 리턴하게 된다.  -->
${board.title }
<form action="/board/${board.id}/remove" method="post">
<input type="submit" value="수정할껍니다">
</form>
<form action="/board/${board.id}/delete" method="post">
<input type="submit" value="삭제할거에요">
</form>
<hr/>
</c:forEach>
<!-- foreach문의 문법은 item 에는 배열등의 데이터를 삽입한다. var은 데이터에서 할당된 값이다. begin은 시작값, end는 끝값, step은 그 사이의 절차이다.
괄호를 닫고 그 안에는 루프를 돌릴 데이터를 삽입한다. -->
	<a href="/board/form">돌아가기</a>
</body>
</html>