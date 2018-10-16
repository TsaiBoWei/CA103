<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.purchcour.model.*" %>
<%@ page import="com.courlist.model.*" %>
<%@ page import="com.watchedhr.model.*" %>

<%
	PlanVO planVO = (PlanVO) session.getAttribute("planVO");
	pageContext.setAttribute("planVO", planVO);

	MemVO memVO = (MemVO) session.getAttribute("memVO");
	
%>

<%/*1.下拉式選單做<請選擇>選項，並作錯誤驗證及導向。 
	2.計畫封面圖片沒上傳錯誤處理不做。
	3.計畫內容拖拉圖片未做。
	4.set/cancel 按鈕未做完全。
	5.觀看次數

*/%>


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>WORK it OUT</title>

<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">
	
<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">

<style>
/*頁面設定*/
	body {
		overflow-x: hidden;
	}
	
	.date{
		width: 170px;
		height: 33px;
		font-size: 18px;
		background:none;
	}
	#courseplan{
	
	height: 60px;
	border: 0.8px solid white;
	}
	
	
	
	
</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>
<style type="text/css">

.side-bar {
  position: relative;
  margin: 30px auto;
/*   width: 400px; */
  width: auto;
  height: 350px;
/*   background: #fff; */
/*   padding: 30px; */ 
  padding: 10px;
/*   box-shadow: 0 32px 40px -20px rgba(0, 0, 0, .25); */ 
  overflow: scroll;
  transition: background 1s;
}


.side-bar.selected {
  background: rgba(0, 0, 0, .05);
}


.side-bar.selected .prod-list {
  transform: scale(0.85);
}
.side-bar .prod-list {
  transition: 500ms;
}
.side-bar .prod-list li, .side-bar .sub-prod-list li {
  margin-bottom: 10px;
  border-bottom: 1px solid #f6901e;
  list-style: none;
  padding: 5px 0; 

  cursor: pointer;
  border-bottom: 0.7px solid #12bbad;
}
.side-bar .popup-list {
  background: #fff; 
  padding: 30px; 
  
  position: absolute;
  top: 10%;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 1;
  visibility: hidden;
  transform: translateY(100%);
  transition: cubic-bezier(0.7, 0, 0.2, 1) 0.5s;
  overflow: scroll;
  background: rgba(48, 48, 48, 1);
}
.side-bar .popup-list.active {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
  box-shadow: 0 -32px 40px -20px rgba(0, 0, 0, .25);
}
/* #style-1::-webkit-scrollbar */
/* { */
/* 	width: 12px; */
/* 	background-color: #F5F5F5; */
/* } */
::-webkit-scrollbar {
    -webkit-appearance: none;
    width: 12px;
  
}

::-webkit-scrollbar-button {
    
    background-color:none;
}
/* ::-webkit-resizer{ */
/*  -webkit-appearance: none; */
/*  background-color:red; */
/* } */

::-webkit-scrollbar-corner {
  background-color:none; 
  -webkit-appearance: none;

}

::-webkit-scrollbar-thumb {
    border-radius: 12px;
    border: 4px solid rgba(255,255,255,0);
    background-clip: content-box;

    background-color: rgba(160, 160, 160,0.8);
}

.side-bar .popup-list.active {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
  box-shadow: 0 -32px 40px -20px rgba(0, 0, 0, .25);
}


</style>
<style>

.commentbottomline{
  border-bottom: 0.5px solid rgba(239, 239, 239,0.4);
}

.postsubtitle .border-right {
    border-right: 0.8px solid rgba(239, 239, 239,0.8)!important;
}
.courboarlistinnerline{
  border-bottom: 0.8px solid rgba(239, 239, 239,0.4); 
}

.h5{
     font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei" !important;
}

p.h6{
     font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei" !important;
}

body{
     font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei" !important;
}
    
