function authControl(auth) {

	if ((auth & 1) === 0) {
		$("a[name='create']").remove();
	}
	if ((auth & 2) === 0) {
		$("a[name='delete']").remove();
	}
	if ((auth & 4) === 0) {
		$("a[name='update']").remove();
	}
	if ((auth & 8) === 0) {
		$("a[name='publish']").remove();
	}
}

function isEdit(auth) {
	if ((auth & 5) === 0) {
		$("#submit").remove();
	}
}

function isPublish(status) {
	if (status == 1)
		return "已发布";
	else
		return "未发布";
}

function pageUp() {
	$("#pageIndex").val($("#pageIndex").val() - 1);
	$("#goto").click();
}

function pageDown() {
	$("#pageIndex").val(parseInt($("#pageIndex").val()) + 1);
	$("#goto").click();
}

function showDiv(dialog) {
	$("#fullbg").css("height", document.body.scrollHeight);
	$("#fullbg").css("display", "block");
	$("#" + dialog).css("display", "block");
}

function closeDiv(dialog) {
	$("#fullbg").css("display", "none");
	$("#" + dialog).css("display", "none");
}

// 获取url参数
function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg); // 匹配目标参数
	if (r != null)
		return unescape(r[2]);
	return null; // 返回参数值
}

function deleteData(idValue, idName, tableName, dataType) {
	if (confirm("确定要删除么？")) {
		$.ajax({
			type : "GET",
			url : "../common/deleteData",
			contentType : "application/json",
			dataType : "json",
			data : {
				idValue : idValue,
				idName : idName,
				tableName : tableName,
				dataType : dataType
			},
			success : function(data) {
				alert("ok");
				$('#goto').click();
			}
		});
	}
}

function setPageInfo(totalPage, indexPage) {
	$("#totalPage").val(totalPage);

	var startPage = indexPage - 2;
	var endPage = indexPage + 2;
	var liHtml = "<li><a href=\"#\" onclick=\"gotoPage(" + (indexPage - 1)
			+ ")\">&laquo;</a></li>";
	if (startPage < 1) {
		endPage = endPage + (1 - startPage);
		startPage = 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	} else if (endPage > totalPage) {
		startPage = startPage - (endPage - totalPage);
		endPage = totalPage;
		if (startPage < 1) {
			startPage = 1;
		}
	}
	for (var i = startPage; i <= endPage; i++) {
		if (i == indexPage) {
			liHtml += "<li class=\"active\"><a href=\"#\" onclick=\"gotoPage("
					+ i + ")\">" + i + "</a></li>"
		} else {
			liHtml += "<li><a href=\"#\" onclick=\"gotoPage(" + i + ")\">" + i
					+ "</a></li>"
		}
	}
	liHtml += "<li><a href=\"#\" onclick=\"gotoPage(" + (indexPage + 1)
			+ ")\">&raquo;</a></li>";
	$("#pageList").html(liHtml);
}

function setPageIndex() {
	if (Number($("#pageIndex").val()) < 1) {
		$("#pageIndex").val(1);
	} else if (Number($("#pageIndex").val()) > Number($("#totalPage").val())) {
		$("#pageIndex").val($("#totalPage").val());
	}
}

function gotoPage(page) {
	$("#pageIndex").val(page);
	$("#goto").click();
}

function delPic(img, path) {
	$("#" + img).attr("src", "../../assets/img/demoUpload.jpg");
	$("#" + path).val("");
}

function showTime(unixTime) {
	var time = new Date(unixTime);
	var ymdhis = "";
	ymdhis += time.getFullYear() + "-";
	ymdhis += (time.getMonth() + 1) + "-";
	ymdhis += time.getDate() + " ";
	ymdhis += time.getHours() + ":";
	ymdhis += time.getMinutes();
	return ymdhis;
}