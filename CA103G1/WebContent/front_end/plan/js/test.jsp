<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>

<!DOCTYPE HTML>
<html>


<head>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/front_end/plan/js/jquery.min.js">
	
</script>


<script type="text/javascript"
	src="<%=request.getContextPath()%>/front_end/plan/js/bootstrap.min.js">
	
</script>


<script type="text/javascript"
	src="<%=request.getContextPath()%>/front_end/plan/js/bootstrap-datetimepicker.min.js">
	
</script>


<script type="text/javascript"
	src="<%=request.getContextPath()%>/front_end/plan/js/bootstrap-datetimepicker.pt-BR.js">
	
</script>

<script type="text/javascript">
	$(function() {
		$('#datetimepicker2').datetimepicker({
			language : 'en',
			pick12HourFormat : true
		});
	});
</script>




<link
	href="<%=request.getContextPath()%>/front_end/plan/css/bootstrap-combined.min.css"
	rel="stylesheet">


<link rel="stylesheet" type="text/css" media="screen"
	href="<%=request.getContextPath()%>/front_end/plan/css/bootstrap-datetimepicker.min.css">
</head>






<body>
	testing
	<br>

	<div id="datetimepicker2" class="input-append">
		<input data-format="MM/dd/yyyy HH:mm:ss PP" type="text"></input> <span
			class="add-on"> <i data-time-icon="icon-time"
			data-date-icon="icon-calendar"> </i>
		</span>
	</div>







</body>
<html>