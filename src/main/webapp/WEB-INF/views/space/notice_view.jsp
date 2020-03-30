<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
				<div>


<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<c:forEach items="${lists }" var="row">	 
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			${row.name }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			${row.pday }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			${row.email }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			${row.vcnt }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			${row.title }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			${row.content }
		</td>
	</tr>
	<tr>
		<th class="text-center" style="vertical-align:middle;">업로드된 사진</th>
		<td colspan="3">
		<c:choose>		
		<c:when test="${row.nfile != null}">
			<img src="${pageContext.request.contextPath}/resources/Upload/${row.nfile }" width="300px">
		</c:when>
		<c:otherwise>
			<span></span>
		</c:otherwise>
		</c:choose>
		
		</td>
	</tr>		
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<c:if test="${not empty row.ofile }">
					${row.ofile }
					<a href="../notice_Download?ofile=${row.ofile }&nfile=${row.nfile }&idx=${row.idx}">[다운로드]</a>		
			</c:if>		
		</td>
	</tr>
</tbody>
</table>
<script>
function delFunc(){
	var f = document.mod_del
	
	if(confirm('삭제하시겠습니까?')){
		f.action="../delete";
		f.method="post";
		return;
	}	
}
function modFunc(){
	var f = document.mod_del
	
	f.action="../notice/modify";
	f.method="post";		
	return;
}
</script>
<form name="mod_del">
<input type="hidden" name="idx" value="${param.idx }"/>
<input type="hidden" name="backURL" value="/space/notice"/>
<input type="hidden" name="tname" value="/notice/View?idx="/>
<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<c:if test="${sessionScope.user_id eq row.id }">
	<button type="submit" class="btn btn-primary" onclick="javascript:modFunc()">수정하기</button>
	<button type="submit" class="btn btn-success" onclick="javascript:delFunc()">삭제하기</button>
	</c:if>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../space/notice';">리스트보기</button>
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