<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//다음 우편번호 API연동하기
function daumZipFind(){
    new daum.Postcode({
        oncomplete: function(data) {
        	var f = document.joinForm;
        	f.zipcode.value = data.zonecode;	
        	f.addr1.value = data.address;
        	f.addr2.focus();
        }
    }).open();
}


function frmCheck(f) {
	
	if(!f.name.value){
		alert("이름를 입력하세요");
		f.name.focus();
		return false;
	}
	if(!f.id.value ){
		alert("아이디를 입력하세요");
		f.id.focus();
		return false;
	}
	if(!f.pass.value ){
		alert("패스워드를 입력하세요");
		f.pass.focus();
		return false;
	}
	if(f.pass.value != f.pass2.value){
		alert("비밀번호가 일치하지 않습니다.");
		f.pass.focus();
		return false;
	}
	if(isNaN(f.mobile1.value)||isNaN(f.mobile2.value)||isNaN(f.mobile3.value)||isNaN(f.tel1.value)||isNaN(f.tel2.value)||isNaN(f.tel3.value)){
		alert("전화번호는 - 을 제외한 숫자만 입력해 주세요")
		return false;
	}
	if(f.mobile1.value == "" && f.mobile2.value == "" && f.mobile3.value == "" && f.tel1.value == "" && f.tel2.value == "" && f.tel3.value == ""){
		alert("전화번호나 휴대폰번호중 하나는 입력하셔야 합니다.");
		f.mobile1.focus();
		return false;
	}
	if(!f.email1.value||!f.email2.value){
		alert("이메일을 입력하세요");
		f.email1.focus();
		return false;
	}
	if(f.zipcode.value == "" || f.addr1.value == ""){
		alert("주소를 입력해주세요.");
		f.zipcode.focus();
		return false;
	}
	if(!f.addr2.value){
		alert("상세주소를 입력해주세요.");
		f.addr2.focus();
		return false;
	}
	if(document.joinForm.idDuplication.value =="idUncheck"){
		alert("아이디 중복확인을 해주세요.")
		return false;
	}
	
	//폼의 전송방식과 action경로를 JS에서 설정함
			
	f.action = "./joinPrc";
	f.method = "post";
	
}

function email_input(){
	
	var x = document.getElementById("last_email_check2").value;
	 
	 if(x == "1"){
		 document.joinForm.email2.readOnly = false;
		 document.joinForm.email2.value = "";
		 document.joinForm.email2.focus();
	 }
	 else{
		 document.joinForm.email2.readOnly = true;
		 document.joinForm.email2.value = x;
	 }
 } 

function openIdChk(f){	
	var id = f.id.value();
	f.action = "./member/idcheck";
	f.method = "get";	
}
function inputIdChk(){
    document.joinForm.idDuplication.value ="idUncheck";
}

$(function(){
	$('#dcheck').click(function(){
	   	 
	   	 $.ajax({
	   		 url: './idcheck',
	   		 dataType : "json",
	   		 type : "post",
	   		 contentType : "application/x-www-form-urlencoded;charset:utf-8",
	   		 data : {id : $('#id').val()},
	   		 success : function(d){	   			
	   			 if(d.Result==0){
	   				alert("사용가능한 아이디입니다.");  	
	   				document.joinForm.idDuplication.value ="idchecked";
	   			 }
	   			 else{
	   				 alert("중복된 아이디입니다.");
	   			 }
	   		 },
	   		 error : function(e){
	   			 alert(e+"오류");
	   		 }  		 
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>
				<form name="joinForm" onsubmit="return frmCheck(this)">
				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" id="id" name="id"  value="" class="join_input" onkeydown="inputIdChk(this);"/>&nbsp;
						<input id="dcheck" type="button" value="               " onclick="openIdChk();" style="background-image: url('../images/btn_idcheck.gif');">    
                        <input type="hidden" name="idDuplication" value="idUncheck" >
                    </tr>    
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
	<input type="text" name="email2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
	<select name="last_email_check2" onChange="email_input(this);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="1" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
	</select>
	 
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value=""  class="join_input" maxlength="6" style="width:250px;" />						
						<a href="javascript:;" title="새 창으로 열림" onclick="daumZipFind();">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>
				<p style="text-align:center; margin-bottom:20px">
				<input type="submit" value="                          " style="background-image: url('../images/btn01.gif");">				
			&nbsp;&nbsp;<a href="../home"><img src="../images/btn02.gif" /></a></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
