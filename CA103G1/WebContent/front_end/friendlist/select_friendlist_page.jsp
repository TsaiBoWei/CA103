<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.friendlist.model.*"%>

<html>
<head>
<title> CA103G1 FriendList: Home</title>

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
   <tr><td><h3>CA103G1 FriendList: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA103G1 FriendList: Home</p>

<h3>資料查詢:</h3>
	
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
  <li><a href="<%=request.getContextPath() %>/front_end/friendlist/listAllFriendList.jsp">List</a> all FriendList.  <br><br></li>
  
  
  <li>
<!--     <FORM METHOD="post" ACTION="friendlist.do" > -->
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/friendlist/friendlist.do">
    
        <b>輸入會員A編號: (如M000001):</b>
        <input type="text" name="fl_memA_id">
        <b>輸入會員B編號:(如M000001):</b>
        <input type="text" name="fl_memB_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    
    </FORM>
  </li>

  <jsp:useBean id="friendlistSvc" scope="page" class="com.friendlist.model.FriendListService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/friendlist/friendlist.do">
       <b>選擇會員A編號:</b>
       <select size="1" name="fl_memA_id">
         <c:forEach var="firendlistVO" items="${friendlistSvc.all}" > 
          <option value="${firendlistVO.fl_memA_id}">${firendlistVO.fl_memA_id}
         </c:forEach>   
       </select>

       <b>選擇會員B編號:</b>
       <select size="1" name="fl_memB_id">
         <c:forEach var="firendlistVO" items="${friendlistSvc.all}" > 
          <option value="${firendlistVO.fl_memB_id}">${firendlistVO.fl_memB_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>新增好友</h3>

<ul>
  <li><a href="<%=request.getContextPath() %>/front_end/friendlist/addFriendList.jsp">Add</a> a new FriendList.</li>
</ul>

</body>
</html>