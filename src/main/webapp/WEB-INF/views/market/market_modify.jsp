<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
function checkValidate(f) {
	
	if (f.name.value == "") {
		alert("제품명을 입력하세요");
		f.name.focus();
		return false;
	}
	if (f.price.value == "") {
		alert("제품가격을 입력하세요");
		f.price.focus();
		return false;
	}
	if (f.dispoint.value == "") {
		alert("마일리지를 입력하세요");
		f.dispoint.focus();
		return false;
	}
	if (f.info.value == "") {
		alert("제품설명을 입력하세요");
		f.info.focus();
		return false;
	}			
	if (f.stock.value == "") {
		alert("제품수량을 입력하세요");
		f.stock.focus();
		return false;
	}	
}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif"" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;제품주문<p>
				</div>
				<div>
<c:forEach items="${lists }" var="row">	
<form name="writeFrm" method="post" action="../market/modifyPrc"
		enctype="multipart/form-data" onsubmit="return checkValidate(this);">
<input type="hidden" name="idx" value="${param.idx }"/>
<input type="hidden" name="backURL" value="/market/View?idx="/>
<input type="hidden" name="id" value="<%=session.getAttribute("user_id")%>"/>
<input type="hidden" name="ofile" value="${row.ofile }"/>
<input type="hidden" name="nfile" value="${row.nfile }"/>
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제품명</th>
		<td>
			<input type="text" class="form-control" 
				style="width:600px;" name="name" value="${row.name }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제품가격</th>
		<td>
			<input type="text" class="form-control" 
				style="width:200px;" name="price" value="${row.price }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">마일리지</th>
		<td>
			<input type="text" class="form-control" 
				style="width:200px;" name="dispoint" value="${row.dispoint }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle; ">제품수량</th>
		<td>
			<input type="text" class="form-control" name="stock" style="width:200px;" value="${row.stock }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle; ">무료/유료 배송</th>
		<td>
			<input type="text" class="form-control" name="deli" style="width:200px;"value="${row.deli }"/>
		</td>	
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle; ">배송비용</th>
		<td>
			<input type="text" class="form-control" name="dprice" style="width:200px;"value="${row.dprice }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제품 상세정보</th>
		<td>
			<textarea rows="10" class="form-control" name="info">${row.info }</textarea>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">주문정보</th>
		<td>
			<input type="text" class="form-control" 
				style="width:200px;" name="etc" value="${row.etc }"/>
		</td>
	</tr>
	<tr>
			<c:if test="${not empty row.nfile }">
				<img src="../resources/Upload/${row.nfile }" width="300px" />														
			</c:if>		
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제품 이미지</th>
		<td>
			<input type="file" name="attachedfile" class="form-control" />
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">작성완료</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../prod/List';">리스트보기</button>
</div>
</form> 
</c:forEach>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>