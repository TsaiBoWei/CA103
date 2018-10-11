<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.boardres.model.*"%>
<%@ page import="com.courboar.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.purchcour.model.*"%>

<%  
    request.setCharacterEncoding("utf-8");
   
	CourlistVO courlistVO = (CourlistVO)session.getAttribute("brows_courlistVO"); //CourlistServlet.java(Controller), 存入req的courlistVO物件
	//session.setAttribute("brows_courlistVO", courlistVO);//存在瀏覽頁面的
	MemVO memVO = (MemVO) session.getAttribute("memVO"); //取出登入會員VO
    String keyWord = request.getParameter("keyword_search");
    if(keyWord==null){
    	keyWord=(String)session.getAttribute("keyword_search");
    }
    session.setAttribute("keyword_search", keyWord);
    String showCrres_id=request.getParameter("showCrres_id");
System.out.print(courlistVO.getCour_id());
System.out.print(keyWord);
    
    CourBoarService courboarSvc = new CourBoarService();
    List<CourBoarVO> list = courboarSvc.keyWordSearch(keyWord, courlistVO.getCour_id());
   
    pageContext.setAttribute("list",list);
%>


<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>maincourboar</title>

<!-- PAGE settings -->
  
  
  <title>TRY</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- ASHLEY -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <!-- end ASHLEY -->
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/course/courlist/css/Course.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/course/courlist/css/font.css">
  <!-- ASHLEY -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/course/courboar/css/courboar.css">
  <!-- end ASHLEY -->
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  
 
 
   <!-- ASHLEY fafaicon -->
   <!-- ASHLEY -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <!-- end ASHLEY -->
  <link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous"> 

  <!-- ASHLEY --> 
<style>
/*頁面設定*/
body {
	overflow-x: hidden;
}
</style>
<script>
//     $('#myModal').on('shown.bs.modal', function () {
//     $('#myInput').trigger('focus')
//   })



  </script>
 

</head>

<body class="text-center">
  <!-- Navbar -->
  <!-- Navbar -->
  <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" 
        href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">User</a>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#register">Register now</a>
      </div>
    </div>
  </nav>
  <!-- Cover -->
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(<%=request.getContextPath() %>/front_end/course/courlist/assets/conference/024.jpg);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-md-left text-center align-self-center my-5" style="height:13rem;"> </div>
      </div>
    </div>
  </div>
 
    <!-- 主頁圖(圖片) -->
  <div class="py-5 text-white">
    <div class="container">
      <div class="row">
        <div class="col-md-7 text-md-left text-center align-self-center my-5">
          <h3><%=courlistVO.getCname()%>
            <br> </h3>
          <div class="text-md-right">
            <a href="#" class="btn btn-outline-primary btn-sm m-1">Share
              <br> </a>
            <a href="#" class="btn btn-sm btn-outline-secondary m-1">Report
              <br> </a>
          </div>
          <div>
