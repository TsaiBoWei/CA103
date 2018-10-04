<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Courlist: Home</title>

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
   <tr><td><h3>IBM Courlist: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Courlist: Home</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~���C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/course/courlist/listAllCourlist.jsp'>List</a> all Courlist.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do"  >
        <b>��J�ҵ{�s�� (�pCOUR000001):</b>
        <input type="text" name="cour_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="courlistSvc" scope="page" class="com.courlist.model.CourlistService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do"  >
       <b>��ܽҵ{�s��:</b>
       <select size="1" name="cour_id">
         <c:forEach var="courlistVO" items="${courlistSvc.all}" > 
          <option value="${courlistVO.cour_id}">${courlistVO.cour_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do"  >
       <b>��ܽҵ{�W��:</b>
       <select size="1" name="cour_id">
         <c:forEach var="courlistVO" items="${courlistSvc.all}" > 
          <option value="${courlistVO.cour_id}">${courlistVO.cname}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>�ҵ{�޲z</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/course/courlist/addCourlist.jsp'>Add</a> a new Courlist.</li>
 
  
</ul>

</body>
</html>