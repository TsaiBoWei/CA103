<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%--@ page import="com.Mgr.model.*"--%>
<%@ page import="com.coach.model.*"%>
<%--  MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");--%>

  <%
	CoachService coaSvc = new CoachService();
	List<CoachVO> list = coaSvc.getReviewEnd();
		
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
    	z-index:4 !important    	
    }
     a.btn{
    position:relative;
    	z-index:2 !important    	
    }

  </style>

<title>Insert title here</title>
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
              <th style="width:15%">教練編號</th>
              <th style="width:15%">教練姓名</th>
              <th style="width:50%">教練介紹</th>
              <th style="width:20%">審核結果</th>
            </tr>
          </thead>
       <%@ include file="page1.file" %> 
          <c:forEach var="coachVO" items="${list}" >
          
      
       
          <tbody > 
            <tr >
              <td>${coachVO.coa_id}</td>
              <td>${memSvc.getOneMem(coachVO.mem_id).mem_name}</td>
              <td><div style="overflow: auto;width:100%; max-height:100px">${coachVO.coa_text}</div></td>
      		
              <td>
            	<c:choose>
            		<c:when test="${coachVO.coa_status.equals('CS02')}">            	
            			審核通過
            		</c:when>            	
            		<c:otherwise>            	
            			審核未通過            
            		</c:otherwise>
            	</c:choose>
              </td>
              
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