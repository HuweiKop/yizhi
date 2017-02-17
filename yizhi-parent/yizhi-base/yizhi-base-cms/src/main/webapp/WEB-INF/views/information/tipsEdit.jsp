<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../../jquery/nicEdit.js"></script>
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
			var url = "createTips";
			if ($("#tipsId").val() != "") {
				url = "updateTips";
				id = $("#tipsId").val();
			}

			var data1 = {
				"id" : id,
				"title" : $("#title").val(),
				"content" : $("#txtContent").val(),
				"writer" : $("#writer").val()
			};
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
		if ($("#tipsId").val() == "")
			return;
		$.ajax({
			type : "GET",
			url : "getTipsDetail",
			contentType : "application/json",
			data : {
				tipsId : $("#tipsId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#title").val(data.data.title);
				$("#txtContent").val(data.data.content);
				$("#writer").val(data.data.writer);
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	<input type="hidden" value="${tipsId }" id="tipsId" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑小贴士</h1>
					<h1 class="page-subhead-line">编辑小贴士
			<a href="<%=request.getContextPath() %>/web/information/tipsList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑小贴士</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>问题</label> <input class="form-control" type="text"
										id="title" />
								</div>
								<div class="form-group">
									<label>内容</label>
									<textarea class="form-control" rows="3" id=txtContent></textarea>
								</div>
								<div class="form-group">
									<label>作者</label> <input class="form-control" type="text"
										id="writer" />
								</div>
							</form>
						</div>
					</div>
					<hr>

					<div class="col-md-10">
						<div class="form-inline pull-right">
							<div class=" pagination  ">
								<input type="button" id="submit" value="确认发布"
									class="btn btn-lg btn-success">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>