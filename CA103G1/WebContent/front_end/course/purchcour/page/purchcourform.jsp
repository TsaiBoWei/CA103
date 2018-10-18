<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.courlist.model.*"%>



<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>purchcourform</title>

<!-- CSS dependencies -->
 <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/purchcourform.css">


<script src="<%=request.getContextPath()%>/front_end/course/purchcour/js/purchcourform.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
	
<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
	
<style>

 

/*頁面設定*/
body {
	overflow-x: hidden;
}

h1 {
      font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }

</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}

 /*  大nav bar */
    .navbar-dark .navbar-nav .nav-link{
	color:rgba(255, 255, 255, 0.7)!important;
	font-weight:bold!important;
	
	}
</style>


</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
 <%
 
//  session.setAttribute("brows_cour_id", "COUR000002");
//  session.setAttribute("brows_courlistVO", courlistVO);
 request.setCharacterEncoding("utf-8");
//  String cour_id=(String)session.getAttribute("brows_courlistVO");
//  CourlistService courlistSvc = new CourlistService();
 CourlistVO courlistVO = (CourlistVO)session.getAttribute("brows_courlistVO");
 
 pageContext.setAttribute("courlistVO",courlistVO);


 %>
 
 <div class="py-3 mt-1 " id="jys">
 </div>
  <!--purchase form-->
  <div class="py-5" >
    <div class="container  ">
      <div class="row">
        <div class="col-12 ">
          <h2 class="text-left">&nbsp;&nbsp;Course Payment</h2>
          <hr> </div>
      </div>
    </div>
  </div>
  <jsp:useBean id="sportSvc" scope="page" class="com.sptype.model.SptypeService" />
  <div class="py5 ">
    <div class="container formpurchas formpurchas2 ">
      <div class="row no-gutters section-fade-in-out" style=" background-image: url('<%=request.getContextPath()%>/purchcour/CourPho_DBGifReader4.do?cour_id=<%=courlistVO.getCour_id()%>'); ">
        <div class="col-md-7 align-self-end text-left text-light purcourpic ">
          <div class=" pt-3 pb-4 align-self-end pl-4 paymentcour">
            <span class="badge badge-secondary mb-2 badge-courpaycata" style="background-color:${sportTypeColor.get(courlistVO.sptype_id)};opacity:0.9;">${sportSvc.getOneSptype(courlistVO.sptype_id).sport}</span>
            <p class="h3 ">${courlistVO.cname}</p>
            <p class="h4 text-primary">$&nbsp;${courlistVO.cour_cost}</p>
          </div>
        </div>
        <!--left-->
        <div class="col-md-5 text-left pl-4 pr-3 paymentcard formpurchas2">
          <div class="mt-2 pb-1 pt-3 mb-4  paymemttitleline ">
            <h3 class="text-light-payment " id="accountdetails"> Account Details </h3>
          </div>
           <!--- if erroMsg --->
           <div class="col-12 mt-1 ">&nbsp;
			<c:if test="${not empty errorMsgs}">
                
				<div class="errorMsgs text-secondary mb-3"><i class="fas fa-exclamation-triangle cancel"></i>&nbsp;&nbsp;Please note&nbsp;:&nbsp;
				<% 
				List errorMsgslist =(List)request.getAttribute("errorMsgs");
				for(int i=0; i<errorMsgslist.size();i++){ 
				String errorMsgs= (String)errorMsgslist.get(i);
				
				%>	
				  <%if(i==errorMsgslist.size()-1){ %>	
				  <%=errorMsgs%>!!!
				  <% break; }%>
		
		         <%=errorMsgs%>&nbsp;,&nbsp;
		         
		         <%} %>
		         </div>
			</c:if>
			</div>
          <!--- if erroMsg --->
          <!--credit card-->
          <FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/purchcour/purchcour.do?"
				name="paymentform">
		
          <label for="basic-url mt-2">Card Holder</label>
          <div class="input-group mb-3 pr-3">
            <div class="input-group-prepend">
              <span class="input-group-text courpaylogotext" id="basic-addon3">
                <i class="fas fa-user-circle text-light"></i>
              </span>
            </div>
            <input type="text" name="cardholder" class="form-control text-primary font-weight-bold courpay " id="" aria-describedby="basic-addon3" placeholder="Peter God Wu"> </div>
          <!--credit card-->
          <!--credit card-->
          <label for="basic-url">Card Number</label>
          <div class="input-group mb-3 pr-3">
            <div class="input-group-prepend">
              <span class="input-group-text courpaylogotext" id="basic-addon3">
                <i class="far fa-credit-card text-light"></i>
              </span>
            </div>
            <input type="text" name="cardNumber" class="form-control courpay text-primary font-weight-bold" id="" aria-describedby="basic-addon3"> </div>
          <!--credit card-->
          <!--credit card-->
          <div class="row px-2 my-0 ">
            <div class="col-md-3 p-0">
              <div class="form-group my-3">
                <label for="basic-url">Vaild Mon</label>
                <input type="text" name="validmonth" class="form-control text-primary font-weight-bold courpay" aria-describedby="basic-addon3" id="" placeholder="08">
              </div>
            </div>
            <!--credit card-->
            <!--credit card-->
            <div class="col-md-3 ml-2 px-0">
              <div class="form-group my-3">
                <label for="basic-url">Year</label>
                 <input type="text" name="validYear" class="form-control courpay text-primary font-weight-bold" aria-describedby="basic-addon3" id="" placeholder="22">
              </div>
            </div>
            <!--credit card-->
            <!--credit card-->
            <div class="col-md-4 form-group my-3 ml-4 text-left text-white ">
              <label>CVC</label>
              <div class="">
                <input type="password" name="cvc" class="form-control courpay text-primary font-weight-bold" aria-describedby="basic-addon3" id="" > </div>
            </div>
            <!--credit card-->
          </div>
          <div class=" text-right mt-4  mb-4 pb-1 paymemtrow ">
            <input type="hidden" name="mem_id" value="${memVO.mem_id}"></input>
            <input type="hidden" name="cour_id" value="${courlistVO.cour_id}"></input>
            <input type="hidden" name="action" value="insert"></input>
            <button type="submit" class="btn btn-primary courpaybtn" data-toggle="modal" data-target="#exampleModal"> Submit Payment </button>
          </div>
        </div>
        <!--left-->
      </div>
    </div>
  </div>
 </FORM>
 <!--purchase form-->
 
 <script>
    window.onload=function(){
    	location.hash="#jys";
    	console.log(location.href);
    };
           
   </script>
   
   <script>
   $(document).ready(function() {
   $("#accountdetails").click(function() {
	   $("input[name='cardholder']").val("PeterWu");
	   $("input[name='cardNumber']").val("1234567890123456");
	   $("input[name='validmonth']").val("08");
	   $("input[name='validYear']").val("22");
	   $("input[name='cvc']").val("123");
   });
   });
   </script>
 


<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	



