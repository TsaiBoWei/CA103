<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.eventsave.model.*"%>

<%
	EventSaveVO eventsaveVO = (EventSaveVO) request.getAttribute("eventsaveVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>���ʦ��íק� - update_eventsave_input.jsp</title>

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
				<h3>���ʦ��íק� - update_eventsave_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front_end/friendlist/select_eventsave_page.jsp">
						<img
						src="<%=request.getContextPath()%>/front_end/friendlist/images/back1.gif"
						width="100" height="32" border="0">�^����
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>���ʦ��íק�:</h3>

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
		ACTION="<%=request.getContextPath()%>/eventsave/eventsave.do"
		name="form1">
		<table>
			<tr>
				<td>�|���s���G<font color=red><b>*</b></font></td>
				<td><%=eventsaveVO.getMem_id()%></td>
			</tr>
			<tr>
				<td>���ʽs���G<font color=red><b>*</b></font></td>
				<td><%=eventsaveVO.getEve_id()%></td>
			</tr>
			<tr>
				<td>���ʦ��ê��A:</td>
				<td><select size="1" name="es_status">
						<option value="ESS0">ESS0 �L
						<option value="ESS1">ESS1 �s�W����
						<option value="ESS2">ESS2 ��������
				</select></td>
			</tr>
		</table>

		<br>
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="mem_id" value="<%=eventsaveVO.getMem_id()%>">
		<input type="hidden" name="eve_id" value="<%=eventsaveVO.getEve_id()%>">
		<input type="submit" value="�e�X�ק�">
	</FORM>
</body>
</html>