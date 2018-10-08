<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="" ></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- CSS  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!--  self-defined css  -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  
  <!-- JS  -->
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>
 
  <title>會員修改</title>

    <style type="text/css">
    body {
      font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei";
      font-weight: bold;
      
    }

    h1,h2,h3,h4,h5,h6 {
        font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei";
        color: #efefef;
      }

    .form-group label{
      font-size: 20px;
    }

    .form-check-input,.form-check{
       font-size: 20px;
    }
    #addEveBtn{
       font-weight: bold;
    }
    
    #upload_pic1{
    	width:100%;
    }
    
    .errorMsg{
    	color:red;
    
    }
    
    input{
      font-size:18px;
      color:black;
      font-weight:bold;
    }
    
    

  </style>

</head>

<body>
<!-- Navbar -->
  <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="#">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
          <li class="nav-item mx-2 btn-lg dropdown" id="navUserBtn">
            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">User&nbsp;
              <i class="fa fa-caret-down dropbtn"></i>
            </a>
            <div class="dropdown-content" id="myDropdown">
              <a href="#">
                <i class="fa fa-file">&nbsp;&nbsp;個人頁面</i>
              </a>
              <a href="#">
                <i class="fa fa-calculator">&nbsp;&nbsp;計畫</i>
              </a>
              <a href="#">
                <i class="fa fa-users" aria-hidden="true">&nbsp;&nbsp;好友</i>
              </a>
              <a href="#">
                <i class="fa fa-film" aria-hidden="true">&nbsp;&nbsp;課程</i>
              </a>
              <a href="#">
                <i class="fa fa-hand-spock-o" aria-hidden="true">&nbsp;&nbsp;活動</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;貼文</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;行事曆</i>
              </a>
              <a href="#">登出</a>
            </div>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#" id="registerBtn">Register now</a>
      </div>
    </div>
  </nav>
<!-- Cover -->
	<div class="container" style="padding-top: 65px;">
		<div class="col-sm-12 formContent center text-light">
			<form action="<%=request.getContextPath()%>/mem/mem.do"
				method="post" enctype="multipart/form-data">
				<div class="form-group">
					<h4 class="mt-3 text-light" align="center">修改資料</h4>
				</div>
				<div class="form-group ">
					<div>
						<img src="<%=request.getContextPath() %>/mem/MemberDBPicReader?memID=${memVO.mem_id }" class="preview" style="max-width: 150px; max-height: 150px;">
						<div class="size"></div>
					</div>
					<label style="font-size: 150%">上傳圖片 : </label> <input type="file" class="upl"
						name="memPhoto" >
				</div>
				<div class="form-group">
					<label style="font-size: 150%">會員暱稱 :</label> <input type="text" name="memName"
						class="form-control" value=${memVO.mem_name }>
				</div>
				<div class="form-group">
					<label style="font-size: 150%">會員生日 :</label> <input type="date" name="memBirth"
						class="form-control" value="${memVO.mem_birth }">
				</div>
				<div class="form-group">
					<label style="font-size: 150%">會員信箱 :</label> <input type="email" name="memEmail"
						class="form-control">
				</div>
				<div class="form-group" style="padding-top: 10px;">
					<fieldset >
						<legend>運動喜好 :</legend>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000001" value="SP000001">田徑</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000002" value="SP000002">單車</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000003" value="SP000003">球類</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000004" value="SP000004">重訓</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000005" value="SP000005">有氧</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000006" value="SP000006">武術</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000007" value="SP000007">水上</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000008" value="SP000008">其他</label>
					</fieldset>
				</div>
				<div class="form-group">
					<label style="font-size: 150%">個人簡介 :</label>
					<textarea class="form-control" name="memIntro" placeholder=""
						style="height: 300px"></textarea>
				</div>

				<div class="form-group">
					<input type="hidden" name="action" value="mem_update">
					<!-- 進入servlet -->
					<button type="submit" class="btn btn-lg btn-primary" id="regSend">送出</button>
					<a class="btn btn-lg btn-secondary" href="../login/TestView.jsp">取消</a>
				</div>
			</form>
		</div>
	</div>

<!-- JavaScript dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- Script: Smooth scrolling between anchors in a same page -->
<script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>

	<script>
		$(function() {

			function format_float(num, pos) {
				var size = Math.pow(10, pos);
				return Math.round(num * size) / size;
			}
			
			function preview(input) {

				if (input.files && input.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						$('.preview').attr('src', e.target.result);
						var KB = format_float(e.total / 1024, 2);
						$('.size').text("檔案大小：" + KB + " KB");
					}

					reader.readAsDataURL(input.files[0]);
				}
			}

			$("body").on("change", ".upl", function() {
				preview(this);
			})

		});
		
	</script>

</body>
</html>