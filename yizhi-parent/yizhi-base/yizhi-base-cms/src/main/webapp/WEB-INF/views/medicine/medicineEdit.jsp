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
<script type="text/javascript">
	$(function() {
		isEdit($("#userAuth").val());
		init();
		$("#submit").click(
				function() {
					var id = 0;
					var url = "createMedicine";
					if ($("#medicineId").val() != "") {
						url = "updateMedicine";
						id = $("#medicineId").val();
					}
					var manufacturerIds = new Array();
					manufacturerIds.push($("#manufacturer").val());

					var types = $("#type input:checkbox:checked");
					var type = 0;
					for (var i = 0; i < types.length; i++) {
						type += parseInt(types[i].value);
					}

					var data1 = {
						"medicine" : {
							"id" : id,
							"name" : $("#name").val(),
							"pinyinName" : $("#pinyinName").val(),
							"showName":$("#showName").val(),
							"pinyinShowName":$("#pinyinShowName").val(),
							"useInfo" : $("#useInfo").val(),
							"taboo" : $("#taboo").val(),
							"sideEffect" : $("#sideEffect").val(),
							"prescription" : $("#prescription").val(),
							"classify" : $("#classify").val(),
							"insurance" : $("#insurance").val(),
							"special" : $("#special").val(),
							"imports" : $("#imports").val(),
							"priceMin" : $("#priceMin").val(),
							"priceMax" : $("#priceMin").val(),
							"chemicalId" : $("#chemical").val(),
							"type" : type,
							"announcements" : $("#announcements").val(),
						},
						"manufacturerId" : manufacturerIds
					};
					alert(JSON.stringify(data1))
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
		if ($("#medicineId").val() == "") {
			getChemical();
			getManufacturer();
		} else {
			getMedicine();
		}

	}

	function getMedicine() {
		$.ajax({
			type : "GET",
			url : "getMedicineDetail",
			contentType : "application/json",
			data : {
				medicineId : $("#medicineId").val()
			},
			dataType : "json",
			success : function(data) {
				$("#name").val(data.data.medicine.name);
				$("#pinyinName").val(data.data.medicine.pinyinName);
				$("#showName").val(data.data.medicine.showName);
				$("#pinyinShowName").val(data.data.medicine.pinyinShowName);
				$("#useInfo").val(data.data.medicine.useInfo);
				$("#taboo").val(data.data.medicine.taboo);
				$("#sideEffect").val(data.data.medicine.sideEffect);
				$("#prescription").val(data.data.medicine.prescription);
				$("#classify").val(data.data.medicine.classify);
				$("#insurance").val(data.data.medicine.insurance);
				$("#special").val(data.data.medicine.special);
				$("#imports").val(data.data.medicine.imports);
				$("#priceMin").val(data.data.medicine.priceMin);
				//$("#type").val(data.data.medicine.type);
				$("#announcements").val(data.data.medicine.announcements);
				for (var i = 1; i <= 16; i *= 2) {
					if ((data.data.medicine.type & i) == i) {
						$("#type" + i).attr("checked", true);
					}
				}
				getChemical(data.data.medicine.chemicalId);
				getManufacturer(data.data.manufacturerId);
			}
		});
	}

	function getChemical(chemicalId) {
		$.ajax({
			type : "GET",
			url : "getChemicalList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<option value='"+data.data[i].id+"' >"
							+ data.data[i].name + "</option>";
				}
				$("#chemical").html(html);
				$("#chemical").val(chemicalId);
			}
		});
	}

	function getManufacturer(manufacturerId) {
		$.ajax({
			type : "GET",
			url : "getManufacturerList",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var html = "";
				for (var i = 0; i < data.data.length; i++) {
					html += "<option value='"+data.data[i].id+"' >"
							+ data.data[i].name + "</option>";
				}
				$("#manufacturer").html(html);
				if (manufacturerId.length > 0) {
					$("#manufacturer").val(manufacturerId[0]);
				}
			}
		});
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

	function getShowPinyin() {
		$.ajax({
			type : "GET",
			url : "../../common/getPinyinString",
			contentType : "application/json",
			dataType : "json",
			data : {
				str : $("#showName").val()
			},
			success : function(data) {
				$("#pinyinShowName").val(data);
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../common/head.jsp"></jsp:include>
	<input type="hidden" id="medicineId" value="${medicineId}" />
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-head-line">编辑药品</h1>
					<h1 class="page-subhead-line">编辑药品<a
				href="<%=request.getContextPath()%>/web/medicine/medicineList" id="returnList">返回列表</a></h1>

				</div>
			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-10 col-sm-8 col-xs-12">
					<div class="panel panel-info">
						<div class="panel-heading">编辑药品</div>
						<div class="panel-body">
							<form role="form">
								<div class="form-group">
									<label>药品名称</label> <input class="form-control" type="text"
										id="name" />
								</div>
								<div class="form-group">
									<label>药品拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinName">
								</div>
								<div class="form-group">
									<label>显示名</label><input class="form-control" type="text"
										id="showName" />
								</div>
								<div class="form-group">
									<label>显示名拼音</label><input
											style="margin-top: 30px; margin-right: 40%"
											class="btn btn-primary pull-right" type="button" value="获取拼音"
											onclick="getShowPinyin()"> <input style="width: 50%;"
											class="form-control" type="text" id="pinyinShowName">
								</div>
								<div class="form-group">
									<label>化学名</label><select id="chemical"></select>
								</div>
								<div class="form-group">
									<label>药厂</label><select id="manufacturer"></select>
								</div>
								<div class="form-group">
									<label>作用分类</label><span id="type">
									<label class=" checkbox-inline"><input type='checkbox' value="16" id="type16" />化疗药物</label>
									<label class=" checkbox-inline"><input type='checkbox' value="2" id="type2" />靶向用药</label>
									<label class=" checkbox-inline"><input type='checkbox' value="4" id="type4" />镇痛</label>
									<label class=" checkbox-inline"><input type='checkbox' value="1" id="type1" />对症用药</label>
									<label class=" checkbox-inline"><input type='checkbox' value="8" id="type8" />其他</label>
								</div>
								<div class="form-group">
									<label>药品用量</label>
									<textarea class="form-control" rows="3" id="useInfo"></textarea>
								</div>
								<div class="form-group">
									<label>禁忌</label>
									<textarea class="form-control" rows="3" id="taboo"></textarea>
								</div>
								<div class="form-group">
									<label>副作用</label>
									<textarea class="form-control" rows="3" id="sideEffect"></textarea>
								</div>
								<div class="form-group">
									<label>注意事项</label>
									<textarea class="form-control" rows="3" id="announcements"></textarea>
								</div>
								<div class="form-group">
									<label>处方药</label><select id="prescription">
									<option value="0">未知</option>
									<option value="1">处方药</option>
									<option value="2">非处方药</option></select>
								</div>
								<div class="form-group">
									<label>分类</label><select id="classify">
									<option value="0">未知</option>
									<option value="1">西药</option>
									<option value="2">中药</option>
									<option value="3">生物血液制品</option></select>
								</div>
								<div class="form-group">
									<label>特种药</label><select id="special">
									<option value="0">未知</option>
									<option value="1">特种药</option>
									<option value="2">非特种药</option></select>
								</div>
								<div class="form-group">
									<label>医保药</label><select id="insurance">
									<option value="0">未知</option>
									<option value="1">甲类</option>
									<option value="2">乙类</option>
									<option value="3">工商</option>
									<option value="4">否</option></select>
								</div>
								<div class="form-group">
									<label>进口药</label><select id="imports">
									<option value="0">未知</option>
									<option value="1">进口药</option>
									<option value="2">非进口药</option></select>
								</div>
								<div class="form-group">
									<label>价格</label> <input class="form-control" type="text"
										id="priceMin" />
								</div>
							</form>
						</div>
					</div>
					<hr>

					<div class="col-md-10">
						<div class="form-inline pull-right">
							<div class=" pagination  ">
								<input type="button" id="submit" value="确认发布"
									class="btn btn-lg btn-success"><a
									href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=1"></a>
							</div>
						</div>
					</div>
				</div>
			</div> 
		</div>
	</div>
</body>
</html>