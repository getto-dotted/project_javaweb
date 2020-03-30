<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script type="text/javascript">
		function checkValidate() {
			var f = document.modForm
			if (f.name2.value == "") {
				alert("이름을 입력하세요");
				f.name2.focus();
				return false;
			}
			if (f.pass2.value == "") {
				alert("패스워드를 입력하세요");
				f.pass2.focus();
				return false;
			}
			if(isNaN(f.pass2.value)){
				alert("패스워드는 숫자만 입력해 주세요")
				return false;
			}
			if (f.title.value == "") {
				alert("제목을 입력하세요");
				f.title.focus();
				return false;
			}
			if (f.content.value == "") {
				alert("내용을 입력하세요");
				f.content.focus();
				return false;
			}		
			
			f.action = "../modifyPrc";
			f.method = "post";			
		}
	</script>

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
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				</div>
				<div>
<c:forEach items="${lists }" var="row">	 
<form enctype="multipart/form-data" name="modForm" onsubmit="return checkValidate()">
<input type="hidden" name="idx" value="${param.idx }"/>
<input type="hidden" name="backURL" value="/info/View?idx="/>
<input type="hidden" name="tname" value="info"/>
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
			style="vertical-align:middle;">작성자</th>
		<td>
			<input type="text" class="form-control" 
				style="width:100px;" name="name2" value="${row.name }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" class="form-control" 
				style="width:400px;" name="email2" value="${row.email }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="password" class="form-control" 
				style="width:200px;" name="pass2" value="${row.pass }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" name="title" class="form-control" value="${row.title }"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" name="content" class="form-control">${row.content }</textarea>
		</td>
	</tr>
	<tr>
		<th class="text-center" style="vertical-align:middle;">업로드된 사진</th>
		<td colspan="3">
		<c:choose>		<c:when test="${row.nfile != null}">
			<img src="../resources/Upload/${row.nfile }" width="300px">
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
		<td>
			<input type="file" name="attachedfile" class="form-control" />
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">수정하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../space/info';">리스트보기</button>
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