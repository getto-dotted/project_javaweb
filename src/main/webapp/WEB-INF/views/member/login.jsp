<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script>
function loginValidate() {
		if (SubLoginForm.id.value == "") {
			alert("아이디를 입력하세요");
			MainLoginForm.id.focus();
			return false;
		}
		if (!SubLoginForm.pass.value) {
			alert("패스워드를 입력하세요");
			MainLoginForm.pass.focus();
			return false;
		}
		document.SubLoginForm.action = "../loginPrc";
		document.SubLoginForm.method = "post";
	}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="${pageContext.request.contextPath}/resources/images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="${pageContext.request.contextPath}/resources/images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="${pageContext.request.contextPath}/resources/images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
			<div class="row" style="border:2px solid #cccccc;padding:10px;">			
	
	
				<div class="login_box01">
				<form name="SubLoginForm" method="post" onsubmit="return loginValidate()">
					<img src="${pageContext.request.contextPath}/resources/images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="${pageContext.request.contextPath}/resources/images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" id="id" name="id" value="" class="login_input01" /></li>
						<li><img src="${pageContext.request.contextPath}/resources/images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" id="pass" name="pass" value="" class="login_input01" /></li>
					</ul>
					<input type="image" src="${pageContext.request.contextPath}/resources/images/login_btn.gif" />					
				</div>
				</form>
				<p style="text-align:center; margin-bottom:50px;"><a href="/member/id_pw.jsp"><img src="${pageContext.request.contextPath}/resources/images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href="/member/join01.jsp"><img src="${pageContext.request.contextPath}/resources/images/login_btn03.gif" alt="회원가입" /></a></p> 
			</div>
		</div>


		
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
