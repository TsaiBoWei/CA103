<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.purchcour.model.*"%>



<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>coach</title>

<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/course/coach/css/coachmanage.css">
<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>






<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
	
<link   rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/course/coach/datetimepicker/jquery.datetimepicker.css" />

	
<style>
 

/*頁面設定*/
body {
	overflow-x: hidden;
}

h1 {
      font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }


/*   .form-group-100{ */
/*         width:100%; */
/*     } */

/*     .modal-dialog. modal-dialog-700{ */
/*        max-width: 500px;  */
/*     } */

/*     .popModel-close-bt{ */
/*         position: absolute; */
/*         right: 0; */
/*         height: 50px; */
/*         width: 50px; */
/*     } */
</style>


</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                               <jsp:include page="coachhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

<!-- title-->
  <div class="py-4">
    <div class="container">
      <div class="row">
        <div class="col-12" >
          <h2 class="text-left">Course Management</h2>
          <hr>
        </div>
      </div>
    </div>
  </div>
<!-- title-->
<%
  CoachVO coachVO=(CoachVO)request.getAttribute("coachVO");
  CourlistService courlistSvc=new CourlistService();
  List<CourlistVO> pielist=courlistSvc.getCourlistByCoa_id(coachVO.getCoa_id());
  request.setCharacterEncoding("utf-8");
%>

<!--piechart--><!--piechart--><!--piechart-->
  <div class="container">
    <div class="row">
      <div class="col-md-4 justify-content-center ">
        <h4 class="mt-3"><i class="far fa-money-bill-alt"></i>&nbsp;&nbsp;<font class="text-primary">Total Income</font>
        </h4>
        <div class="col-4 px-1 offset-md-4 incomeline">
          <i class="fas fa-caret-down"></i>
        </div>
        <div class="incomebg mt-2">
          <span class="badge badge-info badge-pill mt-1 coachmp " >
            <font style="font-size:25px" id="totalincome"></font>
          </span>
        </div>
      </div>
      <div class="col-md-8 analyze">
     
<!--         <div class="pieID pie"> -->
<!--         </div> -->
<!--         <ul class="pieID legend"> -->
        <div id="donutchart" style="width:900px; height: 500px; opacity:0.9;"></div>
        
        
           
         
<!--           <li> -->
<%--             <em><%=courlistpieVO.getCname()%>:$</em> --%>
<%--             <span><%=courlistpieVO.getCour_cost()%></span> --%>
<!--           </li> -->
           
