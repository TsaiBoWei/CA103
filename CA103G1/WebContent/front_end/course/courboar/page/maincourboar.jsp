<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.boardres.model.*"%>
<%@ page import="com.courboar.model.*"%>
<%@ page import="com.mem.model.*"%>

<% 
    session.setAttribute("mem_id", "M000002");
    session.setAttribute("brows_cour_id", "COUR000001");
    
    
    request.setCharacterEncoding("utf-8");
    String cour_id = (String)request.getSession().getAttribute("brows_cour_id");
    String mem_id = (String)request.getSession().getAttribute("mem_id");
    CourBoarService courboarSvc = new CourBoarService();
    List<CourBoarVO> list = courboarSvc.findByCour_id(cour_id);
    pageContext.setAttribute("list",list);
%>



<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>Jennifer Lawernce</title>

<!-- CSS dependencies -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/courboar/css/PersonalPage.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/courboar/css/calender.css">
<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="<%=request.getContextPath()%>js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<!-- summernote -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
	integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
	integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
	crossorigin="anonymous"></script>
<!-- summernote -->
<script
	src="<%=request.getContextPath()%>/front_end/course/courboar/js/jquery.events.touch.js"></script>
<script
	src="<%=request.getContextPath()%>/front_end/course/courboar/js/autotyping.js"></script>
<script
	src="<%=request.getContextPath()%>/front_end/course/courboar/js/truncateoverride.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/courboar/css/buttonfix.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/courboar/css/editpostform.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/courboar/css/courboar.css">
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
</style>
<script>
//     $('#myModal').on('shown.bs.modal', function () {
//     $('#myInput').trigger('focus')
//   })



  </script>
 

</head>

