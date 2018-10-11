<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.purchcour.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.watchedhr.model.*"%>
<%@ page import="com.courunit.model.*"%>
<%@ page import="com.sptype.model.*"%>


<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>purchcour</title>

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
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/purchcour.css">


<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script src="<%=request.getContextPath()%>/front_end/course/purchcour/js/purchcour.js"></script>

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

h1 {
      font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }
</style>


</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
 <%
 	//首頁測試
//  MemVO memVO1= new MemService().getOneMem("M000001");
//  session.setAttribute("memVO", memVO1);
	 request.setCharacterEncoding("utf-8");
	 MemVO memVO=(MemVO)session.getAttribute("memVO");
	 String men_id=memVO.getMem_id();
	 PurchcourService purchcourSvc = new PurchcourService();

	 List<PurchCourVO> list = purchcourSvc.getMemPurchCour(men_id);
	
	 pageContext.setAttribute("list",list);

	 
	


 %>
 
 <% List<PurchCourVO> purchcourlist= (List<PurchCourVO>)pageContext.getAttribute("list"); 
    PurchCourVO purchCourVO=null; 
    CourlistService courlistSvc = new CourlistService();
    
   %> 
    
    
  
    <div class="container px-4 mt-4">   
       <div class="pagenav mt-3 text-left  pl-0"  >	
     <!-- =========================================pagefile========================================== -->
	                                           <%@ include file="page1.file" %>
	 <!-- =========================================pagefile========================================== -->
      </div>
     </div>    
 
 <% if (list.size()==0){ %>
    <div class="container px-4 mt-4">   
       <div class="pagenav mt-3 text-left  pl-0"  >	
        <h5>Haven't Purchased Any Course</h5>
      </div>
     </div>     
    <% }else{%> 
  
  
  <% int maxIndex=pageIndex+rowsPerPage;
	  if (maxIndex>rowNumber){
		  maxIndex=rowNumber;
	  }
	  for(int i=pageIndex; i<maxIndex; i++) {
		  String ratebtn="ratebtn"+i;
		  String ratebtnClass=".ratebtn"+i;
		  
		  String refundbtn="refundbtn"+i;
		  String refundbtnClass=".refundbtn"+i;
		  
		  purchCourVO=list.get(i);
		  
		 
		  CourlistVO courlistVO = courlistSvc.getOneCourlist(purchCourVO.getCour_id());
		  CoachService coachSvc=new CoachService();


		  CoachVO coachVO=coachSvc.getOneCoach(courlistVO.getCoa_id());
		  MemService coamemSvc= new MemService();
		  MemVO coamemVO= coamemSvc.getOneMem(coachVO.getMem_id());
		  
		  SptypeService sptypeSvc=new SptypeService();
 
          SptypeVO sptypeVO=sptypeSvc.getOneSptype(courlistVO.getSptype_id());
          Map<String,String> sportTypeColor= (Map<String,String>)application.getAttribute("sportTypeColor");
      %>
 
 <!-- purchase List-->
  <div class="py-5" id="jys">
    <div class="container px-4">
 
      <div class="row purlistrow">
        <div class="col-md-3 section-fade-in-out px-0 purlistimg" style=" background-image: url('<%=request.getContextPath()%>/purchcour/CourPho_DBGifReader4.do?cour_id=<%=purchCourVO.getCour_id()%>'); ">
          <div class="overlaypurlist "> </div>
        </div>
        <div class="col-md-6 text-left pl-4 pb-2 purchasbg ">
          <div class="mb-4 pb-1 pt-1 purchastitle">
            <span class="badge mb-1 badge-courpaycata"  style="background-color:<%=sportTypeColor.get(courlistVO.getSptype_id())%>;opacity:0.8;"><%=sptypeVO.getSport()%></span>
            <h3 class="text-primary pt-1"><%=courlistVO.getCname()%></h3>
          </div>
          <div class="row mb-2 pl-1 ">
            <div class="col-3 col-md-1 courboarimg px-2 ">
              <img class="img-fluid rounded-circle" alt="Card image" src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=<%=coachVO.getMem_id()%>"></div>
            <div class="col-3 col-md-10  px-1  align-self-end percenatext "><p> Coach · <%=coamemVO.getMem_name()%></p></div>
          </div>                              
          <span class=" mt-1 percenatext "> <fmt:formatDate value="<%=purchCourVO.getCrorder_time()%>" pattern="yyyy-MM-dd"/> · Purchased&nbsp; </span>
          <p class=" percenatext">
            <b>Status&nbsp;·</b>&nbsp;
            
            <%if ("CO1".equals(purchCourVO.getRefund())){%>
            
            <font class="text-primary">
              <i class="far fa-check-circle"></i>&nbsp;Available </font>
             <%}else{%> 
             
             <font class="text-secondary" style="opacity: 0.8;">
              <i class="fas fa-hand-holding-usd"></i>&nbsp;Refund is being processed</font>
             <%}%> 
          </p>
          <div class="row justify-content-end">
            <span class="btn pr-1 mr-2 btnpurchas percenatext <%=refundbtn%>" data-target="#refundexampleModal" data-toggle="modal">
              <i class="fas fa-hand-holding-usd "></i>&nbsp;Refund</span>
            <span class="btn  px-2 mr-3 btnpurchas percenatext <%=ratebtn%>" data-target="#rateexampleModal" data-toggle="modal">
              <%if(purchCourVO.getCoursco()!= 0.0){%>
                <i class="fas fa-star-half-alt"></i>&nbsp;Your&nbsp;Rate:&nbsp;<%=purchCourVO.getCoursco()%></span>
                
              <%}else{ %>
               <i class="fas fa-star-half-alt"></i>&nbsp;Rate</span>
              <%} %>
          </div>
        </div>
       
        <% Date wholeworld=purchCourVO.getCrorder_time();
        if((System.currentTimeMillis()-wholeworld.getTime()>24*60*60*1000*3)||("CO2".equals(purchCourVO.getRefund()))){%>
        <script>
	        $(document).ready(function() {
		           
				  $("<%=refundbtnClass%>").hide();
										   
				});
 
        </script>
        	
        <%}%>
        
        
        <script>
           
		$(document).ready(function() {
			$("<%=ratebtnClass%>").click(function() {
													           
			   $("#hiddencrorder_idforrate").val("<%=purchCourVO.getCrorder_id()%>");
			   $("#coursenamerate").text("<%=courlistVO.getCname()%>");
			   $("#hiddencnameforrate").val("<%=courlistVO.getCname()%>");
			   
													        	  
								});
					});
		</script>
<!-- 		/// -->		
		<%if(purchCourVO.getCoursco()!=null){ %>

		<script>
           
		$(document).ready(function() {
			$("<%=ratebtnClass%>").click(function() {
				
			   $(".start<%=purchCourVO.getCoursco()%>").attr("checked",true);
			   									        	  
								});
					});
		</script>
<!-- 		/// -->
		<%}%>
		<script>
           
		$(document).ready(function() {
			$("<%=refundbtnClass%>").click(function() {
													           
			   $("#hiddencrorder_idforrefund").val("<%=purchCourVO.getCrorder_id()%>");
			  
													        	  
								});
					});
		</script>
        

        
        <div class="col-md-3 percenatext  purchasbg">
          <div class="col-12 pt-3 px-0" id="wrapper ">
            <div class="px-0 text-left">
              <i class="fas fa-chalkboard-teacher"></i> Progress </div>
              <%
              CourunitService courunitSvc=new CourunitService();
              double totalCourLength=courunitSvc.getCourTotalLength(purchCourVO.getCour_id());
              WatchedhrService watchedhrSvc=new  WatchedhrService();
              double total_watchhr=watchedhrSvc.getWatchSumBycrorder_id(purchCourVO.getCrorder_id());
           
              int progress=0;
              if(total_watchhr!=0){
            	  progress=(int)(total_watchhr/totalCourLength*100);
              }else{
            	  progress=0;
              }

              %>
              
              
            <svg class="progress blue" data-progress="<%=progress%>" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 80 80" xml:space="preserve">
              <path class="track" transform="translate(-10 8) rotate(45 50 50)" d="M40,72C22.4,72,8,57.6,8,40C8,22.4,22.4,8,40,8c17.6,0,32,14.4,32,32"></path>
              <text class="display percenatext" x="50%" y="60%">0%</text>
              <path class="fill" transform="translate(-10 8) rotate(45 50 50)" d="M40,72C22.4,72,8,57.6,8,40C8,22.4,22.4,8,40,8c17.6,0,32,14.4,32,32"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>
     <%}%>
     <%}%>
     <!-- purchase List-->
    
    
					 <!-- =========================================pagefile========================================== -->
	                                           <%@ include file="page2.file" %>
	                 <!-- =========================================pagefile========================================== -->
	    	<script>
				
				 $(document).ready(function() {
				        $(".cancel").click(function() {
				           
				             $(location).attr('href', '<%=request.getContextPath()%>/front_end/course/purchcour/page/purchcour.jsp?localhref=localhref');
	
				                
				                 });
				      });
					
			</script>
     
          <c:if test="${localhref!=null}">
			
			<script>
