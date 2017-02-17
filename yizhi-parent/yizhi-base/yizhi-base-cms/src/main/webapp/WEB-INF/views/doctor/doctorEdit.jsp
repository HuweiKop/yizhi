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
			var url = "createDoctor";
			if ($("#doctorId").val() != "") {
				url = "updateDoctor";
				id = $("#doctorId").val();
			}
			var diseases = $("#diseases input:checkbox:checked");
			var diseaseIds = new Array();
			for (var i = 0; i < diseases.length; i++) {
				//indexIds += "," + indexs[i].id;
				diseaseIds.push(diseases[i].value);
			}
			var surgery = $("#surgery input:checkbox:checked");
			var surgeryIds = new Array();
			for (var i = 0; i < surgery.length; i++) {
				//indexIds += "," + indexs[i].id;
				surgeryIds.push(surgery[i].value);
			}
			var hospitals = new Array();
			var hospital = new Object();
			hospital.hospitalId = $("#hospitalId").val();
			hospital.departmentId = $("#departmentId").val();
			hospital.title = $("#title").val();
			hospitals.push(hospital);

			var works = new Array();
			$("#workTime tr").each(function() {
				var work = new Object();
				work.id = $(this).attr("id");
				work.week = $(this).find("select[name=week]").val();
				work.time = $(this).find("select[name=time]").val();
				work.type = $(this).find("select[name=type]").val();
				works.push(work);
			});

			var data1 = {
				"doctor" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"avatar" : $("#picPath").val(),
					"description" : $("#description").val()
				},
				"diseaseIds" : diseaseIds,
				"therapeuticIds" : surgeryIds,
				"fee" : {
					"normalFee" : $("#normalFee").val(),
					"specialFee" : $("#specialFee").val(),
					"expertFee" : $("#expertFee").val(),
				},
				"hospitals" : hospitals,
				"works" : works
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

		$("#hospitalId").change(getDepartment);
	});

	function init() {
		if ($("#doctorId").val() == "") {
			getDisease();
			getTherapeutic();
			getHospital();
		} else {
			getDoctor();
		}
	}

	function getDoctor() {
		$
				.ajax({
					type : "GET",
					url : "getDoctorDetail",
					contentType : "application/json",
					data : {
						doctorId : $("#doctorId").val()
					},
					dataType : "json",
					success : function(data) {
						$("#name").val(data.data.doctor.name);
						$("#pinyinName").val(data.data.doctor.pinyinName);
						$("#avatar").val(data.data.doctor.avatar);
						$("#description").val(data.data.doctor.description);
						if (data.data.fee != null) {
							$("#normalFee").val(data.data.fee.normalFee);
							$("#specialFee").val(data.data.fee.specialFee);
							$("#expertFee").val(data.data.fee.expertFee);
						}
						$("#picPath").val(data.data.doctor.avatar);
						if (data.data.doctor.avatar != ""&&data.data.doctor.avatar!=null) {
							$("#picImg").attr(
									"src",
									"http://" + $("#zhongmebanBucket").val()
											+ "." + $("#endPoint").val() + "/"
											+ data.data.doctor.avatar);
						}
						var works = data.data.works;
						if (works != null) {
							for (var i = 0; i < works.length; i++) {
								var tr = "<tr><td>星期<select name='week' ><option value='1' >星期一</option><option value='2' >星期二</option><option value='3' >星期三</option>"
										+ "<option value='4' >星期四</option><option value='5' >星期五</option><option value='6' >星期六</option><option value='7' >星期日</option></select></td>"
										+ "<td>时间<select name='time' ><option value='1' >上午</option><option value='2' >下午</option></select></td>"
										+ "<td>类型<select name='type' ><option value='1' >普通</option><option value='2' >专家</option><option value='3' >特需</option></select></td>"
										+ "<td><input type='button' onclick='delWorkTime(this)' value='删除' /></td></tr>";
								$("#workTime").append(tr);
								$("#workTime tr").eq(i).find(
										"select[name=week]").val(works[i].week);
								$("#workTime tr").eq(i).find(
										"select[name=time]").val(works[i].time);
								$("#workTime tr").eq(i).find(
										"select[name=type]").val(works[i].type);
							}
						}
						getDisease(data.data.diseaseIds);
						getTherapeutic(data.data.therapeuticIds);
						if (data.data.hospitals != null
								&& data.data.hospitals.length > 0) {
							getHospital(data.data.hospitals[0].hospitalId,
									data.data.hospitals[0].departmentId);
							$("#title").val(data.data.hospitals[0].title);
						} else {
							getHospital();
							getDepartment();
						}
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

	function getTherapeutic(therapeuticIds) {
		$
				.ajax({
					type : "GET",
					url : "../disease/getTherapeuticListByCategoryType",
					contentType : "application/json",
					data : {
						categoryType : 1
					},
					dataType : "json",
					success : function(data) {
						var html = "";
						for (var i = 0; i < data.data.length; i++) {
							html += "<label class=\" checkbox-inline\"><input type='checkbox' id='ther"+data.data[i].id+"' value='"+data.data[i].id+"' />"
							+ data.data[i].name + "</label>";
						}
						$("#surgery").html(html);
						for (var i = 0; i < therapeuticIds.length; i++) {
							$("#ther" + therapeuticIds[i])
									.attr("checked", true);
						}
					}
				});
	}

	function getHospital(hospitalId, departmentId) {
		$.ajax({
			type : "GET",
			url : "../hospital/getHospitalList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<option value='"+data.data[i].id+"' >"
							+ data.data[i].name + "</option>";
				}
				$("#hospitalId").html(html);
				$("#hospitalId").val(hospitalId);
				getDepartment(departmentId);
			}
		});
	}

	function getDepartment(departmentId) {
		if (departmentId === undefined)
			return;
		$.ajax({
			type : "GET",
			url : "../hospital/getDepartmentListByHospitalId",
			contentType : "application/json",
			dataType : "json",
			data : {
				hospitalId : $("#hospitalId").val()
			},
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<option value='"+data.data[i].id+"' >"
							+ data.data[i].name + "</option>";
				}
				$("#departmentId").html(html);
				$("#departmentId").val(departmentId);
			}
		});
	}

	function addWorkTime() {
		var tr = "<tr><td>星期<select name='week' ><option value='1' >星期一</option><option value='2' >星期二</option><option value='3' >星期三</option>"
				+ "<option value='4' >星期四</option><option value='5' >星期五</option><option value='6' >星期六</option><option value='7' >星期日</option></select></td>"
				+ "<td>时间<select name='time' ><option value='1' >上午</option><option value='2' >下午</option></select></td>"
				+ "<td>类型<select name='type' ><option value='1' >普通</option><option value='2' >专家</option><option value='3' >特需</option></select></td>"
				+ "<td><input type='button' onclick='delWorkTime(this)' value='删除' /></td></tr>";
		$("#workTime").append(tr);
	}

	function delWorkTime(del) {
		$(del).parent().parent().remove();
	}

	function upload() {
		var formdata = new FormData();
		var v_this = $("#fileUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadDoctorPicture";
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
	<input type="hidden" id="doctorId" value="${doctorId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑医生</h1>
					<h1 class="page-subhead-line">编辑医生
			<a href="<%=request.getContextPath()%>/web/doctor/doctorList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑医生</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>医生姓名</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>医生拼音姓名</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>医生简介</label>
									<textarea class="form-control" rows="3" id="description"></textarea>
								</div>
								<div class="form-group">
									<label>手术</label><span id="surgery"></span>
								</div>
								<div class="form-group">
									<label>擅长疾病</label><span id="diseases"></span>
								</div>
								<div class="form-group">
									<label>隶属医院</label>
									<table id="hospital">
										<tr>
											<td><select id="hospitalId"></select></td>
											<td><select id="departmentId"></select></td>
											<td><select id="title">
													<option value="1">主任医师</option>
													<option value="2">副主任医师</option>
													<option value="3">主治医师</option>
													<option value="4">副主治医师</option>
													<option value="5">住院医师</option>
													<option value="6">其他</option>
											</select></td>
										<tr>
									</table>
								</div>
								<div class="form-group">
									<label>出诊<input type="button" value="添加"
										onclick="addWorkTime()" /></label>
									<table id="workTime"></table>
								</div>
								<div class="form-group">
									<label>特需门诊费用</label><input class="form-control" type="text"
										id="specialFee" />
								</div>
								<div class="form-group">
									<label>专家门诊费用</label><input class="form-control" type="text"
										id="expertFee" />
								</div>
								<div class="form-group">
									<label>普通门诊费用</label><input class="form-control" type="text"
										id="normalFee" />
								</div>



								<div class="form-group">
									<label class="control-label col-lg-4">医生头像</label>
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