<%--           <p class="coach_text_short"><%=coachVO2.getCoa_text()%></p> --%>
          <p class="coach_text_short"><%=courlistVO.getCour_text()%></p>
              <script>
             	 $(document).ready(function() {
            	    var len = 50; // 超過50個字以"..."取代
            	    $(".coach_text_short").each(function(i){
            	        if($(this).text().length>len){
            	            $(this).attr("title",$(this).text());
            	            var text=$(this).text().substring(0,len-1)+".......";
            	            $(this).text(text);
            	        }
            	    });
            	});   
  			  </script>
          </div>
          <a href="<%=request.getContextPath()%>/front_end/course/purchcour/page/purchcourform.jsp" class="btn btn-lg btn-primary mx-1">Buy It</a>
        </div>
        <div class="col-md-5  align-self-center" >
          <img class="img-fluid d-block mx-auto align-baseline" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>"></div>
      </div>
    </div>
  </div>
    <!-- 分頁頁籤 -->

  <div class="container containerHrT " >
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent&localhref=localhref">
        <!-- 第一個按鈕 -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?courpageloc=tabone&localhref=localhref" >
              <i class="fa fa-user"></i> &nbsp; Coach &nbsp;</a>
          </li>
          <!-- 第二個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?courpageloc=tabtwo&localhref=localhref">
              <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; Announcement &nbsp;</a>
          </li>
          <!-- 第三個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?courpageloc=tabthree&localhref=localhref"  >
              <i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; Information&nbsp;</a>
          </li>
         <!-- 第四個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/courunit.jsp?courpageloc=tabfour"  id="tabfourlink">
              <i class="fa fa-film" aria-hidden="true"></i>&nbsp; Course Unit &nbsp; </a>
          </li>
          <!-- 第五個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courboar/page/maincourboar.jsp?courpageloc=tabfive" id="tabfivelink" >
              <i class="fa fa-comments" aria-hidden="true"></i> &nbsp; Forum &nbsp; </a>
          </li>
          <!-- 第六個按鈕 -->
<!--           <li class="nav-item"> -->
<!--             <a class="nav-link" href="" data-target="#tabsix" data-toggle="tab"> -->
<!--               <i class="fa fa-star" aria-hidden="true"></i> &nbsp; Mangenment &nbsp; </a> -->
<!--           </li> -->
        </ul>
      </div>
    </div>
  </nav>
  
  
  <%
  
  String courpageloc=request.getParameter("courpageloc");
  
	if(courpageloc!=null){
	String courpagelocId="#"+courpageloc;
	String courpageloclinkId="#"+courpageloc+"link";
	
	%>
	<script>
	 $(document).ready(function() {
      
        $("<%=courpagelocId%>").addClass('show active');
        $("<%=courpageloclinkId%>").css({"color": "#12bbad", "border-bottom": " 0.8px solid #12bbad"});

    
	 });
    </script>
 <% }%>
  
 
  <div class="container containerHrB" id="jys" >
    <hr> </div>
	<!--list-->
	<!--Courboar title-->
	<div class="py-4" >
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h2 class="text-left">Course Board</h2>
					<hr>
				</div>
			</div>
		</div>
	</div>
	
	
  	
	<!--courboar-->
	<div class="container mb-3" >
		<div class="row align-items-start ">
			<!--searchbar-->
			<div class=" col-md-9 mb-0 px-5" >
				<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/front_end/course/courboar/page/searchcourboar.jsp#jys"
				name="searchbar">
					<div class="input-group">
						<div class="input-group-prepend">
							<span
								class="input-group-text bg-primary border-primary border text-white">Search</span>
						</div>
						<input type="text" name="keyword_search"
							class="form-control courboarsearchbar text-white">
						<div class="input-group-append">
							<input type="hidden" name="cour_id" value="" class="brows_cour_id"></input>
							<button type="submit" class="btn btn-primary border-primary border text-dark confirmbtn">
								<i class="fa fa-search text-white"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
			<div class=" col-12 col-md-3 mb-0 px-3">
				<button type="button" class="btn btn-outline-primary"
					data-toggle="modal" data-target="#courboarform" id="addcomment">Add Your Comment</button><!-- 										///	 -->
			</div>
			
			<%
			
			  PurchcourService purchcourSvc=new PurchcourService();
			  
			  String orderid=null;
