<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>You Are Fail</h1>

	<c:if test="${not empty errorMsgs }">

		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li>${message }</li>
			</c:forEach>
		</ul>

	</c:if>

</body>
</html>