<%--           <%}%> --%>
<!--         </ul> -->
        <section>
          <p class="h5 text-light"><i class="fas fa-chart-pie"></i>&nbsp;Income Analysis</p>
        </section>
      </div>
    </div>
  </div>
   <script type="text/javascript">
		      google.charts.load("current", {packages:["corechart"]});
		      google.charts.setOnLoadCallback(drawChart);
		      function drawChart() {
		        var data = google.visualization.arrayToDataTable([
		        	 ['Task', 'Hours per Day'],
		        	<%PurchcourService purchcourSvc = new PurchcourService();
		            Integer totalincome=0;
		            
		            for(int i=0;i<pielist.size();i++){ 
		            	CourlistVO courlistpieVO=pielist.get(i);
		            	
		            	Integer purchcourcount= purchcourSvc.getCourCountNotRefund(courlistpieVO.getCour_id());
		            	Integer cour_cost=courlistpieVO.getCour_cost();
		                Integer incomeprecour=purchcourcount*cour_cost;
		                totalincome+=incomeprecour;

		            %>
		            
		          ['<%=courlistpieVO.getCname()%>',   <%=incomeprecour%>],
		          <%}%>
		        ]);
		        
		        
		
		        var options = {

                       
		        backgroundColor:{ 
                        'fill': '#1f1f1f', 
                        } ,
                  
// 		          title: 'My Daily Activities',
		          pieHole: 0.4,
		          slices: {
		              0: { color: 'cornflowerblue' },
		              1: { color: 'olivedrab' },
		              2: { color: 'orange' },
		              3: { color: 'tomato' },
		              4: { color: 'crimson' },
		              5: { color: 'purple' },
		              6: { color: 'turquoise'},
		              7: { color: 'navy'},
		              8: { color: 'forestgreen'},
		              
		             
		            },
                legend: { textStyle: { color: '#efefef', fontSize: 14 ,fontName:"微軟正黑體",} },    
              
               
		        };
		
		        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
		        chart.draw(data, options);
		      }
    		</script>
        
 <!--piechart--><!--piechart--><!--piechart-->
   <div class="container" id="jys">
    <div class="row">
        <div class="col-md-10 offset-md-1">
		 <ul class="nav nav-tabs nav-tabs-courlist " >
		            <li class="nav-item text-light" >
		              <a href="#home" class="nav-link active nav-link-title " data-toggle="tab" aria-controls="home" aria-selected="true" id="home-tab" role="tab" data-target="white">Your Course List</a>
		            </li>
		            
		          </ul>
		 </div>
		  <div class="col-md-10 offset-md-1 mt-3">
			<a href="<%=request.getContextPath()%>/front_end/course/courlist/addCourlist.jsp"> <span data-target="#unitaddampleModal" data-toggle="modal"  style="cursor:pointer; ">
	                  <p class="h5 text-right hovereditunit" id="uploadalesson" > Add New Course
	                    <i class="far fa-plus-square"></i>
	                  </p>
	          </span></a>
		</div>
	</div>
	</div>
