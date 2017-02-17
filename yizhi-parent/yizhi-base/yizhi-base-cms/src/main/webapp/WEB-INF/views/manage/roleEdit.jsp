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
			var url = "createRole";
			if ($("#roleId").val() != "") {
				url = "updateRole";
				id = $("#roleId").val();
			}
			var auth = 0;
			$("input[type='checkbox']").each(function(){
				if($(this).is(":checked")){
					auth = auth|$(this).attr("auth");
				}
			});
			
			var data1 = {
					"id" : id,
					"name" : $("#name").val(),
					"auth" : auth
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
		if ($("#roleId").val() == "")
			return;
		$.ajax({
			type : "GET",
			url : "getRoleDetail",
			contentType : "application/json",
			data : {
				roleId : $("#roleId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#name").val(data.data.name);

				var auth = data.data.auth;
				if((auth&1)==1){
					$("input[name='create']").attr("checked","true");
				}
				if((auth&2)==2){
					$("input[name='delete']").attr("checked","true");
				}
				if((auth&4)==4){
					$("input[name='update']").attr("checked","true");
				}
				if((auth&8)==8){
					$("input[name='publish']").attr("checked","true");
				}
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	roleEdit
	<input type="hidden" id="roleId" value="${roleId}" />
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
									<label>角色名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>权限</label></br>
									<input type="checkbox" name="create" auth="1" /> 添加
									<input type="checkbox" name="delete" auth="2" /> 删除
									<input type="checkbox" name="update" auth="4" /> 修改
									<input type="checkbox" name="publish" auth="8" /> 发布
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/manage/roleList" id="returnList">返回列表</a>
		</div>
	</div>
</body>
</html>