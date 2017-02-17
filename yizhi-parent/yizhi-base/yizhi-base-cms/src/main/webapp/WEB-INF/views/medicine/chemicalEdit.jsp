<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../../jquery/common/common.js"></script>
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
			var url = "createChemical";
			if ($("#chemicalId").val() != "") {
				url = "updateChemical";
				id = $("#chemicalId").val();
			}
			var diseases = $("#diseases input:checkbox:checked");
			var diseaseIds = new Array();
			for (var i = 0; i < diseases.length; i++) {
				//indexIds += "," + indexs[i].id;
				diseaseIds.push(diseases[i].value);
			}
			var data1 = {
				"chemical" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val()
				},
				"diseaseIds" : diseaseIds
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
		if ($("#chemicalId").val() == "") {
			getDisease();
		} else {
			$.ajax({
				type : "GET",
				url : "getChemicalDetail",
				contentType : "application/json",
				data : {
					chemicalId : $("#chemicalId").val()
				},
				dataType : "json",
				success : function(data) {
					$("#name").val(data.data.chemical.name);
					$("#pinyinName").val(data.data.chemical.pinyinName);
					getDisease(data.data.diseaseIds);
				}
			});
		}
	}

	function getDisease(diseaseIds) {
		$
				.ajax({
					type : "GET",
					url : "../disease/getDiseaseList",
					contentType : "application/json",
					dataType : "json",
					success : function(data) {
						var html = "";
						for (var i = 0; i < data.data.length; i++) {
							html += "<label class=\" checkbox-inline\"><input type='checkbox' id='dis"+data.data[i].id+"' value='"+data.data[i].id+"' />"
							+ data.data[i].name + "</label>";
						}
						$("#diseases").html(html);
						for (var i = 0; i < diseaseIds.length; i++) {
							$("#dis" + diseaseIds[i]).attr("checked", true);
						}
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
	<input type="hidden" id="chemicalId" value="${chemicalId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑化学名</h1>
					<h1 class="page-subhead-line">编辑化学名<a
				href="<%=request.getContextPath()%>/web/medicine/chemicalList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑化学名</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>化学名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>关联癌症</label><span id="diseases"></span>
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