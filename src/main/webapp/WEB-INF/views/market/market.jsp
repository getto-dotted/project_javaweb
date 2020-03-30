<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
<script>
function check(){
	
	var chkArr = document.getElementsByName("choice");
	var chkStock = document.getElementsByName("cstock");
	var f = document.getElementsByName("choice");
	var g = document.getElementsByName("idx");	
	var j = document.getElementsByName("bprice");	
	var k = document.getElementsByName("nowpage");	
	var l = document.getElementsByName("cstock2");	
	
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
	
	if(cnt==0){
		alert("상품을 하나 이상 선택해 주세요.");
		return false;
	}
	
	if (tValue == 0) {
		alert("선택된 상품의 갯수가 0개입니다.");
		return false;
	}	
	
	if(f.length==1){		
		if(f[i].checked == false){
			g[i].disabled = true;
			j[i].disabled = true;
			k[i].disabled = true;			
			l[i].disabled = true;			
		}
	}
	else{		
		for(var i=0; i<f.length; i++){
			if(f[i].checked == false){
				g[i].disabled = true;
				j[i].disabled = true;
				k[i].disabled = true;				
				l[i].disabled = true;				
			}
		}		
	}		
	document.basket.action="../market/basketWritePrc";
	document.basket.method="post";
	document.basket.submit();
	
}

function check2(a,b,c,d){	
	
	var f =	document.basket;
	
	f.idx.value=a;	
	f.nowpage.value=b;	
	f.id.value=c;	
	f.bprice.value=d;		
}

function cstockSet() {
	
	var o = document.getElementsByName("cstock2"); 
	var c = document.getElementsByName("cstock"); 
	
	for (var i = 0; i < c.length; i++) {			
		 o[i].value = c[i].value;
	}  
}

</script>

 <body onload="cstockSet()">
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title" style="margin-bottom: 20px; ">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>				
				<div >
						<!-- 검색부분 -->
						<form class="form-inline" style="float: left; ">
							<div class="form-group" style="margin-bottom: 20px;">
						<button style="float: left; margin-left:10px; margin-right: 300px;" type="button" class="btn btn-warning" onclick="location.href='../market/basket';">장바구니</button>
						
								<select name="searchColumn" class="form-control">
									<option value="name" ${Column=="name" ? "selected" : ""}>상품명</option>
									<option value="info" ${Column=="info" ? "selected" : ""}>상품설명</option>
								</select>
							</div>
							<div class="input-group" style="margin-bottom: 20px;">
								<input type="text" name="searchWord" class="form-control" />
								<div class="input-group-btn">
									<button type="submit" class="btn btn-default">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
						</form>
					</div>
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
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
					<form name="basket">
						<c:forEach items="${lists }" var="row" varStatus="loop">
							<input type="hidden" name="idx" value="${row.idx }"/>
							<input type="hidden" name="nowpage" value="${param.nowPage }"/>
							<input type="hidden" name="bprice" value="${row.price }"/>	
							<input type="hidden" name="cstock2" />
						</c:forEach>				
					</form>				
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
										<form action="../market/basketWritePrc2">
										<input type="hidden" name="idx" value="${row.idx }"/>
										<input type="hidden" name="nowpage" value="${param.nowPage }"/>
										<input type="hidden" name="bprice" value="${row.price }"/>													
										<tr>									
											<td><input type="checkbox" name="choice"/></td>									
											<td>
												<a href="../market/View?idx=${row.idx }&nowPage=${param.nowPage }">
													<c:if test="${not empty row.nfile }">
														<img src="${pageContext.request.contextPath}/resources/Upload/${row.nfile }" width="100px" />														
													</c:if>
												</a>
											</td>
											<td class="t_left">${row.name }</td>		
											<td>${row.price }</td>
											<td><input type="text" name="cstock" class="n_box" onkeyup="cstockSet()"/></td>
											<td>
												<button type="button" onclick="check()"><img src="${pageContext.request.contextPath}/resources/images/market/btn02.gif" /></button>
												<br />
												<input type="image" src="${pageContext.request.contextPath}/resources/images/market/btn01.gif" formaction="../market/basketWritePrc2"/>
												<%-- <input type="image" src="${pageContext.request.contextPath}/resources/images/market/btn01.gif" /> --%>
												<%-- <input type="image" src="${pageContext.request.contextPath}/resources/images/market/btn02.gif" /> --%>
											</td>											
										</tr>
										</form>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
					<div class="row text-center">
					<!-- 페이지번호 부분 -->	
						${pagingImg }	
				</div>		
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
