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
			var url = "createIndex";
			if ($("#indexId").val() != "") {
				url = "updateIndex";
				id = $("#indexId").val();
			}
			var data1 = {
				"index" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"fullName" : $("#fullName").val(),
					"pinyinFullName" : $("#pinyinFullName").val(),
					"isLandmark" : $("#isLandmark")
					.is(':checked'),
					"result" : $("#result").val(),
					"normalMin" : $("#normalMin").val(),
					"normalMax" : $("#normalMax").val(),
					"unit" : $("#unit").val()
				}
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
		if ($("#indexId").val() == "")
			return;
		$.ajax({
			type : "GET",
			url : "getIndexDetail",
			contentType : "application/json",
			data : {
				indexId : $("#indexId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#name").val(data.data.index.name);
				$("#pinyinName").val(data.data.index.pinyinName);
				$("#fullName").val(data.data.index.fullName);
				$("#pinyinFullName").val(data.data.index.pinyinFullName);
				$("#isLandmark").attr("checked",
						data.data.index.isLandmark);
				$("#result").val(data.data.index.result);
				$("#normalMin").val(data.data.index.normalMin);
				$("#normalMax").val(data.data.index.normalMax);
				$("#unit").val(data.data.index.unit);
			}
		});
	}

	function getPinyin() {
		$.ajax({
			type : "GET",
			url : "../../common/getPinyinString",
			contentType : "application/json",
			dataType : "json",
			data : {
				str : $("#name").val()
			},
			success : function(data) {
				$("#pinyinName").val(data);
			}
		});
	}

	function getFullPinyin() {
		$.ajax({
			type : "GET",
			url : "../../common/getPinyinString",
			contentType : "application/json",
			dataType : "json",
			data : {
				str : $("#fullName").val()
			},
			success : function(data) {
				$("#pinyinFullName").val(data);
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	indexEdit
	<input type="hidden" id="indexId" value="${indexId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑指标</h1>
					<h1 class="page-subhead-line">编辑指标
			<a href="<%=request.getContextPath() %>/web/disease/indexList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑指标</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>指标名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>指标拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>指标全称</label> <input class="form-control"
										type="text" id="fullName" />
								</div>
								<div class="form-group">
									<label>全称拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getFullPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinFullName">
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isLandmark" />标志物</label>
								</div>
								<div class="form-group">
									<label>最小值</label> <input class="form-control"
										type="text" id="normalMin" />
									<label>最大值</label> <input class="form-control"
										type="text" id="normalMax" />
									<label>单位</label> <input class="form-control"
										type="text" id="unit" />
								</div>
								<div class="form-group">
									<label>结果分析</label>
									<textarea class="form-control" rows="3" id="result"></textarea>
								</div>
							</form>
						</div>
					</div>
					<hr>

					<div class="col-md-10">
						<div class="form-inline pull-right">
							<div class=" pagination  ">
								<input type="button" id="submit" value="确认发布"
									class="btn btn-lg btn-success"><a
									href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=1"></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>