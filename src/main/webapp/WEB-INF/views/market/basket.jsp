<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
<script>


function check(){			
	var chkArr = document.getElementsByName("choice");
	var chkStock = document.getElementsByName("cstock");
		
	var cnt =0;
	var tValue = 0;
	
	for (var i = 0; i < chkArr.length; i++) {
		if (chkArr[i].checked == true) {
			cnt++;				
		}			
	}
	
	for (var i = 0; i < chkStock.length; i++) {			
			 tValue += chkStock[i].value;
		
		 if(isNaN(parseInt(chkArr[i].value))){
			 tValue = 0;
         }
	}
	
	if (tValue == 0) {
		alert("선택된 상품의 갯수가 0개입니다.");
		return false;
	}
	
	if(cnt==0){
		alert("상품을 하나 이상 선택해 주세요.");
		return false;
	}
	
	var f = document.getElementsByName("choice");
	var g = document.getElementsByName("pid");
	var h = document.getElementsByName("idx");
	var q = document.getElementsByName("onum");
		
	if(f.length==1){		
		if(f[i].checked == false){
			g[i].disabled = true;
			h[i].disabled = true;
			q[i].disabled = true;
		}
	}
	else{		
		for(var i=0; i<f.length; i++){
			if(f[i].checked == false){
				g[i].disabled = true;				
				h[i].disabled = true;				
				q[i].disabled = true;				
			}
		}
		
	}		
	
	document.basket.action="../market/basketUpdatePrc2";
	document.basket.method="post";
	document.basket.submit();
	
	}
	
	function del(d){
		var f = document.basket
		document.basket.pid.value = d;
		f.method = "post";
		f.action = "../market/basketDelete";
		f.submit();
	}
	
	function onumSet() {
		
		var a = document.getElementsByName("tPrice"); 
		var a1 = document.getElementsByName("Price"); 
		
		var b = document.getElementsByName("dPrice2"); 
		var b1 = document.getElementsByName("dPrice1"); 
		
		var e = document.getElementsByName("choice"); 
		var o = document.getElementsByName("onum"); 
		var c = document.getElementsByName("cstock"); 
		
		for (var i = 0; i < c.length; i++) {			
			o[i].value = c[i].value;
			e[i].value = c[i].value;
			a[i].value = a1[i].value;
			b[i].value = b1[i].value;			
		}  
		stockSetting();
	}
	
	function stockSetting(){
		
		var size = document.getElementsByName("choice").length;
		var qty = document.getElementsByName("choice");
		var pri = document.getElementsByName("tPrice"); 
		var dpri = document.getElementsByName("dPrice2"); 
		var tdV = document.getElementsByName("tdPrice"); 		
	 	var totalP =0;
	    var deliP =0;
	    var finalP =0;
		
		/* choice name을 가진 요소의 value 가져오기    
	    for(var i = 0; i < size; i++){
	        console.log(document.getElementsByName("choice")[i].value+"(dd)");
	    } */
	    //choice name을 가진 요소중에서 체크된 것만 값 가져오기   
	    //값을 지워버리면 체크를 풀어버리기
	    for(var i = 0; i < size; i++){
	        if(document.getElementsByName("choice")[i].checked == true){	           
	            if(isNaN(parseInt(qty[i].value))){
	            	document.getElementsByName("choice")[i].checked =false;
	            }
	            else{	            	
		            totalP += parseInt(qty[i].value) * parseInt(pri[i].value);
		            deliP += parseInt(dpri[i].value);	   
	            	tdV[i].innerHTML = parseInt(qty[i].value) * parseInt(pri[i].value) + parseInt(dpri[i].value) +" 원";
	            }
	        }
	    }
	    finalP += parseInt(totalP)+parseInt(deliP);	            
        
        document.getElementById("tp").innerHTML=totalP;
        document.getElementById("td").innerHTML=deliP;
        document.getElementById("tt").innerHTML=finalP;
	}
	
	function focusCheck(d){//수량을 클릭or변경하면 체크 활성화
		var c = document.getElementsByName("choice");
		document.getElementsByName("choice")[d].checked =true;
		
	}
	
$(function(){		
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));		    
	});			
});
</script>
<style>
.td {
text-align: center;}
</style>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
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
							<form name="basket">
								<c:forEach items="${lists }" var="row" varStatus="loop">
									<input type="hidden" name="pid" value="${row.pid }"/> 												
									<input type="hidden" name="idx" value="${row.idx }"/> 												
									<input type="hidden" name="onum"/> 	
										
									<input type="hidden" name="Price"  value="${row.price }"/> 		
									<input type="hidden" name="tPrice" /> 		
									<input type="hidden" name="dPrice1" value="${row.dprice }" /> 		
									<input type="hidden" name="dPrice2" /> 		
																													
									<input type="hidden" name="nowPage" value="${param.nowPage}"/> 	
								</c:forEach>									
							</form>							
							<c:choose>
								<c:when test="${empty lists }">
									<tr>
										<td colspan="6">선택한 상품이 없습니다.</td>
									</tr>											
								</c:when>
								<c:otherwise>
									<c:forEach items="${lists }" var="row" varStatus="loop">									
										<tr>		
											<td><input type="checkbox" name="choice" class="check" onclick="onumSet()"/></td>									
											<td>
												<img src="../resources/Upload/${row.nfile }" width="80px" />														
											</td>
											<td class="t_left" style="text-align: center;">${row.name }</td>		
											<td style="text-align: center;">${row.price }</td>
											<td>${row.dispoint }</td>
											<td><input type="text" numberOnly name="cstock" value="${row.onum}" 
												onkeyup="onumSet()" onkeydown="focusCheck(${loop.index })" onfocus="focusCheck(${loop.index })" /></td>
											<td><c:choose><c:when test="${not empty row.deli}">${row.deli }</c:when>	
											<c:otherwise>무료배송</c:otherwise>
											</c:choose></td>
											<td><span >${row.dprice } 원</span></td>												
											<td style="color:green" name="tdPrice" >${row.price*row.onum+row.dprice } 원</td>
											<td><button type="button" onclick="del(${row.pid });"><img src="../images/delete.jpg" width="40px;" /></button></td>											
										</tr>										
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tr>
					</tbody>
				</table>									
				<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span><span id="tp">0 원</span> + 
				<span>배송비</span><span id="td">0 원</span> = 합계 : <span id="tt">0 원</span><br /><br />
				<a href="../market/market"><img src="../images/market/basket_btn01.gif" /></a>&nbsp;
				<button type="button" onclick="check()"><input type="image" src="../images/market/basket_btn02.gif" /></button></p>
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
