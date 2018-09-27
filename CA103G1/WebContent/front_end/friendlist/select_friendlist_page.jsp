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

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
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
    
        <b>��J�|��A�s��: (�pM000001):</b>
        <input type="text" name="fl_memA_id">
        <b>��J�|��B�s��:(�pM000001):</b>
        <input type="text" name="fl_memB_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    
    </FORM>
  </li>

  <jsp:useBean id="friendlistSvc" scope="page" class="com.friendlist.model.FriendListService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/friendlist/friendlist.do">
       <b>��ܷ|��A�s��:</b>
       <select size="1" name="fl_memA_id">
         <c:forEach var="firendlistVO" items="${friendlistSvc.all}" > 
          <option value="${firendlistVO.fl_memA_id}">${firendlistVO.fl_memA_id}
         </c:forEach>   
       </select>

       <b>��ܷ|��B�s��:</b>
       <select size="1" name="fl_memB_id">
         <c:forEach var="firendlistVO" items="${friendlistSvc.all}" > 
          <option value="${firendlistVO.fl_memB_id}">${firendlistVO.fl_memB_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>�s�W�n��</h3>

<ul>
  <li><a href="<%=request.getContextPath() %>/front_end/friendlist/addFriendList.jsp">Add</a> a new FriendList.</li>
</ul>

</body>
</html>