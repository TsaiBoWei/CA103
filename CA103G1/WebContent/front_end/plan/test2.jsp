

<head>

<meta name="robots" content="noindex">
<link rel="shortcut icon" type="image/x-icon"
	href="//static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />

<link rel="mask-icon" type=""
	href="//static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg"
	color="#111" />

<link rel="canonical" href="https://codepen.io/joshuaward/pen/wegBva" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel='stylesheet'
	href='https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css'>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js'></script>
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'>

<style class="cp-pen-styles">

*, *:before, *:after {
	box-sizing: border-box;
	outline: none;
}

.hide {
	opacity: 0;
}

body {
	font-family: 'Source Sans Pro', sans-serif;
	font-size: 16px;
	font-smooth: auto;
	font-weight: 300;
	line-height: 1.5;
	color: #444;
}

.container {
	position: relative;
	display: block;
	width: 80%;
	height: 100%;
	margin: 0 auto;
}

header {
	position: relative;
	display: block;
	width: 100%;
	height: 90vh;
	margin: 0;
	padding: 20px 0 0;
	overflow: hidden;
	z-index: 0;
}

header:before, header:after {
	position: absolute;
	content: '';
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

header:before {
	background-color: rgba(231, 76, 60, 0.8);
	z-index: 0;
}

header:after {
	filter: blur(5px);
	background-attachment: fixed;
	background-image:
		url("https://static.pexels.com/photos/266526/pexels-photo-266526.jpeg");
	background-position: bottom center;
	background-repeat: no-repeat;
	background-size: cover;
	animation: blur 10s linear infinite;
	overflow: hidden;
	z-index: -1;
}

@
keyframes blur { 0% {
	filter: blur(1px);
}

50%
{
filter
:blur(20px)
;


  

}
100%
{
filter


:

 

blur


(1
px
);


  

}
}
header nav {
	position: relative;
	z-index: 2;
}

header nav .logo {
	position: relative;
	display: inline-block;
	width: 50px;
	height: 50px;
	margin: 0;
	border-radius: 50%;
}

header nav .logo svg {
	position: absolute;
	transform: scale(1);
	animation: scale 750ms ease-in-out;
}

@keyframes scale { 
	0% {
		transform: scale(100);
		opacity: 0;
	}
	
	50%{
		transform:scale(0.2);
	}
	
	70%{
		transform:scale(1);
	}
	
	90%{
		transform:scale(0.7);
	}

	100%{
		transform


:

 

scale


(1);
opacity


:

 

1;
}
}
header nav .subscribe {
	position: relative;
	display: inline-block;
	padding: 15px 0;
	float: right;
	animation: slide 1000ms ease;
}

header nav .subscribe a {
	position: relative;
	margin: 0;
	padding: 10px 20px;
	background-color: white;
	border-radius: 4px;
	box-shadow: 0 0 35px rgba(0, 0, 0, 0.3);
	color: #e74c3c;
	font-size: 13px;
	text-decoration: none;
	text-transform: uppercase;
	transition: box-shadow 500ms ease;
}

header nav .subscribe a:hover {
	box-shadow: 0 0 0 rgba(0, 0, 0, 0);
}

@
keyframes slide { 0% {
	transform: translateY(-600px);
	opacity: 0;
}

100%
{
transform


:

 

translateY


(0
px
);


    

opacity


:

 

1;
}
}
header blockquote {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 90%;
	margin: 0;
	padding: 5px 0 5px 30px;
	color: white;
	font-size: 24px;
	font-weight: 100;
	line-height: 1.25;
	letter-spacing: 2px;
	transform: translate(-50%, -50%);
	animation: fadeIn 1250ms ease;
}

header blockquote:before {
	position: absolute;
	content: '';
	top: 0;
	left: 0;
	width: 5px;
	height: 100%;
	background-color: white;
	animation: height 1000ms ease-in-out;
}

@
keyframes height { 0% {
	height: 0;
}

100%
{
height


:

 

100%;
}
}
@
keyframes fadeIn { 0% {
	opacity: 0;
	transform: translate(-50%, -150%);
}

100%
{
opacity


:

 

1;
transform


:

 

translateY


(-50%
,
0%);
}
}
header blockquote span {
	position: relative;
	display: block;
	margin: 20px 0 0;
	font-size: 16px;
}

header .date {
	position: absolute;
	bottom: 20px;
	margin: 0;
	padding: 5px 15px;
	border: 2px solid white;
	border-radius: 4px;
	color: white;
	font-size: 12px;
	font-weight: 400;
}

header .date i {
	margin-right: 5px;
	font-size: 14px;
}

section {
	position: relative;
	display: block;
	margin: 0;
	padding: 100px 0;
	z-index: 999;
}

section .scroll {
	position: absolute;
	right: 50px;
	top: -20px;
	width: 40px;
	height: 40px;
	background-color: white;
	border-radius: 50%;
}

section .scroll i {
	position: relative;
	top: 50%;
	left: 50%;
	color: #e74c3c;
	transform: translate(-50%, -100%);
	animation: down 2s ease infinite;
	z-index: 9;
}

@
keyframes down { 100% {
	transform: translate(-50%, -30%);
	opacity: 0;
}

}
section .container {
	width: 80%;
}

section h1 {
	margin: 0;
	padding: 0;
	color: #5A7D7C;
	line-height: 1.5;
}

section .byline {
	position: relative;
	display: block;
	width: 100%;
	margin-bottom: 50px;
	font-style: italic;
	vertical-align: middle;
}

section .byline .avatar {
	position: relative;
	display: inline-block;
	top: 10px;
	width: 30px;
	height: 30px;
	margin-right: 5px;
	background-image:
		url("https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ2NjM5NjE5NF5BMl5BanBnXkFtZTYwNTk3MjUz._V1_UY317_CR0,0,214,317_AL_.jpg");
	background-size: cover;
	background-color: #5A7D7C;
	border-radius: 50%;
}

section .byline span {
	color: #e74c3c;
	font-style: normal;
	font-weight: bold;
}

section p {
	margin-bottom: 50px;
	font-family: 'Merriweather', serif;
	font-size: 16px;
	line-height: 1.95;
}

section p .drop {
	position: relative;
	display: inline-block;
	margin: 0 20px 0 0;
	color: #e74c3c;
	font-size: 64px;
	font-weight: bold;
	line-height: 1.2;
	float: left;
}

section blockquote {
	position: relative;
	width: 80%;
	margin: 150px auto;
	padding: 5px 0 5px 30px;
	border-left: 5px solid #e74c3c;
	color: #444;
	font-size: 20px;
	line-height: 1.75;
}

section blockquote span {
	position: relative;
	display: block;
	margin: 20px 0 0;
	font-size: 16px;
}

.quote {
	height: 400px;
	background-attachment: fixed;
	background-position: center center;
	background-repeat: no-repeat;
	background-size: cover;
	overflow: hidden;
}

.quote.desert {
	background-image:
		url("https://static.pexels.com/photos/80454/tree-desert-namibia-dead-vlei-80454.jpeg");
}



.quote:before {
	position: absolute;
	content: '';
	top: 0;
	left: 0;
	width: 130%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.8);
	box-shadow: inset 0 0 30px rgba(0, 0, 0, 0.3);
	z-index: -1;
}