<body class="text-center">
	<!-- Navbar -->
	<nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
		<span class="navbar-text"></span>
		<div class="container">
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbar2SupportedContent"
				aria-controls="navbar2SupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-center"
				id="navbar2SupportedContent">
				<a
					class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg"
					href="#">WORK it OUT</a>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-2 btn-lg"><a class="nav-link" href="#">activity</a>
					</li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link"
						href="#speakers">Course</a></li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link"
						href="#schedule">User</a></li>
				</ul>
				<a class="btn btn-lg btn-primary" href="#register">Register now</a>
			</div>
		</div>
	</nav>
	<!-- Cover -->
	<div class="d-flex align-items-center cover section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/course/courboar/assets/conference/jogback.jpg&quot;);">
	</div>
	<!-- Personal Pic -->
	<div class="row mb-5 personalarea">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="<%=request.getContextPath()%>/front_end/course/courboar/assets/styleguide/people_2.jpg">
			</div>
		</div>
		<div class="col-md-4 align-self-end ml-1">
			<h1 class="text-left text-primary">Jennifer Lawrence</h1>
			<p class="text-left">Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.</p>
		</div>
		<!-- Personal Pic -->
		<!--<div class="col-md-4  py-10"></div>-->
	</div>
	<!-- NavBar Personal-->
	<div class="container containerHrT ">
		<hr>
	</div>
	<nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0"
		id="profile-navbar">
		<div class="container">
			<div
				class="collapse navbar-collapse text-right justify-content-center marignBun"
				id="navbar3SupportedContent">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;
					</a></li>
					<!-- Workoutplan-->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" href="#"
						id="navbarDropdownMenuLink"> <i class="fa fa-calculator"></i>
							&nbsp; WorkOutPlan &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light dropdown-item-custom"
								href="#">My Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Plan</a>
						</div></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown"
						id="navbarDropdownMenuLink"> <i class="fa fa-film"
							aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom ">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">MyCourse</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Course</a>
						</div></li>
					<li class="nav-item dropdown"><a class="nav-link" href="#">
							<i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>&nbsp;&nbsp;Post&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>
							&nbsp;MyCalender&nbsp;
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container containerHrB ">
		<hr>
	</div>
	<!-- Plan List-->
	<div class=" m-5">
		<div class="row">
			<div class="container">
				<div class="row">
					<div class="col-md-6 my-3">
						<div class="jzdbox1 jzdbasf jzdcal ">
							<div class="jzdcalt">
								<ul class="monyeartitle">
									<li class="prev"><i class="fas fa-angle-left"></i></li>
									<li class="montitle">JUNE</li>
									<sapn class="yeartitle">2018</sapn>
									<li class="nxt"><i class="fas fa-angle-right"></i></li>
								</ul>
							</div>
							<span>Su</span> <span>Mo</span> <span>Tu</span> <span>We</span> <span>Th</span>
							<span>Fr</span> <span>Sa</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> </span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span>1</span> <span class="circle"
								data-title="My 25th birthday!">2</span> <span>3</span> <span>4</span>
							<span>5</span> <span>6</span> <span>7</span> <span>8</span> <span>9</span>
							<span>10</span> <span>11</span> <span class="circle"
								data-title="2 month anniversary!">12</span> <span>13</span> <span>14</span>
							<span>15</span> <span>16</span> <span>17</span> <span>18</span> <span>19</span>
							<span>20</span> <span class="circle"
								data-title="#MusicMonday - share your favorite song!">21</span>
							<span class="circle"
								data-title="#MusicMonday - share your favorite song!">22</span>
							<span>23</span> <span>24</span> <span>25</span> <span>26</span> <span>27</span>
							<span>28</span> <span>29</span> <span class="circle"
								data-title="#MusicMonday - share your favorite song!">30</span>
							<span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span> <span class="jzdb"> <!--BLANK-->
							</span>
						</div>
					</div>
					<div class=" col-md-6 p-3">
						<div class="row justify-content-end">
							<div class="card col-12 card-custom">
								<div class="card-header card-header-custom text-left text-light">Aug
									11 , 2018</div>
								<div class="card-body card-body-custom">
									<h4 class="text-primary text-left">Plan Today</h4>
									<h6 class="text-muted  text-left">Subtitle</h6>
									<p class="text-left text-white">Some quick example text to
										build on the card title.</p>
								</div>
							</div>
							<div class="col-sm-12 my-3">
								<div class="card workoutnotecard">
									<div class="card-body workoutnotecardbody ">
										<div class="my-2 ">
											<h4 class="text-left">Hi,&nbsp;&nbsp;Jennifer</h4>
											<h4>
												Do You <span class="txt-rotate" data-period="1800"
													data-rotate="[ &quot;Work Out Today ?&quot; ]"></span>
											</h4>
										</div>
										<div class="mt-3 text-right">
											<a href="#posteditlight"
												class="btn btn-primary btnworkoutnote "
												data-rel="lightcase:myCollection:slideshow"> <i
												class="fa fa-edit"></i>Make Post
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--list-->
	<!--Courboar title-->
	<div class="py-4">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h2 class="text-left">Course Board</h2>
					<hr>
				</div>
			</div>
		</div>
	</div>
	<!--fixbutton-->
	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing"
		href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="far fa-calendar-plus"></i>
	</a>
	<!--fixbutton-->
	

	
	<!--courboar-->
	<div class="container mb-3">
		<div class="row align-items-start ">
			<!--searchbar-->
			<div class=" col-md-9 mb-0 px-5">
				<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/front_end/course/courboar/page/searchcourboar.jsp"
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
							<button type="submit" class="btn btn-primary border-primary border text-dark">
								<i class="fa fa-search text-white"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
			<div class=" col-12 col-md-3 mb-0 px-3">
				<button type="button" class="btn btn-outline-primary"
					data-toggle="modal" data-target="#courboarform">Add Your Comment</button><!-- 										///	 -->
			</div>

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
									<button type="submit" class="btn btn-primary">Save
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
										<button type="submit" class="btn btn-primary" >Save
											Changes</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</FORM>
		     <script>
	    		 $("#updateform").modal({show: true});
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
									<input type="hidden" name="action" value="insert"></input>
									<button type="submit" class="btn btn-primary">Save
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
	    		 $("#replyform").modal({show: true});
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
									<input type="hidden" name="action" value="update"></input>
									<button type="submit" class="btn btn-primary">Save
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
									<button type="submit" class="btn btn-primary">Confirm</button>
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
									<button type="submit" class="btn btn-primary">Confirm</button>
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
			           
			             $(location).attr('href', '<%=request.getContextPath()%>/front_end/course/courboar/page/maincourboar.jsp#jys');

			                
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
           <c:if test="${localhref!=null}">
			<script>
	    		 location.href="#jys";
	        </script>
	        </c:if>
           
			<!--courboarlist-->
			<div class="col-12 col-sm-12 mt-5 " id="jys" >
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
												src="<%=request.getContextPath()%>/courboar/CourBoar_DBGifReader4.do?mem_id=<%=courboarVO.getMem_id()%>">
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
													           
													             $(location).attr('href', '<%=request.getContextPath()%>/courboar/courboar.do?action=getOne&crpost_id=<%=courboarVO.getCrpost_id()%>');
													                
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
																			
													</div>
													<div class="col-md-1 text-left text-center ">
														<span class="badge badge-primary badge-pill mt-3">14</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</button>
								<div class="col-md-10courboarlistinnerline pr-2"></div>
							</div>
						</div>
						
						  <c:if test="<%=mem_id.equals(courboarVO.getMem_id())%>">
						  <script>
								$(document).ready(function() {
													           
								  $("<%=editsectionClass%>").show();
														   
								});
						  </script>
						  
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
							
							<script>
           
								$(document).ready(function() {
									 $("<%=replybtnClass%>").click(function() {
													           
										$("#hiddencrpost_idreplyform").val("<%=courboarVO.getCrpost_id()%>");
													  
										});
							        });
			               </script>
							
							
							

							<div class="courboarlistinnerline">&nbsp;</div>

							<!--courboarlistcommet-->
							<%
							BoardresService boardresSvc = new BoardresService();
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
										src="<%=request.getContextPath()%>/courboar/CourBoar_DBGifReader4.do?mem_id=<%=boardresVO.getMem_id()%>">
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
										
										 <c:if test="<%=mem_id.equals(boardresVO.getMem_id())%>">
										  <script>
												$(document).ready(function() {
																	           
												  $("<%=replyeditsectionClass%>").show();
																		   
												});
										  </script>
										   
								          </c:if>	
									</div>
								</div>
							</div>

							<!--courboarlistcommet-->
                         <%}%>
						</div>
                   
						
						<%}%>
					 <!-- =========================================pagefile========================================== -->
	                                           <%@ include file="page2.file" %>
	                 <!-- =========================================pagefile========================================== -->	 
					 
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

	<script>
	           
	$(document).ready(function() {
													           
		$(".brows_cour_id").val("<%=cour_id%>");
	   
	});
	</script>
	

	<!--courboar-->
		<!-- Sponsor logos -->
		<div class="py-5 section" >
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
		<div class="py-5 section section-fade-in-out" id="register"
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
		
		<!--  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>-->
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




