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
<!-- GOOGLE FONTS-->
<link href='http://fonts.useso.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<script type="text/javascript">
	$(function() {
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(function() {
			var id = 0;
			var url = "createInspection";
			if ($("#inspectionId").val() != "") {
				url = "updateInspection";
				id = $("#inspectionId").val();
			}
			var indexs = $("#index input:checkbox:checked");
			var indexIds = new Array();
			for (var i = 0; i < indexs.length; i++) {
				//indexIds += "," + indexs[i].id;
				indexIds.push(indexs[i].value);
			}
			var data1 = {
				"inspection" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"method" : $("#method").val(),
					"costMin" : $("#costMin").val(),
					"costMax" : $("#costMin").val(),
					"discomfortIndex" : $("#discomfortIndex").val(),
					"isInsurance" : $("#insurance").is(':checked'),
					"cycle" : $("#cycle").val(),
					"description" : $("#description").val()
				},
				"indexIds" : indexIds
			};
			alert(JSON.stringify(data1));
			$.ajax({
				type : "POST",
				url : url,
				contentType : "application/json",
				data : JSON.stringify(data1),
				dataType : "json",
				success : function(data) {
				}
			});
		});
	});

	function init() {
		if ($("#inspectionId").val() == "") {
			getIndexs();
		} else {
			getInspection();
		}
	}

	function getInspection() {
		$
				.ajax({
					type : "GET",
					url : "getInspectionDetail",
					contentType : "application/json",
					data : {
						inspectionId : $("#inspectionId").val()
					},
					dataType : "json",
					success : function(data) {
						$("#name").val(data.data.inspection.name);
						$("#pinyinName").val(data.data.inspection.pinyinName);
						//$("#method").val(data.data.inspection.method);
						$("#costMin").val(data.data.inspection.costMin);
						$("#costMax").val(data.data.inspection.costMax);
						$("#discomfortIndex").val(
								data.data.inspection.discomfortIndex);
						$("#insurance").attr("checked",
								data.data.inspection.isInsurance);
						$("#cycle").val(data.data.inspection.cycle);
						$("#description").val(data.data.inspection.description);
						getIndexs(data.data.indexIds);
						getMethod(data.data.inspection.method);
					}
				});
	}

	function getIndexs(indexIds) {
		$
				.ajax({
					type : "GET",
					url : "getIndexList",
					contentType : "application/json",
					dataType : "json",
					success : function(data) {
						var html = "";
						for (var i = 0; i < data.data.length; i++) {
							html += "<input type='checkbox' id='ind"+data.data[i].id+"' value='"+data.data[i].id+"' />"
									+ data.data[i].name+"&nbsp&nbsp";
							//html+="<option value='"+data.data[i].id+"'>"+data.data[i].name+"</option>";
						}
						$("#index").html(html);
						if ($("#inspectionId").val() != "") {
							for (var i = 0; i < indexIds.length; i++) {
								$("#ind" + indexIds[i]).attr("checked", true);
							}
						}
					}
				});
	}

	function getMethod(methodId) {
		$.ajax({
			type : "GET",
			url : "getInspectionMethodList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<option value='"+data.data[i].id+"' >"
							+ data.data[i].name + "</option>";
				}
				$("#method").html(html);
				$("#method").val(methodId);
			}
		});
	}

	function xxx() {
		var indexs = $("#index input:checkbox:checked");
		var indexIds = "";
		for (var i = 0; i < indexs.length; i++) {
			indexIds += "," + indexs[i].id;
		}
		if (indexIds.length > 0) {
			indexIds = indexIds.substr(1);
		}
		alert(indexIds);
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
	inspectionEdit
	<input type="hidden" id="inspectionId" value="${inspectionId}" />
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
									<label>检查名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>检查拼音<input type="button" value="获取拼音"
										onclick="getPinyin()" /></label> <input class="form-control"
										type="text" id="pinyinName" />
								</div>
								<div class="form-group">
									<label>手段</label> <select id="method"></select>
								</div>
								<div class="form-group">
									<label>花费</label> <input class="form-control" type="text"
										id="costMin" />
								</div>
								<div class="form-group">
									<label>简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>痛苦程度</label><select id="discomfortIndex"><option
											value="1">无痛苦</option>
										<option value="2">较小痛苦</option>
										<option value="3">较高痛苦</option></select>
								</div>
								<div class="form-group">
									<label>医保<input type="checkbox" id="insurance" /></label>
								</div>
								<div class="form-group">
									<label>周期</label> <input class="form-control" type="text"
										id="cycle" />
								</div>
								<div class="form-group">
									<label>指标</label><span id="index"> </span>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/disease/inspectionList" >返回列表</a>
		</div>
	</div>
</body>
</html>