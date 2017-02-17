<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../../jquery/common/common.js"></script>
<!-- JQUERY SCRIPTS -->
<script src="../../assets/js/jquery-1.10.2.js"></script>
<!-- BOOTSTRAP SCRIPTS -->
<script src="../../assets/js/bootstrap.js"></script>
<!-- METISMENU SCRIPTS -->
<script src="../../assets/js/jquery.metisMenu.js"></script>
<!-- CUSTOM SCRIPTS -->
<script src="../../assets/js/custom.js"></script>
<!-- BOOTSTRAP STYLES-->
<link href="../../assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="../../assets/css/font-awesome.css" rel="stylesheet" />
<!--CUSTOM BASIC STYLES-->
<link href="../../assets/css/basic.css" rel="stylesheet" />
<link href="../../assets/css/bootstrap-fileupload.min.css"
	rel="stylesheet" />
<script type="text/javascript">
	var tnmTypeOption = "<option value='1' >T</option><option value='2' >N</option><option value='3' >M</option>";
	var categoryOption = "<input type='checkbox' id='1' />手术&nbsp<input type='checkbox' id='2' />化疗&nbsp<input type='checkbox' id='3' />放疗&nbsp<input type='checkbox' id='4' />靶向治疗"

	$(function() {
		isEdit($("#userAuth").val());
		init();
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
						$("#organFunction")
								.val(data.data.disease.organFunction);
						$("#diseaseExplain").val(
								data.data.disease.diseaseExplain);
						$("#symptom").val(data.data.disease.symptom);
						$("#modeType").val(data.data.disease.modeType);
						$("#earlyStage").val(data.data.disease.earlyStage);
						$("#interimStage").val(data.data.disease.interimStage);
						$("#laterStage").val(data.data.disease.laterStage);
						$("#notes").val(data.data.disease.notes);
						$("#tNotes").val(data.data.disease.tNotes);
						$("#nNotes").val(data.data.disease.nNotes);
						$("#mNotes").val(data.data.disease.mNotes);
						if (data.data.disease.stagePicUrl != ""
								&& data.data.disease.stagePicUrl != null) {
							$("#stagePicPath").val(
									data.data.disease.stagePicUrl);
							if (data.data.disease.stagePicUrl != ""
									&& data.data.disease.stagePicUrl != null) {
								$("#stageImg")
										.attr(
												"src",
												"http://"
														+ $("#zhongmebanBucket")
																.val()
														+ "."
														+ $("#endPoint").val()
														+ "/"
														+ data.data.disease.stagePicUrl);
							}
						}
						var categorys = data.data.categorys;
						$("#category input:checkbox")
								.each(
										function() {
											for (var i = 0; i < categorys.length; i++) {
												if (parseInt($(this).attr(
														"value")) == categorys[i]) {
													$(this).attr("checked",
															true);
												}
											}
										});

						var tnms = data.data.tnms;

						for (var i = 0; i < tnms.length; i++) {
							var tnm = "<span type='"+tnms[i].type+"'><hr><div class=\"form-group\"><label>子分期名称</label>"
									+ "<a  class=\"btn btn-link fileupload-exists \" data-dismiss=\"fileupload\" onclick=\"del(this)\">删除此条分期</a>"
									+ "<input style=\"width: 100%;\" type=\"email\" class=\"form-control\" name='name' value='"
									+ tnms[i].name
									+ "'></div>"
									+ "<div class=\"form-group\"><label>子分期描述</label><textarea style=\"width: 100%;\" class=\"form-control\" rows=\"3\" name='notes'>"
									+ tnms[i].notes
									+ "</textarea></div></span>";
							if (tnms[i].type == 1)
								$("#stageT").append(tnm);
							else if (tnms[i].type == 2)
								$("#stageN").append(tnm);
							else if (tnms[i].type == 3)
								$("#stageM").append(tnm);
						}
						if ($("#stageT span").length > 1) {
							$("#stageT span")[0].remove();
						}
						if ($("#stageN span").length > 1) {
							$("#stageN span")[0].remove();
						}
						if ($("#stageM span").length > 1) {
							$("#stageM span")[0].remove();
						}
					}
				});
	}

	function submit() {
		var id = 0;
		var url = "createDisease";
		if ($("#diseaseId").val() != "") {
			url = "updateDisease";
			id = $("#diseaseId").val();
		}

		var tnms = new Array();
		buildStages(tnms, "stageT");
		buildStages(tnms, "stageN");
		buildStages(tnms, "stageM");

		var categorys = new Array();
		var category = $("#category input:checkbox:checked");
		for (var i = 0; i < category.length; i++) {
			categorys.push(parseInt(category[i].value));
		}

		var data1 = {
			"disease" : {
				"id" : id,
				"name" : $("#name").val(),
				"pinyinName" : $("#pinyinName").val(),
				"organFunction" : $("#organFunction").val(),
				"diseaseExplain" : $("#diseaseExplain").val(),
				"symptom" : $("#symptom").val(),
				"modeType" : $("#modeType").val(),
				"earlyStage" : $("#earlyStage").val(),
				"interimStage" : $("#interimStage").val(),
				"laterStage" : $("#laterStage").val(),
				"notes" : $("#notes").val(),
				"tNotes" : $("#tNotes").val(),
				"nNotes" : $("#nNotes").val(),
				"mNotes" : $("#mNotes").val(),
				"stagePicUrl" : $("#stagePicPath").val()
			},
			"tnms" : tnms,
			"categorys" : categorys
		};
		alert(JSON.stringify(data1));

		$.ajax({
			type : "POST",
			url : url,
			contentType : "application/json",
			data : JSON.stringify(data1),
			dataType : "json",
			success : function(data) {
				if (data.errorCode != 0) {
					alert(data.errorMessage);
				} else {
					alert("ok");
					window.location.href = $("#returnList").attr("href");
				}
			}
		});
	}

	function buildStages(stages, name) {
		var count = 1;
		$("#" + name + " span").each(function() {
			var stage = new Object();
			//qa.id = $(this).attr("id");
			if ($(this).find("input[name=name]").val() != "") {
				stage.type = $(this).attr("type");
				stage.name = $(this).find("input[name=name]").val();
				stage.notes = $(this).find("textarea[name=notes]").val();
				stage.sequence = count++;
				stages.push(stage);
			}
		});
	}

	function addStage(but) {
		var stage = $(but).parent().parent().parent().find("table[name=stage]");
		var tr = "<tr><td>名称<input type='text' name='name' /></td><td>特征<input type='text' name='feature' /></td><td>标准<input type='text' name='standard' /></td><td>序号<input type='text' name='orderBy' /></td><td><input type='button' onclick='delStage(this)' value='删除' /></td></tr>";
		$(stage).append(tr);
	}

	function addStage2(stage, type) {
		var html = "<span type='"+type+"'><hr><div class=\"form-group\"><label>子分期名称</label>"
		+ "<a  class=\"btn btn-link fileupload-exists \" data-dismiss=\"fileupload\" onclick=\"del(this)\">删除此条分期</a>"
				+ " <input style=\"width: 100%;\" type=\"email\" class=\"form-control\" name=\"name\"></div><div class=\"form-group\"><label>子分期描述</label>"
				+ "<textarea style=\"width: 100%;\" class=\"form-control\" rows=\"3\" name=\"notes\"></textarea></div></span>";
		$("#" + stage).append(html);
	}

	function del(del) {
		$(del).parent().parent().remove();
	}

	function addTnm() {
		var tr = "<tr><td>名称<input type='text' name='name' /></td><td>描述<input type='text' name='notes' /></td><td>类型<select name='type' >"
				+ tnmTypeOption
				+ "</select></td><td>序号<input type='text' name='sequence' /></td><td><input type='button' onclick='del(this)' value='删除' /></td></tr>";
		$("#tnm").append(tr);
	}

	function upload() {
		var formdata = new FormData();
		var v_this = $("#fileUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadDiseaseStagePicture";
		//var fileObj=document.getElementById("fileToUpload").files; 
		formdata.append("imgFile", fileObj[0]);
		$.ajax({
			url : url,
			type : 'post',
			data : formdata,
			cache : false,
			contentType : false,
			processData : false,
			dataType : "json",
			success : function(data) {
				alert(data);
				$("#stagePicPath").val(data);
				$("#stageImg").attr(
						"src",
						"http://" + $("#zhongmebanBucket").val() + "."
								+ $("#endPoint").val() + "/" + data);
			}
		});
		return false;
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

	function delPic(img, path) {
		$("#" + img).attr("src", "../../assets/img/demoUpload.jpg");
		$("#" + path).val("");
		$("#fileText").html("未选择文件");
	}

	function changePic(pic, fileText) {
		$("#" + fileText).html(pic.value);
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
					<h1 class="page-head-line">编辑癌症</h1>
					<h1 class="page-subhead-line">
						编辑癌症 <a
							href="<%=request.getContextPath()%>/web/disease/diseaseList"
							id="returnList">返回列表</a>
					</h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<ul class="nav nav-tabs" role="tablist" id="myTab">
						<li role="presentation" class="active"><a href="#home"
							role="tab" data-toggle="tab">癌症基础信息</a></li>
						<li role="presentation"><a href="#profile" role="tab"
							data-toggle="tab">癌症分期信息</a></li>
						<li role="presentation"><a href="#messagesT" role="tab"
							data-toggle="tab">癌症T信息</a></li>
						<li role="presentation"><a href="#messagesN" role="tab"
							data-toggle="tab">癌症N信息</a></li>
						<li role="presentation"><a href="#messagesM" role="tab"
							data-toggle="tab">癌症M信息</a></li>

					</ul>
					<div class="tab-content">
						<!--tabpanel 1 begin -->
						<div role="tabpanel" class="tab-pane active" id="home">
							<div class="panel-body">
								<form role="form">
									<div class="form-group">
										<label>癌症名称</label> <input class="form-control" type="text"
											id="name" />
									</div>
									<div class="form-group">
										<label>癌症拼音</label> <input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
									</div>
									<div class="form-group">
										<label>简介</label>
										<textarea class="form-control" rows="3" id="notes"></textarea>
									</div>
									<div class="form-group">
										<label>治疗方法</label>
										<div id="category">
											<label class=" checkbox-inline"> <input
												type='checkbox' value='1' />手术&nbsp
											</label><label class=" checkbox-inline"> <input
												type='checkbox' value='2' />化疗&nbsp
											</label><label class=" checkbox-inline"> <input
												type='checkbox' value='3' />放疗&nbsp
											</label><label class=" checkbox-inline"> <input
												type='checkbox' value='4' />靶向治疗
											</label>
										</div>
									</div>
									<div class="form-group">
										<label>器官功能</label>
										<textarea class="form-control" rows="3" id="organFunction"></textarea>
									</div>
									<div class="form-group">
										<label>疾病讲解</label>
										<textarea class="form-control" rows="3" id="diseaseExplain"></textarea>
									</div>
									<div class="form-group">
										<label>症状</label>
										<textarea class="form-control" rows="3" id="symptom"></textarea>
									</div>

									<div class="form-group">
										<label class="control-label col-lg-4">分期图片</label>
										<div class="">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<span class="btn btn-file btn-default"> <span
													class="fileupload-new">选取文件</span> <span
													class="fileupload-exists">更换文件</span> <input type="file"
													name="fileName" id="fileUploader"
													onchange="changePic(this,'fileText')">
												</span> <span class="fileupload-preview" id="fileText">
													未选择文件</span> <a href="#" class="close fileupload-exists"
													data-dismiss="fileupload" style="float: none">×</a>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-lg-4"> 仅支持jpg,png图片文件</label>
										<div class="">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<div class="fileupload-new thumbnail"
													style="width: 200px; height: 150px;">
													<img src="../../assets/img/demoUpload.jpg" alt=""
														id="stageImg" /> <input type="hidden" id="stagePicPath" />
												</div>
												<div class="fileupload-preview fileupload-exists thumbnail"
													style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
												<div>
													<span class="btn btn-file btn-primary" onclick="upload()"><span
														class="fileupload-new">上传图片</span></span> <span
														class="btn btn-file btn-primary"
														onclick="delPic('stageImg','stagePicPath')"><span
														class="fileupload-new">删除图片</span></span>

												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="profile">

							<div class="panel-body">

								<form role="form">
									<div class="form-group">
										<label>分型分类</label>
										<textarea class="form-control" rows="3" id="modeType"></textarea>
									</div>
									<div class="form-group">
										<label>早期</label>
										<textarea class="form-control" rows="3" id="earlyStage"></textarea>
									</div>
									<div class="form-group">
										<label>中期</label>
										<textarea class="form-control" rows="3" id="interimStage"></textarea>
									</div>
									<div class="form-group">
										<label>晚期</label>
										<textarea class="form-control" rows="3" id="laterStage"></textarea>
									</div>
								</form>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="messagesT">

							<div class="panel panel-info">
								<div class="panel-heading">T</div>
								<div class="panel-body">

									<form role="form">
										<div class="form-group">
											<label>分期描述</label>
											<textarea class="form-control" rows="3" id="tNotes"></textarea>
										</div>
										<span id="stageT"> <span type='1'>
												<hr>
												<div class="form-group">
													<label>子分期名称</label> <input style="width: 100%;"
														type="email" class="form-control" name="name">
												</div>
												<div class="form-group">
													<label>子分期描述</label>
													<textarea style="width: 100%;" class="form-control"
														rows="3" name="notes"></textarea>

												</div>
										</span></span>
										<div class="form-group">

											<span class="btn btn-file btn-primary"
												onclick="addStage2('stageT',1)"><span
												class="fileupload-new">添加问答</span><input type="button"></span>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="messagesN">

							<div class="panel panel-info">
								<div class="panel-heading">N</div>
								<div class="panel-body">

									<form role="form">
										<div class="form-group">
											<label>分期描述</label>
											<textarea class="form-control" rows="3" id="nNotes"></textarea>
										</div>

										<span id="stageN"> <span type='2'>
												<hr>
												<div class="form-group">
													<label>子分期名称</label> <input style="width: 100%;"
														type="email" class="form-control" name="name">
												</div>
												<div class="form-group">
													<label>子分期描述</label>
													<textarea style="width: 100%;" class="form-control"
														rows="3" name="notes"></textarea>

												</div>
										</span></span>
										<div class="form-group">

											<span class="btn btn-file btn-primary"
												onclick="addStage2('stageN',2)"><span
												class="fileupload-new">添加问答</span><input type="button"></span>
										</div>
									</form>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="messagesM">

							<div class="panel panel-info">
								<div class="panel-heading">M</div>
								<div class="panel-body">

									<form role="form">
										<div class="form-group">
											<label>分期描述</label>
											<textarea class="form-control" rows="3" id="mNotes"></textarea>
										</div>

										<span id="stageM"> <span type='3'>
												<hr>
												<div class="form-group">
													<label>子分期名称</label> <input style="width: 100%;"
														type="email" class="form-control" name="name">
												</div>
												<div class="form-group">
													<label>子分期描述</label>
													<textarea style="width: 100%;" class="form-control"
														rows="3" name="notes"></textarea>

												</div>
										</span></span>
										<div class="form-group">

											<span class="btn btn-file btn-primary"
												onclick="addStage2('stageM',3)"><span
												class="fileupload-new">添加问答</span><input type="button"></span>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<hr>

					<div class="col-md-10">
						<div class="form-inline pull-right">
							<div class=" pagination  ">
								<input type="button" onclick="submit()" value="确认发布"
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