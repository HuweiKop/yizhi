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
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(
				function() {
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
					$("#qas tr").each(function(){
						var qa = new Object();
						qa.id = $(this).attr("id");
						qa.question = $(this).find("input[name=question]").val();
						qa.answer = $(this).find("input[name=answer]").val();
						qa.sequence = $(this).find("input[name=sequence]").val();
						qa.category = $(this).find("input[name=category]").val();
						qas.push(qa);
					})
					var data1 = {
						"therapeutic" : {
							"id" : id,
							"name" : $("#name").val(),
							"pinyinName" : $("#pinyinName").val(),
							"categoryId" : $("#categoryId").val(),
							"categoryType" : $("#categoryId").find(
									"option:selected").attr("type")
						},
						"diseaseIds":diseaseIds,
						"qaDbs":qas
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
							window.location.href=$("#returnList").attr("href");
						}
					});
				});
	});

	function init() {
		if ($("#therapeuticId").val() == "") {
			getCategory();
			getDisease();
		}
		else{
			getTherapeutic();
		}
	}

	function getTherapeutic() {
		$.ajax({
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
				
				var qas = data.data.qaDbs;
				for (var i = 0; i < qas.length; i++) {
					var tr = "<tr id='"+qas[i].id+"'><td>问题<input type='text' name='question' value='"+qas[i].question
					+"' /></td><td>回答<input type='text' name='answer' value='"+qas[i].answer
					+"'  /></td><td>序号<input type='text' name='sequence' value='"+qas[i].sequence
					+"'  /></td><td><input type='button' onclick='del(this)' value='删除' /></td></tr>";
					$("#qas").append(tr);
				}

				getCategory(data.data.therapeutic.categoryId);
				getDisease(data.data.diseaseIds);
			}
		});
	}

	function getCategory(categoryId) {
		$.ajax({
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
	
	function getDisease(diseaseIds){
		$.ajax({
			type : "GET",
			url : "getDiseaseList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<input type='checkbox' id='dis"+data.data[i].id+"' value='"+data.data[i].id+"' />"
					+ data.data[i].name+"&nbsp&nbsp";
				}
				$("#diseases").html(html);
				for (var i = 0; i < diseaseIds.length; i++) {
					$("#dis" + diseaseIds[i]).attr("checked", true);
				}
			}
		});
	}
	
	function addQa(){
		var tr = "<tr><td>问题<input type='text' name='question' /></td><td>回答<input type='text' name='answer' /></td><td>序号<input type='text' name='sequence' /></td><td><input type='button' onclick='del(this)' value='删除' /></td></tr>";
		$("#qas").append(tr);
	}

	function del(del) {
		$(del).parent().parent().remove();
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
									<label>治疗方法名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>治疗方法拼音<input type="button" value="获取拼音"
										onclick="getPinyin()" /></label> <input class="form-control"
										type="text" id="pinyinName" />
								</div>
								<div class="form-group">
									<label>治疗类型</label><select id="categoryId"></select>
								</div>
								<div class="form-group">
									<label>问答<input type="button" onclick="addQa()"
										value="添加" /></label>
									<table id="qas">
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/disease/therapeuticList" id="returnList">返回列表</a>
		</div>
	</div>
</body>
</html>