.replyinreplynametext{
  border-bottom: 0.5px solid rgba(239, 239, 239,0.4);  
}


   .commenttextarea {
      height: 120px;
    }

    .courboarsearchbar {
      background: none;
      border: 0.7px solid #303030;
    }

    .courboarsearchbar:focus {
      background: none;
    }

    .courboarformtitle {
      border-radius: 2px;
      background: none;
      border: 0.5px solid rgba(204, 204, 204, 0.5);
    }

    .courboarformtitle:focus {
      background: none;
    }

    .courboarqform {
      background: rgba(48, 48, 48, 0.9);
      /*width: 700px;*/
    }

    .courboardqtext {
      border-radius: 2px;
      background: none;
      border: 0.5px solid rgba(204, 204, 204, 0.5);
    }

    .courboardqtext:focus {
      background: none;
    }

    .courboarmodalheader {
      border-bottom: none;
    }

    .courboarmodal {
      border-top: 0.5px solid rgba(204, 204, 204, 0.5);
    }

    .courboarlistinnerline {
      border-bottom: 0.5px solid rgba(239, 239, 239, 0.4);
    }
    
    .crposticon:hover{
    
    color:#009ac0;
    }
    
  
    /*20180915  courboarform  彈出表單修改尺寸*/

    .form-group-100{
        width:100%;
    }

    .modal-dialog.modal-dialog-700{
        max-width: 400px;
    }

    .popModel-close-bt{
        position: absolute;
        right: 0;
        height: 50px;
        width: 50px;
    }

    /*//20180915  courboarform  彈出表單修改尺寸*/
 #plan_votext{
 background:none;
 
 }
 
 .myfirstday{
 background:none;
 
 }
 

</style>



<%--上傳圖片 --%>
<script
	src="<%=request.getContextPath()%>/front_end/plan/js/UploadPlan_Cover.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/plan/css/img.css">


</head>


<body class="text-center">
<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	 <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
	
	
	<div class="py-5 text-light opaque-overlay section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/img/CreatPlan_picture.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 mx-auto">
					<form method="post"
						action="<%=request.getContextPath()%>/plan/plan.do"
						enctype="multipart/form-data">

						<div class="form-group text-primary" style="font-size: 24px">
							Create A New Plan
						</div>
						<br>
						
						<%-- 錯誤表列 --%>
							<c:if test="${not empty errorMsgs}">
								<font style="color:red" size="5">Amend　The　Following　Errors</font><br>
								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color:red ; font-size:20px ">${message}</li>
									</c:forEach>
								</ul>
							</c:if>
						

						<div class="form-group">
							<h3>Plan Name</h3>
							<input type="text" name="plan_name"
								value="<%= (planVO==null) ? "MyFirstDay" : planVO.getPlan_name()%>"
								class="form-control myfirstday text-light"/>
						</div>
						<br>

				 		<div class="form-group">
							<label><h3>PlanStartDate</h3></label> 
							<input type="text" name="plan_start_date" id="f_date1" class="date text-light"/>
						</div>


					 	<div class="form-group">
							<label><h3>Plan EndDate</h3></label> 
							<input type="text" name="plan_end_date" id="f_date2" class="date text-light"/>
						</div>

						
						
 						<jsp:useBean id="sptypeSvc"  scope="page" class="com.sptype.model.SptypeService"/>
						
 						<div class="form-group">  
							<label><h3>Sport Type　</h3></label> <select size="1"
								name="sptype_id" class="" style="width: 150px; font-size: 18px;">
								<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
									<option value="${sptypeVO.sptype_id}" ${(planVO.sptype_id==sptypeVO.sptype_id)? 'selected':''}>${sptypeVO.sport}
								</c:forEach>
							</select>
						</div>


						<div class="form-group">  
							<label><h3>Privacy</h3></label> <select size="1"
								name="plan_privacy" style="width: 150px; font-size: 18px;">
								<option value="PLANPR0">公開</option>
								<option value="PLANPR1">不公開</option>
								<option  value="PLANPR2">只對朋友公開</option>
							</select>
						</div>

						<div class="form-group">
							<label><h3>Plan Cover　</h3></label> 
							<label class="btn btn-info btn-lg"> 
								<input type="file" id="upload_img" name="plan_cover" accept="image/*" 
									 onchange="openFile(event)" style="display: none;" 
									 <%--  value="= (planVO==null) ?"= request.getContextPath()>/front_end/plan/images/photo.png":planVO.getPlan_cover%>"--%>/>
									<i class="fa fa-photo">　Upload</i>
							</label>
						</div>
						
						
						<div class="form-group">
							　　　　　　　　　<img class="img" id="output"  style="display: none;">
						</div>

						<div class="form-group">
							<label><h3>Plan Content</h3></label><br>
							<span class="btn btn-info deletecbform px-1 mb-2 " data-toggle="modal" data-target="#courlistplan"> 
								<i class="far fa-plus-square"></i>&nbsp;&nbsp;Add Course Into Plan
							</span>
							<textarea name="plan_vo" rows="10" class="form-control text-light" style="font-size: 26px" id="plan_votext" >789</textarea>
							<br>
						</div>
						<!-- 	ashley -->
						
