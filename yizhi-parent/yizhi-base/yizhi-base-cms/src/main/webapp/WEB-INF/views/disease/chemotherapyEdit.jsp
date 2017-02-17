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
<!--DIALOG STYLES-->
<link href="../../css/dialog.css" rel="stylesheet" />
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
			buildQas(qas,"TreatAttentionQa");
			buildQas(qas,"TreatPrepareQa");
			buildQas(qas,"BadReactionQa");
			var medicines = $("#medicines input:checkbox:checked");
			var medicineIds = new Array();
			for (var i = 0; i < medicines.length; i++) {
				//indexIds += "," + indexs[i].id;
				medicineIds.push(medicines[i].value);
			}
			var data1 = {
				"therapeutic" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"notes" : $("#notes").val(),
					"caseType" : $("#caseType").val(),
					"categoryId" : 2,
					"categoryType" : 2
				},
				"diseaseIds" : diseaseIds,
				"qaDbs" : qas,
				"medicineIds" : medicineIds
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
	
	function buildQas(qas, name){
		var count = 1;
		$("#"+name+" span").each(function() {
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
			getDisease();
			getMedicine();
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
						$("#caseType").val(data.data.therapeutic.caseType);

						var qas = data.data.qaDbs;
						for (var i = 0; i < qas.length; i++) {
							var tr = "<span category='"+qas[i].category+"'><div class=\"form-group\"><label>问题</label>"
							+ "<a  class=\"btn btn-link fileupload-exists \" data-dismiss=\"fileupload\" onclick=\"del(this)\">删除此条问答</a>"
							+ "<input style=\"width: 100%;\" type=\"email\" class=\"form-control\" name='question' value='"
							+ qas[i].question
							+ "'></div>"
							+ "<div class=\"form-group\"><label>答案</label><textarea style=\"width: 100%;\" class=\"form-control\" rows=\"3\" name='answer'>"
							+ qas[i].answer
							+ "</textarea></div><hr></span>";
							if (qas[i].category == 103)
								$("#TreatAttentionQa").append(tr);
							else if (qas[i].category == 101)
								$("#TreatPrepareQa").append(tr);
							else if (qas[i].category == 104)
								$("#BadReactionQa").append(tr);
						}
						
						if ($("#TreatAttentionQa span").length > 1) {
							$("#TreatAttentionQa span")[0].remove();
						}
						if ($("#TreatPrepareQa span").length > 1) {
							$("#TreatPrepareQa span")[0].remove();
						}
						if ($("#BadReactionQa span").length > 1) {
							$("#BadReactionQa span")[0].remove();
						}

						getDisease(data.data.diseaseIds);
						getMedicine(data.data.medicineIds);
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
							html += "<label class=\" checkbox-inline\" ><input type='checkbox' id='dis"+data.data[i].id+"' value='"+data.data[i].id+"' />"
									+ data.data[i].name + "</label>";
						}
						$("#diseases").html(html);
						for (var i = 0; i < diseaseIds.length; i++) {
							$("#dis" + diseaseIds[i]).attr("checked", true);
						}
					}
				});
	}

	function getMedicine(medicineIds) {
		$
				.ajax({
					type : "POST",
					url : "../medicine/getMedicineList?type=18",
					contentType : "application/json",
					dataType : "json",
					success : function(data) {
						var html = "";
						for (var i = 0; i < data.data.length; i++) {
							html += "<div class=\"checkbox\" value='"+ data.data[i].showName +"'><label><input type='checkbox' id='med"
							+data.data[i].id+"' value='"+data.data[i].id+"' name='"+ data.data[i].showName +"' />"
									+ data.data[i].showName + "</label></div>";
						}
						$("#medicines").append(html);
						for (var i = 0; i < medicineIds.length; i++) {
							$("#med" + medicineIds[i]).attr("checked", true);
						}
						closeDiv();
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
	
	function searchMedicine(){
		$("#medicines").find("div").each(function (){
			if($(this).attr("value").indexOf($("#searchName").val())!= -1){
				$(this).show();
			}
			else{
				$(this).hide();
			}
		});
	}
	
	function closeDiv(){
		var medicines = $("#medicines input:checkbox:checked");
		var html="";
		for (var i = 0; i < medicines.length; i++) {
			html+="<div>"+medicines[i].name+"</div>&nbsp;&nbsp;&nbsp;";
		}
		$("#medicineList").html(html);
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
					<h1 class="page-head-line">编辑化疗</h1>
					<h1 class="page-subhead-line">编辑化疗
			<a href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=2" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-12 col-sm-8 col-xs-12">
					<ul class="nav nav-tabs" role="tablist" id="myTab">
						<li role="presentation" class="active"><a href="#home"
							role="tab" data-toggle="tab">基础信息</a></li>
						<li role="presentation"><a href="#TreatPrepare" role="tab"
							data-toggle="tab">准备治疗</a></li>
						<li role="presentation"><a href="#BadReaction" role="tab"
							data-toggle="tab">不良反应</a></li>
						<li role="presentation"><a href="#TreatAttention" role="tab"
							data-toggle="tab">治疗注意</a></li>
					</ul>
					<div class="tab-content">
						<!--tabpanel 1 begin -->
						<div role="tabpanel" class="tab-pane active" id="home">
							<div class="panel-body">
								<!-- Modal -->
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
									aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" onclick="closeDiv()">
													<span aria-hidden="true">&times;</span><span
														class="sr-only">Close</span>
												</button>
												<h4 class="modal-title" id="myModalLabel">药品列表</h4>
											</div>
											<div
												style="height: 500px; overflow: auto; margin: 5px 0; display: block;"
												class="modal-body" id="medicines">
												<input class="form-control"  type="text" id="searchName" onchange="searchMedicine()" /></div>

											<div class="modal-footer">
												<button type="button" class="btn btn-default"
													data-dismiss="modal" onclick="closeDiv()">关闭</button>
											</div>
										</div>
									</div>
								</div>
								<form role="form">
									<div class="form-group">
										<label>化疗名称</label> <input class="form-control" type="text"
											id="name" />
									</div>
									<div class="form-group">
										<label>拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
									</div>
									<div class="form-group">
										<label>概述</label>
										<textarea class="form-control" rows="3" id="notes"></textarea>
									</div>
									<div class="form-group">
										<label>关联癌症</label><span id="diseases"> </span>
									</div>
									<div class="form-group">
										<label>药品</label>
										<button type="button" class="btn btn-default"
											data-toggle="modal" data-target="#myModal">点击添加</button>
									</div>
									<div class="form-group" id="medicineList">
									</div>
									<div class="form-group">
										<label>方案类型</label><select id="caseType"><option
												value="1">一线方案</option>
											<option value="2">二线方案</option></select>
									</div>
								</form>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="TreatPrepare">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">治疗准备</div>
								<div class="panel-body" id="TreatPrepareQa">
									<span category='101'>
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
										onclick="addQa2('TreatPrepareQa',101)"><span
										class="fileupload-new">添加问答</span></span>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="BadReaction">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">不良反应</div>
								<div class="panel-body" id="BadReactionQa">
									<span category='104'>
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
										onclick="addQa2('BadReactionQa',104)"><span
										class="fileupload-new">添加问答</span></span>
								</div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane" id="TreatAttention">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">治疗注意</div>
								<div class="panel-body" id="TreatAttentionQa">
									<span category='103'>
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
										onclick="addQa2('TreatAttentionQa',103)"><span
										class="fileupload-new">添加问答</span></span>
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
	</div>
	<div id="medicines" class="showDiv">
		<span class="rightTop"><input type="button" value="关闭"
			onclick="closeDiv('medicines')" /></span>
	</div>
	<div id="fullbg" class="mask"></div>
</body>
</html>