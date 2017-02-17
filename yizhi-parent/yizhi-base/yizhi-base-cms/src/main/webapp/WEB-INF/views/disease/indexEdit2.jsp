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
			var url = "createIndex";
			if ($("#indexId").val() != "") {
				url = "updateIndex";
				id = $("#indexId").val();
			}
			var diseases = $("#disease tr");
			var diseaseIds = new Array();
			$("#disease tr").each(function() {
				var dis = $(this).find("select[name=diseaseId]")[0];
				var model = $(this).find("select[name=model]")[0];
				var stage = $(this).find("select[name=stage]")[0];
				var disease = new Object();
				disease.diseaseId = dis.value;
				disease.modelId = model.value;
				disease.stage = stage.value;
				diseaseIds.push(disease);
			});
			var data1 = {
				"index" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"result" : $("#result").val(),
					"normalMin" : $("#normalMin").val(),
					"normalMax" : $("#normalMin").val(),
					"unit" : $("#unit").val(),
					"cycle" : $("#cycle").val(),
					"description" : $("#description").val()
				},
				"diseases" : diseaseIds
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
				$("#result").val(data.data.index.result);
				$("#normalMin").val(data.data.index.normalMin);
				$("#normalMax").val(data.data.index.normalMax);
				$("#unit").val(data.data.index.unit);
				$("#cycle").val(data.data.index.cycle);
				$("#description").val(data.data.index.description);

				getDisease(data.data.diseases);
			}
		});
	}

	function getDisease(diseases) {
		$.ajax({
			type : "GET",
			url : "getDiseaseList",
			contentType : "application/json",
			data : {
				indexId : $("#indexId").val()
			},
			dataType : "json",
			success : function(data) {
				var disease = "";
				dis = data.data;
				for (var j = 0; j < dis.length; j++) {
					disease += "<option value='"+dis[j].id+"' >" + dis[j].name
							+ " </option>";
				}
				if (diseases === undefined) {
					addDiseaseTr(disease);
				}
				for (var i = 0; i < diseases.length; i++) {
					addDiseaseTr(disease, diseases[i].diseaseId,
							diseases[i].modelId, diseases[i].stage);
				}
			}
		});
	}

	function addDiseaseTr(disease, diseaseId, modelId, stageId) {
		var tr = "<tr><td>癌症<select name='diseaseId' onchange='changeDisease(this)' >"
				+ disease
				+ "</select></td><td>分型<select name='model' onchange='changeModel(this)' ></select></td><td>分期<select name='stage' ></select></td><td><input type='button' onclick='delDisease(this)' value='删除' /></td></tr>";
		$("#disease").append(tr);
		var dis = $("#disease").find("tr:last").find("select[name=diseaseId]");
		$(dis).val(diseaseId);

		changeDisease(dis, modelId, stageId);
	}

	function addDisease() {
		getDisease();
		$.ajax({
			type : "GET",
			url : "getDiseaseList",
			contentType : "application/json",
			data : {
				indexId : $("#indexId").val()
			},
			dataType : "json",
			success : function(data) {
				var disease = "";
				dis = data.data;
				for (var j = 0; j < dis.length; j++) {
					disease += "<option value='"+dis[j].id+"' >" + dis[j].name
							+ " </option>";
				}
				if (diseases === undefined) {
					addDiseaseTr(disease);
				}
				for (var i = 0; i < diseases.length; i++) {
					addDiseaseTr(disease, diseases[i].diseaseId);
				}
			}
		});
	}

	function delDisease(del) {
		$(del).parent().parent().remove();
	}

	function changeDisease(dis, modelId, stageId) {
		$
				.ajax({
					type : "GET",
					url : "getDiseaseModelList",
					contentType : "application/json",
					data : {
						diseaseId : $(dis).val()
					},
					dataType : "json",
					success : function(data) {
						var models = "";
						dms = data.data;
						for (var j = 0; j < dms.length; j++) {
							models += "<option value='"+dms[j].id+"' >"
									+ dms[j].name + " </option>";
						}
						var model = $(dis).parent().parent().find(
								"select[name=model]");
						model.html(models);
						if (modelId !== undefined) {
							model.val(modelId);
						}
						changeModel(model, stageId);

					}
				});
	}

	function changeModel(model, stageId) {
		var dis = $(model).parent().parent().find("select[name=diseaseId]");
		$.ajax({
			type : "GET",
			url : "getDiseaseStageList",
			contentType : "application/json",
			data : {
				diseaseId : $(dis).val(),
				modelId : $(model).val()
			},
			dataType : "json",
			success : function(data) {
				var stages = "";
				st = data.data;
				for (var j = 0; j < st.length; j++) {
					stages += "<option value='"+st[j].id+"' >" + st[j].name
							+ " </option>";
				}
				var stage = $(model).parent().parent().find(
						"select[name=stage]");
				stage.html(stages);
				if (stageId !== undefined) {
					stage.val(stageId);
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
	indexEdit
	<input type="hidden" id="indexId" value="${indexId}" />
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
									<label>指标名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>指标拼音<input type="button" value="获取拼音"
										onclick="getPinyin()" /></label> <input class="form-control"
										type="text" id="pinyinName" />
								</div>
								<div class="form-group">
									<label>结果分析</label>
									<textarea class="form-control" rows="3" id="result"></textarea>
								</div>
								<div class="form-group">
									<label>简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>癌症<input type="button" value="添加"
										onclick="addDisease()" /></label>
									<table id="disease"></table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/disease/indexList" >返回列表</a>
		</div>
	</div>
</body>
</html>