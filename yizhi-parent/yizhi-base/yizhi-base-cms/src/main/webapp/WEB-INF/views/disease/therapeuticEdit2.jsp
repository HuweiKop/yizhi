<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="../../jquery/jquery-2.2.1.min.js"></script>
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
		$("#submit").click(
				function() {
					var id = 0;
					var url = "createTherapeutic";
					if ($("#therapeuticId").val() != "") {
						url = "updateTherapeutic";
						id = $("#therapeuticId").val();
					}
					var diseases = $("#diseases input:checkbox:checked");
					var diseaseIds = new Array();
					for (var i = 0; i < diseases.length; i++) {
						//indexIds += "," + indexs[i].id;
						diseaseIds.push(diseases[i].value);
					}
					var data1 = {
						"therapeutic" : {
							"id" : id,
							"name" : $("#name").val(),
							"pinyinName" : $("#pinyinName").val(),
							"categoryId" : $("#categoryId").val(),
							"categoryType" : $("#categoryId").find(
									"option:selected").attr("type"),
							"advantage" : $("#advantage").val(),
							"disadvantage" : $("#disadvantage").val(),
							"process" : $("#process").val(),
							"prepare" : $("#prepare").val(),
							"operation" : $("#operation").val(),
							"interval" : $("#interval").val(),
							"surgery" : $("#surgery").val(),
							"convalescence" : $("#convalescence").val(),
							"cost" : $("#cost").val(),
							"description" : $("#description").val()
						},
						"diseaseIds":diseaseIds
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
		if ($("#therapeuticId").val() == "") {
			getCategory();
			getDisease();
		}
		else{
			getTherapeutic();
		}
	}

	function getTherapeutic() {
		$.ajax({
			type : "GET",
			url : "getTherapeuticDetail",
			contentType : "application/json",
			data : {
				therapeuticId : $("#therapeuticId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#name").val(data.data.therapeutic.name);
				$("#pinyinName").val(data.data.therapeutic.pinyinName);
				//$("#categoryId").val(data.data.therapeutic.categoryId);
				//$("#categoryType").val(data.data.therapeutic.categoryType);
				$("#advantage").val(data.data.therapeutic.advantage);
				$("#disadvantage").val(data.data.therapeutic.disadvantage);
				$("#process").val(data.data.therapeutic.process);
				$("#prepare").val(data.data.therapeutic.prepare);
				$("#operation").val(data.data.therapeutic.operation);
				$("#interval").val(data.data.therapeutic.interval);
				$("#surgery").val(data.data.therapeutic.surgery);
				$("#convalescence").val(data.data.therapeutic.convalescence);
				$("#cost").val(data.data.therapeutic.cost);
				$("#description").val(data.data.therapeutic.description);

				getCategory(data.data.therapeutic.categoryId);
				getDisease(data.data.diseaseIds);
			}
		});
	}

	function getCategory(categoryId) {
		$.ajax({
			type : "GET",
			url : "getTherapeuticCategoryList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<option value='"+data.data[i].id+"' type='"+data.data[i].type+"' >"
							+ data.data[i].name + "</option>";
				}
				$("#categoryId").html(html);
				$("#categoryId").val(categoryId);
			}
		});
	}
	
	function getDisease(diseaseIds){
		$.ajax({
			type : "GET",
			url : "getDiseaseList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<input type='checkbox' id='dis"+data.data[i].id+"' value='"+data.data[i].id+"' />"
					+ data.data[i].name+"&nbsp&nbsp";
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
	therapeuticEdit
	<input type="hidden" id="therapeuticId" value="${therapeuticId}" />
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
									<label>治疗方法名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>治疗方法拼音<input type="button" value="获取拼音"
										onclick="getPinyin()" /></label> <input class="form-control"
										type="text" id="pinyinName" />
								</div>
								<div class="form-group">
									<label>治疗类型</label><select id="categoryId"></select>
								</div>
								<div class="form-group">
									<label>简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>优势</label>
									<textarea class="form-control" rows="3" id="advantage"></textarea>
								</div>
								<div class="form-group">
									<label>劣势</label>
									<textarea class="form-control" rows="3" id="disadvantage"></textarea>
								</div>
								<div class="form-group">
									<label>步骤</label>
									<textarea class="form-control" rows="3" id="process"></textarea>
								</div>
								<div class="form-group">
									<label>准备期</label>
									<textarea class="form-control" rows="3" id="prepare"></textarea>
								</div>
								<div class="form-group">
									<label>操作期</label>
									<textarea class="form-control" rows="3" id="operation"></textarea>
								</div>
								<div class="form-group">
									<label>隔离期</label>
									<textarea class="form-control" rows="3" id="interval"></textarea>
								</div>
								<div class="form-group">
									<label>手术期</label>
									<textarea class="form-control" rows="3" id="surgery"></textarea>
								</div>
								<div class="form-group">
									<label>康复期</label>
									<textarea class="form-control" rows="3" id="convalescence"></textarea>
								</div>
								<div class="form-group">
									<label>癌症</label><span id="diseases"> </span>
								</div>
								<div class="form-group">
									<label>花费</label> <input class="form-control" type="text"
										id="cost" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/disease/therapeuticList" >返回列表</a>
		</div>
	</div>
</body>
</html>