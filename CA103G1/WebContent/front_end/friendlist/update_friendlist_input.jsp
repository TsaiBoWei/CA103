<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.friendlist.model.*"%>

<%
	FriendListVO firendlistVO = (FriendListVO) request.getAttribute("firendlistVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>�n�ͭק� - addFriendList.jsp</title>

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
		<tr>
			<td>
				<h3>�n�ͷ|���ק� - update_friendlist_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front_end/friendlist/select_friendlist_page.jsp">
						<img
						src="<%=request.getContextPath()%>/front_end/friendlist/images/back1.gif"
						width="100" height="32" border="0">�^����
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>�|����ƭק�:</h3>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/friendlist/friendlist.do"
		name="form1">
		<table>
			<tr>
				<td>�|��A�s���G<font color=red><b>*</b></font></td>
				<td><%=firendlistVO.getFl_memA_id()%></td>
			</tr>
			<tr>
				<td>�|��B�s���G<font color=red><b>*</b></font></td>
				<td><%=firendlistVO.getFl_memB_id()%></td>
			</tr>
			<tr>
				<td>�n�ͦW�١G<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="fl_friend_name" size="45" value="<%=firendlistVO.getFl_friend_name()%>" /></td>
			</tr>
			<tr>
				<td>�n�ͪ��A:</td>
				<td><select size="1" name="fl_status">
						<option value="FLS0">FLS0 �L
						<option value="FLS1">FLS1 �e�X�B���ܲM�����\
						<option value="FLS2">FLS2 �e�X�B���ܽФw�[�J
				</select></td>
			</tr>
			<tr>
				<td>�O�_����:</td>
				<td><select size="1" name="fl_block">
						<option value="FLB0">FLB0 ������
						<option value="FLB1">FLB1 �w����
				</select></td>
			</tr>
		</table>

		<br>
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="fl_memA_id" value="<%=firendlistVO.getFl_memA_id()%>">
		<input type="hidden" name="fl_memB_id" value="<%=firendlistVO.getFl_memB_id()%>">
		<input type="submit" value="�e�X�ק�">
	</FORM>
</body>
</html>