<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.friendlist.model.*"%>

<%
	FriendListVO firendlistVO = (FriendListVO) request.getAttribute("firendlistVO"); //FriendListServlet.java(Concroller), �s�Jreq��empVO����
%>

<html>
<head>
<title>�|�����n�ͲM�� - listOneFriendList.jsp</title>

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
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

	<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
	<table id="table-1">
		<tr><td>
		 <h3>���u��� - ListOneEmp.jsp</h3>
			<h4><a href="<%=request.getContextPath() %>/front_end/friendlist/select_friendlist_page.jsp">
			<img src="<%=request.getContextPath() %>/front_end/friendlist/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
		</td></tr>
	</table>
	<table>
		<tr>
			<th>�|���s��</th>
			<th>�n�ͽs��</th>
			<th>�n�ͩm�W</th>
			<th>�O�_�ܽ�</th>
			<th>�O�_����</th>
		</tr>
		<tr>
			<td><%=firendlistVO.getFl_memA_id()%></td>
			<td><%=firendlistVO.getFl_memB_id()%></td>
			<td><%=firendlistVO.getFl_friend_name()%></td>
			<td><%=firendlistVO.getFl_status()%></td>
			<td><%=firendlistVO.getFl_block()%></td>
		</tr>
	</table>

</body>
</html>