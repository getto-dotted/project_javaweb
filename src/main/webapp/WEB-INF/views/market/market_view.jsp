<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
function delFunc(){
	var f = document.mod_del
	
	if(confirm('삭제하시겠습니까?')){
		f.action="../market/delete";
		f.method="post";
		return;
	}	
}
function modFunc(){
	var f = document.mod_del
	
	f.action="../market/modify";
	f.method="post";		
	return;
}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents" align="center">
				<c:forEach items="${lists }" var="row">	
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<div class="market_view_box">
					<div class="market_left">
						<c:if test="${not empty row.nfile }">
							<img src="../resources/Upload/${row.nfile }" width="300px" />														
						</c:if>						
					</div>
					<div class="market_right">
						<p class="m_title">${row.name }
						<p>■ ${row.name }</p>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style">${row.price }</dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd>${row.dispoint }</dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd style="margin-bottom: 10px;"><input type="number" name="cstock" value="1" class="n_box" /></dd>									
									<dt>재고</dt>
									<dd>${row.stock } 개</dd>
								</dl>
								<dl>
									<dt>상품 상세설명</dt><br />
									<dd style="text-align: center;">${row.info }</dd>
								</dl>
								<dl>
									<dt>배송정보</dt>
									<dd>${row.deli }</dd>
									<dt>배송비</dt>
									<dd>${row.dprice }</dd>
								</dl>								
								<dl style="border-bottom:0px;">
									<dt>주문정보</dt>
									<dd><input type="text" name="etc" class="n_box" style="width:200px;" /></dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box"><a href=""><img src="../images/market/m_btn01.gif" alt="바로구매" /></a>&nbsp;&nbsp;<a href="basket.jsp"><img src="../images/market/m_btn02.gif" alt="장바구니" /></a></p>
					</div>				
				</div>
					<!-- 각종 버튼 부분 -->
					<form name="mod_del">
						<input type="hidden" name="idx" value="${param.idx }"/>
						<input type="hidden" name="backURL" value="/market/View?idx="/>
						<div class="row text-center" style="">
				<c:if test="${sessionScope.user_grade gt 0 }">
					<button type="submit" class="btn btn-primary" onclick="javascript:modFunc()">수정하기</button>
					<button type="submit" class="btn btn-success" onclick="javascript:delFunc()">삭제하기</button>
				</c:if>
				<button type="button" class="btn btn-warning"
					onclick="location.href='../market/market';">리스트보기</button>	
					</form> 
			</div>
		</div>			
</c:forEach>
			<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
