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
<link href="../../assets/css/bootstrap-fileupload.min.css"
	rel="stylesheet" />
<script type="text/javascript">
	$(function() {
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(function() {
			var id = 0;
			var url = "createHospital";
			if ($("#hospitalId").val() != "") {
				url = "updateHospital";
				id = $("#hospitalId").val();
			}

			var departments = new Array();
			$("#departments tr").each(function() {
				var dep = new Object();
				dep.id = $(this).attr("id");
				dep.name = $(this).find("input[name=departmentName]").val();
				dep.bedNum = $(this).find("input[name=bedNum]").val();
				departments.push(dep);
			});

			var data1 = {
				"hospital" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"address" : $("#address").val(),
					"description" : $("#description").val(),
					"level" : $("#level").val(),
					"description" : $("#description").val(),
					"picture" : $("#picPath").val()
				},
				"departments" : departments
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

		$("#addDepartment").click(addDepartment);
	});

	function init() {
		$
				.ajax({
					type : "GET",
					url : "getHospitalDetail",
					contentType : "application/json",
					data : {
						hospitalId : $("#hospitalId").val()
					},
					dataType : "json",
					success : function(data) {
						$("#name").val(data.data.hospital.name);
						$("#pinyinName").val(data.data.hospital.pinyinName);
						$("#address").val(data.data.hospital.address);
						$("#description").val(data.data.hospital.description);
						$("#level").val(data.data.hospital.level);
						$("#description").val(data.data.hospital.description);
						$("#picPath").val(data.data.hospital.picture);
						if (data.data.hospital.picture != ""&&data.data.hospital.picture!=null) {
							$("#picImg").attr(
									"src",
									"http://" + $("#zhongmebanBucket").val()
											+ "." + $("#endPoint").val() + "/"
											+ data.data.hospital.picture);
						}
						var deps = data.data.departments;
						for (var i = 0; i < deps.length; i++) {
							var tr = "<tr id='"+deps[i].id+"'><td>名称<input type='text' name='departmentName' value='"+deps[i].name+"' /></td><td>床位<input type='text' name='bedNum' value='"+deps[i].bedNum+"'  /></td><td><input type='button' onclick='delDepartment(this)' value='删除' /></td></tr>";
							$("#departments").append(tr);
						}
					}
				});
	}

	function addDepartment() {
		var tr = "<tr><td>名称<input type='text' name='departmentName' /></td><td>床位<input type='text' name='bedNum' /></td><td><input type='button' onclick='delDepartment(this)' value='删除' /></td></tr>";
		$("#departments").append(tr);
	}

	function delDepartment(del) {
		$(del).parent().parent().remove();
	}

	function upload() {
		var formdata = new FormData();
		var v_this = $("#fileUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadHospitalPicture";
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
				$("#picPath").val(data);
				$("#picImg").attr(
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
	<input type="hidden" value="${hospitalId }" id="hospitalId" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑医院</h1>
					<h1 class="page-subhead-line">编辑医院
					<a href="<%=request.getContextPath()%>/web/hospital/hospitalList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑医院</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>医院名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>医院拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>医院地址</label>
									<textarea class="form-control" rows="3" id="address"></textarea>
								</div>
								<div class="form-group">
									<label>医院简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>医院等级</label><select id="level">
										<option value="0">其他</option>
										<option value="10">一级</option>
										<option value="20">二级</option>
										<option value="29">二级甲等</option>
										<option value="28">二级乙等</option>
										<option value="30">三级</option>
										<option value="39">三级甲等</option>
										<option value="38">三级乙等</option>
									</select>
								</div>
								<div class="form-group">
									<label>科室<input type="button" id="addDepartment"
										value="添加" /></label>
									<table id="departments">
									</table>
								</div>

								<div class="form-group">
									<label class="control-label col-lg-4">医院图片</label>
									<div class="">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<span class="btn btn-file btn-default"> <span
												class="fileupload-new">选取文件</span> <span
												class="fileupload-exists">更换文件</span> <input type="file"
												name="fileName" id="fileUploader" onchange="changePic(this,'fileText')">
											</span> <span class="fileupload-preview" id="fileText"> 未选择文件</span>
											<a href="#" class="close fileupload-exists"
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
													id="picImg" /> <input type="hidden" id="picPath" />
											</div>
											<div class="fileupload-preview fileupload-exists thumbnail"
												style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-file btn-primary" onclick="upload()"><span
													class="fileupload-new">上传图片</span></span>
												<span class="btn btn-file btn-primary" onclick="delPic('picImg','picPath')"><span
													class="fileupload-new">删除图片</span></span>

											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
					<hr>

					<div class="col-md-10">
						<div class="form-inline pull-right">
							<div class=" pagination  ">
								<input type="button"  id="submit" value="确认发布"
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