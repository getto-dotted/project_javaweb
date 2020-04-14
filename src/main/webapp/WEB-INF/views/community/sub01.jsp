<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
				</div>
				<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
				<form class="form-inline">	
					<div class="form-group">
						<select name="searchColumn" class="form-control">
							<option value="title" ${Column=="title" ? "selected" : ""}>제목</option>
							<option value="name" ${Column=="name" ? "selected" : ""}>작성자</option>
							<option value="content" ${Column=="content" ? "selected" : ""}>내용</option>
						</select>
					</div>
					<div class="input-group">
						<input type="text" name="searchWord"  class="form-control"/>
						<div class="input-group-btn">
							<button type="submit" class="btn btn-default">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form>	
				</div>
				<div class="row">
					<!-- 게시판리스트부분 -->
					<table class="table table-bordered table-hover">
					<colgroup>
						<col width="80px"/>
						<col width="*"/>
						<col width="120px"/>
						<col width="120px"/>
						<col width="80px"/>
						<col width="50px"/>
					</colgroup>
					
					<thead>
					<tr class="success">
						<th class="text-center">번호</th>
						<th class="text-left">제목</th>
						<th class="text-center">작성자</th>
						<th class="text-center">작성일</th>
						<th class="text-center">조회수</th>
						<th class="text-center">첨부</th>
					</tr>
					</thead>	
					<tbody>
					<!-- 리스트반복 -->
					<tr>
						<c:choose>
							<c:when test="${empty lists }">
								<tr>
									<td colspan="6">등록된 게시물이 없습니다.</td>
								</tr>		
							</c:when>
							<c:otherwise>
								<c:forEach items="${lists }" var="row" varStatus="loop">
									<tr>										
										<td>${totalCount-(((nowPage-1)*pageSize)+loop.index) }</td>
										<td><a href="../free/View?idx=${row.idx }&nowPage=${param.nowPage }">${row.title }</a></td>
										<td>${row.name }</td>
										<td>${row.pday }</td>
										<td>${row.vcnt }</td>
										<td align="center">
											<c:if test="${not empty row.ofile }">
												<a href="./Download?ofile=${row.ofile }&nfile=${row.nfile }&idx=${row.idx }">
												<img src="../images/disk.png" width="20" alt="" /></a>
											</c:if>
										</td>
									</tr>
								</c:forEach>		
							</c:otherwise>
						</c:choose>
					</tr>
					</tbody>
					</table>
				</div>
<div class="row text-center" style="padding-right:50px;" >
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-default" 
		onclick="location.href='Write';">글쓰기</button>
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
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
