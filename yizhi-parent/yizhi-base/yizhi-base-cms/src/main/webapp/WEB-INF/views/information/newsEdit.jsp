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
<!-- 加载编辑器的容器 -->
<script id="container" name="content" type="text/plain">
        这里写你的初始化内容
    </script>
    <script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../../jquery/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="../../jquery/utf8-jsp/ueditor.all.min.js">
	
</script>
    
    <!-- 实例化编辑器 -->
    <script type="text/javascript">
        var ue = UE.getEditor('container');
    </script>
<script type="text/javascript">
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');
	
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }

	$(function() {
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(function() {
			var id = 0;
			var url = "createNews";
			if ($("#newsId").val() != "") {
				url = "updateNews";
				id = $("#newsId").val();
			}
			var abc = content.instanceById('txtContent').getContent();

			var data1 = {
				"id" : id,
				"title" : $("#title").val(),
				"absContent" : $("#absContent").val(),
				"content" : content.instanceById('txtContent').getContent(),
				"time" : $("#time").val(),
				"type" : $("#type").val(),
				"writer" : $("#writer").val(),
				"picture" : $("#picture").val()
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
			url : "getNewsDetail",
			contentType : "application/json",
			data : {
				newsId : $("#newsId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#title").val(data.data.title);
				$("#absContent").val(data.data.absContent);
				$("#time").val(data.data.time);
				$("#type").val(data.data.type);
				$("#writer").val(data.data.writer);
				$("#picture").val(data.data.picture);
			}
		});
	}
</script>
</head>
<body>

	<jsp:include page="../common/head.jsp"></jsp:include>
	<input type="hidden" value="${newsId }" id="newsId" />
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
									<label>图片编号</label> <input class="form-control" type="text"
										id="picture" />
								</div>
								<div class="form-group">
									<label>内容</label>
									<textarea class="form-control" rows="3" id=txtContent></textarea>
								</div>
								<div>
									<script id="editor" type="text/plain"
										style="width:1024px;height:500px;"></script>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" /> <a
				href="<%=request.getContextPath()%>/web/information/newsList"
				id="returnList">返回列表</a>
		</div>
	</div>
</body>
</html>