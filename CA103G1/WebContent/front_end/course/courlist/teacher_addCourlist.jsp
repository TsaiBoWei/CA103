<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.sptype.model.*"%>


<%
  CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�ҵ{��Ʒs�W - addCourlist.jsp</title>

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
		 <h3>�ҵ{��Ʒs�W - addCourlist.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">
      <img src="<%=request.getContextPath()%>/front_end/course/courlist/images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do" name="form1" enctype="multipart/form-data">
<table>

	<jsp:useBean id="sportSvc" scope="page" class="com.sptype.model.SptypeService" />
	<tr>
		<td>�B�ʶ���:<font color=red><b>*</b></font></td>
		<td><select size="1" name="sptype_id">
			<c:forEach var="sptypeVO" items="${sportSvc.all}">
				<option value="${sptypeVO.sptype_id}" ${(courlistVO.sptype_id==sptypeVO.sptype_id)? 'selected':'' } >${sptypeVO.sport}
			</c:forEach>
		</select></td>
	</tr>

	<jsp:useBean id="coa_idSvc" scope="page" class="com.coach.model.CoachService" />
	<tr>
		<td>�нm�s��:<font color=red><b>*</b></font></td>
		<td><select size="1" name="coa_id">
			<c:forEach var="coachVO" items="${coa_idSvc.all}">
				<option value="${coachVO.coa_id}" ${(courlistVO.coa_id==coachVO.coa_id)?'selected':'' } >${coachVO.coa_id}
			</c:forEach>
		</select></td>
	</tr>
	
	<tr>
		<td>�ҵ{�W��:</td>
		<td><input type="TEXT" name="cname" size="45"
			value="<%= (courlistVO==null)? "�ҵ{�W��1" : courlistVO.getCname()%>" /></td>
	</tr>
	
	<tr>
		<td>�ҵ{����:(�n��ƪ�...)</td>
		<td><input type="TEXT" name="cour_text" size="45"	
		value="<%= (courlistVO==null)? "�ҵ{����1" : courlistVO.getCour_text()%>" /></td>
	</tr>
	
	<tr>
		<td>�ҵ{�O��:</td>
		<td><input type="TEXT" name="cour_cost" size="45" 
		value="<%= (courlistVO==null)? "4100" : courlistVO.getCour_cost()%>" /></td>
	</tr>
	
	<tr>
		<td>�ҵ{�D���Ϥ�:</td>
		<td><input type="file" name="cour_pho" size="45" 
		value="<%= (courlistVO==null)? "�ȵL�Ϥ�" : courlistVO.getCour_pho()%>" /></td>
	</tr>
	

	
<%-- 	<jsp:useBean id="cour_lauSvc" scope="page" class="com.courlist.model.CourlistService" /> --%>
<!-- 	<tr> -->
<!-- 		<td>�ҵ{���A:<font color=red><b>*</b></font></td> -->
<!-- 		<td><select size="1" name="cour_lau"> -->
<%-- 			<c:forEach var="courlistVO" items="${cour_lauSvc.all}"> --%>
<%-- 				<option value="${courlistVO.cour_lau}">${courlistVO.cour_lau} --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
<!-- 	</tr>	 -->

	<tr>
		<td>�ҵ{���A:<font color=red><b>*</b></font></td>
		<td><input type="radio" name="cour_lau" value="CL01">�U�[<br>
			<input type="radio" name="cour_lau" value="CL02">�W�[<br>
			<input type="radio" name="cour_lau" value="CL03">���v<br></td>
	</tr>
	
	<tr>
		<td>�ҵ{���i:</td>
		<td><input type="TEXT" name="cour_ann" size="45" 
		value="<%= (courlistVO==null)? "�ҵ{���i1" : courlistVO.getCour_ann()%>" /></td>
	</tr>
	


</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>
</html>