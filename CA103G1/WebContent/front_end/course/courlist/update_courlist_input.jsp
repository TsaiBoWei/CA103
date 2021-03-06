<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.courlist.model.*"%>


<%
CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>員工資料修改 - update_courlist_input.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>課程資料修改 - update_courlist_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">
		 <img src="<%=request.getContextPath()%>/front_end/course/courlist/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>課程編號:<font color=red><b>*</b></font></td>
		<td><%=courlistVO.getCour_id()%></td>
	</tr>

	<jsp:useBean id="sportSvc" scope="page" class="com.sptype.model.SptypeService" />
	<tr>
		<td>運動項目:<font color=red><b>*</b></font></td>
		<td><select size="1" name="sptype_id">
			<c:forEach var="sptypeVO" items="${sportSvc.all}">
				<option value="${sptypeVO.sptype_id}" ${(courlistVO.sptype_id==sptypeVO.sptype_id)?'selected':'' } >${sptypeVO.sport}
			</c:forEach>
		</select></td>
	</tr>
			

	<jsp:useBean id="coa_idSvc" scope="page" class="com.coach.model.CoachService" />
	<tr>
		<td>教練編號:<font color=red><b>*</b></font></td>
		<td><select size="1" name="coa_id">
			<c:forEach var="coachVO" items="${coa_idSvc.all}">
				<option value="${coachVO.coa_id}" ${(courlistVO.coa_id==coachVO.coa_id)?'selected':'' } >${coachVO.coa_id}
			</c:forEach>
		</select></td>
	</tr>

	
<%-- 	<jsp:useBean id="coa_idSvc" scope="page" class="com.coach.model.CoachService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>教練編號:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="coa_id"> -->
<%-- 			<c:forEach var="courlistVO" items="${coa_idSvc.all}"> --%>
<%-- 				<option value="${courlistVO.coa_id}">${courlistVO.coa_id} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->
	
	<tr>
		<td>課程名稱:</td>
		<td><input type="TEXT" name="cname" size="45"	value="<%=courlistVO.getCname()%>" ></td>
	</tr>
	
	<tr>
		<td>課程介紹:(要能排版...)</td>
		<td><input type="TEXT" name="cour_text" size="45" value="<%=courlistVO.getCour_text()%>" /></td>
	</tr>
	
	<tr>
		<td>課程費用:</td>
		<td><input type="TEXT" name="cour_cost" size="45" value="<%=courlistVO.getCour_cost()%>" /></td>
	</tr>
	
	<tr>
		<td>課程主頁圖片:(要能顯示預覽、尚無圖片)</td>
		<td>
		<img class="img-fluid rounded-circle" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>">
		<input type="file" name="cour_pho" size="45" value="<%=courlistVO.getCour_pho()%>" />
		</td>
	</tr>
	
<%-- 	<jsp:useBean id="cour_lauSvc" scope="page" class="com.courlist.model.CourlistService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>課程狀態:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="cour_lau"> -->
<%-- 			<c:forEach var="courlistVO" items="${cour_lauSvc.all}"> --%>
<%-- 				<option value="${courlistVO.cour_lau}">${courlistVO.cour_lau} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr> -->
	
	<tr>
		<td>課程狀態 (沒抓預設值):<font color=red><b>*</b></font></td>
		<td><input type="radio" name="cour_lau" value="CL01">下架<br>
			<input type="radio" name="cour_lau" value="CL02">上架<br>
			<input type="radio" name="cour_lau" value="CL03">停權<br></td>
	</tr>
	
	<tr>
		<td>課程公告:</td>
		<td><input type="TEXT" name="cour_ann" size="45" value="<%=courlistVO.getCour_ann()%>" /></td>
	</tr>
	


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="cour_id" value="<%=courlistVO.getCour_id()%>">
<input type="submit" value="送出修改">
</FORM>
</body>




</html>