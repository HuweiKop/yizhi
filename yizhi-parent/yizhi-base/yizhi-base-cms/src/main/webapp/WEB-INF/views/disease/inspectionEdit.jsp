<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../../jquery/common/common.js"></script>
<!-- GOOGLE FONTS-->
<script type="text/javascript" src="../../assets/js/bootstrap.js" /></script>
<!-- BOOTSTRAP STYLES-->
<link href="../../assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="../../assets/css/font-awesome.css" rel="stylesheet" />
<!--CUSTOM BASIC STYLES-->
<link href="../../assets/css/basic.css" rel="stylesheet" />
<!--CUSTOM MAIN STYLES-->
<link href="../../assets/css/custom.css" rel="stylesheet" />
<!--DIALOG STYLES-->
<link href="../../css/dialog.css" rel="stylesheet" />
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
			var diseases = $("#diseases input:checkbox:checked");
			var diseaseIds = new Array();
			for (var i = 0; i < diseases.length; i++) {
				//indexIds += "," + indexs[i].id;
				diseaseIds.push(diseases[i].value);
			}
			var data1 = {
				"inspection" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"fullName" : $("#fullName").val(),
					"pinyinFullName" : $("#pinyinFullName").val(),
					"method" : $("#method").val(),
					"costMin" : $("#costMin").val(),
					"costMax" : $("#costMin").val(),
					"discomfortIndex" : $("#discomfortIndex").val(),
					"isInsurance" : $("#insurance").is(':checked'),
					"type" : $("#type").val(),
					"meaning" : $("#meaning").val(),
					"processing" : $("#type").val(),
					"announcements" : $("#announcements").val(),
					"description" : $("#description").val()
				},
				"indexIds" : indexIds,
				"diseaseIds" : diseaseIds
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
					window.location.href = $("#returnList").attr("href");
				}
			});
		});
	});

	function init() {
		if ($("#inspectionId").val() == "") {
			getIndexs();
			getMethod();
			getDisease();
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
						$("#fullName").val(data.data.inspection.fullName);
						$("#pinyinFullName").val(data.data.inspection.pinyinFullName);
						//$("#method").val(data.data.inspection.method);
						$("#type").val(data.data.inspection.type);
						$("#costMin").val(data.data.inspection.costMin);
						$("#costMax").val(data.data.inspection.costMax);
						$("#discomfortIndex").val(
								data.data.inspection.discomfortIndex);
						$("#insurance").attr("checked",
								data.data.inspection.isInsurance);
						$("#description").val(data.data.inspection.description);
						$("#meaning").val(data.data.inspection.meaning);
						$("#processing").val(data.data.inspection.processing);
						$("#announcements").val(
								data.data.inspection.announcements);
						getIndexs(data.data.indexIds);
						getMethod(data.data.inspection.method);
						getDisease(data.data.diseaseIds);
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
							//html += "<input type='checkbox' id='ind"+data.data[i].id+"' value='"+data.data[i].id+"' />"
								//	+ data.data[i].name + "&nbsp&nbsp</br>";
							html+="<div class=\"checkbox\">"+"<label> <input type=\"checkbox\" value='"+data.data[i].id+"'  id='ind"+data.data[i].id+"'/>"
							+ data.data[i].name +"</label></div>"
						}
						$("#index").append(html);
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
	inspectionEdit
	<input type="hidden" id="inspectionId" value="${inspectionId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑检查</h1>
					<h1 class="page-subhead-line">编辑检查
					<a href="<%=request.getContextPath()%>/web/disease/inspectionList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑检查</div>
						<div class="panel-body">
							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">
												<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">指标列表</h4>
										</div>
										<div
											style="height: 500px; overflow: auto; margin: 5px 0; display: block;"
											class="modal-body" id="index">

										</div>

										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">关闭</button>
										</div>
									</div>
								</div>
							</div>
							<form role="form">
								<div class="form-group">
									<label>检查名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>检查拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>检查全称</label> <input class="form-control" type="text"
										id="fullName" />
								</div>
								<div class="form-group">
									<label>全称拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getFullPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinFullName">
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
									<label>定性/定量<select id="type"><option
												value="1">定性</option>
											<option value="2">定量</option></select></label>
								</div>
								<div class="form-group">
									<label>指标</label>
									<button type="button" class="btn btn-default"
										data-toggle="modal" data-target="#myModal">点击添加</button>
								</div>
								<div class="form-group">
									<label>关联癌症</label><span id="diseases"></span>
								</div>
								<div class="form-group">
									<label>意义</label>
									<textarea class="form-control" rows="3" id="meaning"></textarea>
								</div>
								<div class="form-group">
									<label>检查流程</label>
									<textarea class="form-control" rows="3" id="processing"></textarea>
								</div>
								<div class="form-group">
									<label>注意事项</label>
									<textarea class="form-control" rows="3" id="announcements"></textarea>
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
	<div id="index" class="showDiv">
		<span class="rightTop"><input type="button" value="关闭"
			onclick="closeDiv('index')" /></span>
	</div>
	<div id="fullbg" class="mask"></div>

</body>
</html>