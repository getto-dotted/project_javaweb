<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
function findId(d){
	
	if(d.rs==0){
		alert(d.id);	
	}
	else{
		
		alert("회원님의 ID는 "+d.id+"입니다.");	
	}
}

function findPass(d){
	
	if(d.rs==0){
		alert(d.pass);	
	}
	else{
		
		alert(d.pass);	
	}
}
$(function(){
	$('#fid').click(function(){
	   	 
		var f = document.fidForm;
				 
		if(f.name.value==""){
			alert("이름을 입력하세요");
			f.name.focus();
			return false;
		}
		if(f.email.value==""){
			alert("이메일을 입력하세요"); 
			f.email.focus();
			return false;
		}		
		
	   	$.ajax({
	   		 url: './findId',
	   		 dataType : "json",
	   		 type : "post",
	   		 contentType : "application/x-www-form-urlencoded;charset:utf-8",
	   		 data : {name:$('#name').val(), email:$('#email').val()},
	   		 success : findId
		});
	});	
	
	$('#fpass').click(function(){
	   	 
		var g = document.fpassForm;
		 
		if(g.id.value==""){
			alert("아이디를 입력하세요");
			g.id.focus();
			return false;
		}
		if(g.name2.value==""){
			alert("이름을 입력하세요"); 
			g.name2.focus();
			return false;
		}		
		
		if(g.email2.value==""){
			alert("이메일을 입력하세요"); 
			g.email2.focus();
			return false;
		}		
		
		$.ajax({
	   		 url: './findPass',
	   		 dataType : "json",
	   		 type : "post",
	   		 contentType : "application/x-www-form-urlencoded;charset:utf-8",
	   		 data : {name:$('#name2').val(), email:$('#email2').val(), id:$('#id').val()},
	   		 success : findPass
		});
	  });
});
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
					<form action="./findId" id="fidForm" name="fidForm">
						<ul> 
							<li><input type="text" id="name" class="login_input01" /></li>
							<li><input type="text" id="email" class="login_input01" /></li>
						</ul>
						<button id="fid" type="button"><img src="../images/member/id_btn01.gif" class="id_btn" /></button>
						<a href="./join01"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</form>	
					</div>
					<div class="pw_box">
					<form action="./findPass" id="fpassForm" name="fpassForm">
						<ul>
							<li><input type="text" id="id" class="login_input01" /></li>
							<li><input type="text" id="name2" class="login_input01" /></li> 
							<li><input type="text" id="email2" class="login_input01" /></li>
						</ul>
						<button id="fpass" type="button"><img src="../images/member/id_btn01.gif" class="id_btn" /></button>						
					</form>	
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
