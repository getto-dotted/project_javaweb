<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
			 tValue = 0;//체크후 수량을 null값으로 전송할 수 있으므로 0으로 초기화 시킴
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

function onumSet() {//히든폼에 값을 채움
	
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
	stockSetting();//값을 채우고 나면 계산 후 자동으로 HTML 변경
}

function stockSetting(){
	
	var size = document.getElementsByName("choice").length;
	var qty = document.getElementsByName("choice");
	var pri = document.getElementsByName("tPrice");//상품가격 합산용
	var dpri = document.getElementsByName("dPrice2");//배송비 합산용
	var tdV = document.getElementsByName("tdPrice");//각 상품별 합계 		
 	var totalP =0;//총상품가격
    var deliP =0;//총배송비
    var finalP =0;//최종비용
	
    //choice name을 가진 요소중에서 체크된 것만 값 가져오기   
    //값을 지워버리면 계산에 영향을 미치지 않도록 체크를 풀어버림
    for(var i = 0; i < size; i++){
        if(document.getElementsByName("choice")[i].checked == true){	           
            if(isNaN(parseInt(qty[i].value))){
            	document.getElementsByName("choice")[i].checked =false;
            }
            else{	            	
	            totalP += parseInt(qty[i].value) * parseInt(pri[i].value);
	            deliP += parseInt(dpri[i].value);	   
            	tdV[i].innerHTML = parseInt(qty[i].value) * parseInt(pri[i].value) + parseInt(dpri[i].value) +" 원"; //각 상품별 합계는 for문 안에서 입력
            }
        }
    }
    finalP += parseInt(totalP)+parseInt(deliP);//최종비용은 for문 밖에서 계산     
       
    document.getElementById("tp").innerHTML=totalP;
    document.getElementById("td").innerHTML=deliP;
    document.getElementById("tt").innerHTML=finalP; //각 위치에 입력
}

function focusCheck(d){//수량을 클릭or변경하면 체크 활성화
	var c = document.getElementsByName("choice");
	document.getElementsByName("choice")[d].checked =true;
	
}
	
$(function(){//수량에 문자를 입력하지 못하도록 함 NaN출력방지
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));		    
	});			
});
</script>
</head>
<body>

<tbody>			
	<tr>							
<form name="basket">
	<c:forEach items="${lists }" var="row" varStatus="loop">
		<input type="hidden" name="pid" value="${row.pid }"/> 												
		<input type="hidden" name="idx" value="${row.idx }"/> 												
		<input type="hidden" name="onum"/> 	
			
		<input type="hidden" name="Price"  value="${row.price }"/> <!-- 수량변경시 ${row.price }의 값을 name="tPrice"로 옮겨줌 -->		
		<input type="hidden" name="tPrice" /> 		
		<input type="hidden" name="dPrice1" value="${row.dprice }" /><!-- 수량변경시 ${row.dprice }의 값을 name="dPrice2"로 옮겨줌 --> 		
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
<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span>
<span id="tp">0 원</span> + <span>배송비</span>
<span id="td">0 원</span> = 합계 : <span id="tt">0 원</span>
</body>
</html>