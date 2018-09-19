<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>
<%
	EveService eveSvc = new EveService();
	List<EventVO> list = eveSvc.getAll();
	pageContext.setAttribute("list",list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listEvesByOrganizer.jsp</title>
<<style>
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
 	width: 100%; 
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
  .eveImg{
  width:100%;
  }
  
</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3>所有員工資料 - listAllEve.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front_end/event/eve/select_event_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>   
		<th>活動編號</th>
		<th>主辦人ID</th>
		<th>活動標題</th>	
		<th>活動頁面圖片</th>
		<th>活動圖片</th>
		<th>活動圖片檔案格式</th>
		<th>活動敘述</th>
		<th>活動開始時間</th>
		<th>活動結束時間</th>
		<th>活動開始報名日</th>
		<th>活動結束報名日</th>
		<th>活動成行底線人數</th>
		<th>活動狀態</th>
		<th>活動地點</th>
		<th>活動地經度</th>
		<th>活動地緯度</th>
		<th>地區縣市編號</th>
		<th>運動類別編號</th>
		<th>活動瀏覽次數</th>
		<th>收費金額</th>
		<th>主辦人聯絡電話</th>
		<th>活動建立時間</th>
			
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr ${(eveVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${eveVO.eve_id}</td>
			<td>${eveVO.mem_id}</td>
			<td>${eveVO.eve_title}</td>
			<td>${eveVO.eve_photo}</td>
			<td>
			<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
			</td>
			<td>${eveVO.eve_ptype}</td>
			<td>${eveVO.eve_content}</td>			
			<td>${eveVO.eve_startdate}</td>			
			<td>${eveVO.eve_enddate}</td>			
			<td>${eveVO.ereg_startdate}</td>			
			<td>${eveVO.ereg_enddate}</td>			
			<td>${eveVO.estart_limit}</td>			
			<td>${eveVO.eve_status}</td>			
			<td>${eveVO.eve_location}</td>			
			<td>${eveVO.eve_long}</td>			
			<td>${eveVO.eve_lat}</td>			
			<td>${eveVO.city_id}</td>			
			<td>${eveVO.sptype_id}</td>			
			<td>${eveVO.eve_view}</td>			
			<td>${eveVO.eve_charge}</td>			
			<td>${eveVO.econtact_info}</td>			
			<td>${eveVO.eestablish_date}</td>			
			
		
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>