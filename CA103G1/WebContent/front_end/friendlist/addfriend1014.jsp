<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.friendlist.model.*"%>
<%@ page import="com.mem.model.*" %>

 <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<!-- �����|��3���n�s�W�n�� -->
<%
  session.setAttribute("memVO",memSvc.getOneMem("M000002"));
  String flmem_id="M000003"; 
  pageContext.setAttribute("flmem_id",flmem_id );
%>



<%
  MemVO memVO=(MemVO)session.getAttribute("memVO");
%>
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
  <li><a href="<%=request.getContextPath() %>/front_end/friendlist/listAllFriendList.jsp">add</a>  FriendList.  <br><br></li>
  
  
  <li>
  <jsp:useBean id="friendlistSvc" scope="page" class="com.friendlist.model.FriendListService" />
  
  


    
        <input type="hidden" name="fl_memA_id" value="${memVO.mem_id}" id="fl_memA_id">
        <input type="hidden" name="fl_memB_id" value="<%=flmem_id %>" id="fl_memB_id">
        
<!--          ���O�ۤv���|������ -->
        <c:if test="${memVO.mem_id!=flmem_id}">
<!--             �O�|�� �B���[�J�n�� -->
	        <c:if test="${friendlistSvc.getOneFriendList(memVO.mem_id,flmem_id)==null&&memVO!=null}">
<!-- 	        ��襼�e�X�ܽ� -->
	        	<c:if test="${friendlistSvc.getOneFriendList(flmem_id,memVO.mem_id).fl_status!='FLS0'}">        
	        		<input type="hidden" name="action" value="insert">        
	        		<input type="submit" value="�e�X�ܽ�" id="addflBtn" onclick="addfriend()">
	        	</c:if>
	    	</c:if>
	    	 
<!-- 	    	 ��観�o�e�ܽ� -->
	    	<c:if test="${friendlistSvc.getOneFriendList(flmem_id,memVO.mem_id).fl_status=='FLS0'}">
	        	<input type="submit" value="�n�ͽT�{" id="addflchBtn" onclick="addflcheck()">
	    	</c:if> 
	    	
<!-- 	    	 �o�e�ܽе���� -->
	    	<c:if test="${friendlistSvc.getOneFriendList(memVO.mem_id,flmem_id).fl_status=='FLS0'}">
	        	<input type="BUTTON" value="�w�e�X�ܽ�" >
	    	</c:if> 
	    	
<!-- 	    	 �w�����n�� -->	    	
	    	<c:if test="${friendlistSvc.getOneFriendList(memVO.mem_id,flmem_id).fl_status=='FLS1'}">
	        	<input type="BUTTON" value="�n��"  >
	    	</c:if> 
    	</c:if>

  
  </li>

</ul>  

<script type="text/javascript">
	function addfriend(){
		var fl_memA_id=document.getElementById("fl_memA_id").value;
		var fl_memB_id=document.getElementById("fl_memB_id").value;
		
		var xhr = new XMLHttpRequest();
	    //�]�w�n�^�I���   
	    xhr.onload = function (){
	        if( xhr.status == 200){
					console.log(xhr.responseText);
				  if(xhr.responseText=='success'){
					  document.getElementById("addflBtn").value = "�w�e�X�ܽ�";
				  }else{
					  alert(xhr.responseText);
				  }
	        	 
	        }else{
	          alert( xhr.status );
	        }//xhr.status == 200
	    };//onload 
	    
	    //�إߦnGet�s��
	    var url= "<%=request.getContextPath() %>/friendlist/friendlist.do?action=insert&fl_memA_id=" + fl_memA_id+
	    		"&fl_memB_id="+fl_memB_id;
	    xhr.open("Get",url,true); 
	    //�e�X�ШD 
	    xhr.send( null );    
		
		
	}
	
	
	function addflcheck(){
		var fl_memA_id=document.getElementById("fl_memA_id").value;
		var fl_memB_id=document.getElementById("fl_memB_id").value;
		
		var xhr = new XMLHttpRequest();
	    //�]�w�n�^�I���   
	    xhr.onload = function (){
	        if( xhr.status == 200){
					console.log(xhr.responseText);
				  if(xhr.responseText=='success'){
					  document.getElementById("addflchBtn").value = "�n��";
				  }else{
					  alert(xhr.responseText);
				  }
	        	 
	        }else{
	          alert( xhr.status );
	        }//xhr.status == 200
	    };//onload 
	    
	    //�إߦnGet�s��
	    var url= "<%=request.getContextPath() %>/friendlist/friendlist.do?action=insert_friend&fl_memA_id=" + fl_memA_id+
	    		"&fl_memB_id="+fl_memB_id;
	    xhr.open("Get",url,true); 
	    //�e�X�ШD 
	    xhr.send( null );    
		
		
	}


</script>
   
  

      

</body>
</html>