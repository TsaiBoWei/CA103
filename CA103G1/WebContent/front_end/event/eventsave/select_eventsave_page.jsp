<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.eventsave.model.*"%>


<html>
<head>
<title> CA103G1 EventSave: Home</title>

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
   <tr><td><h3>CA103G1 EventSave: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA103G1 EventSave: Home</p>

<h3>��Ƭd��:</h3>

<ul>
  <li>
    <a href="<%=request.getContextPath() %>/front_end/event/eve/select_event_page.jsp">
       �^��select_event_page.jsp 
    </a>
  </li>
</ul>



	
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
  <li><a href="<%=request.getContextPath() %>/front_end/event/eventsave/listAllEventSave.jsp">List</a> all EventSave.  <br><br></li>
  
  
  <li>
<!--     <FORM METHOD="post" ACTION="friendlist.do" > -->
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventsave/eventsave.do">
    
        <b>��J�|���s��: (�pM000001):</b>
        <input type="text" name="mem_id">
        <b>��J���ʽs��:(�pE000001):</b>
        <input type="text" name="eve_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    
    </FORM>
  </li>

  <jsp:useBean id="eventSaveSvc" scope="page" class="com.eventsave.model.EventSaveService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventsave/eventsave.do">
       <b>��ܷ|���s��:</b>
       <select size="1" name="mem_id">
         <c:forEach var="eventsaveVO" items="${eventSaveSvc.all}" > 
          <option value="${eventsaveVO.mem_id}">${eventsaveVO.mem_id}
         </c:forEach>   
       </select>

       <b>��ܬ��ʽs��:</b>
       <select size="1" name="eve_id">
         <c:forEach var="eventsaveVO" items="${eventSaveSvc.all}" > 
          <option value="${eventsaveVO.eve_id}">${eventsaveVO.eve_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>�s�W���ʦ���</h3>

<ul>
  <li><a href="<%=request.getContextPath() %>/front_end/event/eventsave/addEventSave.jsp">Add</a> a new FriendList.</li>
</ul>

</body>
</html>