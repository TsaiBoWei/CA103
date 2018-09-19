<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>Conference Neon - Pingendo template</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <!--  self-defined css  -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>
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
                <i class="fa fa-file">&nbsp;&nbsp;�ӤH����</i>
              </a>
              <a href="#">
                <i class="fa fa-calculator">&nbsp;&nbsp;�p�e</i>
              </a>
              <a href="#">
                <i class="fa fa-users" aria-hidden="true">&nbsp;&nbsp;�n��</i>
              </a>
              <a href="#">
                <i class="fa fa-film" aria-hidden="true">&nbsp;&nbsp;�ҵ{</i>
              </a>
              <a href="#">
                <i class="fa fa-hand-spock-o" aria-hidden="true">&nbsp;&nbsp;����</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;�K��</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;��ƾ�</i>
              </a>
              <a href="#">�n�X</a>
            </div>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#" id="registerBtn">Register now</a>
      </div>
    </div>
  </nav>
  <!-- Cover -->
  <div class="align-items-center py-5 section-fade-in-out " id="coverfirstImg" style="background: url(&quot;assets/conference/cover_marathon.png&quot;);"> </div>
  <div class="banner-div">
    <div class="container">
      <div class="row ">
        <div class="col-md-10 pt-3 text-left pl-0">
          <h1 class=" text-left">
            <span>�O�_���y2018���d���O�A�B�ʻO�_�z�ߪŸ��]���B���� &nbsp;
              <button class="btn btn-sm  btn-outline-success">Jogging </button>
            </span>
          </h1>
          <div class="m-1   pb-2">
            <span class=" eveview"> �s���� :
              <span>10</span>&nbsp;&nbsp;���ü� :
              <span>10</span> &nbsp; </span>
            <span class="pull-right text-warning" style="font-size:24px;"> ���W�I��˼� :
              <span>2</span>��
              <span>21</span> ��
              <span>50</span>��
              <span>20</span>�� </span>
          </div>
          <div>
            <img src="assets/eventpic/run/banner_maokong_run.jpg" style="height:100%;"> </div>
        </div>
        <div class="col-md-2">
          <div>
            <h4 class=" pt-5 mt-3">���ʵo�_�H</h4>
          </div>
          <div>
            <a href="">
              <img src="assets/styleguide/people_6.jpg" style="height:100%;">
              <h5 class="p-1 pt-2">Lily</h5>
            </a>
          </div>
          <!-- ���������� ���W���s�n����ܵ��� -->
          <a class="btn btn-lg btn-block btn-danger my-3 p-1" href="#">�ߧY���W</a>
          <div class="d-flex align-self-center align-items-center justify-content-center">
            <a href="#" class="btn btn-sm m-1 btn-outline-success">���� </a>
            <a href="#" class="btn btn-outline-primary btn-sm m-1">���� </a>
            <a href="#" class="btn btn-sm btn-outline-secondary m-1">���| </a>
          </div>
        </div>
      </div>
      <div class="row pt-1">
        <div class="col-md-6  px-3  text-left"> </div>
        <div class="col-md-6">
          <h3 class="text-right text-warning m-1"> </h3>
        </div>
      </div>
    </div>
  </div>
  <div class="container containerHrT ">
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
        <!-- �Ĥ@�ӫ��s -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabone" data-toggle="tab">
              <i class="fa fa-info-circle"></i> &nbsp; ���ʸ�T &nbsp;</a>
          </li>
          <!-- �ĤG�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabtwo" data-toggle="tab">
              <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; �̷s���� &nbsp;</a>
          </li>
          <!-- �ĤT�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabthree" data-toggle="tab">
              <i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; ���W�d��&nbsp;</a>
          </li>
          <!-- �ĥ|�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfour" data-toggle="tab">
              <i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp; ��q��T &nbsp; </a>
          </li>
          <!-- �Ĥ��ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfive" data-toggle="tab">
              <i class="fa fa-quora" aria-hidden="true"></i> &nbsp; ���D�Ը� &nbsp; </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container containerHrB ">
    <hr> </div>
  <!-- ���� -->
  <div class="tab-content mt-2 px-5">
    <div class="tab-pane fade show active" id="tabone" role="tabpanel">
      <div class="container">
        <div class="row d-block text-left px-5">
          <h3 class="py-1">���ʤ�� :
            <div></div>
          </h3>
          <h3 class="py-1">���ʤ��� : </h3>
          <div class="px-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
            irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. </div>
          <h3 class="py-1">���ʦ���H�� :
            <span>20</span>�H</h3>
          <h3 class="py-1">���W�O�� :
            <span>1000</span>��</h3>
          <h3 class="py-1">�`�N�ƶ� : </h3>
          <div class="px-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
            irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabtwo" role="tabpanel">
      <p class="">Tab pane two. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </div>
    <div class="tab-pane fade" id="tabthree" role="tabpanel">
      <div class="container">
        <div class="row d- text-left">
          <div class="col-md-3"></div>
          <div class="col-md-3">
            <h3>�п�J�z���|���b�� : </h3>
            <h3>�п�J�q�渹�X : </h3>
            <div class="text-center">
              <a class="btn btn-lg  btn-info my-3 p-2 " href="#">�d��</a>
            </div>
          </div>
          <div class="col-md-3"></div>
          <div class="col-md-3"></div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabfour" role="tabpanel">
      <div class="container text-left px-5">
        <div class="row">
          <div class="col-md-12">
            <h3>���ʦa�I : </h3>
            <p class="px-4">Tab pane two. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
          </div>
        </div>
        <h3 class="">���ʦa��</h3>
        <div class="row">
          <div class="col-md-12">
            <img class="d-block img-fluid img-thumbnail mx-auto" src="https://maps.googleapis.com/maps/api/staticmap?key=AIzaSyDW8nO9JhT_pEjebobq9pgUF2cEp0EUb1I&amp;markers=%E4%B8%AD%E5%A4%AE%E5%A4%A7%E5%AD%B8&amp;center=%E4%B8%AD%E5%A4%AE%E5%A4%A7%E5%AD%B8&amp;zoom=16&amp;size=800x350&amp;sensor=false"> </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabfive" role="tabpanel">
      <div class="container px-5">
        <div class="row d-block text-left">
          <div class="col-md-12">
            <h3>�s���q�� : </h3>
            <h3>�s���H�c : </h3>
            <h3>�d��</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="py-5" id="speakers">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h2>�M�ݱ��ˬ���</h2>
          <div class="tab-content mt-2">
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="carousel slide" data-ride="carousel" id="bs4-multi-slide-carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="row mr-4 ml-4">
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title1</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>

                <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev">
                  <span class="carousel-control-prev-icon"></span>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title2</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title3</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
          
                <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next">
                  <span class="carousel-control-next-icon"></span>
                </a>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <div class="row mr-4 ml-4">
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title4</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
               
                <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev">
                  <span class="carousel-control-prev-icon"></span>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title5</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title6</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
             
                <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next">
                  <span class="carousel-control-next-icon"></span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Schedule -->
  <!-- Sponsor logos -->
  <div class="py-5 section sponsor-div">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="mb-4">Sponsors</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_1.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_4.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_3.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="assets/conference/logo_2.png"> </div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/cover_2.jpg');">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3">Something Here</h1>
          <p>Pre-register to get a priority access to the event. Fares will be published later on.&nbsp;
            <br>Get the maximum from the lectures together with the possibility of joining exclusive side-events.</p>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="text-md-left text-center p-4">
    <div class="container">
      <div class="row">
        <div class="col-lg-12"> </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <p class="text-muted">
            <br>
            <br> Copyright 2018 Pingendo - All rights reserved.
            <br>
            <br> </p>
        </div>
      </div>
    </div>
  </footer>
  <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <button id="goTopBtn" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:80px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">
  GoTop </button>
  
</body>

</html>