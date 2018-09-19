<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />

<%  //模擬會員的SESSION
	session.setAttribute("memVO", memSvc.getOneMem("M000003"));
%>

<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>select_event_page.jsp</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>Event Page: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Event Page: Home</p>

<h3>資料查詢:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/event/eve/listAllEve.jsp'>List</a> all Eves. <br><br></li>
  
    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" >
       <b>選擇活動編號:</b>
       <select size="1" name="eve_id">
         <c:forEach var="eveVO" items="${eveSvc.all}" > 
          <option value="${eveVO.eve_id}">${eveVO.eve_title}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" >
       <b>主辦會員的活動管理:</b>
       <input type="text"  name="mem_id" value="${memVO.mem_id}">
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="get_Eves_By_Mem">
    </FORM>
  </li>
</ul>

<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" name="form1">
        <b><font color=blue>萬用複合查詢:</font></b> <br>
        <b>輸入活動名稱:</b>
        <input type="text" name="empno" value="7001"><br>
           
       <b>輸入活動開始時間:</b>
        <input name="hiredate" id="f_date1" type="text">
       
       <b>輸入活動結束時間:</b>
       <input name="hiredate" id="f_date1" type="text"><br>
       
        <b>輸入活動金額:</b>
       <input type="text" name="ename" value="KING"><br>
       
       <b>輸入活動地點:</b>
       <input type="text" name="job" value="PRESIDENT"><br>
    
       <b>選擇活動地區:</b>
       <select size="1" name="deptno" >
          <option value="">
         <c:forEach var="deptVO" items="${deptSvc.all}" > 
          <option value="${deptVO.deptno}">${deptVO.dname}
         </c:forEach>   
       </select><br>
       
       <b>選擇運動種類:</b>
       <select size="1" name="deptno" >
          <option value="">
         <c:forEach var="deptVO" items="${deptSvc.all}" > 
          <option value="${deptVO.deptno}">${deptVO.dname}
         </c:forEach>   
       </select><br>
           		        
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="listEmps_ByCompositeQuery">
     </FORM>
  </li>
</ul>



<h3><font color=orange>新增活動</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/event/eve/addEve.jsp'>Add</a> Event </li>
</ul>

</body>
</html>