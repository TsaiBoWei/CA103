<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>MemSpLike: Home</title></head>
<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='400'>
  <tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
    <td><h3>IBM Emp: Home</h3><font color=red>( MVC )</font></td>
  </tr>
</table>

<p>This is the Home page for MemSpLike: Home</p>

<h3>資料查詢:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li>${message}</li>
		</c:forEach>
	</ul>
	</font>
</c:if>

<ul>
  <li><a href='listAllMemSpLike.jsp'>List</a> all MemSpLike. </li> <br><br>
  
  <li>
    <FORM METHOD="post" ACTION="memsplike.do" >
        <b>輸入會員編號與運動喜好編號 (如M000001, SP000001):</b>
        <input type="text" name="mem_id">
        <input type="text" name="sptype_id">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="get_one_for_display">
    </FORM>
  </li>

  <jsp:useBean id="memSpLikeSvc" scope="page" class="com.memsplike.model.MemSpLikeService" />
   
  <li>
     <FORM METHOD="post" ACTION="memsplike.do" >
       <b>選擇會員編號與運動喜好編號:</b>
       <select size="1" name="mem_id">
         <c:forEach var="memSpLikeVO" items="${memSpLikeSvc.all}" > 
          <option value="${memSpLikeVO.mem_id}">${memSpLikeVO.mem_id}
         </c:forEach>   
       </select>
       
       <select size="1" name="sptype_id">
         <c:forEach var="memSpLikeVO" items="${memSpLikeSvc.all}" > 
          <option value="${memSpLikeVO.sptype_id}">${memSpLikeVO.sptype_id}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="get_one_for_display">
    </FORM>
  </li>
  
</ul>


<h3>員工管理</h3>

<ul>
  <li><a href='addMemSpLike.jsp'>Add</a> a new MemSpLike.</li>
</ul>

</body>

</html>
