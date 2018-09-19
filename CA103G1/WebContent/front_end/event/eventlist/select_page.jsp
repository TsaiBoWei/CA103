<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />


<%  //模擬會員的SESSION
	session.setAttribute("memVO", memSvc.getOneMem("M000001"));
%>

<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>

<!DOCTYPE html>
<html>
<head>
<title>EventList</title>

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
   <tr><td><h3>EventList</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for EventList</p>

<h3>活動清單查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
   
<!--   <li> -->
<%--     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" > --%>
<!--         <b>輸入會員編號 (得該會員的所有活動清單):</b> -->
<!--         <input type="text" name="mem_id"> -->
<!--         <input type="hidden" name="action" value="getEvelists_By_MEM"> -->
<!--         <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->
  
    <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp" >
        <b>session取出的會員名稱 (查該會員的所有活動清單):</b>${memVO.mem_name}
        <input type="hidden" name="mem_id" value="${memVO.mem_id}">    
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<!--   <li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" > --%>
<!--        <b>選擇活動名稱(得參加該活動的所有會員)):</b> -->
<!--        <select size="1" name="eve_id"> -->
<%--          <c:forEach var="eventVO" items="${eveSvc.all}" >  --%>
<%--           <option value="${eventVO.eve_id}">${eventVO.eve_title} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getEvelists_By_EVE"> -->
<!--        <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->
  
  
   <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >
       <b>session取的會員所主辦的活動(得該活動的所有會員活動清單)):</b>
       <select size="1" name="eve_id">
         <c:forEach var="eventVO" items="${eveSvc.getEvesByMem(memVO.mem_id)}" > 
          <option value="${eventVO.eve_id}">${eventVO.eve_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getEvelists_By_EVE">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >
       <b>選擇單一活動清單:</b>
      會員名稱
       <select size="1" name="mem_id">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          <option value="${memVO.mem_id}">${memVO.mem_name}
         </c:forEach>   
       </select>
      活動名稱
       <select size="1" name="eve_id">
         <c:forEach var="eventVO" items="${eveSvc.all}" > 
          <option value="${eventVO.eve_id}">${eventVO.eve_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>會員活動清單管理</h3>

<ul>
  <li><a href='<%=request.getContextPath() %>/front_end/event/eventlist/addeveList.jsp'>Add</a> a new EventList.</li>
</ul>

</body>
</html>