// 			  String orderid=purchcourSvc.getCrorder_idByCrMemId(courlistVO.getCour_id(), memVO.getMem_id()); 
			  if(memVO==null||purchcourSvc.getCrorder_idByCrMemId(courlistVO.getCour_id(), memVO.getMem_id())==null){
				
			%>
			<script type="text/javascript">
			$(document).ready(function() { 
	       		$("#addcomment").click(function () {

              $('#courboarform').on('show.bs.modal', function (e) {
            	  if (!data) return e.preventDefault() 
              });
              alert("您尚未購買此課程");


			        });
			
			    });
			
			
			</script>
			<%}
			%>	
		
			  
			  

			<!--searchbar-->
			<!--courboarform-->
			
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/courboar/courboar.do"
				name="courboarform">
				<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" tabindex="-1" role="dialog"
						aria-hidden="true" aria-labelledby="exampleModalLabel"
						id="courboarform" data-backdrop="static" data-keyboard="false"><!-- 										///	 -->
						<div class="modal-dialog modal-dialog-700" role="document">
							<div class="modal-content courboarqform">
								<button type="button" class="close popModel-close-bt cancel"
									data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true" class="text-light"><i
										class="fas fa-times cancel"></i></span>
								</button>
								<div class="modal-header courboarmodalheader">
									<div class="form-group text-left text-white form-group-100">
										<label>Title</label>
										<div class="col-12 px-0 text-white">
											<input type="text" name="crpos_tit"
												class="form-control courboarformtitle text-white">
										</div>
									</div>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
										<label>Content</label>
										<textarea class="form-control courboardqtext  text-white"
											rows="5" name="crpos_text"></textarea>
                                    <!--- if erroMsg --->
										<c:if test="${not empty errorMsgs}">
											
											<div class="errorMsgs mt-2 text-secondary"><i class="fas fa-exclamation-triangle cancel"></i>&nbsp;Please note&nbsp;:&nbsp;<c:forEach var="message" items="${errorMsgs}">${message}&nbsp;</c:forEach></div>
	
										</c:if>
<!-- 								<!--- if erroMsg --->
									</div>
								</div>
								<div class="modal-footer courboarmodal">
									<button type="button" class="btn btn-secondary cancel"
										data-dismiss="modal">Cancel</button>
									<input type="hidden" name="action" value="insert"></input> 
									<input
										type="hidden" name="cour_id" value="" class="brows_cour_id"></input>
								
								    <input type="hidden" name="mem_id" id="" value="${memVO.mem_id}"></input>
						
									<input class="whichPagepasser" type="hidden" name="whichPage" value=""></input> 
									<button type="submit" class="btn btn-primary confirmbtn">Save
										Changes</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</FORM>
			<!--- if erroMsg open lightbox again--->
			<c:if test="${opencourboarform!=null}">
			<script>
	    		 $("#courboarform").modal({show: true});
	        </script>
	        </c:if>
	        <!--- if erroMsg --->
	      
			<!--courboarform-->
				
		<!--updateform-->
	     <c:if test="${openModal!=null}">
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/courboar/courboar.do"
					name="courboarform">
					<div class="col-md-12 text-center">
						<div class="modal fade mx-auto" tabindex="-1" role="dialog"
							aria-hidden="true" aria-labelledby="exampleModalLabel"
							id="updateform" data-backdrop="static" data-keyboard="false">
							<div class="modal-dialog modal-dialog-700" role="document">
								<div class="modal-content courboarqform">
									<button type="button" class="close popModel-close-bt cancel"
										data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
									
	        <!-- =========================================以下為原getOneCourboar.jsp的內容========================================== -->
	                                               <jsp:include page="getOneCourboar.jsp"/>
	        <!-- =========================================以上為原getOneCourboar.jsp的內容========================================== -->
	
				
									<div class="modal-footer courboarmodal">
										<button type="button" class="btn btn-secondary cancel"
											data-dismiss="modal">Cancel</button>
										<input type="hidden" name="action" value="update"></input> 
										<button type="submit" class="btn btn-primary confirmbtn" >Save
											Changes</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</FORM>
		     <script>
		     $(document).ready(function() {
	    		 $("#updateform").modal({show: true});
		     });
	        </script>
	       </c:if>		
			
		 <!--updateform-->
			
	
			<!--replyform-->
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/boardres/boardres.do"
				name="replyform">

				<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" aria-hidden="true"
						aria-labelledby="exampleModalLabel" id="replyform"
						role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog modal-dialog-700" role="document">
							<div class="modal-content courboarqform">
								<div class="modal-header courboarmodalheader">
									<h5 class="modal-title text-light" id="exampleModalCenterTitle">Leave
										your comment</h5>
									<button type="button" class="close cancel" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
										<label>Content</label>
										<textarea class="form-control courboardqtext text-white"
											rows="5" name="crres_text"></textarea>
											
									<!--- if erroMsg --->
										<c:if test="${not empty errorMsgs}">
											
											<div class="errorMsgs mt-2 text-secondary"><i class="fas fa-exclamation-triangle"></i>&nbsp;Please note&nbsp;:&nbsp;<c:forEach var="message" items="${errorMsgs}">${message}&nbsp;</c:forEach></div>
	
										</c:if>