.quote blockquote {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 44%;
	margin: 0;
	padding: 5px 0 5px 30px;
	border-left: 5px solid #e74c3c;
	color: #444;
	font-size: 24px;
	font-weight: 100;
	line-height: 1.25;
	letter-spacing: 2px;
	transform: translate(-50%, -50%);
}

.quote blockquote span {
	position: relative;
	display: block;
	margin: 20px 0 0;
	font-size: 16px;
}

.comments {
	padding-top: 0;
}

.comments .toggle {
	position: relative;
	display: block;
	width: 100%;
	margin: 10px 0 50px;
	padding: 10px;
	background-color: #719998;
	border-radius: 4px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
	color: white;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
}

.comments .toggle .indicator {
	position: relative;
	top: 4px;
	width: 15px;
	height: 16px;
	line-height: 1.75;
	transition: transform 250ms ease;
	float: right;
}

.comments .toggle .indicator:before, .comments .toggle .indicator:after
	{
	position: absolute;
	content: '';
}

.comments .toggle .indicator:before {
	top: 50%;
	width: 100%;
	height: 2px;
	background-color: white;
	transform: translateY(-1px);
}

.comments .toggle .indicator:after {
	left: 50%;
	width: 2px;
	height: 100%;
	background-color: white;
	transform: translateX(-1px);
}

.comments #toggle {
	display: none;
}

.comments #toggle:checked+.toggle .indicator {
	transform: rotate(45deg);
}

.comments #toggle:checked ~ .wrapper {
	height: auto;
}

.comments .wrapper {
	position: relative;
	display: block;
	height: 0;
	overflow: hidden;
}

.comments .wrapper .comment {
	position: relative;
	display: flex;
}

.comments .wrapper .comment .user {
	position: relative;
	width: 80px;
	height: inherit;
	margin: 0 20px 20px 0;
	padding: 0;
	float: left;
	font-size: 12px;
	text-align: center;
}

.comments .wrapper .comment .user .pic {
	position: relative;
	width: 100%;
	height: 65px;
	margin: 6px auto;
	background-image:
		url("http://images.complex.com/complex/image/upload/c_limit,w_680/fl_lossy,pg_1,q_auto/Screen_Shot_2015-09-08_at_12.11.35_PM_sy22b5.jpg");
	background-position: center center;
	background-size: cover;
	background-color: darkgray;
	overflow: hidden;
}

.comments .wrapper .comment .user .date {
	font-size: 12px;
}

.comments .wrapper .comment .text .author {
	font-weight: bold;
	text-transform: uppercase;
	color: #e74c3c;
}

.comments .wrapper .comment .text p {
	position: relative;
	margin: 0;
	padding: 0;
	font-size: 14px;
}

.tags {
	position: relative;
	display: block;
	margin: 0;
	padding: 0;
	list-style-type: none;
}

