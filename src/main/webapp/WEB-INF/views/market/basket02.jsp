<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
function daumZipFind1(){
    new daum.Postcode({
        oncomplete: function(data) {
        	document.getElementById("mzipcode").value = data.zonecode;
        	document.getElementById("maddr1").value = data.address;
        	document.getElementById("maddr2").focus();        	
        }
    }).open();
}
function daumZipFind(){
    new daum.Postcode({
        oncomplete: function(data) {
        	var f = document.deliAddr;
        	f.zipcode.value = data.zonecode;	
        	f.addr1.value = data.address;
        	f.addr2.focus();
        }
    }).open();
}
	
function check(){			
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
	
	var chkArr = document.getElementsByName("choice");
	var chkStock = document.getElementsByName("cstock");
	var chkPayment = document.getElementsByName("pay");
		
	var cnt =0;
	var tValue = 0;
	var pValue = 0;
		
	for (var i = 0; i < chkPayment.length; i++) {
		if (chkPayment[i].checked == true) {
			pValue++;				
		}			
	}
	
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
	if(pValue==0){
		alert("결제수단을 선택해 주세요.");
		return false;
	}
	document.deliAddr.action="../market/basketUpdatePrc";
	document.deliAddr.method="post";
	
}

function onumSet() {
	
	var o = document.getElementsByName("onum"); 
	var c = document.getElementsByName("cstock"); 
	
	for (var i = 0; i < c.length; i++) {			
		 o[i].value = c[i].value;
	}  
}

$(function(){		
		
	var fp = 0;
	$('.choice').bind("change",function(){	
		var tp = $(this).attr('value');
		if($(this).is(":checked")){
			fp += parseInt(tp);
		}		
		else{
			fp -= parseInt(tp);
		}
		
		$('#tmoney').html(fp);		
	
	});
	
	
	$('#mname').val($('#fname1').attr('value'));
	$('#mzipcode').val($('#fzipcode1').attr('value'));
	$('#maddr1').val($('#faddr11').attr('value'));
	$('#maddr2').val($('#faddr21').attr('value'));
	$('#mmobile1').val($('#fmobile11').attr('value'));
	$('#mmobile2').val($('#fmobile21').attr('value'));
	$('#mmobile3').val($('#fmobile31').attr('value'));
	$('#memail1').val($('#femail11').attr('value'));
	$('#memail2').val($('#femail21').attr('value'));	
	
	$('#radio1').bind("click",function(){	
		$('#rname').val(document.getElementById("mname").value);
		$('#rzipcode').val(document.getElementById("mzipcode").value);
		$('#raddr1').val(document.getElementById("maddr1").value);
		$('#raddr2').val(document.getElementById("maddr2").value);
		$('#rmobile1').val(document.getElementById("mmobile1").value);
		$('#rmobile2').val(document.getElementById("mmobile2").value);
		$('#rmobile3').val(document.getElementById("mmobile3").value);
		$('#remail1').val(document.getElementById("memail1").value);
		$('#remail2').val(document.getElementById("memail2").value);
	});
	
	$('#radio2').click(function(){
		document.deliAddr.reset();
	}); 
	
	$('#radio1').trigger('click');
	
	 
});

