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
<!--CUSTOM MAIN STYLES-->
<link href="../../assets/css/custom.css" rel="stylesheet" />
<link href="../../jquery/jQuery-video5.8/css/video-js.min.css"
	rel="stylesheet" type="text/css">
<link href="../../assets/css/bootstrap-fileupload.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="../../jquery/jQuery-video5.8/js/video.min.js"></script>
<script type="text/javascript">
	$(function() {

		isEdit($("#userAuth").val());
		init();
		$("#submit").click(function() {
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

			var qas = new Array();
			buildQas(qas, "advantageQa");
			buildQas(qas, "disadvantageQa");
			buildQas(qas, "SurgeryPrepareQa");
			buildQas(qas, "AnaesthesiaMethodQa");
			buildQas(qas, "RoughlyFolwQa");
			buildQas(qas, "ResectionScopeQa");
			buildQas(qas, "SurgeryRecoverQa");
			buildQas(qas, "NurseCharacteristicQa");
			var data1 = {
				"therapeutic" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"notes" : $("#notes").val(),
					"categoryId" : 1,
					"categoryType" : 1
				},
				"extend" : {
					"id" : $("#extendId").val(),
					"url" : $("#filePath").val(),
					"title" : $("#title").val(),
					"picUrl" : $("#PicPath").val(),
					"notes" : $("#videoNotes").val()
				},
				"diseaseIds" : diseaseIds,
				"qaDbs" : qas
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

	function buildQas(qas, name) {
		var count = 1;
		$("#" + name + " span").each(function() {
			var qa = new Object();
			//qa.id = $(this).attr("id");
			if ($(this).find("input[name=question]").val() != "") {
				qa.category = $(this).attr("category");
				qa.question = $(this).find("input[name=question]").val();
				qa.answer = $(this).find("textarea[name=answer]").val();
				qa.sequence = count++;
				qas.push(qa);
			}
		});
	}

	function init() {
		if ($("#therapeuticId").val() == "") {
			getCategory();
			getDisease();
		} else {
			getTherapeutic();
		}
	}

	function getTherapeutic() {
		$
				.ajax({
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
						$("#notes").val(data.data.therapeutic.notes);

						if (data.data.extend != null) {
							$("#extendId").val(data.data.extend.id);
							$("#filePath").val(data.data.extend.url);
							$("#videoNotes").val(data.data.extend.notes);
							if (data.data.extend.picUrl != null
									&& data.data.extend.picUrl != "") {
								$("#Img")
										.attr(
												"src",
												"http://"
														+ $("#zhongmebanBucket")
																.val()
														+ "."
														+ $("#endPoint").val()
														+ "/"
														+ data.data.extend.picUrl);
							}
							$("#title").val(data.data.extend.title);
							$("#surgeryVideo").attr(
									"src",
									"http://" + $("#zhongmebanBucket").val()
											+ "." + $("#endPoint").val() + "/"
											+ data.data.extend.url);
							videojs("example_video1", {}, function() {
								// Player (this) is initialized and ready.
							});
						}

						var qas = data.data.qaDbs;
						for (var i = 0; i < qas.length; i++) {
							var qa = "<span category='"+qas[i].category+"'><div class=\"form-group\"><label>问题</label>"
									+ "<a  class=\"btn btn-link fileupload-exists \" data-dismiss=\"fileupload\" onclick=\"del(this)\">删除此条问答</a>"
									+ "<input style=\"width: 100%;\" type=\"email\" class=\"form-control\" name='question' value='"
									+ qas[i].question
									+ "'></div>"
									+ "<div class=\"form-group\"><label>答案</label><textarea style=\"width: 100%;\" class=\"form-control\" rows=\"3\" name='answer'>"
									+ qas[i].answer
									+ "</textarea></div><hr></span>";
							if (qas[i].category == 107)
								$("#advantageQa").append(qa);
							else if (qas[i].category == 108)
								$("#disadvantageQa").append(qa);
							else if (qas[i].category == 109)
								$("#SurgeryPrepareQa").append(qa);
							else if (qas[i].category == 110)
								$("#AnaesthesiaMethodQa").append(qa);
							else if (qas[i].category == 111)
								$("#RoughlyFolwQa").append(qa);
							else if (qas[i].category == 106)
								$("#ResectionScopeQa").append(qa);
							else if (qas[i].category == 112)
								$("#SurgeryRecoverQa").append(qa);
							else if (qas[i].category == 113)
								$("#NurseCharacteristicQa").append(qa);
						}
						if ($("#advantageQa span").length > 1) {
							$("#advantageQa span")[0].remove();
						}
						if ($("#disadvantageQa span").length > 1) {
							$("#disadvantageQa span")[0].remove();
						}
						if ($("#SurgeryPrepareQa span").length > 1) {
							$("#SurgeryPrepareQa span")[0].remove();
						}
						if ($("#AnaesthesiaMethodQa span").length > 1) {
							$("#AnaesthesiaMethodQa span")[0].remove();
						}
						if ($("#RoughlyFolwQa span").length > 1) {
							$("#RoughlyFolwQa span")[0].remove();
						}
						if ($("#ResectionScopeQa span").length > 1) {
							$("#ResectionScopeQa span")[0].remove();
						}
						if ($("#SurgeryRecoverQa span").length > 1) {
							$("#SurgeryRecoverQa span")[0].remove();
						}
						if ($("#NurseCharacteristicQa span").length > 1) {
							$("#NurseCharacteristicQa span")[0].remove();
						}

						//getCategory(data.data.therapeutic.categoryId);
						getDisease(data.data.diseaseIds);
					}
				});
	}

	function getCategory(categoryId) {
		$
				.ajax({
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

	function getDisease(diseaseIds) {
		$
				.ajax({
					type : "GET",
					url : "getDiseaseList",
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

	function addQa(table, category) {
		var tr = "<tr category='"+category+"'><td>问题<input type='text' name='question' /></td><td>回答<input type='text' name='answer' /></td><td>序号<input type='text' name='sequence' /></td><td><input type='button' onclick='del(this)' value='删除' /></td></tr>";
		$("#" + table).append(tr);
	}

	function addQa2(table, category) {
		var span = "<span category='"+category+"'><div class=\"form-group\"><label>问题</label>"
				+ "<a  class=\"btn btn-link fileupload-exists \" data-dismiss=\"fileupload\" onclick=\"del(this)\">删除此条问答</a>"
				+ "<input style=\"width: 100%;\" type=\"email\" class=\"form-control\" name='question' ></div>"
				+ "<div class=\"form-group\"><label>答案</label><textarea style=\"width: 100%;\" class=\"form-control\" rows=\"3\" name='answer'></textarea></div><hr></span>";
		$("#" + table).append(span);
	}

	function del(del) {
		$(del).parent().parent().remove();
	}

	function upload() {
		var formdata = new FormData();
		var v_this = $("#fileUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadSurgeryVideo";
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
				$("#filePath").val(data);
				$("#surgeryVideo").attr(
						"src",
						"http://" + $("#zhongmebanBucket").val() + "."
								+ $("#endPoint").val() + "/" + data);
				videojs("example_video1", {}, function() {
					// Player (this) is initialized and ready.
				});
				alert($("#surgeryVideo").attr("src"));
			}
		});
		return false;
	}

	function picUpload() {
		var formdata = new FormData();
		var v_this = $("#filePicUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadSurgeryPic";
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
				$("#PicPath").val(data);
				$("#Img").attr(
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
	
	function changePic(pic, fileText){
		$("#"+fileText).html(pic.value);
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
					<h1 class="page-head-line">编辑手术</h1>
					<h1 class="page-subhead-line">编辑手术
<a id="returnList" href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=1">返回列表</a></h1>
				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-12 col-sm-8 col-xs-12">

					<ul class="nav nav-tabs" role="tablist" id="myTab">
						<li role="presentation" class="active"><a href="#home"
							role="tab" data-toggle="tab">基础信息</a></li>
						<li role="presentation"><a href="#profile" role="tab"
							data-toggle="tab">视频管理</a></li>
						<li role="presentation"><a href="#advantage" role="tab"
							data-toggle="tab">优势管理</a></li>
						<li role="presentation"><a href="#disadvantage" role="tab"
							data-toggle="tab">劣势管理</a></li>
						<li role="presentation"><a href="#SurgeryPrepare" role="tab"
							data-toggle="tab">术前准备</a></li>
						<li role="presentation"><a href="#AnaesthesiaMethod"
							role="tab" data-toggle="tab">麻醉方式</a></li>
						<li role="presentation"><a href="#RoughlyFolw" role="tab"
							data-toggle="tab">大致流程</a></li>
						<li role="presentation"><a href="#ResectionScope" role="tab"
							data-toggle="tab">切除范围</a></li>
						<li role="presentation"><a href="#SurgeryRecover" role="tab"
							data-toggle="tab">术后恢复</a></li>
						<li role="presentation"><a href="#NurseCharacteristic"
							role="tab" data-toggle="tab">护理特点</a></li>


					</ul>
					<div class="tab-content">
						<!--tabpanel 1 begin -->
						<div role="tabpanel" class="tab-pane active" id="home">
							<div class="panel-body">
								<form role="form">
									<div class="form-group">
										<label>手术名称</label> <input style="width: 60%;"
											class="form-control" type="text" id="name" />
									</div>
									<div class="form-group">
										<label>手术拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()" /> <input class="form-control"
											type="text" id="pinyinName" style="width: 50%;" />
									</div>
									<div class="form-group">
										<label>概述</label>
										<textarea style="width: 60%;" class="form-control" rows="3"
											id="notes"></textarea>
									</div>
									<div class="form-group" style="width: 60%;">
										<label>关联癌症</label>
										<div id="diseases"></div>
									</div>
								</form>
							</div>

						</div>
						<!--tabpanel 1 end -->
						<!--tabpanel 1 end -->

						<div role="tabpanel" class="tab-pane" id="profile">

							<div class="panel-body">
								<form role="form">


									<div class="form-group">
										<label class="control-label col-lg-4">视频</label>
										<div class="">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<span class="btn btn-file btn-default"> <span
													class="fileupload-new">选取文件</span> <span
													class="fileupload-exists">更换文件</span> <input type="file"
													id="fileUploader" onchange="changePic(this,'videoText')">
												</span> <span class="fileupload-preview" id="videoText"> 未选择文件</span> <a href="#"
													class="close fileupload-exists" data-dismiss="fileupload"
													style="float: none">×</a>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-lg-4"> 仅支持.MP4文件</label>
										<div class="">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<input type="hidden" id="extendId" />

												<video id="example_video1" class="video-js vjs-default-skin"
													controls preload="none" width="200px" height="150px"
													poster="http://video-js.zencoder.com/oceans-clip.png">
												<source id="surgeryVideo" src="" type='video/mp4' /></video>
												<input type="hidden" id="filePath" />
												<div>
													<span class="btn btn-file btn-primary" onclick="upload()"><span
														class="fileupload-new">上传视频</span></span> <a href="#"
														class="btn btn-link fileupload-exists"
														data-dismiss="fileupload">重置视频</a>

												</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label>标题</label> <input class="form-control" type="text"
											id="title" />
									</div>
									<div class="form-group">
										<label>概述</label>
										<textarea class="form-control" rows="3" id="videoNotes"></textarea>
									</div>


									<div class="form-group">
										<label class="control-label col-lg-4">视频图片</label>
										<div class="">
											<div class="fileupload fileupload-new"
												data-provides="fileupload">
												<span class="btn btn-file btn-default"> <span
													class="fileupload-new">选取文件</span> <span
													class="fileupload-exists">更换文件</span> <input type="file"
													name="fileName" id="filePicUploader" onchange="changePic(this,'fileText')">
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
													<img src="../../assets/img/demoUpload.jpg" alt="" id="Img" />
													<input type="hidden" id="PicPath" />
												</div>
												<div class="fileupload-preview fileupload-exists thumbnail"
													style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
												<div>
													<span class="btn btn-file btn-primary"
														onclick="picUpload()"><span class="fileupload-new">上传图片</span></span>
													<span class="btn btn-file btn-primary"
														onclick="delPic('Img','PicPath')"><span
														class="fileupload-new">删除图片</span></span>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="advantage">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">优势管理</div>
								<div class="panel-body" id="advantageQa">
									<span category='107'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>

										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('advantageQa',107)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="disadvantage">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">劣势管理</div>
								<div class="panel-body" id="disadvantageQa">
									<span category='108'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('disadvantageQa',108)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="SurgeryPrepare">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">术前准备</div>
								<div class="panel-body" id="SurgeryPrepareQa">
									<span category='109'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('SurgeryPrepareQa',109)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="AnaesthesiaMethod">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">麻醉方式</div>
								<div class="panel-body" id="AnaesthesiaMethodQa">
									<span category='110'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('AnaesthesiaMethodQa',110)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="RoughlyFolw">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">大致流程</div>
								<div class="panel-body" id="RoughlyFolwQa">
									<span category='111'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('RoughlyFolwQa',111)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="ResectionScope">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">切除范围</div>
								<div class="panel-body" id="ResectionScopeQa">
									<span category='106'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('ResectionScopeQa',106)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="SurgeryRecover">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">术后恢复</div>
								<div class="panel-body" id="SurgeryRecoverQa">
									<span category='112'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('SurgeryRecoverQa',112)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
						</div>

						<div role="tabpanel" class="tab-pane" id="NurseCharacteristic">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">护理特点</div>
								<div class="panel-body" id="NurseCharacteristicQa">
									<span category='113'>
										<div class="form-group">
											<label>问题</label> <input style="width: 100%;" type="email"
												class="form-control" name='question'>

										</div>
										<div class="form-group">
											<label>答案</label>
											<textarea style="width: 100%;" class="form-control" rows="3"
												name='answer'></textarea>
										</div>
										<hr>
									</span>

								</div>
								<div class="form-group">

									<span class="btn btn-file btn-primary"
										onclick="addQa2('NurseCharacteristicQa',113)"><span
										class="fileupload-new">添加问答</span><input type="button"></span>
								</div>
							</div>
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