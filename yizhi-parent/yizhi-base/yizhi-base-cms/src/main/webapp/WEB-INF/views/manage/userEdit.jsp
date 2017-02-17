<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript"
	src="../../jquery/common/common.js"></script>
<!-- BOOTSTRAP STYLES-->
<link href="../../assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="../../assets/css/font-awesome.css" rel="stylesheet" />
<!--CUSTOM BASIC STYLES-->
<link href="../../assets/css/basic.css" rel="stylesheet" />
<!--CUSTOM MAIN STYLES-->
<link href="../../assets/css/custom.css" rel="stylesheet" />
<script type="text/javascript">
	$(function() {
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(function() {
			var id = 0;
			var url = "createUser";
			if ($("#myUserId").val() != "") {
				url = "updateUser";
				id = $("#myUserId").val();
			}
			var roleIds = new Array();
			$("#role").find("input:checkbox:checked").each(function() {
				roleIds.push($(this).val())
			});

			var data1 = {
				"user" : {
					"id" : id,
					"name" : $("#userName").val(),
					"password" : $("#password").val()
				},
				"roleIds" : roleIds
			};
			alert(JSON.stringify(data1));

			$.ajax({
				type : "POST",
				url : url,
				contentType : "application/json",
				data : JSON.stringify(data1),
				dataType : "json",
				success : function(data) {
					alert("ok");
					window.location.href=$("#returnList").attr("href");
				}
			});
		});
	});

	function init() {
		if ($("#myUserId").val() == ""){
			getRoles();
			return;
		}
		$.ajax({
			type : "GET",
			url : "getUserDetail",
			contentType : "application/json",
			data : {
				userId : $("#myUserId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#userName").val(data.data.user.name);
				$("#password").val(data.data.user.password);
				getRoles(data.data.roleIds);
			}
		});
	}

	function getRoles(roleIds) {
		$
				.ajax({
					type : "GET",
					url : "getRoleList",
					contentType : "application/json",
					data : {
						userId : $("#myUserId").val()
					},
					dataType : "json",
					success : function(data) {
						var html = "";
						for (var i = 0; i < data.data.length; i++) {
							html += "<input type='checkbox' id='role"+data.data[i].id+"' value='"+data.data[i].id+"' />"
									+ data.data[i].name + "&nbsp&nbsp";
							//html+="<option value='"+data.data[i].id+"'>"+data.data[i].name+"</option>";
						}
						$("#role").html(html);
						if ($("#myUserId").val() != "") {
							for (var i = 0; i < roleIds.length; i++) {
								$("#role" + roleIds[i]).attr("checked", true);
							}
						}
					}
				});
	}
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	userEdit
	<input type="hidden" id="myUserId" value="${myUserId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">Basic Forms</h1>
					<h1 class="page-subhead-line">This is dummy text , you can
						replace it with your original text.</h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">BASIC FORM</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>用户名称</label> <input class="form-control" type="text"
										id="userName" />
								</div>
								<div class="form-group">
									<label>用户密码</label> <input class="form-control" type="text"
										id="password" />
								</div>
								<div class="form-group">
									<label>角色</label></br>
									<span id="role"> </span>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/manage/userList" id="returnList">返回列表</a>
		</div>
	</div>
</body>
</html>