<!--singleclass-->
    <div class="container mt-3 mb-5">
    <div class="row align-items-start ">
      <!--courselist-->

      <div class="col-12 col-sm-12 mt-4 " id="jys">
        <div class="col-12 col-sm-10 offset-md-1 ">
          <div class="accordion" id="accordionExample">
          <%
      for(int i=0;i<pielist.size();i++){ 
    	  CourlistVO owncourlistVO=pielist.get(i);
    	  Integer refundcourcount= purchcourSvc.getCourCountRefund(owncourlistVO.getCour_id());
      	  Integer purchcourcount= purchcourSvc.getCourCountNotRefund(owncourlistVO.getCour_id());
	      String datatarget="#collapse"+ i ;
	      String id="collapse"+i ;
	      String broadcastbtn="broadcastbtn"+i;
	      String broadcastbtnid="#broadcastbtn"+i;


      %>
            <div class="card">
              <div class="card-header " id="headingOne" >
                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="<%=datatarget%>" aria-expanded="true" aria-controls="collapsev">
                  <div class="row align-items-start px-1">
                    <div class="col-3 col-md-1 courboarimg px-1 ">
                    <div class="">
                      <img class="img-fluid rounded rounded-courseimage" alt="Card image" src="<%=request.getContextPath()%>/front_end/course/purchcour/assets/conference/coursean.jpg"></div> </div>
                    <div class="col-md-11 commentbottomline px-0">
                      <div class="replynametext text-left ">
                        <div class="col-md-12  mt-2">
                          <p class="h5 text-primary courboartitleword"><%=owncourlistVO.getCname()%>&nbsp;<a href="<%=request.getContextPath()%>/courlist/courlist.do?action=getOne_For_Update&cour_id=<%=owncourlistVO.getCour_id()%>"><i class="fas fa-pencil-alt"></i></a>&nbsp;<span ><i class="fas fa-bullhorn" id="<%=broadcastbtn%>" data-toggle="modal" data-target="#broadcastform"></i></span></span></p>
                        </div>
                      <script type="text/javascript">
                      $("<%=broadcastbtnid%>").click(function () {
                    	  $("#discountcname").val("<%=owncourlistVO.getCname()%>");
                    	  $("#discountcour_id").val("<%=owncourlistVO.getCour_id()%>");
                      });
                      
                      </script>
                        
                        
                        <div class="row text-right justify-content-end pb-2 px-2">
                          <div class="col-md-2 text-left text-right text-light px-1 mr-1 ml-2 ">
                            <div>&nbsp;Refund&nbsp;<span class="badge badge-secondary badge-pill mt-1 badge-pill-coachm"><%=refundcourcount %></span></div>
                          </div>
                          <div class="col-md-2 text-left text-right text-light px-1 mr-1 ml-1">
                            <div>&nbsp;Purchase&nbsp;<span class="badge badge-info badge-pill mt-1 badge-pill-coachmi"><%=purchcourcount%></span></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </button>
                <div class="col-md-10courboarlistinnerline pr-0 py-0"></div>
              </div>
            </div>
            <div id="<%=id%>" class="collapse px-5" aria-labelledby="headingOne" data-parent="#accordionExample">
              <div class="card-body text-left"> </div>
<!--               <div class="col-12 col-md-2 mb-2 text-left"> -->
<!--               </div> -->
              <div class="text-left courboarlistinnerline pb-1 mb-2">
                <h5><i class="fas fa-users"></i>&nbsp;&nbsp; Students&nbsp;·&nbsp;List All</h5>
              </div>
              <!--course student-->
              <%
              PurchcourService purchcoursvcstu = new PurchcourService();

              List<PurchCourVO>stulist = purchcoursvcstu.getCourPurchCour(owncourlistVO.getCour_id());

              for(int j=0; j<stulist.size();j++){
            	  PurchCourVO purchCourVOstu=stulist.get(j);
            	  MemService stumemSvc= new MemService();
            	  MemVO stumemVO=stumemSvc.getOneMem(purchCourVOstu.getMem_id());
            	
              
              %>
              
              <div class="row align-items-start pt-2 px-1 mt-2 mb-2">
                <div class="col-3 col-md-1 px-3 ">
                  <img class="img-fluid rounded-circle" alt="Card image" src="<%=request.getContextPath()%>/front_end/assets/styleguide/people_2.jpg"> </div>
                <div class="col-md-11  pr-2 ">
                  <div class="replyinreplynametext text-left">
                    <div class="row">
                      <div class="col-md-10 pb-2 mb-0 ">
                        <p class="h6"><%=stumemVO.getMem_name()%></p>
                      </div>
                      <div class="col-md-2 pl-0 mb-0 text-left">
                       <%if ("CO2".equals(purchCourVOstu.getRefund())){%>
                       
                         <FORM METHOD="POST" ACTION="<%=request.getContextPath()%>/coach/coach.do" name="checkform">
                         <input type="hidden" class="" name="action" value="refundconfirm"></input>
                         <input type="hidden" class="" id="" name="crorder_id" value="<%=purchCourVOstu.getCrorder_id()%>" ></input>
                         <font class="text-secondary"><i class="fas fa-hand-holding-usd " ></i>Refund</font>
                         <br>
                         
                          <button type="submit" class="btn btn-outline-secondary btn-sm py-1 mb-2 mt-1"> Confirm</button>
                          </FORM>
                       <%}else{%> 

                         <p class="h6 text-primary" style="cursor:pointer;">
                          <i class="far fa-money-bill-alt"></i>&nbsp;Purchased</p>
                       <%}%>
                       
                       
                      </div>
                    </div>
                  </div>
                </div>
                    <!--course student-->
              </div>

              <%}%>
              <!--course student-->
            </div>
            
      <%}%>
      
      
          </div>
          
      <script>
      $(document).ready(function(){   
    	  $("#totalincome").html("$<%=totalincome%>");
      });
      
      </script>
          <!--singleclass-->
           
<%--       <%}%> --%>
    <!--singleclass-->
        </div>
       </div>
      </div>
     </div>        <!--singleclass-->
     
     
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

