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
			buildQas(qas, "TreatPrepareQa");
			buildQas(qas, "TreatProcessQa");
			buildQas(qas, "TreatAttentionQa");
			buildQas(qas, "BadReactionQa");
			var data1 = {
				"therapeutic" : {
					"id" : id,
					"name" : $("#name").val(),
					"pinyinName" : $("#pinyinName").val(),
					"notes" : $("#notes").val(),
					"categoryId" : 3,
					"categoryType" : 3
				},
				"diseaseIds" : diseaseIds,
				"qaDbs" : qas
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

	function buildQas(qas, name) {
		var count = 1;
		$("#" + name + " span").each(function() {
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
							if (qas[i].category == 101)
								$("#TreatPrepareQa").append(tr);
							else if (qas[i].category == 102)
								$("#TreatProcessQa").append(tr);
							else if (qas[i].category == 103)
								$("#TreatAttentionQa").append(tr);
							else if (qas[i].category == 104)
								$("#BadReactionQa").append(tr);
						}

						if ($("#TreatPrepareQa span").length > 1) {
							$("#TreatPrepareQa span")[0].remove();
						}
						if ($("#TreatProcessQa span").length > 1) {
							$("#TreatProcessQa span")[0].remove();
						}
						if ($("#TreatAttentionQa span").length > 1) {
							$("#TreatAttentionQa span")[0].remove();
						}
						if ($("#BadReactionQa span").length > 1) {
							$("#BadReactionQa span")[0].remove();
						}

						getDisease(data.data.diseaseIds);
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
					<h1 class="page-head-line">编辑放疗</h1>
					<h1 class="page-subhead-line">编辑放疗
					 <a href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=3" id="returnList">返回列表</a></h1>

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
						<li role="presentation"><a href="#TreatProcess" role="tab"
							data-toggle="tab">治疗过程</a></li>
						<li role="presentation"><a href="#BadReaction" role="tab"
							data-toggle="tab">不良反应</a></li>
						<li role="presentation"><a href="#TreatAttention" role="tab"
							data-toggle="tab">治疗注意</a></li>
					</ul>
					<div class="tab-content">
						<!--tabpanel 1 begin -->
						<div role="tabpanel" class="tab-pane active" id="home">
							<div class="panel-body">
								<form role="form">
									<div class="form-group">
										<label>放疗名称</label> <input class="form-control" type="text"
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
						
						<div role="tabpanel" class="tab-pane" id="TreatProcess">
							<hr>
							<div class="panel panel-info">
								<div class="panel-heading">治疗过程</div>
								<div class="panel-body" id="TreatProcessQa">
									<span category='102'>
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
										onclick="addQa2('TreatProcessQa',102)"><span
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
</body>
</html>