.tags li {
	position: relative;
	display: inline-block;
	margin: 0 5px 5px 0;
}

.tags li.tag {
	display: block;
	color: #e74c3c;
	font-weight: bold;
	text-transform: uppercase;
}

.tags li a {
	position: relative;
	display: block;
	padding: 7px 20px;
	background-color: #5A7D7C;
	border-radius: 99px;
	color: white;
	font-size: 12px;
	font-weight: bold;
	text-transform: uppercase;
	text-decoration: none;
}

.tags li a:hover {
	background-color: #719998;
}
</style>
</head>
<body>
	<header>
		<div class="container">
			<nav>
				<div class="logo">
					<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
						xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
						viewBox="0 0 50 50" style="enable-background: new 0 0 50 50;"
						xml:space="preserve">
					<style type="text/css">
.st0 {
	fill: #FFFFFF;
}

.st1 {
	fill: #B93D30;
}
</style>
					<circle class="st0" cx="25" cy="25" r="25" />
					<g>
						<polygon class="st1"
							points="34.1,25 27.7,13.9 21.3,25 19.2,28.7 16.5,24 13,30 9.5,36.1 14.9,36.1 16.5,36.1 23.5,36.1 
													 27.7,36.1 40.5,36.1 	" />
					</g>
				</svg>
				</div>
				<div class="subscribe">
					<a href="#">Subscribe</a>
				</div>
			</nav>
			<blockquote>
				The 7777777777 Indian is a mysterious spiritual force, and we're
				going to Cathedral Rock, and that's the vortex of the heart. <span>&mdash;
					Gary Busey</span>
			</blockquote>
			<div class="date">
				<i class="fa fa-calendar" aria-hidden="true"></i> August 1, 2017
			</div>
		</div>
	</header>

	<section>
		<div class="scroll">
			<i class="fa fa-long-arrow-down" aria-hidden="true"></i>
		</div>
		<div class="container">
			<h1>I wrestled a bear once. 750lbs.</h1>
			<div class="byline">
				<div class="avatar"></div>
				by <span>Gary Busey</span>
			</div>
			<p class="hide">
				<span class="drop">Y</span>ou gotta go through it to see there ain't
				nothing to it. Did you feel that? Look at me - I'm not out of breath
				anymore! Go with the feeling of the nature. Take it easy. Know why
				you're here. And remember to balance your internal energy with the
				environment.
			</p>

			<p class="hide">Listen to the silence. And when the silence is
				deafening, you're in the center of your own universe. It's OK to get
				Rib-grease on your face, because you're allowing people to see that
				you're proud of these ribs. The best way to communicate is
				compatible. Compatible communication is listening with open ears and
				an open mind, and not being fearful or judgemental about what you're
				hearing.</p>
		</div>
	</section>


	<section class="quote second">
		<blockquote>I would like to give you a backstage pass to
			my imagination.</blockquote>
	</section>

	<section>
		<div class="container">
			<ul class="tags">
				<li class="tag">Tags</li>
				<li><a href="#">Psychedelic</a></li>
				<li><a href="#">Spiritual</a></li>
				<li><a href="#">WTF</a></li>
				<li><a href="#">Gary Busey</a></li>
				<li><a href="#">Philosophy</a></li>
				<li><a href="#">Deep Thoughts</a></li>
				<li><a href="#">Drugs</a></li>
				<li><a href="#">Doctrine</a></li>
			</ul>
		</div>
	</section>

	<section class="comments">
		<div class="container">
			<input type="checkbox" id="toggle" /> <label class="toggle"
				for="toggle"> Toggle Comments <i class="indicator"></i>
			</label>
			<div class="wrapper">

				<!-- COMMENT -->
				<div class="comment">
					<div class="user">
						<div class="pic"></div>
						<div class="date">06/16/2017</div>
					</div>

					<div class="text">
						<div class="author">Joaquin Phoenix</div>
						<p>Thats an advanced modern oxymoron. It was good, I like it
							and I beleived it. Man you got a way with using words. Thats like
							a lariat that does a snake whip on your back legs, I mean on the
							back of your legs - not that you have 4 legs - and pulls you this
							way, and thats what that line did to me and I believed every
							minute of it. Until I looked at the quadrangle that it produced
							with the verbs used in the sentence.</p>
					</div>
				</div>
			</div>
		</div>
	</section>


	<script
		src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script>
	<script
		src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
	<script>
		$(document)
				.ready(
						function() {
							/* Every time the window is scrolled ... */
							$(window)
									.scroll(
											function() {
												$('.hide')
														.each(
																function(i) {
																	var bottom_of_object = $(
																			this)
																			.offset().top
																			+ $(
																					this)
																					.outerHeight();
																	var bottom_of_window = $(
																			window)
																			.scrollTop()
																			+ $(
																					window)
																					.height();
																	if (bottom_of_window > bottom_of_object) {
																		$(this)
																				.animate(
																						{
																							'opacity' : '1'
																						},
																						500);
																	}
																});
											});
						});
		//# sourceURL=pen.js
	</script>
</body>
</html>