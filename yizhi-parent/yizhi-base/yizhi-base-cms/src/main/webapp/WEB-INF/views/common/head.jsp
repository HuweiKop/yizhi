<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<input type="hidden" id="userAuth" value="${userAuth}" />
<div>
	<!--  <a href='<%=request.getContextPath()%>/web/hospital/hospitalList'>医院</a>
	<a href='<%=request.getContextPath()%>/web/doctor/doctorList'>医生</a> <a
		href='<%=request.getContextPath()%>/web/disease/diseaseList'>癌症</a> <a
		href='<%=request.getContextPath()%>/web/disease/indexList'>指标</a> <a
		href='<%=request.getContextPath()%>/web/disease/inspectionList'>检查</a>
	<a href='<%=request.getContextPath()%>/web/disease/therapeuticList'>治疗</a>
	<a href='<%=request.getContextPath()%>/web/medicine/medicineList'>药品</a>
	<a href='<%=request.getContextPath()%>/web/medicine/manufacturerList'>药厂</a> -->

</div>
	<input type="hidden" id="zhongmebanBucket" value="${zhongmebanBucket}" />
	<input type="hidden" id="endPoint" value="${endPoint}" />
<div id="wrapper">
	<nav class="navbar navbar-default navbar-cls-top " role="navigation"
		style="margin-bottom: 0">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".sidebar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.html">COMPANY NAME</a>
		</div>

		<div class="header-right">

			<a href="message-task.html" class="btn btn-info" title="New Message"><b>30
			</b><i class="fa fa-envelope-o fa-2x"></i></a> <a href="message-task.html"
				class="btn btn-primary" title="New Task"><b>40 </b><i
				class="fa fa-bars fa-2x"></i></a> <a href="../../login/login"
				class="btn btn-danger" title="Logout"><i
				class="fa fa-exclamation-circle fa-2x"></i></a>


		</div>
	</nav>
	<!-- /. NAV TOP  -->
	<nav class="navbar-default navbar-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav" id="main-menu">
				<li>
					<div class="user-img-div">
						<img src="assets/img/user.png" class="img-thumbnail" />

						<div class="inner-text">
							Jhon Deo Alex <br /> <small>Last Login : 2 Weeks Ago </small>
						</div>
					</div>

				</li>


				<li><a
					href="<%=request.getContextPath()%>/web/doctor/doctorList"><i
						class="fa fa-dashboard "></i>医生列表</a></li>
				<li><a
					href="<%=request.getContextPath()%>/web/hospital/hospitalList"><i
						class="fa fa-dashboard "></i>医院列表</a></li>

				<li><a href="#"><i class="fa fa-desktop "></i>癌症管理<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<%=request.getContextPath()%>/web/disease/diseaseList"><i
								class="fa fa-toggle-on"></i>癌症列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/disease/indexList"><i
								class="fa fa-toggle-on"></i>指标列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/disease/inspectionList"><i
								class="fa fa-toggle-on"></i>检查列表</a></li>
					</ul></li>
					<li><a href="#"><i class="fa fa-desktop "></i>治疗管理<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=1"><i
								class="fa fa-toggle-on"></i>手术列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=2"><i
								class="fa fa-toggle-on"></i>化疗列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/disease/therapeuticList?category=3"><i
								class="fa fa-toggle-on"></i>放疗列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/disease/surgeryMethodList"><i
								class="fa fa-toggle-on"></i>手术方法列表</a></li>
					</ul></li>
				<li><a href="#"><i class="fa fa-desktop "></i>药品管理<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<%=request.getContextPath()%>/web/medicine/medicineList"><i
								class="fa fa-toggle-on"></i>药品列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/medicine/manufacturerList"><i
								class="fa fa-toggle-on"></i>药厂列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/medicine/chemicalList"><i
								class="fa fa-toggle-on"></i>化学名列表</a></li>
					</ul></li>
				<li><a href="#"><i class="fa fa-desktop "></i>文章管理<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<%=request.getContextPath()%>/web/information/informationList"><i
								class="fa fa-toggle-on"></i>信息列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/information/recommendList"><i
								class="fa fa-toggle-on"></i>推荐列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/information/tipsList"><i
								class="fa fa-toggle-on"></i>小贴士列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/information/interpretationList"><i
								class="fa fa-toggle-on"></i>名词解释列表</a></li>
					</ul></li>
				<li><a href="#"><i class="fa fa-desktop "></i>权限管理<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<%=request.getContextPath()%>/web/manage/userList"><i
								class="fa fa-toggle-on"></i>用户列表</a></li>
						<li><a
							href="<%=request.getContextPath()%>/web/manage/roleList"><i
								class="fa fa-toggle-on"></i>角色列表</a></li>
					</ul></li>
			</ul>
		</div>

	</nav>
</div>