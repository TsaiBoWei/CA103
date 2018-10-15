<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.friendlist.model.*"%>
<%@ page import="com.mem.model.*" %>

 <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<!-- 模擬會員3號要新增好友 -->
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
  <li><a href="<%=request.getContextPath() %>/front_end/friendlist/listAllFriendList.jsp">add</a>  FriendList.  <br><br></li>
  
  
  <li>
  <jsp:useBean id="friendlistSvc" scope="page" class="com.friendlist.model.FriendListService" />
  
  


    
        <input type="hidden" name="fl_memA_id" value="${memVO.mem_id}" id="fl_memA_id">
        <input type="hidden" name="fl_memB_id" value="<%=flmem_id %>" id="fl_memB_id">
        
<!--          不是自己的會員頁面 -->
        <c:if test="${memVO.mem_id!=flmem_id}">
<!--             是會員 且未加入好友 -->
	        <c:if test="${friendlistSvc.getOneFriendList(memVO.mem_id,flmem_id)==null&&memVO!=null}">
<!-- 	        對方未送出邀請 -->
	        	<c:if test="${friendlistSvc.getOneFriendList(flmem_id,memVO.mem_id).fl_status!='FLS0'}">        
	        		<input type="hidden" name="action" value="insert">        
	        		<input type="submit" value="送出邀請" id="addflBtn" onclick="addfriend()">
	        	</c:if>
	    	</c:if>
	    	 
<!-- 	    	 對方有發送邀請 -->
	    	<c:if test="${friendlistSvc.getOneFriendList(flmem_id,memVO.mem_id).fl_status=='FLS0'}">
	        	<input type="submit" value="好友確認" id="addflchBtn" onclick="addflcheck()">
	    	</c:if> 
	    	
<!-- 	    	 發送邀請給對方 -->
	    	<c:if test="${friendlistSvc.getOneFriendList(memVO.mem_id,flmem_id).fl_status=='FLS0'}">
	        	<input type="BUTTON" value="已送出邀請" >
	    	</c:if> 
	    	
<!-- 	    	 已成為好友 -->	    	
	    	<c:if test="${friendlistSvc.getOneFriendList(memVO.mem_id,flmem_id).fl_status=='FLS1'}">
	        	<input type="BUTTON" value="好友"  >
	    	</c:if> 
    	</c:if>

  
  </li>

</ul>  

<script type="text/javascript">
	function addfriend(){
		var fl_memA_id=document.getElementById("fl_memA_id").value;
		var fl_memB_id=document.getElementById("fl_memB_id").value;
		
		var xhr = new XMLHttpRequest();
	    //設定好回呼函數   
	    xhr.onload = function (){
	        if( xhr.status == 200){
					console.log(xhr.responseText);
				  if(xhr.responseText=='success'){
					  document.getElementById("addflBtn").value = "已送出邀請";
				  }else{
					  alert(xhr.responseText);
				  }
	        	 
	        }else{
	          alert( xhr.status );
	        }//xhr.status == 200
	    };//onload 
	    
	    //建立好Get連接
	    var url= "<%=request.getContextPath() %>/friendlist/friendlist.do?action=insert&fl_memA_id=" + fl_memA_id+
	    		"&fl_memB_id="+fl_memB_id;
	    xhr.open("Get",url,true); 
	    //送出請求 
	    xhr.send( null );    
		
		
	}
	
	
	function addflcheck(){
		var fl_memA_id=document.getElementById("fl_memA_id").value;
		var fl_memB_id=document.getElementById("fl_memB_id").value;
		
		var xhr = new XMLHttpRequest();
	    //設定好回呼函數   
	    xhr.onload = function (){
	        if( xhr.status == 200){
					console.log(xhr.responseText);
				  if(xhr.responseText=='success'){
					  document.getElementById("addflchBtn").value = "好友";
				  }else{
					  alert(xhr.responseText);
				  }
	        	 
	        }else{
	          alert( xhr.status );
	        }//xhr.status == 200
	    };//onload 
	    
	    //建立好Get連接
	    var url= "<%=request.getContextPath() %>/friendlist/friendlist.do?action=insert_friend&fl_memA_id=" + fl_memA_id+
	    		"&fl_memB_id="+fl_memB_id;
	    xhr.open("Get",url,true); 
	    //送出請求 
	    xhr.send( null );    
		
		
	}


</script>
   
  

      

</body>
</html>