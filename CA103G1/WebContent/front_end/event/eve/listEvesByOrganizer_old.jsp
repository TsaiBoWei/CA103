<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>
<%@ page import="com.mem.model.*" %>

<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />

<%  
	MemVO memVO=(MemVO)session.getAttribute("memVO");
	List<EventVO> list = eveSvc.getEvesByMem(memVO.getMem_id());
	pageContext.setAttribute("list",list);
%>
${memVO.mem_id}
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<title>listEvesByOrganizer.jsp</title>
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
		 <h3>主辦會員的活動管理 - listEvesByOrganizer.jsp</h3>
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
		<th>活動標題</th>	
		<th>活動圖片</th>
		<th>活動時間</th>
		<th>報名期間</th>
		<th>報名人數/活動成行底線人數</th>
		<th>活動狀態</th>
		<th>地區縣市編號</th>
		<th>運動類別編號</th>
		<th>活動瀏覽次數</th>
		<th>收費金額總計</th>
		<th>檢視報名會員</th>		
		<th>修改資訊</th>
		<th>取消活動</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr ${(eveVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->			
			<td>${eveVO.eve_title}</td>
			<td>
				<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
			</td>		
			<td><fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>~			
				<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/></td>
			<td><fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy/MM/dd "/>~					
				<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy/MM/dd"/></td>		
			<td>${eveVO.estart_limit}</td>			
			<td>${eveStatusMap.get(eveVO.eve_status)}</td>		
			<td>${citySvc.getCityName(eveVO.city_id)}</td>			
			<td>${sportTypeMap.get(eveVO.sptype_id)}</td>		
			<td>${eveVO.eve_view}</td>			
			<td>
				<c:if test="${eveVO.eve_charge==0}">
				    免費
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${eveVO.eve_charge}元/人
				</c:if>		
			</td>										
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eventlist/eventlist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="報名清單"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getEvelists_By_EVE"></FORM>
			</td>
	
				
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改資訊"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" value="取消活動">
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