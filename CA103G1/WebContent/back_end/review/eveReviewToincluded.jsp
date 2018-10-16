<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.mem.model.*"%>
<%--@ page import="com.Mgr.model.*"--%>
<%@ page import="com.eve.model.*"%>
<%--  MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");--%>

<%
	EveService eveSvc = new EveService();
	List<EventVO> list = eveSvc.getReviewEndEves();
		
	pageContext.setAttribute("list",list);
	
	
	
%>
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">

  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/PersonalPageBase.css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <!-- lightcase settings -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <style>
    /*頁面設定*/






    body {
      overflow-x: hidden;
    }

    .loginbox {
      background-color: #808080
    }

    .logbt {
      width: 100px
    }

    .mgrlistbar {
      font-size: 28px
    }

    .imglist {
      height: 200px;
      width: 270px
    }
    input.btn{
     position:relative;
    	z-index:2 !important    	
    }
     a.btn{
    position:relative;
    	z-index:2 !important    	
    }
  </style>

</head>
<body class="text-center">
<div class="container">
     <div class="row">
      <nav class="navbar navbar-expand-lg navbar-light bg-success m-2 w-100" aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item active mgrlistbar" aria-current="page">已審核</li>
        </ol>
      </nav>
    </div>
    
      <div class="card bg-dark">
        <%-- --c:foreach var="coachVO" items="${coachSvc.all}"> </c:foreach> --%>
        <table class="table table-hover table-striped table-bordered" style="table-layout:fixed;word-wrap:break-word">
        
          <thead class="thead-inverse">
          
            <tr>
              <th style="width:9.3%">活動標題</th>
              <th style="width:6.4%">主辦人姓名</th>
              <th style="width:29.8%">活動敘述</th>
              <th style="width:12.2%">活動時間</th>
              <th style="width:14.2%">活動地點</th>
              <th style="width:7.3%">參加人數</th>
              <th style="width:5.8%">報名費用</th>
              <th style="width:15%">審核結果</th>
            </tr>
          </thead>
 	<%@ include file="page1.file" %> 
          <c:forEach var="eventVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
          
     
          <tbody>
            <tr>
              <td>${eventVO.eve_title}</td>         	
              <td>${memSvc.getOneMem(eventVO.mem_id).mem_name}</td>          
              <td><div style="overflow: auto;width:100%; max-height:200px">${eventVO.eve_content}</div></td>      
              <td>
              	<fmt:formatDate value="${eventVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>
              									<br>~<br>		
			   	<fmt:formatDate value="${eventVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/>
			   </td>
              <td>${eventVO.eve_location}</td>
              <td>${eventVO.estart_limit}~${eventVO.estart_max}人</td>
              <td>
   				<c:choose>
   					<c:when test="${eventVO.eve_charge==0}">   					
   						免費    					
   					</c:when>   				
   					<c:otherwise>   					
   						${eventVO.eve_charge}元
   					</c:otherwise>   			
   				</c:choose>   				   		
              </td>
              <td>${eveStatusMap.get(eventVO.eve_status)}</td>         
            </tr>           
          </tbody>
          </c:forEach>
        </table>
       
      </div>
       <%@ include file="page2.file" %>
  </div>
  
 <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>


</body>
</html>