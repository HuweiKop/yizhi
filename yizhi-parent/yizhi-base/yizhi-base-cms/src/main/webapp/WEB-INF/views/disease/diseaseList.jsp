<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/jquery/jquery-2.2.1.min.js"></script>
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
	$(function() {
		$("#goto").click(function(){
			setPageIndex();
			
			var data1={
					"pageIndex":$("#pageIndex").val(),
					"pageSize":10,
					"orderBy":$("#orderBy").val()+" "+$("#asc").val(),
					"nameValue":$("#name").val(),
					"status":$("#status").val()
					}; 
		$.ajax({
			type : "GET",
			url : "getDiseasePage",
			contentType:"application/json",
			data : data1,
			dataType : "json",
			success : function(data) {
				
				setPageInfo(data.data.totalPage, data.data.indexPage);
				
				$('#list').empty(); //清空resText里面的所有内容
				var html = "";
				var dataList = data.data.sourceItems
				for(var i=0;i<dataList.length;i++){

					html+="<tr><td>"+dataList[i].id+"</td><td><a href='<%=request.getContextPath() %>/web/disease/diseaseEdit?diseaseId="+dataList[i].id+"'>"+dataList[i].name+"</a></td>"
							+"<td>"+isPublish(dataList[i].status)+"</td>"
							+"<td>"+dataList[i].lastOperator+"</td>"
							+"<td>"+showTime(dataList[i].updateTime)+"</td>"
							+"<td><a name='update' href='<%=request.getContextPath() %>/web/disease/diseaseEdit?diseaseId="
														+ dataList[i].id
														+ "' class=\"btn btn-link\">编辑</a>"
														+ "<a href='#' name='delete' onclick=\"deleteData("
														+ dataList[i].id
														+ ",'dis_id','t_dis_disease',2)\" class=\"btn btn-link\">删除</a>";
												if (dataList[i].status != 1) {
													html += "<a href='#' name='publish' onclick='publish("
															+ dataList[i].id
															+ ")' class=\"btn btn-link\">发布</a>";
												}
												html += "</td></tr>";
											}
											$("#list").html(html);

											authControl($("#userAuth").val());
										}
									});
						});
		$('#goto').click();
	});

	function publish(id) {
		var data1 = {
			"id" : id,
			"status" : 1
		};

		$.ajax({
			type : "POST",
			url : "updateDiseaseStatus",
			contentType : "application/json",
			data : JSON.stringify(data1),
			dataType : "json",
			success : function(data) {
				alert("ok");
				$('#goto').click();
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">癌症列表</h1>
					<h1 class="page-subhead-line">数据展示</h1>
				</div>
			</div>
			<!-- /. ROW  -->
			<div class="form-group col-md-12">
				<!--   修改这里搜索 -->
				<label class="control-label pull-left" for="name">癌症名称</label>
				<div class="col-md-2">
					<input class="form-control" type="text" id="name">
				</div>
				<div class="col-md-2">
					<select class="form-control " id="status"><option
							value="0">全部</option>
						<option value="1">已发布</option>
						<option value="2">未发布</option>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control " id="orderBy">
						<option value="updateTime">最后操作时间</option>
						<option value="dis_id">Id</option>
						<option value="convert(dis_name using gbk)">Name</option>
					</select>
				</div>

				<div class="col-md-2">
					<select class="form-control " id="asc">
						<option value="desc">降序</option>
						<option value="asc">升序</option>
					</select>
				</div>
				<input class="btn btn-sm btn-primary" type="button" id="goto"
					value="查询">
			</div>

			<div class="row">
				<div class="col-md-12">
					<!--   Kitchen Sink -->
					<div class="panel panel-default">
						<div class="panel-heading">癌症列表</div>
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
											<th class="col-md-3">操作</th>
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

				<div class="col-md-10">
					<div class="form-inline pull-right">
						<jsp:include page="../common/pageInfo.jsp"></jsp:include>
					</div>
					<!--   修改这里  新建 按钮 -->
					<div class=" pagination  ">
						<a class="btn btn-sm btn-primary" name="create"
							href="<%=request.getContextPath()%>/web/disease/diseaseEdit">
							新建</a>
					</div>
					<div class="pagination">
						<input type="button" onclick="gotoPage(1)" value="首页"
							class="btn btn-sm btn-default">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>