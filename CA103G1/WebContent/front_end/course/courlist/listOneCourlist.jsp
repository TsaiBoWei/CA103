<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.courlist.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
CourlistService courlistSvc=new CourlistService(); 
CourlistVO courlistVO1=courlistSvc.getOneCourlist("COUR000001");
request.setAttribute("courlistVO", courlistVO1);
CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //CourlistServlet.java(Controller), 存入req的courlistVO物件
%>

<html>
<head>
<title>員工資料 - listOneCourlist.jsp</title>

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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - listOneCourlist.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">
		 <img src="<%=request.getContextPath()%>/front_end/course/courlist/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>課程編號</th>
		<th>運動類別編號</th>
		<th>教練編號</th>
		<th>課程姓名</th>
		<th>課程介紹</th>
		<th>課程費用</th>
		<th>課程主頁圖片</th>
		<th>課程狀態</th>
		<th>課程公告</th>
		<th>課程瀏覽次數</th>
	</tr>
	<tr>
		<td><%=courlistVO.getCour_id()%></td>
		<td><%=courlistVO.getSptype_id()%></td>
		<td><%=courlistVO.getCoa_id()%></td>
		<td><%=courlistVO.getCname()%></td>
		<td><%=courlistVO.getCour_text()%></td>
		<td><%=courlistVO.getCour_cost()%></td>
		<td>
		<img class="img-fluid rounded-circle" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>">
		</td>
		<td><%=courlistVO.getCour_lau()%></td>
		<td><%=courlistVO.getCour_ann()%></td>
		<td><%=courlistVO.getCour_view()%></td>
	</tr>
</table>

</body>
</html>