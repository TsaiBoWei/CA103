<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Iron Man Day 26 - ClockPicker</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="robots" content="noindex, nofollow">
<meta name="googlebot" content="noindex, nofollow">
<meta name="viewport" content="width=device-width, initial-scale=1">


<script type="text/javascript" src="//code.jquery.com/jquery-git.js"></script>

<link rel="stylesheet" type="text/css" href="/css/result-light.css">

<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/clockpicker/0.0.7/bootstrap-clockpicker.min.css">
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/clockpicker/0.0.7/bootstrap-clockpicker.min.js"></script>
<style type="text/css">

</style>
<!-- TODO: Missing CoffeeScript 2 -->

<script type="text/javascript">
	$(window).on('load', function() {

		var clockInput = $('.clockpicker').clockpicker({
			placement : 'right',
			autoclose : true
		});

	});
</script>

</head>
<body>
	<div class="col-xs-6">
		<div class="input-group clockpicker">
			<input type="text" class="form-control" value="12:34"> <span
				class="input-group-addon"> <span
				class="glyphicon glyphicon-time"></span>
			</span>
		</div>
	</div>


	<script>
		// tell the embed parent frame the height of the content
		if (window.parent && window.parent.parent) {
			window.parent.parent.postMessage([ "resultsFrame", {
				height : document.body.getBoundingClientRect().height,
				slug : "n9LmazpL"
			} ], "*")
		}
	</script>
</body>
</html>
