<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />

<%  //�����|����SESSION
	session.setAttribute("memVO", memSvc.getOneMem("M000002"));
%>

<%	//���X�|����SESSION
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

<h3>��Ƭd��:</h3>
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>�Эץ��H�U���~:</font>
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
       <b>��ܬ��ʽs��:</b>
       <select size="1" name="eve_id">
         <c:forEach var="eveVO" items="${eveSvc.all}" > 
          <option value="${eveVO.eve_id}">${eveVO.eve_title}
         </c:forEach>   
       </select>
       <input type="submit" value="�e�X">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp" >
       <b>�D��|�������ʺ޲z:</b>
<!--        <select size="1" name="eve_id"> -->
<%--          <c:forEach var="eveVO" items="${eveSvc.getEvesByMem(memVO.mem_id)}" >  --%>
<%--          	 <option value="${eveVO.eve_id}">${eveVO.eve_title} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
       <input type="submit" value="�e�X">
<%--        <input type="hidden" name="mem_id" value="${memVO.mem_id}"> --%>
<!--        <input type="hidden" name="action" value="get_Eves_By_Mem">     -->
    </FORM>
  </li>
</ul>

<%-- �U�νƦX�d��-�H�U���-�i�H�N�W�� --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" name="form1">
        <b><font color=blue>�U�νƦX�d��:</font></b> <br>
        <b>��J���ʦW��:</b>
        <input type="text" name="empno" value="7001"><br>
           
       <b>��J���ʶ}�l�ɶ�:</b>
        <input name="hiredate" id="f_date1" type="text">
       
       <b>��J���ʵ����ɶ�:</b>
       <input name="hiredate" id="f_date1" type="text"><br>
       
        <b>��J���ʪ��B:</b>
       <input type="text" name="ename" value="KING"><br>
       
       <b>��J���ʦa�I:</b>
       <input type="text" name="job" value="PRESIDENT"><br>
    
       <b>��ܬ��ʦa��:</b>
       <select size="1" name="deptno" >
          <option value="">
         <c:forEach var="deptVO" items="${deptSvc.all}" > 
          <option value="${deptVO.deptno}">${deptVO.dname}
         </c:forEach>   
       </select><br>
       
       <b>��ܹB�ʺ���:</b>
       <select size="1" name="deptno" >
          <option value="">
         <c:forEach var="deptVO" items="${deptSvc.all}" > 
          <option value="${deptVO.deptno}">${deptVO.dname}
         </c:forEach>   
       </select><br>
           		        
        <input type="submit" value="�e�X">
        <input type="hidden" name="action" value="listEmps_ByCompositeQuery">
     </FORM>
  </li>
</ul>



<h3><font color=orange>�s�W����</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front_end/event/eve/addEve.jsp'>Add</a> Event </li>
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