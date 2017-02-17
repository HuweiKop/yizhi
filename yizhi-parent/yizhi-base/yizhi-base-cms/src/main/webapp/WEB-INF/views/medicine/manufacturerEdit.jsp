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
			var url = "createManufacturer";
			if ($("#manufacturerId").val() != "") {
				url = "updateManufacturer";
				id = $("#manufacturerId").val();
			}
			var data1 = {
				"manufacturer" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"englishName" : $("#englishName").val(),
					"address" : $("#address").val(),
					"description" : $("#description").val(),
					"type" : $("#type").val(),
					"scope" : $("#scope").val(),
					"slogen" : $("#slogen").val(),
					"logo" : $("#logo").val()
				}
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
		$.ajax({
			type : "GET",
			url : "getManufacturerDetail",
			contentType : "application/json",
			data : {
				manufacturerId : $("#manufacturerId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#name").val(data.data.manufacturer.name);
				$("#pinyinName").val(data.data.manufacturer.pinyinName);
				$("#englishName").val(data.data.manufacturer.englishName);
				$("#address").val(data.data.manufacturer.address);
				$("#description").val(data.data.manufacturer.description);
				$("#logo").val(data.data.manufacturer.logo);
				$("#slogen").val(data.data.manufacturer.slogen);
				$("#scope").val(data.data.manufacturer.scope);
				$("#type").val(data.data.manufacturer.type);
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
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	<input type="hidden" id="manufacturerId" value="${manufacturerId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑药厂</h1>
					<h1 class="page-subhead-line">编辑药厂
			<a href="<%=request.getContextPath() %>/web/medicine/manufacturerList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑药厂</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>药厂名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>药厂拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>英文名称</label> <input class="form-control" type="text"
										id="englishName" />
								</div>
								<div class="form-group">
									<label>地址</label>
									<textarea class="form-control" rows="3" id="address"></textarea>
								</div>
								<div class="form-group">
									<label>简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>logo编号</label> <input class="form-control" type="text"
										id="logo" />
								</div>
								<div class="form-group">
									<label>类型</label><select id="type"><option value="1">外资</option>
										<option value="2">独资</option>
										<option value="3">合资</option></select>
								</div>
								<div class="form-group">
									<label>口号</label> <input class="form-control" type="text"
										id="slogen" />
								</div>
								<div class="form-group">
									<label>经营范围</label> <input class="form-control" type="text"
										id="scope" />
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