<!-- 								<!--- if erroMsg --->
									</div>
								</div>
								<div class="modal-footer courboarmodal">
									<button type="button" class="btn btn-secondary cancel"
										data-dismiss="modal">Cancel</button>
									<input type="hidden" name="crpost_id" id="hiddencrpost_idreplyform" value=""></input> 
									<input type="hidden" name="mem_id" id="" value="${memVO.mem_id}"></input>
									<input class="whichPagepasser" type="hidden" name="whichPage" value=""></input> 
									<input type="hidden" name="action" value="insert"></input>
									<button type="submit" class="btn btn-primary confirmbtn">Save
										Changes</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</FORM>
			<!--- if erroMsg open lightbox again--->
			<c:if test="${openreplyform!=null}">
			<script>
			$(document).ready(function() {
	    		 $("#replyform").modal({show: true});
			});
	        </script>
	        </c:if>
	        <!--- if erroMsg --->
			
			<!--replyform-->
			
		<!--updatereplyform-->
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/boardres/boardres.do"
				name="updatereplyform">

				<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" aria-hidden="true"
						aria-labelledby="exampleModalLabel" id="updatereplyform"
						role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog modal-dialog-700" role="document">
							<div class="modal-content courboarqform">
								<div class="modal-header courboarmodalheader">
									<h5 class="modal-title text-light" id="exampleModalCenterTitle">Leave
										your comment</h5>
									<button type="button" class="close cancel" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
										<label>Content</label>
										<textarea class="form-control courboardqtext text-white "
											rows="5" name="crres_text" id="courboardqrtext"></textarea>
											
									<!--- if erroMsg --->
										<c:if test="${not empty errorMsgs}">
											
											<div class="errorMsgs mt-2 text-secondary"><i class="fas fa-exclamation-triangle"></i>&nbsp;Please note&nbsp;:&nbsp;<c:forEach var="message" items="${errorMsgs}">${message}&nbsp;</c:forEach></div>
	
										</c:if>