<!-- 						ashley -->
						<div class="col-12 "id="courseplan" style="display:none;" ></div>
	<!-- 						ashley -->
		
						<div class="from-group">
<!-- 							<h5> -->
<%--     							瀏覽數：${planVO.plan_view}  --%>
							<input type="hidden" name="plan_view" value="50">
<!-- 							</h5> -->
						</div>
						<div class="form-group">
							<input type="hidden" name="action" value="insert">
							<button type="submit" class="btn btn-primary creatbtn">Create</button>
<!-- 							<button type="submit" class="btn btn-primary" -->
<%-- 								formaction="<%= request.getContextPath()%>/front_end/plan/Interesting_Plan.jsp">Reset</button> --%>
<!-- 							<button type="submit" class="btn btn-primary"  -->
<%-- 								formaction="<%= request.getContextPath()%>/front_end/plan/HomePage.jsp">cancel</button> --%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container containerHrB ">
		<hr>
	</div>

<!--ashley -->
	<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" tabindex="-1" role="dialog"
						aria-hidden="true" aria-labelledby="exampleModalLabel"
						id="courlistplan" data-backdrop="static" data-keyboard="false"><!-- 										///	 -->
						<div class="modal-dialog modal-dialog-700" role="document">
							<div class="modal-content courboarqform">
								<button type="button" class="close popModel-close-bt cancel"
									data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true" class="text-light"><i
										class="fas fa-times cancel"></i></span>
								</button>
								<div class="modal-header courboarmodalheader">
									<div class="form-group text-left text-white form-group-100">
										
										
									</div>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
<!-- 										<label>Content</label> -->
                                     <h3 class="text-primary">Choose A Lesson</h3>
										<div class="side-bar text-light">
										<ul class="prod-list">
					<jsp:useBean id="purcourSvc" scope="page" class="com.purchcour.model.PurchcourService" />
					<jsp:useBean id="courlistSvc" scope="page" class="com.courlist.model.CourlistService" />
					<jsp:useBean id="watchedhrSvc" scope="page" class="com.watchedhr.model.WatchedhrService" />
									<c:forEach var="purchcourVO" items="${purcourSvc.getMemPurchCour(memVO.mem_id)}">
											<li class="pb-1" name="${purchcourVO.cour_id}" id="${purchcourVO.crorder_id}" ><i class="far fa-file-video"></i>&nbsp;${courlistSvc.getOneCourlist(purchcourVO.cour_id).cname}</li>
									
									<script>
									$("#${purchcourVO.crorder_id}").click( function(){
										
										$("#plan_votext").hide();
										$("#courseplan").show();
										
										$.ajax({
									        url:'<%=request.getContextPath()%>/courunit/courunit.do',
									        method:'POST',
									       
									        data:{
									           action:"queryforcourlist",
									           cour_id:$(this).attr("name"),
									           crorder_id:$(this).attr("id"),
								
									        },
									        success : function(result) {
// 									            if (result.status === 'success'){
									            	alert(result);
									            $(".sub-prod-list").empty();
									            $(".sub-prod-list").append(result);
									            },
									      
									
									});
										
									});
									
									
									</script>
									
									
									
									</c:forEach>
									
										</ul>
										<div class="popup-list" id="style-1">
											<ul class="sub-prod-list">
