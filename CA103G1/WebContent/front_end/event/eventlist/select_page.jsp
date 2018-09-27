<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />


<%  //�����|����SESSION
	session.setAttribute("memVO", memSvc.getOneMem("M000002"));
%>

<%	//���X�|����SESSION
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

<h3>���ʲM��d��:</h3>
	
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
   
<!--   <li> -->
<%--     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" > --%>
<!--         <b>��J�|���s�� (�o�ӷ|�����Ҧ����ʲM��):</b> -->
<!--         <input type="text" name="mem_id"> -->
<!--         <input type="hidden" name="action" value="getEvelists_By_MEM"> -->
<!--         <input type="submit" value="�e�X"> -->
<!--     </FORM> -->
<!--   </li> -->
  
    <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp" >
        <b>session���X���|���W�� (�d�ӷ|�����Ҧ����ʲM��):</b>${memVO.mem_name}
        <input type="hidden" name="mem_id" value="${memVO.mem_id}">    
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<!--   <li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" > --%>
<!--        <b>��ܬ��ʦW��(�o�ѥ[�Ӭ��ʪ��Ҧ��|��)):</b> -->
<!--        <select size="1" name="eve_id"> -->
<%--          <c:forEach var="eventVO" items="${eveSvc.all}" >  --%>
<%--           <option value="${eventVO.eve_id}">${eventVO.eve_title} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getEvelists_By_EVE"> -->
<!--        <input type="submit" value="�e�X"> -->
<!--     </FORM> -->
<!--   </li> -->
  
  
   <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >
       <b>session�����|���ҥD�쪺����(�o�Ӭ��ʪ��Ҧ��|�����ʲM��)):</b>
       <select size="1" name="eve_id">
         <c:forEach var="eventVO" items="${eveSvc.getEvesByMem(memVO.mem_id)}" > 
          <option value="${eventVO.eve_id}">${eventVO.eve_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getEvelists_By_EVE">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >
       <b>��ܳ�@���ʲM��:</b>
      �|���W��
       <select size="1" name="mem_id">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          <option value="${memVO.mem_id}">${memVO.mem_name}
         </c:forEach>   
       </select>
      ���ʦW��
       <select size="1" name="eve_id">
         <c:forEach var="eventVO" items="${eveSvc.all}" > 
          <option value="${eventVO.eve_id}">${eventVO.eve_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>�|�����ʲM��޲z</h3>

<ul>
  <li><a href='<%=request.getContextPath() %>/front_end/event/eventlist/addeveList.jsp'>Add</a> a new EventList.</li>
</ul>

<h3>��ѫ�</h3>

<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<c:forEach var="evelsVO" items="${evelistSvc.getEveListsByMem(memVO.mem_id)}">	
	<ul>
		<li>
			���ʦW��: ${evelsVO.eve_id}-${eveSvc.getOneEve(evelsVO.eve_id).eve_title}
			<a href='<%=request.getContextPath() %>/front_end/event/evechat/evechat.jsp?eve_id=${evelsVO.eve_id}'>Enter</a>
		</li>
	</ul>	
</c:forEach>


</body>
</html>