<!-- 								<!--- if erroMsg --->
									</div>
								</div>
								<div class="modal-footer courboarmodal">
									<button type="button" class="btn btn-secondary cancel"
										data-dismiss="modal">Cancel</button>
									<input type="hidden" name="crres_id" id="hiddencrres_idupdatereplyform" value=""></input> 
									<input class="whichPagepasser" type="hidden" name="whichPage" value=""></input> 
									<input type="hidden" name="action" value="update"></input>
									<button type="submit" class="btn btn-primary confirmbtn">Save
										Changes</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</FORM>
			<!--- if erroMsg open lightbox again--->
			<c:if test="${openupdatereplyform!=null}">
			<script>
	    		 $("#updatereplyform").modal({show: true});
	        </script>
	        </c:if>
	        <!--- if erroMsg --->
			
			<!--updatereplyform-->
			
			
			
			<!--courpostdeletecheckform-->
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/courboar/courboar.do"
				name="courpostdeletecheckform">

				<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" aria-hidden="true"
						aria-labelledby="exampleModalLabel" id="courpostdeletecheckform"
						role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog modal-dialog-700" role="document">
							<div class="modal-content courboarqform">
								<div class="modal-header courboarmodalheader">
									<h5 class="modal-title text-secondary" id="exampleModalCenterTitle">Confirmation</h5>
									<button type="button" class="close cancel" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
										<i class="fas fa-exclamation-circle"></i>&nbsp;&nbsp;Are you sure you want to delete this 'post'&nbsp;?
									</div>
								</div>
								<div class="modal-footer courboarmodal">
									<button type="button" class="btn btn-secondary cancel"
										data-dismiss="modal">Cancel</button>
									<input type="hidden" name="action" value="hide"></input> 
									<input type="hidden" name="crpost_id" value="" id="inputhidecrpost_id"></input> 
									<input class="whichPagepasser" type="hidden" name="whichPage" value=""></input> 
									<button type="submit" class="btn btn-primary confirmbtn">Confirm</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</FORM>
			
			<!--courpostdeletecheckform-->
			
			<!--replydeletecheckform-->
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/boardres/boardres.do"
				name="replydeletecheckform">

				<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" aria-hidden="true"
						aria-labelledby="exampleModalLabel" id="replydeletecheckform"
						role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog modal-dialog-700" role="document">
							<div class="modal-content courboarqform">
								<div class="modal-header courboarmodalheader">
									<h5 class="modal-title text-secondary" id="exampleModalCenterTitle">Confirmation</h5>
									<button type="button" class="close cancel" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
										<i class="fas fa-exclamation-circle"></i>&nbsp;&nbsp;Are you sure you want to delete this 'reply'&nbsp;?
									</div>
								</div>
								<div class="modal-footer courboarmodal">
									<button type="button" class="btn btn-secondary cancel"
										data-dismiss="modal">Cancel</button>
									<input type="hidden" name="action" value="hide"></input> 
									<input type="hidden" name="crres_id" value="" id="hiddencrres_idupdatereplyformcheck"></input> 
									<input class="whichPagepasser" type="hidden" name="whichPage" value=""></input> 
									<button type="submit" class="btn btn-primary confirmbtn">Confirm</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</FORM>
			
			<!--replydeletecheckform-->
			
			<script>
			
			 $(document).ready(function() {
			        $(".cancel").click(function() {
			           
			             $(location).attr('href', '<%=request.getContextPath()%>/front_end/course/courboar/page/maincourboar.jsp?localhref=localhref');

			                
			                 });
			      });
				
			</script>
			
			<!--if list null-->
			<c:if test="${empty list}">
	         <div class="col-12 col-md-6 offset-md-1 mt-5 text-secondary">
	          <h4><i class="fas fa-exclamation-triangle"></i>&nbsp;&nbsp;NO Relevant Data
	         </h4></div>
	        </c:if>
            <!--if list null-->
            <!--for confirmbtn-->
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
	       
           
			<!--courboarlist-->
			<div class="col-12 col-sm-12 mt-5 "  >
				<div class="col-12 col-sm-10 offset-md-1">
					<div class="accordion" id="accordionExample">
					<div class="pagenav mt-3 text-left mb-4"  >					
	        <!-- =========================================pagefile========================================== -->
	                                           <%@ include file="page1.file" %>
	        <!-- =========================================pagefile========================================== -->
	                </div>
						<%List<CourBoarVO> courboarlist= (List<CourBoarVO>)pageContext.getAttribute("list"); 
						CourBoarVO courboarVO=null;
						%>
                        
						<% 	int maxIndex=pageIndex+rowsPerPage;
						  if (maxIndex>rowNumber){
							  maxIndex=rowNumber;
						  }
						  for(int i=pageIndex; i<maxIndex; i++) {
							
						    

			                 String datatarget="#collapse"+ i ;
			                 String id="collapse"+i ;
			                 String idj="#collapse"+i ;
			                 String updateClass=".updatelink"+i;
			                 String update="updatelink"+i;
			                 String hideClass=".hide"+i;
			                 String hide="hide"+i;
			                 String editsectionClass=".editsection"+i;
			                 String editsection="editsection"+i;
			                 
			                 String replybtnClass=".replybtn"+i;
			                 String replybtn="replybtn"+i;
			                 
			                 courboarVO = courboarlist.get(i); 
			            %>
                       <!--CRPOSTformem-->
                        <%
                            MemService crmemSvc = new MemService();
						    MemVO crmenVO = crmemSvc.getOneMem(courboarVO.getMem_id());
						    pageContext.setAttribute("crmenVO",crmenVO);
						    
						 %>
						<!--CRPOSTformem-->
<%System.out.println("pageIndex"+pageIndex); %>
<%System.out.println(pageIndex+rowsPerPage-1); %>

						<div class="card">

							<div class="card-header " id="headingOne">
								<button class="btn btn-link" type="button"
									data-toggle="collapse" data-target="<%=datatarget%>"
									aria-expanded="true" aria-controls="collapsev">
									<div class="row align-items-start px-1">
										<div class="col-3 col-md-1 courboarimg px-1">
											<img class="img-fluid rounded-circle" alt="Card image"
												src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=<%=courboarVO.getMem_id()%>">
										</div>
										<div class="col-md-11 commentbottomline ">
											<div class="replynametext text-left ">
												<div class="col-md-12  d-flex flex-wrap p-0">
													<div class="col-md-11 pl-0 mb-1">

														<p class="h5 text-primary courboartitleword"><%= courboarVO.getCrpos_tit()%></p>
														<span class="text-light "> <%= crmenVO.getMem_name()%>
															·<fmt:formatDate value="<%= courboarVO.getCrpos_time()%>" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;&nbsp;</span> 
														<span class="<%=update%> text-muted"><i class="far fa-edit crposticon <%=editsection%> "  style="display:none"></i>&nbsp;&nbsp;
														</span> 
														<script>
           
													      $(document).ready(function() {
													        $("<%=updateClass%>").click(function() {
													           
													             $(location).attr('href', '<%=request.getContextPath()%>/courboar/courboar.do?action=getOne&crpost_id=<%=courboarVO.getCrpost_id()%>&whichPage=<%=whichPage%>');
													             
													                 });                                                                                                                           
													      });
													    </script>
														
														<span class=" deletecbform px-0 text-muted " data-toggle="modal" data-target="#courpostdeletecheckform"> <i
															class="far fa-trash-alt crposticon <%=hide%> <%=editsection%> " style="display:none"></i>&nbsp;&nbsp;
														</span>
														
														<script>
           
													      $(document).ready(function() {
													        $("<%=hideClass%>").click(function() {
													           
													        	$("#inputhidecrpost_id").val("<%=courboarVO.getCrpost_id()%>");
													        	    var wtf=$("#inputhidecrpost_id").val();
													        	    console.log(wtf);
													                 });
													      });
													    </script>
														<% 
															BoardresService boardresSvc = new BoardresService();
															Integer replyCount=boardresSvc.getReplyCount(courboarVO.getCrpost_id());
									System.out.print(boardresSvc.getReplyCount(courboarVO.getCrpost_id()));

// 														    pageContext.setAttribute("count",count);
// 														    Integer replyCount=(Integer)pageContext.getAttribute("count");
														    
														    if(boardresSvc.getReplyCount(courboarVO.getCrpost_id())==null){
														    	replyCount=0;
														    }
									
														%>					
													</div>
													<div class="col-md-1 text-left text-center ">
														<span class="badge badge-primary badge-pill mt-3"><%=replyCount%></span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</button>
								<div class="col-md-10courboarlistinnerline pr-2"></div>
							</div>
						</div>
						
						
						<c:if test="${ memVO != null }">
						  <c:if test="<%=memVO.getMem_id().equals(courboarVO.getMem_id())%>">
						  <script>
								$(document).ready(function() {
													           
								  $("<%=editsectionClass%>").show();
														   
								});
						  </script>
						  </c:if>
				          </c:if>	
<%System.out.println("i="+i); %>
<%System.out.println(datatarget); %>
						<div id="<%=id%>" class="collapse px-3 "
							aria-labelledby="headingOne" data-parent="#accordionExample">
							<div class="card-body text-left"><%=courboarVO.getCrpos_text()%></div>

							<div class="col-12 col-md-2 mb-2 text-left">

								<button type="button" class="btn btn-outline-primary <%=replybtn%>"
									data-toggle="modal" data-target="#replyform">
									Reply</button>
							</div>
							
							<%if(memVO!=null&&purchcourSvc.getCrorder_idByCrMemId(courlistVO.getCour_id(), memVO.getMem_id())!=null){%>	
							<script>
						
								$(document).ready(function() {
								
									 $("<%=replybtnClass%>").click(function() {
											           
										$("#hiddencrpost_idreplyform").val("<%=courboarVO.getCrpost_id()%>");
													  
										});
									
									 
							        });
			               </script>
			               
			                <%}else{%>
			                <script>
			                $(document).ready(function() {
			                	 $("<%=replybtnClass%>").click(function() {
										 $('#replyform').on('show.bs.modal', function (e) {
							            	  if (!data) return e.preventDefault() 
							              });
							              alert("您尚未購買此課程");
							              
			                });
			                	 
			                });
							</script>
						    <%}%>
						
						    
							

							<div class="courboarlistinnerline">&nbsp;</div>

							<!--courboarlistcommet-->
							<%
							
						    List<BoardresVO> replylist = boardresSvc.getCrpostReply(courboarVO.getCrpost_id());
						    pageContext.setAttribute("replylist",replylist);
						   
						    
						    %>
							<%	for(int j=0; j<replylist.size(); j++) {
						    	BoardresVO boardresVO = replylist.get(j);
						    	String replyeditClass=".replyeditclass"+i+j;
							    String replyedit="replyeditclass"+i+j;
							    String replyhideClass=".replyhideclass"+i+j;
							    String replyhide="replyhideclass"+i+j;
							    String replyeditsectionClass=".replyeditsection"+i+j;
							    String replyeditsection="replyeditsection"+i+j;
			                %>
<%System.out.println("j="+j); %>
<%System.out.println(replyedit); %>
			                <!--CRREPLYformem-->
	                        <%
	                            MemService brmemSvc = new MemService();
							    MemVO brmenVO = brmemSvc.getOneMem(boardresVO.getMem_id());
							    pageContext.setAttribute("brmenVO",brmenVO);
							    
							 %>
						    <!--CRREPLYformem-->


							<div class="row align-items-start mt-2 px-3 mb-2  ">
								<div class="col-3 col-md-1 ">
									<img class="img-fluid rounded-circle" alt="Card image"
										src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=<%=boardresVO.getMem_id()%>">
								</div>
								<div class="col-md-11  pr-2 ">
									<div class="replyinreplynametext text-left  ">
										<div class="col-md-12  d-flex flex-wrap p-0">
											<div class="col-md-2 pl-0 mb-0 ">
												<p class="h6 text-primary"><%=brmenVO.getMem_name()%></p>
											</div>
										</div>
										<p class="m-0"><%=boardresVO.getCrres_text()%></p>
										<span class="text-muted mb-5 "><fmt:formatDate value="<%=boardresVO.getCrres_time()%>" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;</span>
										<span class=" text-muted mb-5 " data-toggle="modal" data-target="#updatereplyform"><i class="far fa-edit crposticon <%=replyedit%> <%=replyeditsection%> " style="display:none"></i>&nbsp;</span>
														
														
										<span class=" deletecbform px-0 text-muted " data-toggle="modal" data-target="#replydeletecheckform"> <i
															class="far fa-trash-alt crposticon <%=replyeditsection%> <%=replyhide%>" style="display:none" ></i>&nbsp;&nbsp;
														</span>
										<div class="mt-1"></div>
										<script>
											
											$(document).ready(function() {
												 $("<%=replyeditClass%>").click(function() {
													         
													$("#courboardqrtext").val("<%=boardresVO.getCrres_text()%>");
													$("#hiddencrres_idupdatereplyform").val("<%=boardresVO.getCrres_id()%>");			  
													});
										        });
										
										</script>
										<script>
											
											$(document).ready(function() {
												 $("<%=replyhideClass%>").click(function() {
													         
													$("#hiddencrres_idupdatereplyformcheck").val("<%=boardresVO.getCrres_id()%>");			  
													});
										        });
										
										</script>
										<c:if test="${memVO!=null}">
										<c:if test="<%=memVO.getMem_id().equals(boardresVO.getMem_id())%>">
										  <script>
												$(document).ready(function() {
																	           
												  $("<%=replyeditsectionClass%>").show();
																		   
												});
										  </script>
										   
								       </c:if>
								       </c:if>


								       <c:if test="<%=showCrres_id!=null %>">


								       <c:if test="<%=showCrres_id.equals(boardresVO.getCrres_id())%>">

										  <script>
												$(document).ready(function() {
																	           
													$('<%=idj%>').addClass('show');
																		   
												});
										 </script>

						  
				          			</c:if>	
				          			</c:if>	
				          			
									</div>
								</div>
							</div>
<%System.out.println("id="+id);
  System.out.println("boardresVO.getCrres_id()="+boardresVO.getCrres_id());
  System.out.println("showCrres_id"+showCrres_id+"!!!");
%>
							<!--courboarlistcommet-->
                         <%}%>
						</div>
                   
						
						<%}%>
					 <!-- =========================================pagefile========================================== -->
	                                           <%@ include file="page2search.file" %>
	                 <!-- =========================================pagefile========================================== -->	 
					 
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

	<script>
	           
	$(document).ready(function() {
													           
		$(".brows_cour_id").val("<%=courlistVO.getCour_id()%>");
	   
	});
	</script>
	
	<script><!-- for localhref-->
           
		$(document).ready(function() {
			 $(".confirmbtn").click(function() {
													           
				$(".whichPagepasser").val("<%=whichPage%>");
													  
				});
		});
	</script>
	

	<!--courboar-->
		<!-- Sponsor logos -->
		<div class="py-5 mt-5 section" >
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h1 class="mb-4">Sponsors</h1>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2 col-6"></div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/courboar/assets/conference/logo_1.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/courboar/assets/conference/logo_4.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/courboar/assets/conference/logo_3.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/course/courboar/assets/conference/logo_2.png">
					</div>
				</div>
			</div>
		</div>
		
	
		<!-- Call to action -->
		<div class="py-5 mt-3 section section-fade-in-out" id="register"
			style="background-image: url('<%=request.getContextPath()%>/front_end/course/courboar/assets/conference/cover_2.jpg');">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-left">
						<h1 class="mb-3">Something Here</h1>
						<p>
							Pre-register to get a priority access to the event. Fares will be
							published later on.&nbsp; <br>Get the maximum from the
							lectures together with the possibility of joining exclusive
							side-events.
						</p>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Footer -->
		<footer class="text-md-left text-center p-4">
			<div class="container">
				<div class="row">
					<div class="col-lg-12"></div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<p class="text-muted">
							<br> <br> <br>
						</p>
					</div>
				</div>
			</div>
		</footer>
		<!-- JavaScript dependencies -->
		
		
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
			integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
			crossorigin="anonymous"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
			crossorigin="anonymous"
			integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"></script>
		<!-- Script: Smooth scrolling between anchors in a same page -->
		<script
			src="<%=request.getContextPath()%>/js/smooth-scroll.js"></script>


</body>

</html>