<!-- 											<li class="pb-1" data-dismiss="modal">Sub-option 1</li>				 -->
										</ul>
										</div>
										
									</div>
								</div>
								<div class="modal-footer courboarmodal">
<!-- 									<button type="button" class="btn btn-secondary cancel" -->
<!-- 										data-dismiss="modal">Cancel</button> -->
<!-- 									<input type="hidden" name="action" value="insert"></input>  -->
<!-- 									<input -->
<!-- 										type="hidden" name="cour_id" value="" class="brows_cour_id"></input> -->
								
<%-- 								    <input type="hidden" name="mem_id" id="" value="${memVO.mem_id}"></input> --%>

<%-- 								<c:if test="${watchedhrSvc.getFirstByCrorder_id(purchcourVO.crorder_id).cour_unit_id.equals(courunitlist.get(i).getCour_unit_id())}"> --%>
<!-- 								<script type="text/javascript"> -->
<!-- //  								$(document).ready(function() {   -->
<!-- // 					            var strli=$("#").text()+"<i class='far fa-eye'></i>最後觀看至"; -->
<!-- // 									$("#").text(strli);  -->
<!-- // 							});  -->
<!-- <!-- 								</script> --> 
<%-- 								</c:if> --%>

						
<!-- 									<input class="whichPagepasser" type="hidden" name="whichPage" value=""></input>  -->
<!-- 									<button type="submit" class="btn btn-primary confirmbtn">Save -->
<!-- 										Changes</button> -->
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
<!--ashley -->


<script type="text/javascript">
	var courplantext="";
	$('.side-bar').click( function(){
	$(this).toggleClass('selected')
	$('.popup-list').toggleClass('active')
});


    
	
	$(document).ready(function() {
		$(".creatbtn").click(function(e) {
// 			e.preventDefault();
			$("#courseplan").find('.linkclose').each(function(index, item){
				$(item).html('');
			});
			$("#courseplan").find('a').each(function(index, item){
				$(item).removeClass();
			});
			var inputcourplan = $("#courseplan").html();
			console.log(inputcourplan);
		
			if (($("#courseplan").text())!=""){
			$("#plan_votext").val(inputcourplan);}
		});

	});

  


</script>


	
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->

	<!-- Script: Smooth scrolling between anchors in a same page -->
	<script src="<%=request.getContextPath()%>/js/smooth-scroll.js"></script>
</body> 

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
	java.sql.Timestamp plan_start_date = null;
	try {
		plan_start_date = planVO.getPlan_start_date();
	} catch (Exception e) {
		plan_start_date = new java.sql.Timestamp(System.currentTimeMillis());
	}
%>

<%
	java.sql.Timestamp plan_end_date = null;
	try {
		plan_end_date = planVO.getPlan_end_date();
	} catch (Exception e) {
		plan_end_date = new java.sql.Timestamp(System.currentTimeMillis());
	}
%>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.full.js"></script>


<script>
$.datetimepicker.setLocale('zh'); // kr ko ja en
$(function(){
	$('#f_date1').datetimepicker({
		format:'Y-m-d H:i',
	  	timepicker:true,
	  	step: 5,
		onShow:function(){
			this.setOptions({
				maxDate:$('#f_date2').val()?$('#f_date2').val():false
			})
		}
	});
	 
	$('#f_date2').datetimepicker({
		format:'Y-m-d H:i',
		timepicker:true,
		step: 5,
		onShow:function(){
			this.setOptions({
				minDate:$('#f_date1').val()?$('#f_date1').val():false
			})
		}
	});
});
</script>




</html>