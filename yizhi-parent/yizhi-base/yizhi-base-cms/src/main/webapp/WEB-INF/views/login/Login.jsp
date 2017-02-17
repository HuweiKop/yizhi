<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>chinaz</title>
<script type="text/javascript" src="../jquery/jquery-2.2.1.min.js"></script>

<!-- BOOTSTRAP STYLES-->
<link href="../assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="../assets/css/font-awesome.css" rel="stylesheet" />

<script type="text/javascript">
	$(function(){
		$("#login").click(function(){
			$("#formid").submit();
			/** var data1 = {"name":$("#name").val(),"password":$("#password").val()};
			$.ajax({
				type : "POST",
				url : "doLogin",
				contentType:"application/json",
				data : JSON.stringify(data1),
				dataType : "json",
				success : function(data) {
					alert(data);
				}
			}); **/
		});
	})
</script>

</head>
<body style="background-color: #E2E2E2;">
	<div class="container">
		<div class="row text-center " style="padding-top: 100px;">
			<div class="col-md-12">
				<img src="assets/img/logo-invoice.png" />
			</div>
		</div>
		<div class="row ">

			<div
				class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1">

				<div class="panel-body">
					<form role="form" id="formid" action="doLogin" method="post">
						<hr />
						<h5>Enter Details to Login</h5>
						<br />
						<div class="form-group input-group">
							<span class="input-group-addon"><i class="fa fa-tag"></i></span>
							<input type="text" class="form-control" id="name" name="name"
								placeholder="Your Username " />
						</div>
						<div class="form-group input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="password" class="form-control" id="password" name="password"
								placeholder="Your Password" />
						</div>
						<div class="form-group">
							<label class="checkbox-inline"> <input type="checkbox" />
								Remember me
							</label> <span class="pull-right"> <a href="index.html">Forget
									password ? </a>
							</span>
						</div>

						<a  class="btn btn-primary " id="login">Login Now</a>
						<hr />
						Not register ? <a href="index.html">click here </a> or go to <a
							href="index.html">Home</a>
					</form>
				</div>

			</div>


		</div>
	</div>

</body>
</html>