function pNumberFunc(pNumber){
	
	$.ajax({
  		 url: './basket03',
  		 dataType : "html",
  		 type : "get",
  		 contentType : "text/html;charset:utf-8",
  		 data : {nowPage:pNumber},
  		 success : function(d){
  			 $('#deliTable').html(d); 
  		 }
	});
}
</script>

 <body onload="onumSet()">
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
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list" style="margin-bottom:50px;">
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
					<tbody id="deliTable">					
						<c:choose>
							<c:when test="${empty lists }">
								<tr>
									<td colspan="6">장바구니에 고른 상품이 없습니다.</td>
								</tr>											
							</c:when>
						<c:otherwise>
							<c:forEach items="${lists }" var="row" varStatus="loop">
							<c:set var="pid" value="${row.pid }"/>		
							<c:set var="idx" value="${row.idx }"/>										
								<tr>		
									<td><input type="checkbox" name="choice" value="${row.price+row.dprice }" class="choice"/></td>									
									<td>
										<img src="../resources/Upload/${row.nfile }" width="80px" />														
									</td>
									<td class="t_left" style="text-align: center;">${row.name }</td>		
									<td style="text-align: center;" class="price">${row.price }</td>
									<td>${row.dispoint }</td>
									<td><input type="text" name="cstock" value="${row.cstock}" class="cstock" onkeyup="onumSet()"/></td>
									<td><c:choose><c:when test="${not empty row.deli}">${row.deli }</c:when>	
									<c:otherwise>무료배송</c:otherwise>
									</c:choose></td>
									<td><c:choose><c:when test="${not empty row.dprice}"><span class="dprice">${row.dprice }</span>원</c:when>	
									<c:otherwise><span class="dprice">0</span>원</c:otherwise>
									</c:choose></td>												
									<td name="tp" style="color:green">${row.price+row.dprice } 원</td>																			
								</tr>										
							</c:forEach>
						</c:otherwise>
						</c:choose>						
					</tbody>
				</table>
				<div class="row text-center">
					<!-- 페이지번호 부분 -->	
						${pagingImg }	
				</div>	
				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<c:forEach items="${lists2 }" var="row2"  varStatus="status">
					<c:set var="addr" value="${fn:split(row2.addr, '@') }" />
					<c:set var="mobile" value="${fn:split(row2.mobile, '-') }" />
					<c:set var="email" value="${fn:split(row2.email, '@') }" />
					<input type="hidden" id="fname${status.count}" value="${row2.name }"/>
					<input type="hidden" id="fzipcode${status.count}" value="${row2.zipcode }"/>
					<input type="hidden" id="faddr1${status.count}" value="${addr[0] }"/>
					<input type="hidden" id="faddr2${status.count}" value="${addr[1] }"/>
					<input type="hidden" id="fmobile1${status.count}" value="${mobile[0]}"/>
					<input type="hidden" id="fmobile2${status.count}" value="${mobile[1]}"/>
					<input type="hidden" id="fmobile3${status.count}" value="${mobile[2]}"/>
					<input type="hidden" id="femail1${status.count}" value="${email[0] }"/>
					<input type="hidden" id="femail2${status.count}" value="${email[1] }"/>
					</c:forEach>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" id="mname" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" id="mzipcode" class="join_input" style="width:250px; margin-bottom:5px;" />
							 <a href="javascript:;" title="새 창으로 열림" onclick="daumZipFind1();">[우편번호검색]</a>
							 <br /><input type="text" id="maddr1" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br />
							 <input type="text" id="maddr2" class="join_input" style="width:300px;" /> 상세주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" id="mmobile1" class="join_input" style="width:50px;" /> - 
							<input type="text" id="mmobile2" class="join_input" style="width:50px;" /> - 
							<input type="text" id="mmobile3" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" id="memail1" class="join_input" style="width:100px;" /> @ 
							<input type="text" id="memail2" class="join_input" style="width:100px;" /></td>
						</tr>
					</tbody>					
				</table>
					
					<div>
						<p style="text-align: right">배송지 정보가 주문자 정보와 동일합니까?
					<form method="post" name="autoCheck" id="autoCheck">
						예<input type="radio" name="auto" value="true"
							onclick="deliCheck(this)" id="radio1"/> 아니오<input
							type="radio" name="auto" value="false" onclick="deliCheck(this)" id="radio2" checked="checked" />
						</p>
					</form>
					<div id="table1">
						<table cellpadding="0" cellspacing="0" border="0"
							class="con_table" style="width: 100%; margin-bottom: 50px;">
							<colgroup>
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<tbody> 
		<tr>
			<form name="deliAddr" onsubmit="return check()">
			<c:forEach items="${lists }" var="row" varStatus="loop">					
			<input type="hidden" name="pid" value="${row.pid }"/>
			<input type="hidden" name="idx" value="${row.idx }"/>
			<input type="hidden" name="onum" id="${row.pid }"/>
			</c:forEach>
		<tr>
			<th>성명</th>
			<td style="text-align: left;">
				<input type="text" id="rname" name="name" class="join_input" />
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td style="text-align: left;">
				<input type="text" id="rzipcode" name="zipcode" class="join_input" style="width: 250px; margin-bottom: 5px;" /> 
					<a href="javascript:;" title="새 창으로 열림" onclick="daumZipFind();">[우편번호검색]</a><br />
				<input type="text" name="addr1" id="raddr1" class="join_input" style="width: 300px; margin-bottom: 5px;" />기본주소<br /> 
				<input type="text" name="addr2" id="raddr2" value="" class="join_input" style="width: 300px;" /> 나머지주소
			</td>
		</tr>
		<tr>
			<th>휴대폰</th>
			<td style="text-align: left;">
				<input type="text" name="mobile1" class="join_input" style="width: 50px;" id="rmobile1" /> - 
				<input type="text" name="mobile2" class="join_input" style="width: 50px;" id="rmobile2"/> - 
				<input type="text" name="mobile3" class="join_input" style="width: 50px;" id="rmobile3"/>
			</td>
		</tr>
		<tr>
			<th>이메일주소</th>
			<td style="text-align: left;">
				<input type="text" name="email1" class="join_input" style="width: 100px;" id="remail1"/> @ 
				<input type="text" name="email2" value="" class="join_input" style="width: 100px;" id="remail2"/>
			</td>
		</tr>
		<tr>
			<th>배송메세지</th>
			<td style="text-align: left;">
				<input type="text" name="msg" class="join_input" style="width: 500px;" />
			</td>
		</tr>								
							</tbody>
						</table>
					</div>			
								
							</tbody>
						</table>
					</div>

				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td style="text-align:left;"><span class="money" id="tmoney">0원</span></td>							
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;"><input type="radio" name="pay" value="card"/> 카드결제&nbsp;&nbsp;&nbsp;<input type="radio" name="pay" value="noneAcc"/> 무통장입금&nbsp;&nbsp;&nbsp;
							<input type="radio" name="pay" value="Acc"/> 실시간 계좌이체</td>
						</tr>
					</tbody>
				</table>				
				<p style="text-align:right;"><button type="submit"><img src="../images/market/basket_btn04.gif" /></button></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
