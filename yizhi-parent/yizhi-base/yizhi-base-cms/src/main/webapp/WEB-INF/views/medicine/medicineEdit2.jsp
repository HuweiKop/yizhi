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
<!-- GOOGLE FONTS-->
<link href='http://fonts.useso.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
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
					var data1 = {
						"medicine" : {
							"id" : id,
							"name" : $("#name").val(),
							"pinyinName" : $("#pinyinName").val(),
							"useInfo" : $("#useInfo").val(),
							"taboo" : $("#taboo").val(),
							"sideEffect" : $("#sideEffect").val(),
							"isPrescription" : $("#isPrescription")
									.is(':checked'),
							"isChinese" : $("#isChinese").is(':checked'),
							"isWestern" : $("#isWestern").is(':checked'),
							"isMedicalInsurance" : $("#isMedicalInsurance").is(
									':checked'),
							"isSpecial" : $("#isSpecial").is(':checked'),
							"isImport" : $("#isImport").is(':checked'),
							"priceMin" : $("#priceMin").val(),
							"priceMax" : $("#priceMin").val(),
							"chemicalId" : $("#chemical").val(),
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
				$("#useInfo").val(data.data.medicine.useInfo);
				$("#taboo").val(data.data.medicine.taboo);
				$("#sideEffect").val(data.data.medicine.sideEffect);
				$("#isPrescription").attr("checked",
						data.data.medicine.isPrescription);
				$("#isWestern").attr("checked", data.data.medicine.isWestern);
				$("#isChinese").attr("checked", data.data.medicine.isChinese);
				$("#isMedicalInsurance").attr("checked",
						data.data.medicine.isMedicalInsurance);
				$("#isSpecial").attr("checked", data.data.medicine.isSpecial);
				$("#isImport").attr("checked", data.data.medicine.isImport);
				$("#priceMin").val(data.data.medicine.priceMin);
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
</script>
</head>
<body>
<jsp:include page="../common/head.jsp"></jsp:include>
	<input type="button" id="xx" onclick="xx()" />
	<input type="hidden" id="medicineId" value="${medicineId}" />
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
									<label>药品名称</label> <input class="form-control"
										type="text" id="name" />
								</div>
								<div class="form-group">
									<label>药品拼音<input type="button" value="获取拼音"
										onclick="getPinyin()" /></label> <input class="form-control"
										type="text" id="pinyinName" />
								</div>
								<div class="form-group">
									<label>化学名</label><select id="chemical"></select>
								</div>
								<div class="form-group">
									<label>药厂</label><select id="manufacturer"></select>
								</div>
								<div class="form-group">
									<label>药品用量</label><textarea class="form-control" rows="3" id="useInfo"></textarea>
								</div>
								<div class="form-group">
									<label>禁忌</label><textarea class="form-control" rows="3" id="taboo"></textarea>
								</div>
								<div class="form-group">
									<label>副作用</label><textarea class="form-control" rows="3" id="sideEffect"></textarea>
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isPrescription" />处方药</label>
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isWestern" />西药</label>
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isChinese" />中药</label>
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isSpecial" />特种药</label>
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isMedicalInsurance" />医保药</label>
								</div>
								<div class="form-group">
									<label><input type="checkbox" id="isImport" />进口药</label>
								</div>
								<div class="form-group">
									<label>价格</label> <input class="form-control"
										type="text" id="priceMin" />
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
	<input type="button" id="submit" value="提交" />
			<a href="<%=request.getContextPath() %>/web/medicine/medicineList" >返回列表</a>
		</div>
	</div>
</body>
</html>