<!--broacastform-->
			
			<div class="col-md-12 text-center">
					<div class="modal fade mx-auto" aria-hidden="true"
						aria-labelledby="exampleModalLabel" id="broadcastform"
						role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog " role="document">
							<div class="modal-content dicountform">
								<div class="modal-header courboarmodalheader">
									<h5 class="modal-title text-secondary" id="exampleModalCenterTitle">Broadcast</h5>
									<button type="button" class="close cancel" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
								</div>
								<div class="modal-body text-left">
									<div class="form-group text-white">
										<label>Discount</label>
										<div class="col-12 px-0 text-white">
											<input type="text" name="" id="discount"
												class="form-control courboarformtitle text-white">
										</div>
										
										<div class="form-row mt-2">
											<div class="col px-1">
											<label>Expiry Date</label>
												<input class="form-control courboarformtitle text-light" type="" name="relased" id="f_date1">
											</div>
											
										</div>
										
											<input type="hidden" class="" id="discountcour_id" value="" ></input>
											<input type="hidden" class="" id="discountcname" value="" ></input>

									</div>
								</div>
								<div class="modal-footer courboarmodal">
									<button type="button" class="btn btn-secondary cancel"
										data-dismiss="modal">Cancel</button>
								 
									<button type="button" id="broacastbtn" data-dismiss="modal" class="btn btn-primary confirmbtn">Confirm</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			
<!--broacastform-->

<script>
	$(document).ready(function(){   
		connect();
	
	});
</script>

<script>
     
    var MyPoint = "/MyEchoServer";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var discountcour_id;
	var discountcname;
	var discount = document.getElementById("discount");
	var expiredate = document.getElementById("f_date1");
	var wholeworld;
	var finaldiscount;
	var expiredateval;
    

	var webSocket;
	
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			
			console.log("WebSocket 成功連線");

		};

		webSocket.onmessage = function(event) {
            alert(event.data);
		};

	}
	
	
// 	var discount = document.getElementById("discount");
// 	var expiredate = document.getElementById("f_date1");
// 	var wholeworld;
// 	var finaldiscount;
// 	var expiredateval;
	
	console.log(expiredate);

// 	inputUserName.focus();
	   
	function sendMessage() {
	    finaldiscount = discount.value.trim();
	    expiredateval = expiredate.value;
console.log(expiredateval);
	    wholeworld= new Date(expiredateval).getTime()-new Date().getTime();
console.log(wholeworld);
	        var jsonObj = {"finaldiscount" : finaldiscount,
	        		"discountcour_id":discountcour_id,
	        		"discountcname":discountcname}
	        webSocket.send(JSON.stringify(jsonObj));
	        };
// 	        webSocket.send(JSON.stringify(jsonObj));
// 	        webSocket.send("finaldiscount折");
	
	

	
// 	var discountcour_id;
// 	var discountcname;
	$(document).ready(function(){ 
		$("#broacastbtn").click(function () {
			discountcour_id = $("#discountcour_id").val();
			discountcname = $("#discountcname").val();
			sendMessage();
			
			
			 $.ajax({
		        url:'<%=request.getContextPath()%>/coach/DiscountSave.do',
		        method:'POST',
		       
		        data:{
		           finaldiscount:finaldiscount,
		           discountcour_id:discountcour_id,
		           expiredateval:expiredateval,
		           wholeworld:wholeworld
		        	
		           
		        },

		     });
			
		});
		});	

    
</script>

<!--datepicker-->



<script>
$(document).ready(function(){ 
// 		$.datetimepicker.setLocale('zh');
		$('#f_date1').datetimepicker({
		theme: 'dark',              //theme: 'dark',
		timepicker:false,       //timepicker:true,
		step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
		format:'Y-m-d',         //format:'Y-m-d H:i:s',

		value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:             '2017/07/10',  // 起始日
		//minDate:               '-1970-01-01', // 去除今日(不含)之前
		//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
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






	       


<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script src="<%=request.getContextPath()%>/front_end/course/coach/js/coachmanage.js"></script>
<script src="<%=request.getContextPath()%>/front_end/course/coach/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front_end/course/coach/datetimepicker/jquery.datetimepicker.full.js"></script>
<div class="row my-5"></div>
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	              <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	



