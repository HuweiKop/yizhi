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
<script type="text/javascript">
	$(function() {
		$.ajax({
			type : "POST",
			url : "getNewsList",
			contentType:"application/json",
			dataType : "json",
			success : function(data) {
				$('#list').empty(); //清空resText里面的所有内容
				var html = "";
				var dataList = data.data;
				for(var i=0;i<dataList.length;i++){

					html+="<tr><td>"+dataList[i].id+"</td><td><a href='<%=request.getContextPath() %>/web/information/newsEdit?newsId="+dataList[i].id+"'>"+dataList[i].title+"</a></td>"
					+"<td>"+isPublish(dataList[i].status)+"</td>"
					+"<td>"+dataList[i].lastOperator+"</td>"
					+"<td>"+showTime(dataList[i].updateTime)+"</td>"
					+"<td><a name='update' href='<%=request.getContextPath() %>/web/information/newsEdit?newsId="+dataList[i].id+"'>编辑</a></td></tr>"
					+"<a href='#' name='delete' onclick=\"deleteData("
					+ dataList[i].id
					+ ",'news_id','t_info_news',11)\">删除</a>";
				}
				$("#list").html(html);

				authControl($("#userAuth").val());
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="../common/head.jsp"></jsp:include>
<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">News列表</h1>
					<h1 class="page-subhead-line">数据展示</h1>
					<a name='create' href='<%=request.getContextPath() %>/web/information/newsEdit'>创建</a>
				</div>
			</div>
			<!-- /. ROW  -->

			<div class="row">
				<div class="col-md-6">
					<!--   Kitchen Sink -->
					<div class="panel panel-default">
						<div class="panel-heading">信息列表</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>Id</th>
											<th>Name</th>
											<th>状态</th>
											<th>最后操作人</th>
											<th>最后操作时间</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody id="list">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- End  Kitchen Sink -->
				</div>
			</div>
		</div>
	</div>
</body>
</html>