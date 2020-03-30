<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>정보게시판</title>

<!-- Custom fonts for this template-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link
	href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin.css"
	rel="stylesheet">


</head>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

		<a class="navbar-brand mr-1" href="index.html">Start Bootstrap</a>

		<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>

		<!-- Navbar Search -->
		<form
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="Search for..."
					aria-label="Search" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-primary" type="button">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</div>
		</form>

		<!-- Navbar -->
		<ul class="navbar-nav ml-auto ml-md-0">
			<li class="nav-item dropdown no-arrow mx-1"><a
				class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <span
					class="badge badge-danger">9+</span>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="alertsDropdown">
					<a class="dropdown-item" href="#">Action</a> <a
						class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div></li>
			<li class="nav-item dropdown no-arrow mx-1"><a
				class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <span
					class="badge badge-danger">7</span>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="messagesDropdown">
					<a class="dropdown-item" href="#">Action</a> <a
						class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div></li>
			<li class="nav-item dropdown no-arrow"><a
				class="nav-link dropdown-toggle" href="#" id="userDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-user-circle fa-fw"></i>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="userDropdown">
					<a class="dropdown-item" href="#">Settings</a> <a
						class="dropdown-item" href="#">Activity Log</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#" data-toggle="modal"
						data-target="#logoutModal">Logout</a>
				</div></li>
		</ul>

	</nav>

	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item"><a class="nav-link" href="index.html">
					<i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span>
			</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-folder"></i> <span>Pages</span>
			</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Login Screens:</h6>
					<a class="dropdown-item" href="login.html">Login</a> <a
						class="dropdown-item" href="register.html">Register</a> <a
						class="dropdown-item" href="forgot-password.html">Forgot
						Password</a>
					<div class="dropdown-divider"></div>
					<h6 class="dropdown-header">관리목록:</h6>
					<a class="dropdown-item" href="./">복지관 메인</a> <a
						class="dropdown-item" href="./notice">게시판관리 페이지</a> <a
						class="dropdown-item" href="./market">상품관리 페이지</a> <a
						class="dropdown-item" href="./member">회원관리 페이지</a> <a
						class="dropdown-item" href="./order">신청관리 페이지</a>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="charts.html">
					<i class="fas fa-fw fa-chart-area"></i> <span>Charts</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="tables.html">
					<i class="fas fa-fw fa-table"></i> <span>Tables</span>
			</a></li>
		</ul>

		<div id="content-wrapper">

			<div class="container-fluid">
				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="./notice">공지사항</a></li>
					<li class="breadcrumb-item"><a href="./program">프로그램 일정</a></li>
					<li class="breadcrumb-item"><a href="./free">자유게시판</a></li>
					<li class="breadcrumb-item"><a href="./pic">사진게시판</a></li>
					<li class="breadcrumb-item active">정보게시판</li>
					<li class="breadcrumb-item"><a href="./crew">직원게시판</a></li>
					<li class="breadcrumb-item"><a href="./fam">보호자게시판</a></li>
				</ol>
				<div class="row text-right"
					style="margin-bottom: 20px; padding-right: 50px;">
					<!-- 검색부분 -->
					<form class="form-inline">
						<div class="form-group">
							<select name="searchColumn" class="form-control">
								<option value="title" ${Column=="title" ? "selected" : ""}>제목</option>
								<option value="name" ${Column=="name" ? "selected" : ""}>작성자</option>
								<option value="content" ${Column=="content" ? "selected" : ""}>내용</option>
							</select>
						</div>
						<div class="input-group">
							<input type="text" name="searchWord" class="form-control" />
							<div class="input-group-btn">
								<button type="submit" class="btn btn-default">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<div class="row">
					<!-- 게시판리스트부분 -->
					<table class="table table-bordered table-hover">
						<colgroup>
							<col width="80px"/>
							<col width="80px"/>
							<col width="*"/>
							<col width="150px"/>
							<col width="200px"/>
							<col width="80px"/>
							<col width="80px"/>
						</colgroup>
						<thead>
							<tr class="success" style="background-color: #99ffcc;">
								<th class="text-center">체크</th>
								<th class="text-center">번호</th>
								<th class="text-left">제목</th>
								<th class="text-center">작성자</th>
								<th class="text-center">작성일</th>
								<th class="text-center">조회수</th>
								<th class="text-center">첨부</th>
							</tr>
						</thead>
						<tbody>
							<!-- 리스트반복 -->
							<tr>
								<c:choose>
									<c:when test="${empty lists }">
										<tr>
											<td colspan="6">등록된 게시물이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${lists }" var="row" varStatus="loop">
											<tr>
												<td><input type="checkbox" class="idx" name="idx"
													id="idx" /></td>
												<td>${totalCount-(((nowPage-1)*pageSize)+loop.index) }</td>
												<td><a
													href="../notice/View?idx=${row.idx }&nowPage=${param.nowPage }">${row.title }</a></td>
												<td>${row.name }</td>
												<td>${row.pday }</td>
												<td>${row.vcnt }</td>
												<td align="center"><c:if test="${not empty row.ofile }">
														<a
															href="../notice_Download?ofile=${row.ofile }&nfile=${row.nfile }&idx=${row.idx }">
															<img src="../resources/images/disk.png" width="20" alt="" />
														</a>
													</c:if></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="row text-center" style="padding-right: 50px;">

					<form name="writeForm">
						<input type="hidden" name="tname" value="notice" /> <input
							type="hidden" name="user_id"
							value="<%=session.getAttribute("user_id")%>" />
					</form>

				</div>
				<div class="row text-center">
					<span style="padding-left: 800px">${pagingImg }</span>
				</div>



				<!-- /.container-fluid -->

				<!-- Sticky Footer -->
				<footer class="sticky-footer">
					<div class="container my-auto">
						<div class="copyright text-center my-auto">
							<span>Copyright © Your Website 2019</span>
						</div>
					</div>
				</footer>

			</div>
			<!-- /.content-wrapper -->

		</div>
		<!-- /#wrapper -->

		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fas fa-angle-up"></i>
		</a>

		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="login.html">Logout</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Bootstrap core JavaScript-->
		<script
			src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script
			src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script
			src="${pageContext.request.contextPath}/resources/js/sb-admin.min.js"></script>
</body>

</html>
