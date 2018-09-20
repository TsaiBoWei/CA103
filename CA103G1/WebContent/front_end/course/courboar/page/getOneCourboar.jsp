<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.boardres.model.*"%>
<%@ page import="com.courboar.model.*"%>
<%CourBoarVO courBoarVO = (CourBoarVO) request.getAttribute("courBoarVO");%>


<!DOCTYPE html>
<html>
<head>

<title>getOneCourboar.jsp</title>
</head>
<body>

	<div class="modal-header courboarmodalheader">
		<div class="form-group text-left text-white form-group-100">
			<label>Title</label>
			<div class="col-12 px-0 text-white">
				<input type="text" name="crpos_tit"
					class="form-control courboarformtitle text-white" value="${courBoarVO.crpos_tit}">
			</div>
		</div>
	</div>
	<div class="modal-body text-left">
		<div class="form-group text-white">
			<label>Content</label>
			<textarea class="form-control courboardqtext  text-white" rows="5"
				name="crpos_text">${courBoarVO.crpos_text}</textarea>
		</div>
	
	<input type="hidden" name="crpost_id" value="${courBoarVO.crpost_id}"></input>
	
	<c:if test="${not empty errorMsgs}">
		
		<div class="errorMsgs mt-2 text-secondary"><i class="fas fa-exclamation-triangle"></i>&nbsp;Please note&nbsp;:&nbsp;<c:forEach var="message" items="${errorMsgs}">${message}&nbsp;</c:forEach></div>
		
	</c:if>
	</div>

</body>
</html>