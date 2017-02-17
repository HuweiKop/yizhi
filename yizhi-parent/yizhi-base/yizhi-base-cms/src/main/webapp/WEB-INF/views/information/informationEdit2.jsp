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
<script type="text/javascript">
	var content;

	bkLib.onDomLoaded(function() {
		content = new nicEditor({
			fullPanel : true
		}).panelInstance('txtContent');
	});

	$(function() {
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(function() {
			var id = 0;
			var url = "createInformation";
			if ($("#infoId").val() != "") {
				url = "updateInformation";
				id = $("#infoId").val();
			}
			var abc = content.instanceById('txtContent').getContent();
			var data1 = {
				"id" : id,
				"title" : $("#title").val(),
				"absContent" : $("#absContent").val(),
				"content" : abc,
				"time" : $("#time").val(),
				"type" : $("#type").val(),
				"writer" : $("#writer").val(),
				"picture" : $("#picture").val(),
				"weight" : $("#weight").val(),
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
					window.location.href=$("#returnList").attr("href");
				}
			});
		});
	});

	function init() {
		$.ajax({
			type : "GET",
			url : "getInformationDetail",
			contentType : "application/json",
			data : {
				infoId : $("#infoId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#title").val(data.data.title);
				$("#absContent").val(data.data.absContent);
				$("#time").val(data.data.time);
				$("#type").val(data.data.type);
				$("#writer").val(data.data.writer);
				$("#picture").val(data.data.picture);
				$("#weight").val(data.data.weight);
				$("#picPath").val(data.data.picture);
				$("#picImg").attr(
						"src",
						"http://" + $("#zhongmebanBucket").val() + "."
								+ $("#endPoint").val() + "/"
								+ data.data.picture);
				content.instanceById('txtContent')
						.setContent(data.data.content);
			}
		});
	}

	function upload() {
		var formdata = new FormData();
		var v_this = $("#fileUploader");
		var fileObj = v_this.get(0).files;
		url = "uploadInformationPicture";
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

	function uploadPic() {
		var formdata = new FormData();
		var v_this = $("#fileUploaderPic");
		var fileObj = v_this.get(0).files;
		url = "uploadInformationPicturePic";
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
				$("#picPathUpload").val("http://" + $("#zhongmebanBucket").val() + "."
						+ $("#endPoint").val() + "/" + data);
				$("#picImgUpload").attr(
						"src",
						"http://" + $("#zhongmebanBucket").val() + "."
								+ $("#endPoint").val() + "/" + data);
			}
		});
		return false;
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
									<label>标题</label> <input class="form-control" type="text"
										id="title" />
								</div>
								<div class="form-group">
									<label>摘要</label> <input class="form-control" type="text"
										id="absContent" />
								</div>
								<div class="form-group">
									<label>作者</label> <input class="form-control" type="text"
										id="writer" />
								</div>
								<div class="form-group">
									<label>权重（数字）</label> <input class="form-control" type="text"
										id="weight" />
								</div>
								<div class="form-group">
									<label>缩略图片</label>
									<form name="itemForm" target="_self" id="itemForm"
										method="post" action="uploadInformationPicture"
										enctype="multipart/form-data">
										<input name="fileName" type="file" class="text1" size="40"
											maxlength="40" id="fileUploader">
									</form>
									<input type="button" id="uploader" value="上传"
										onclick="upload()" /> <input type="hidden" id="picPath" /> <br><img
										alt="" src="" id="picImg"   height="180" width="320"/>
								</div>
								
								<div class="form-group">
									<label>上传图片</label>
									<form name="itemForm" target="_self" id="itemFormPic"
										method="post" action="uploadInformationPicturePic"
										enctype="multipart/form-data">
										<input name="fileName" type="file" class="text1" size="40"
											maxlength="40" id="fileUploaderPic">
									</form>
									<input type="button" id="uploaderPic" value="上传"
										onclick="uploadPic()" /> <br>图片地址：<input type="text" id="picPathUpload" /><br> <img 
										alt="" src="" id="picImgUpload"  height="180" width="320"/>
								</div>
								
								<div class="form-group">
									<label>内容</label>
									<textarea class="form-control" rows="3" id=txtContent></textarea>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" /> <a
				href="<%=request.getContextPath()%>/web/information/informationList" id="returnList">返回列表</a>
		</div>
	</div>
</body>
</html>