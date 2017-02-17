<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="../../jquery/dist/css/wangEditor.min.css">
<style type="text/css">
#editor-trigger {
	height: 400px;
	/*max-height: 500px;*/
}

.container {
	width: 100%;
	margin: 0 auto;
	position: relative;
}
</style>
<script type="text/javascript" src="../../jquery/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../../jquery/nicEdit.js"></script>
<script type="text/javascript" src="../../jquery/common/common.js"></script>
<!-- JQUERY SCRIPTS -->
<script src="../../assets/js/jquery-1.10.2.js"></script>
<!-- GOOGLE FONTS-->
<script type="text/javascript" src="../../assets/js/bootstrap.js" /></script>
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
<link href="../../assets/css/bootstrap-fileupload.min.css"
	rel="stylesheet" />
<!--DIALOG STYLES-->
<link href="../../css/dialog.css" rel="stylesheet" />
<script type="text/javascript">
	$(function() {
		isEdit($("#userAuth").val());
		init();
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
				if (data.data.picture != "" && data.data.picture != null) {
					$("#picImg").attr(
							"src",
							"http://" + $("#zhongmebanBucket").val() + "."
									+ $("#endPoint").val() + "/"
									+ data.data.picture);
				}
				editor.$txt.html(data.data.content);
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
				$("#picture").val(data);
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
				$("#picPathUpload").val(
						"http://" + $("#zhongmebanBucket").val() + "."
								+ $("#endPoint").val() + "/" + data);
				$("#picImgUpload").attr(
						"src",
						"http://" + $("#zhongmebanBucket").val() + "."
								+ $("#endPoint").val() + "/" + data);
			}
		});
		return false;
	}

	function submit() {
		var id = 0;
		var url = "createInformation";
		if ($("#infoId").val() != "") {
			url = "updateInformation";
			id = $("#infoId").val();
		}
		var html = editor.$txt.html();
		//var abc = content.instanceById('txtContent').getContent();
		var data1 = {
			"id" : id,
			"title" : $("#title").val(),
			"absContent" : $("#absContent").val(),
			"content" : html,
			"time" : $("#time").val(),
			"type" : $("#type").val(),
			"writer" : $("#writer").val(),
			"picture" : $("#picture").val(),
			"weight" : $("#weight").val()
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
	}

	function delPic(img, path) {
		$("#" + img).attr("src", "../../assets/img/demoUpload.jpg");
		$("#" + path).val("");
		$("#fileText").html("未选择文件");
	}

	function changePic(pic, fileText) {
		$("#" + fileText).html(pic.value);
	}

	function preview() {
		var html = editor.$txt.html();
		$.ajax({
			type : "POST",
			url : "getInformationContent",
			data : {
				content : html
			},
			dataType : "json",
			success : function(data) {
				$("#preview").html(data);
			}
		});
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
					<h1 class="page-head-line">编辑资讯</h1>
					<h1 class="page-subhead-line">
						编辑资讯<a
							href="<%=request.getContextPath()%>/web/information/informationList"
							id="returnList">返回列表</a>
					</h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-8 col-sm-6 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑资讯</div>
						<div class="panel-body">
							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content" style="height: 787px; width: 385px;">
										<!-- style="height: 860px; width: 430px; background-image: url(http://localhost:8090/zhongmeban-cms/img/iphone2.png); background-position: center; background-size: contain; background-repeat: no-repeat"> -->
										
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												onclick="closeDiv()">
												<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">预览</h4>
										</div>
										<div
											style="height: 667px; width: 375px; overflow: auto; margin: auto; display: block;"
											class="modal-body" id="preview"></div>

										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal" onclick="closeDiv()">关闭</button>
										</div>
									</div>
								</div>
							</div>
							<form role="form">
								<div class="form-group">
									<label>标题</label> <input class="form-control" type="text"
										id="title" />
								</div>
								<div class="form-group">
									<label>摘要</label>
									<textarea style="width: 100%;" class="form-control" rows="3"
										id="absContent"></textarea>
								</div>
								<div class="form-group">
									<label>作者</label> <input style="width: 30%;"
										class="form-control" type="text" id="writer" />
								</div>
								<div class="form-group">
									<label>权重（数字）</label> <input style="width: 10%;"
										class="form-control" type="text" id="weight" />
								</div>

								<div id="editor-container" class="1">
									<div id="editor-trigger"></div>
								</div>
								<script type="text/javascript"
									src="../../jquery/dist/js/lib/jquery-1.10.2.min.js"></script>
								<script type="text/javascript"
									src="../../jquery/dist/js/wangEditor.js"></script>
								<script type="text/javascript">
									// 阻止输出log
									// wangEditor.config.printLog = false;

									var editor = new wangEditor(
											'editor-trigger');

									// 上传图片
									editor.config.uploadImgUrl = '/zhongmeban-cms/web/information/uploadInformationPicturePic';
									editor.config.uploadParams = {
									// token1: 'abcde',
									// token2: '12345'
									};
									editor.config.uploadHeaders = {
									// 'Accept' : 'text/x-json'
									}
									// editor.config.uploadImgFileName = 'myFileName';

									// 隐藏网络图片
									// editor.config.hideLinkImg = true;

									// 表情显示项
									editor.config.emotionsShow = 'value';
									editor.config.emotions = {
										'default' : {
											title : '默认',
											data : './emotions.data'
										},
										'weibo' : {
											title : '微博表情',
											data : [
													{
														icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/7a/shenshou_thumb.gif',
														value : '[草泥马]'
													},
													{
														icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/60/horse2_thumb.gif',
														value : '[神马]'
													},
													{
														icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/bc/fuyun_thumb.gif',
														value : '[浮云]'
													},
													{
														icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/c9/geili_thumb.gif',
														value : '[给力]'
													},
													{
														icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/f2/wg_thumb.gif',
														value : '[围观]'
													},
													{
														icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/70/vw_thumb.gif',
														value : '[威武]'
													} ]
										}
									};

									// 插入代码时的默认语言
									// editor.config.codeDefaultLang = 'html'

									// 只粘贴纯文本
									// editor.config.pasteText = true;

									// 跨域上传
									// editor.config.uploadImgUrl = 'http://localhost:8012/upload';

									// 第三方上传
									// editor.config.customUpload = true;

									// 普通菜单配置
									// editor.config.menus = [
									//     'img',
									//     'insertcode',
									//     'eraser',
									//     'fullscreen'
									// ];
									// 只排除某几个菜单（兼容IE低版本，不支持ES5的浏览器），支持ES5的浏览器可直接用 [].map 方法
									// editor.config.menus = $.map(wangEditor.config.menus, function(item, key) {
									//     if (item === 'insertcode') {
									//         return null;
									//     }
									//     if (item === 'fullscreen') {
									//         return null;
									//     }
									//     return item;
									// });

									// onchange 事件
									editor.onchange = function() {
										console.log(this.$txt.html());
									};

									// 取消过滤js
									// editor.config.jsFilter = false;

									// 取消粘贴过来
									// editor.config.pasteFilter = false;

									// 设置 z-index
									// editor.config.zindex = 20000;

									// 语言
									// editor.config.lang = wangEditor.langs['en'];

									// 自定义菜单UI
									// editor.UI.menus.bold = {
									//     normal: '<button style="font-size:20px; margin-top:5px;">B</button>',
									//     selected: '.selected'
									// };
									// editor.UI.menus.italic = {
									//     normal: '<button style="font-size:20px; margin-top:5px;">I</button>',
									//     selected: '<button style="font-size:20px; margin-top:5px;"><i>I</i></button>'
									// };
									editor.create();
								</script>

								<hr>
								<div class="form-group">
									<label class="control-label col-lg-4">缩略图片</label>
									<div class="">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<span class="btn btn-file btn-default"> <span
												class="fileupload-new">选取文件</span> <span
												class="fileupload-exists">更换文件</span> <input type="file"
												name="fileName" id="fileUploader"
												onchange="changePic(this,'fileText')">
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
													id="picImg" /> <input type="hidden" id="picture" />
											</div>
											<div class="fileupload-preview fileupload-exists thumbnail"
												style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-file btn-primary" onclick="upload()"><span
													class="fileupload-new">上传图片</span></span> <span
													class="btn btn-file btn-primary"
													onclick="delPic('picImg','picture')"><span
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
								<input type="button" id="submit" value="确认发布"
									class="btn btn-lg btn-success" onclick="submit()">
								<button type="button" class="btn btn-default"
									data-toggle="modal" data-target="#myModal" onclick="preview()">预览</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>