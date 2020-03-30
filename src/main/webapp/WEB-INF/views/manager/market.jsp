<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<script>
	function check(f) {

		var chkArr = document.getElementsByName("choice");
		var chkStock = document.getElementsByName("cstock");
		var cnt = 0;
		var tValue = 0;

		for (var i = 0; i < chkArr.length; i++) {
			if (chkArr[i].checked == true) {
				cnt++;
			}
		}

		for (var i = 0; i < chkStock.length; i++) {
			tValue += chkStock[i].value;
		}

		if (tValue == 0) {
			alert("선택된 상품의 갯수가 0개입니다.");
			return false;
		}

		if (cnt == 0) {
			alert("상품을 하나 이상 선택해 주세요.");
			return false;
		}
		f.action = "../market/basketWritePrc";
	}
</script>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>수아밀 상품관리</title>

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
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="./basket">장바구니 관리</a></li>
					<li class="breadcrumb-item active">상품관리</li>
				</ol>
				<div class="contents_box">
					<div class="right_contents">
						<div class="row text-right"
							style="margin-bottom: 20px; padding-right: 50px;">
							<!-- 검색부분 -->
							<form class="form-inline">
								<div class="form-group">
									<select name="searchColumn" class="form-control">
										<option value="name" ${Column=="name" ? "selected" : ""}>상품명</option>
										<option value="info" ${Column=="info" ? "selected" : ""}>상품설명</option>
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
						<table cellpadding="0" cellspacing="0" border="0"
							class="market_board01">
							<colgroup>
								<col width="5%" />
								<col width="20%" />
								<col width="*" />
								<col width="10%" />
								<col width="10%" />
								<col width="15%" />
							</colgroup>
							<tr>
								<th>선택</th>
								<th>상품이미지</th>
								<th>상품명</th>
								<th>가격</th>
								<th>수량</th>
								<th>구매</th>
							</tr>
							<!-- 리스트반복 -->
							<tr>
								<c:choose>
									<c:when test="${empty lists }">
										<tr>
											<td colspan="6">등록된 상품이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${lists }" var="row" varStatus="loop">
											<tr>
												<form method="post" name="basket"
													onsubmit="return check(this)">
													<input type="hidden" name="idx" value="${row.idx }" /> <input
														type="hidden" name="nowpage" value="${param.nowPage }" />
													<input type="hidden" name="id"
														value="<%=session.getAttribute("user_id")%>" /> <input
														type="hidden" name="bprice" value="${row.price }" />
													<td><input type="checkbox" name="choice"
														value="${row.idx }" /></td>
													<td><a
														href="../market/View?idx=${row.idx }&nowPage=${param.nowPage }">
															<c:if test="${not empty row.nfile }">
																<img
																	src="${pageContext.request.contextPath}/resources/Upload/${row.nfile }"
																	width="100px" />
															</c:if>
													</a></td>
													<td class="t_left">${row.name }</td>
													<td>${row.price }</td>
													<td><input type="text" name="cstock" value="0"
														class="n_box" width="50px" /></td>
													<td><input type="image"
														src="${pageContext.request.contextPath}/resources/images/market/btn01.gif" />
														<br /> <a href="../market/basket"><button
																type="button">
																<img
																	src="${pageContext.request.contextPath}/resources/images/market/btn02.gif" />
															</button></a> <%-- <input type="image" src="${pageContext.request.contextPath}/resources/images/market/btn02.gif" /> --%>
													</td>
												</form>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tr>
						</table>
						<div class="row text-center">
							<span style="padding-left: 800px">${pagingImg }</span>
						</div>
					</div>
				</div>

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
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
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