<%-- 	    		 location.href="<%=request.getContextPath()%>${localhref}#jys"; --%>
           $(document).ready(function(){       
           $('html,body').animate({scrollTop:$('#jys').offset().top}, 800); 
           }); 
           </script>
	        </c:if>
	        
	        <c:if test="${param.localhref!=null}">
			
			<script>
	<%-- 	    		 location.href="<%=request.getContextPath()%>${localhref}#jys"; --%>
	           $(document).ready(function(){       
	           $('html,body').animate({scrollTop:$('#jys').offset().top}, 800); 
	           });
	           </script>
			      </c:if>
			      
		



     
     <!--rateform-->
 <FORM METHOD="POST"
				ACTION="<%=request.getContextPath()%>/purchcour/purchcour.do"
				name="ratecheckform">
   
    <div class="col-md-12 text-center ">
    <input type="hidden" class="" name="action" value="updateforrate"></input>
      <div class="modal fade mx-auto" aria-hidden="true" aria-labelledby="exampleModalLabel" id="rateexampleModal" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-dialog-700" role="document">
          <div class="modal-content courboarqform">
            <div class="modal-header courboarmodalheader px-3">
              <h4 class="text-primary">Rate the Course</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" class="text-light"><i class="fas fa-times cancel"></i></span>
              </button>
            </div>
            <div class="modal-body text-left px-3">
              <div class="form-group text-white">
                <h6>Please rate the Course&nbsp;
                
                <font id="coursenamerate">${returncname}</font></h6>
                <fieldset class="rating">
                  <input type="radio" class="star5" id="star5" name="coursco" value="5">
                  <label class="full" for="star5" title="Awesome - 5 stars"></label>
                  
                  <input type="radio" class="star4.5" id="star4half" name="coursco" value="4.5">
                  <label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
                  
                  <input type="radio" class="star4" id="star4" name="coursco" value="4">
                  <label class="full" for="star4" title="Pretty good - 4 stars"></label>
                  
                  <input type="radio" class="star3.5" id="star3half" name="coursco" value="3.5">
                  <label class="half" for="star3half" title="Meh - 3.5 stars"></label>
                  
                  <input type="radio" class="star3" id="star3" name="coursco" value="3">
                  <label class="full" for="star3" title="Meh - 3 stars"></label>
                  
                  <input type="radio" class="star2.5"  id="star2half" name="coursco" value="2.5">
                  <label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
                  
                  <input type="radio" class="star2" id="star2" name="coursco" value="2">
                  <label class="full" for="star2" title="Kinda bad - 2 stars"></label>
                  
                  <input type="radio" class="star1.5" id="star1half" name="coursco" value="1.5">
                  <label class="half" for="star1half" title="Meh - 1.5 stars"></label>
                  
                  <input type="radio" class="star1" id="star1" name="coursco" value="1">
                  <label class="full" for="star1" title="Sucks big time - 1 star"></label>
                  
                  <input type="radio" class="star0.5" id="starhalf" name="coursco" value="0.5">
                  <label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
                </fieldset>
              </div>
            </div>
            <!--- if erroMsg --->
			<c:if test="${not empty errorMsgs}">
											
				<div class="errorMsgs px-3 my-1 text-secondary text-left"><i class="fas fa-exclamation-triangle"></i>&nbsp;Please note&nbsp;:&nbsp;<c:forEach var="message" items="${errorMsgs}">${message}&nbsp;</c:forEach></div>
	
			</c:if>
	        <!--- if erroMsg --->
            <div class="modal-footer courboarmodal">
              <button type="button" class="btn btn-secondary cancel" data-dismiss="modal">Cancel</button>
      
              <input type="hidden" class="" name="action" value="updateforrate"></input>
              <input type="hidden" class="" id="hiddencrorder_idforrate" name="crorder_id" value="" ></input>
              <input type="hidden" class="" id="hiddencnameforrate" name="returncname" value="" ></input>
              <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
            
          </div>
        </div>
      </div>
       
    </div>
   </FORM>
   
  <c:if test="${openrateform!=null}">
			<script>
			$(document).ready(function(){  
	    		 $("#rateexampleModal").modal({show: true});
	    		 
			});
	        </script>
	        </c:if>

    <!--rateform-->

    <!--refundform-->
    <FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/purchcour/purchcour.do" name="refundcheckform">
    
    <div class="col-md-12 text-center ">
      <div class="modal fade mx-auto" aria-hidden="true" aria-labelledby="exampleModalLabel" id="refundexampleModal" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-dialog-700" role="document">
          <div class="modal-content courboarqform">
            <div class="modal-header courboarmodalheader px-3">
              <h4 class="text-secondary">Confirmation</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" class="text-light class"><i class="fas fa-times cancel"></i></span>
              </button>
            </div>
            <div class="modal-body text-left px-3">
              <div class="form-group text-white">
                <p>Are you want to refund this 'course'?</p>
              </div>
            </div>
            <div class="modal-footer courboarmodal">
              <input type="hidden" class="" name="action" value="updateforrefund"></input>
              <input type="hidden" class="" id="hiddencrorder_idforrefund" name="crorder_id" value="" ></input>
              <button type="button" class="btn btn-secondary cancel" data-dismiss="modal">Cancel</button>
              <button type="submit" class="btn btn-primary">Confirm</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    </FORM>
    <!--refundform-->

<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	



