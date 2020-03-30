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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

function check(){
	
	var chkArr = document.getElementsByName("choice");
	var chkStock = document.getElementsByName("cstock");
	
	var f = document.getElementsByName("choice");
	var g = document.getElementsByName("cstock");
	var h = document.getElementsByName("price");
	
	if(f.length==1){
		
		if(f[i].checked == false){
			g[i].disabled = true;
			h[i].disabled = true;
		}
	}
	else{
		
		for(var i=0; i<f.length; i++){
			if(f[i].checked == false){
				g[i].disabled = true;
				h[i].disabled = true;
			}
		}
		
	}
	var cnt =0;
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
	
	if(cnt==0){
		alert("상품을 하나 이상 선택해 주세요.");
		return false;
	} 	

		var f = document.basket
		f.method = "post";
		f.action = "../market/purchase";
		f.submit();
	}	
	
	function del(d){
		var f = document.basket
		document.basket.pid.value = d;
		f.method = "post";
		f.action = "../market/basketDelete";
		f.submit();
	}
$(function(){
		var price =	$('.price').val;
		var cstock = $('.cstock').val;
		var dprice = $('.dprice').val;
		var tp = $('#tp').val;
		var td = $('#td').val;
	$('.check').click(function(){
		$('#tp').html(price*cstock);
		$('#td').html(dprice);
		$('#tt').html(tp+td);
	});
	$('.cstock').click(function(){
		$('#tp').html(price*cstock);
		$('#td').html(dprice);
		$('#tt').html(tp+td);
	});
});
</script>
<style>
.td {
	text-align: center;
}
</style>
<c:set var="row" value="${lists}" />
<c:set var="ttprice" value="0" />
<c:set var="tdprice" value="0" />
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
					<li class="breadcrumb-item"><a href="./market">상품관리</a></li>
					<li class="breadcrumb-item active">장바구니 관리</li>
				</ol>

				<div class="contents_box">
					<div class="right_contents">
						<table cellpadding="0" cellspacing="0" border="0"
							class="basket_list">
							<colgroup>
								<col width="7%" />
								<col width="10%" />
								<col width="*" />
								<col width="10%" />
								<col width="8%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="8%" />
							</colgroup>
							<thead>
								<tr>
									<th>선택</th>
									<th>이미지</th>
									<th>상품명</th>
									<th>판매가</th>
									<th>적립금</th>
									<th>수량</th>
									<th>배송구분</th>
									<th>배송비</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
								<!-- 리스트반복 -->
								<tr>
									<form name="basket" method="post">
										<input type="hidden" name="pid" /> <input type="hidden"
											name="nowPage" value="${param.nowPage}" />
									</form>
									<c:choose>
										<c:when test="${empty lists }">
											<tr>
												<td colspan="6">장바구니에 상품이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${lists }" var="row" varStatus="loop">

												<tr>
													<td><input type="checkbox" name="choice"
														value="${row.idx }" class="check" /></td>
													<td><img src="../resources/Upload/${row.nfile }"
														width="80px" /></td>
													<td class="t_left" style="text-align: center;">${row.name }</td>
													<td style="text-align: center;" class="price">${row.price }</td>
													<td>${row.dispoint }</td>
													<td><input type="text" name="cstock"
														value="${row.cstock}" class="n_box" class="cstock" /></td>
													<td><c:choose>
															<c:when test="${not empty row.deli}">${row.deli }</c:when>
															<c:otherwise>무료배송</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${not empty row.dprice}">
																<span class="dprice">${row.dprice }</span>원</c:when>
															<c:otherwise>
																<span class="dprice">0</span>원</c:otherwise>
														</c:choose></td>
													<td style="color: green">${row.price+row.dprice }원</td>
													<td>
														<!-- <button type="button" onclick="check()"><img src="../images/market/btn01.gif" /></button><br /> -->
														<button type="button" onclick="del(${row.pid });">
															<img src="../images/delete.jpg" width="40px;" />
														</button>
													</td>

												</tr>
												<c:set var="ttprice" value="${ttprice + row.price }" />
												<c:set var="tdprice" value="${tdprice + row.dprice }" />
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tr>
							</tbody>
						</table>

						<p class="basket_text">
							[ 기본 배송 ] <span>상품구매금액</span><span id="tp">0 원</span> + <span>배송비</span><span
								id="td">0 원</span> = 합계 : <span id="tt">0 원</span><br />
							<br /> <a href="../market/market"><img
								src="../images/market/basket_btn01.gif" /></a>&nbsp;<a
								href="../market/basket02"><input type="image"
								src="../images/market/basket_btn02.gif" />
						</p>
						</a>
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
