<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>

<%
	EveService eveSvc = new EveService();
	List<EventVO> list = eveSvc.getReviewEves();
	pageContext.setAttribute("list",list);
%>



<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReviewEve.jsp</title>
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
  width:30%;
  }
  
</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3>審核活動 - ReviewEve.jsp</h3>
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
		<th>主辦人姓名</th>
		<th>活動時間</th>
		<th>報名期間</th>
		<th>收費金額</th>
		<th>活動最低人數</th>
		<th>活動最高人數</th>
		<th>審核狀態</th>
		

			
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr ${(eveVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${eveVO.eve_title}</td>						
			<td>
			<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
			</td>
			<td>${memSvc.getOneMem(eveVO.mem_id).mem_name}</td>		
			<td><fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>~			
				<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/></td>
			<td><fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy/MM/dd "/>~					
				<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy/MM/dd"/></td>					
			<td>
				<c:if test="${eveVO.eve_charge==0}">
				    免費
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${eveVO.eve_charge}元/人
				</c:if>		
			</td>
			<td>${eveVO.estart_limit}人</td>			
			<td>${eveVO.estart_max}人</td>						
		
			<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="review">
			     <input type="hidden" name="result"	    value="review_pass">
				 <input type="submit" value="通過">			
					
			</FORM>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="review">
			     <input type="hidden" name="result"	    value="review_fail">
				 <input type="submit" value="不通過">								
			</FORM>
		 	
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