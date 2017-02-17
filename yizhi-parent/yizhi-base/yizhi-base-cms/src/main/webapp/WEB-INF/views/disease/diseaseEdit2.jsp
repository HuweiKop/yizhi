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
			var url = "createDisease";
			if ($("#diseaseId").val() != "") {
				url = "updateDisease";
				id = $("#diseaseId").val();
			}

			var models = new Array();
			$("#models table[name=model]").each(function(){
				var md = new Object();
				var model = new Object();
				model.id = $(this).attr("modelId");
				model.name=$(this).find("input[name=modelName]").val();
				var stages = new Array();
				$(this).find("table[name=stage] tr").each(function(){
					var stage = new Object();
					stage.id = $(this).attr("id");
					stage.name = $(this).find("input[name=name]").val();
					stage.feature = $(this).find("input[name=feature]").val();
					stage.standard = $(this).find("input[name=standard]").val();
					stage.orderBy = $(this).find("input[name=orderBy]").val();
					stages.push(stage);
				});
				md.stages = stages;
				md.model = model;
				models.push(md);
			});
			
			var stages = new Array();
			$("#stages tr").each(function() {
				var stage = new Object();
				stage.id = $(this).attr("id");
				stage.name = $(this).find("input[name=name]").val();
				stage.feature = $(this).find("input[name=feature]").val();
				stage.standard = $(this).find("input[name=standard]").val();
				stage.orderBy = $(this).find("input[name=orderBy]").val();
				stages.push(stage);
			});

			var data1 = {
				"disease" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"diseasePosition" : $("#position").val(),
					"feature" : $("#feature").val(),
					"description" : $("#description").val()
				},
				"models" : models,
				"stages" : stages
			};
			alert(JSON.stringify(data1));
			
			$.ajax({
				type : "POST",
				url : url,
				contentType : "application/json",
				data : JSON.stringify(data1),
				dataType : "json",
				success : function(data) {
					if(data.errorCode!=0){
						alert(data.errorMessage);
					}
					else{alert("ok");}
				}
			});
		});
	});

	function init() {
		if ($("#diseaseId").val() == "")
			return;
		$
				.ajax({
					type : "GET",
					url : "getDiseaseDetail",
					contentType : "application/json",
					data : {
						diseaseId : $("#diseaseId").val()
					},
					dataType : "json",
					success : function(data) {
						$("#name").val(data.data.disease.name);
						$("#pinyinName").val(data.data.disease.pinyinName);
						$("#position").val(data.data.disease.diseasePosition);
						$("#feature").val(data.data.disease.feature);
						$("#description").val(data.data.disease.description);

						//var stages = data.data.stages;
						

						var models = data.data.models;
						for (var i = 0; i < models.length; i++) {
							var table = "<tr><td><table name='model' modelId='"+models[i].model.id+"'><tr><td>名称<input type='text' name='modelName' value='"+models[i].model.name+"' />分期<input type='button' onclick='addStage(this)' value='添加分期' /></td></tr><tr><td><table name='stage'>";
							var tr = "";
							for (var j = 0; j < models[i].stages.length; j++) {
								var stage = models[i].stages[j];
								tr += "<tr id='"+stage.id+"'><td>名称<input type='text' name='name' value='"+stage.name
								+"' /></td><td>特征<input type='text' name='feature' value='"+stage.feature
								+"'  /></td><td>标准<input type='text' name='standard' value='"+stage.standard
								+"'  /></td><td>序号<input type='text' name='orderBy' value='"+stage.orderBy
								+"'  /></td><td><input type='button' onclick='delStage(this)' value='删除' /></td></tr>";
							}
							table = table + tr
									+ "</table></td></tr></table></td></tr>";
							$("#models").append(table);
						}
					}
				});
	}

	function addStage(but) {
		var stage = $(but).parent().parent().parent().find("table[name=stage]");
		var tr = "<tr><td>名称<input type='text' name='name' /></td><td>特征<input type='text' name='feature' /></td><td>标准<input type='text' name='standard' /></td><td>序号<input type='text' name='orderBy' /></td><td><input type='button' onclick='delStage(this)' value='删除' /></td></tr>";
		$(stage).append(tr);
	}

	function delStage(del) {
		$(del).parent().parent().remove();
	}

	function addModel() {
		var table = "<tr><td><table name='model' ><tr><td>名称<input type='text' name='modelName' />分期<input type='button' onclick='addStage(this)' value='添加分期' /></td></tr><tr><td><table name='stage'></table></td></tr></table></td></tr>";
		$("#models").append(table);
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
	DiseaseEdit
	<input type="hidden" id="diseaseId" value="${diseaseId}" />
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
									<label>癌症名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>癌症拼音<input type="button" value="获取拼音"
										onclick="getPinyin()" /></label> <input class="form-control"
										type="text" id="pinyinName" />
								</div>
								<div class="form-group">
									<label>位置</label> <input class="form-control" type="text"
										id="position" />
								</div>
								<div class="form-group">
									<label>特征</label>
									<textarea class="form-control" rows="3" id="feature"></textarea>
								</div>
								<div class="form-group">
									<label>简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>分期<input type="button" onclick="addModel()"
										value="添加" /></label>
									<table id="models">
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/disease/diseaseList" >返回列表</a>
		</div>
	</div>
</body>
</html>