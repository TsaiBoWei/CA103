<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>


<%
CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>


<!DOCTYPE html>
<html>
<head>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  
 
  
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>TRY</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="css/Course.css">
  <link rel="stylesheet" href="css/font.css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="js/animate-in.js"></script>
  <!-- lightcase settings -->
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
   
  <!-- include summernote css/js -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
  
  
     
  <style>
    /*�����]�w*/

    body {
      overflow-x: hidden;
    }
  </style>
</head>

<body class="text-center">
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
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(&quot;assets/conference/024.jpg&quot;);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-md-left text-center align-self-center my-5" style="height:13rem;"> </div>
      </div>
    </div>
  </div>
    <!-- �D����(�Ϥ�) -->
  <div class="py-5 text-white">
    <div class="container">
      <div class="row">
        <div class="col-md-7 text-md-left text-center align-self-center my-5">
          <h3>�ɩ|��� ���߫�ЪŤ����ɱЫ�
            <br> </h3>
          <div class="text-md-right">
            <a href="#" class="btn btn-outline-primary btn-sm m-1">Share
              <br> </a>
            <a href="#" class="btn btn-sm btn-outline-secondary m-1">Report
              <br> </a>
          </div>
          <p class="">�n�b�Ť��@��I�O�@����o���Ũ�ꤣ�e���A���O�o�O�Ť����ɩM�@����ɳ̤��P���a��A�q�@�}�l���A�������x�A���C�Ӱʧ@�٦׳��|Ÿ�ݡA���ӲߺD��ש�i�H�M�`�b�վ㫺�աA�ݵ���l�̪��ۤv�A�ש�i�H�����a�Q�������ʧ@�A�۷����N�P�I����@�w�n�A�ӬD�ԥ������٦סA���ۤv�b�Ť��a�Q�|��ۦb�B��ξA�I</p>
          <a href="#" class="btn btn-lg btn-primary mx-1">Buy It</a>
        </div>
        <div class="col-md-5">
          <img class="img-fluid d-block mx-auto" src="assets/conference/course_A_01_S.png"> </div>
      </div>
    </div>
  </div>
    <!-- �������� -->
  <div class="container containerHrT ">
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
        <!-- �Ĥ@�ӫ��s -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabone" data-toggle="tab">
              <i class="fa fa-user"></i> &nbsp; Coach &nbsp;</a>
          </li>
          <!-- �ĤG�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabtwo" data-toggle="tab">
              <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; Announcement &nbsp;</a>
          </li>
          <!-- �ĤT�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabthree" data-toggle="tab">
              <i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; Information&nbsp;</a>
          </li>
         <!-- �ĥ|�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfour" data-toggle="tab">
              <i class="fa fa-film" aria-hidden="true"></i>&nbsp; Course &nbsp; </a>
          </li>
          <!-- �Ĥ��ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfive" data-toggle="tab">
              <i class="fa fa-comments" aria-hidden="true"></i> &nbsp; Forum &nbsp; </a>
          </li>
          <!-- �Ĥ��ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabsix" data-toggle="tab">
              <i class="fa fa-star" aria-hidden="true"></i> &nbsp; Review &nbsp; </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container containerHrB ">
    <hr> </div>
    <!-- ���� -->
   <div class="tab-content mt-2">
    <div class="tab-pane fade show active" id="tabone" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row mb-5">
            <div class="col-md-7">
              <h2 class="text-primary text-md-left"> <i class="fa fa-user"></i> &nbsp; ���߫�  &nbsp;  <br> </h2>
              
              <p class="text-md-left">�n�b�Ť��@��I�O�@����o���Ũ�ꤣ�e���A���O�o�O�Ť����ɩM�@����ɳ̤��P���a��A�q�@�}�l���A�������x�A���C�Ӱʧ@�٦׳��|Ÿ�ݡA���ӲߺD��ש�i�H�M�`�b�վ㫺�աA�ݵ���l�̪��ۤv�A�ש�i�H�����a�Q�������ʧ@�A�۷����N�P�I����@�w�n�A�ӬD�ԥ������٦סA���ۤv�b�Ť��a�Q�|��ۦb�B��ξA�I
                <br>
                <br>�\�h�H�����D�W�Ҥ��߫�P�W�����N�L�q�Ǩ�H�O�n�����Y�A��H�z�L�C�]�{�ѡA�]��Ĳ���h�S��B�ʧκA�����ԪQ�A�]���ѥ[�L�L�q���|�쪺�mSUPERACE�W�Ű��ԪQ-�d���]���n�C
                <br> �߷R���զU�جD�Ԫ��߫�A�o���A���D�ԤT�Ѩ�] 111 �����mSUPERACE�W�Ű��ԪQ-���X���n�A�D�ԥή{�B���覡�ۦ�I�t����B�����B��ϫ~�ΦU���˳ơA���F�n�J�A���t���~�A�]�o�J�A�Y�m�B���šB���F�B���߷Ůt�j���F�z��ԡC </p>
              <div class="accordion" id="coach_update">
   				  <div class="text-md-right" id="coach_update_hide">
       				 <button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
       				 data-target="#coach_update_text" aria-expanded="false" aria-controls="coach_update_text"> 
       				 <i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
        			 </button>
    			  </div>
    			  <div id="coach_update_text" class="col-md-12 collapse" aria-labelledby="coach_update_hide" data-parent="#coach_update">
     				 <div class="card-body">
        				<br>
       					<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; �ק�нm��T</h5>
         				<form class="" method="post" action="https://formspree.io/">
            				<div class="form-group">
	  							<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="5"></textarea>
	  						</div>
	  						<br>
	  						<div class="text-md-right">
            					<button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
            				</div>
				        </form>
				      </div>
				    </div>
				</div>
            </div>
            <div class="col-md-5 align-self-center">
              <img class="img-fluid d-block w-100 img-thumbnail" src="assets/conference/coach_001.jpg"> </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="tab-pane fade" id="tabtwo" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
              <h2 class="text-primary text-md-left"><i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; �ҵ{���i &nbsp;
                <br> </h2>
              <p class="text-md-left">9/28(��)�v���W�ǼȰ��@�P�C</p>
              <div class="accordion" id="announcement_update">
   				<div class="text-md-right" id="announcement_update_hide">
       				<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
       				data-target="#announcement_update_text" aria-expanded="false" aria-controls="announcement_update_text"> 
       				<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
        			</button>
    			</div>
    			<div id="announcement_update_text" class="col-md-12 collapse" aria-labelledby="announcement_update_hide" data-parent="#announcement_update">
     				<div class="card-body">
        				<br>
       					<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; �ק�ҵ{���i</h5>
         				<form class="" method="post" action="https://formspree.io/">
            				<div class="form-group">
	  							<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="5"></textarea>
	  						</div>
	  						<br>
	  						<div class="text-md-right">
            					<button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
            				</div>
				        </form>
				    </div>
				 </div>
			  </div>
            </div>
            <div class="col-md-3"></div>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabthree" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                  <h2 class="text-primary text-md-left"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; �ҵ{����  &nbsp;<br> </h2>
                  <p class="text-md-left">�Ť����ť�_�ӫܥȡA�d�F�@�d�o�{�A�Ť�����]Aerial Yoga�^�A�S�٬��ϭ��O����]Anti-gravity Yoga�^�C <br>
                  						     �D�n�Q���a���b�b�Ť��A���Y���צܤH��y����÷���Q�ɤ伵����A�ǥѻP�Q��/�Q÷�����ʡA�m�߶ǲΪ����F���ɡC�Ť����ɦ����ӯS�I�A�J����A�B�P�i��G�`���B�νw������O�B�V�m�����թʡB�����ߩ��P�C</p>
                  <img class="img-fluid d-block w-100 mb-3 rounded" src="assets/conference/course_002.jpg">
                  <p class="text-md-left">�Ť����ɬO�B���a�����h���A�ǧU�Ϧa�ߤޤO�P�����伵���骺�O�q�A���U�ڭ̦b�Ť��i����ɽm�ߡA�ϥ��ɳ������H���������ɰʧ@�ܱo�����P�A��|��`�ת��L���O�ٸs���i�C<br>
                  						   �Ť����ɦP�ɵۭ��󥭿šB�֤ߡB�X�n�סB�M�`�O�A�i���U�m�ߪ̴��ɥ����ʪ���շP�A��ı�����P������A���稭�߭��������յήi�C</p>
					<div class="accordion" id="information_update">
					   	<div class="text-md-right" id="information_update_hide">
					       	<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" data-target="#information_update_text" 
					       			aria-expanded="false" aria-controls="information_update_text"> 
					       	<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
					        </button>
					    </div>
						<div id="information_update_text" class="col-md-12 collapse" aria-labelledby="information_update_hide" data-parent="#information_update">
						    <div class="card-body">
						        <br>
						       	<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; �ק�ҵ{����</h5>
						         						       
								    <div id="summernote"></div>
								    <script>
								      $('#summernote').summernote({
								        placeholder: 'Hello stand alone ui',
								        tabsize: 2,
								        height: 100
								      });
								    </script>
    								
							</div>
						</div>
					</div>
                </div>
                <div class="col-md-1"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
     <div class="tab-pane fade" id="tabfour" role="tabpanel">
      <div class="py-5 text-white">
        <div class="container">
          <div class="row">
            <div class="col-md-7 text-md-left text-center align-self-center my-5">
              <h3 class="text-primary"><i class="fa fa-film" aria-hidden="true"></i>&nbsp; ��ߪŤ����ɱЫ� �椸�@ &nbsp;</h3>
              
<!--               <p class="">�Ť�����²��&nbsp; -->
<!--                 <br>���Ť����ɳ]�ơC&nbsp; -->
<!--                 <br>���p��i�J�P���}�����C&nbsp; -->
<!--                 <br>���i�J�ʧ@�e�A�������w�Ʀ�m�C&nbsp; -->
<!--                 <br>�m�ߴ����G �v�����ܽd�ʧ@�m�߶���ҵ{�W���M�~�Ѯv��@�ǫ��ɡC �Ť����ɤ���ĳ�w�����C�����B��Ŧ�f�B���貨�P�M�����ѻP�j���ҵ{�A�A�{�Ͳz�������קK�˱����ʧ@�m�ߡC</p> -->
			  <div class="accordion" id="courunit_update_1">
			   	<div class="text-md-right" id="courunit_update_hide_1">
			       	<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
			       			data-target="#courunit_update_text_1" aria-expanded="false" aria-controls="courunit_update_text_1"> 
			       	<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
			        </button>
			    </div>
			    <div id="courunit_update_text_1" class="col-md-12 collapse" aria-labelledby="courunit_update_hide_1" data-parent="#courunit_update_1">
			     	<div class="card-body">
			        	<br>
			       		<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; �ק�椸�W��</h5>
			         	<form class="" method="post" action="https://formspree.io/">
			            	<div class="form-group">
				  				<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="1"></textarea>
				  			</div>
				  			<br>
				  			<div class="text-md-right">
			            		<button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
			            	</div>
						</form>
					</div>
				</div>
			</div>
              <h5 class="text-md-left">�[�ݶi��</h5>
              <div class="progress">
                <div class="progress-bar progress-bar-striped bg-primary progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
              </div>
              <br>              
            </div>
            <div class="col-md-5">
              <div class="embed-responsive embed-responsive-4by3  rounded">
                <iframe class="embed-responsive-item" allowfullscreen="" src="https://www.youtube.com/embed/8GRCuzUmkpY?autoplay=0"> </iframe>
              </div>
            </div>
          </div>
          <br>
          <div class="row">
            <div class="col-md-7 text-md-left text-center align-self-center my-5" >
              <h3 class="text-primary"><i class="fa fa-film" aria-hidden="true"></i>&nbsp; ��ߪŤ����ɱЫ� �椸�G</h3>
              <div class="accordion" id="courunit_update_2">
				<div class="text-md-right" id="courunit_update_hide_2">
					<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
						    data-target="#courunit_update_text_2" aria-expanded="false" aria-controls="courunit_update_text_2"> 
					<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
					</button>
				</div>
				<div id="courunit_update_text_2" class="col-md-12 collapse" aria-labelledby="courunit_update_hide_2" data-parent="#courunit_update_2">
					<div class="card-body">
						<br>
						<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; �ק�椸�W��</h5>
						<form class="" method="post" action="https://formspree.io/">
						    <div class="form-group">
							  	<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="1"></textarea>
							</div>
							<br>
							<div class="text-md-right">
						        <button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
						    </div>
						</form>
					</div>
				</div>
			</div>
<!--               <p class="">�Ť����ɽҵ{���i�J�e�s�B�U�����B�˥߰ʧ@���ʧ@�A�������w�Ʀ�m�C -->
<!--                 <br>���p��i�J���� -->
<!--                 <br>�����}�������覡 -->
<!--                 <br>���Ť����ɤj�𮧦�����&nbsp;</p> -->
              <h5 class="text-md-left">�[�ݶi��</h5>
              <div class="progress">
                <div class="progress-bar progress-bar-striped bg-primary progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
              </div>
            </div>
            <div class="col-md-5">
              <div class="embed-responsive embed-responsive-4by3  rounded">
                <iframe class="embed-responsive-item" allowfullscreen="" src="https://www.youtube.com/embed/8GRCuzUmkpY?autoplay=0"> </iframe>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabfive" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <p class="text-md-left">�o�̩�Q�װϡC</p>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabsix" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <p class="text-md-left">�o�̩�����C</p>
          </div>
        </div>
      </div>
    </div>
  </div>
    <!-- Sponsors -->
  <div class="py-5 section">
    <div class="container">
      <div class="row">
        <div class="col-md-12"></div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
      </div>
    </div>
  </div>
    <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/gymback.jpg');">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3"></h1>
          <p></p>
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
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script> 



</body>
</html>