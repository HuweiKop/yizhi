<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../../jquery/nicEdit.js"></script>
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
			var url = "createRecommend";
			if ($("#infoId").val() != "") {
				url = "updateRecommend";
				id = $("#infoId").val();
			}

			var data1 = {
				"id" : id,
				"title" : $("#title").val(),
				"type" : $("#type").val(),
				"contentId" : $("#contentId").val(),
				"orderBy" : $("#orderBy").val(),
				"picture" : $("#picPath").val()
			};
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
		$.ajax({
			type : "GET",
			url : "getRecommendDetail",
			contentType : "application/json",
			data : {
				infoId : $("#infoId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#title").val(data.data.title);
				$("#type").val(data.data.type);
				$("#orderBy").val(data.data.orderby);
				$("#contentId").val(data.data.contentId);
				$("#picPath").val(data.data.picture);
				if (data.data.picture != "" && data.data.picture != null) {
					$("#picImg").attr(
							"src",
							"http://" + $("#zhongmebanBucket").val() + "."
									+ $("#endPoint").val() + "/"
									+ data.data.picture);
				}
				content.instanceById('txtContent')
						.setContent(data.data.content);
			}
		});
	}

	function upload() {
		var formdata = new FormData();
		var v_this = $("#fileUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadRecommendPicture";
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
	<input type="hidden" value="${infoId }" id="infoId" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑推荐</h1>
					<h1 class="page-subhead-line">编辑推荐<a
				href="<%=request.getContextPath()%>/web/information/recommendList"
				id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑推荐</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>标题</label> <input class="form-control" type="text"
										id="title" />
								</div>
								<div class="form-group">
									<label>类型</label> <select id="type">
										<option value="1">文章</option>
									</select>
								</div>
								<div class="form-group">
									<label>关联Id</label> <input class="form-control" type="text"
										id="contentId" />
								</div>
								<div class="form-group">
									<label>排序（数字）</label> <input class="form-control" type="text"
										id="orderBy" />
								</div>
								<div class="form-group">
									<label class="control-label col-lg-4">图片</label>
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