<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("${pageContext.request.contextPath}/resources/css/common.css");
@import url("${pageContext.request.contextPath}/resources/css/main.css");
@import url("${pageContext.request.contextPath}/resources/css/sub.css");

.main_con_center .date 
{
float : right;
}
.main_con_right .date 
{
float : right;
}
.main_con_right .title 
{
text-align: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(function(){
	
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var user_id = getCookie("user_id");
    $("input[name='id']").val(user_id); 
     
    if($("input[name='id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#id_save").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#id_save").change(function(){ // 체크박스에 변화가 있다면,
        if($("#id_save").is(":checked")){ // ID 저장하기 체크했을 때,
            var user_id = $("input[name='id']").val();
            setCookie("user_id", user_id, 1); // 1일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("user_id");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#id_save").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var user_id = $("input[name='id']").val();
            setCookie("user_id", user_id, 7); // 7일 동안 쿠키 보관
        }
    });
});

</script>
<script type="text/javascript">
function loginValidate(f)
{
	if(f.id.value==""){
		alert("아이디를 입력하세요");
		f.id.focus();
		return false;
	}
	if(f.pass.value==""){
		alert("패스워드를 입력하세요"); 
		f.pass.focus();
		return false;
	} 
	f.action="./loginPrc";
	f.method="post";	
}
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}//삭제예정
</script>
</head>
<body>
<center>
	<div style="float: left;">
	<br /><br /><br /><br /><br /><br /><br />
	<%@ include file="./include/quick2.jsp"%>
	</div>
	<div id="wrap">
		<%@ include file="./include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="${pageContext.request.contextPath}/resources/images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="${pageContext.request.contextPath}/resources/images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="${pageContext.request.contextPath}/resources/images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="${pageContext.request.contextPath}/resources/images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="${pageContext.request.contextPath}/resources/images/main_title01.gif" alt="로그인 LOGIN" /></p>
				
			<c:choose>
				<c:when test="${empty sessionScope.user_info }">
				
				<form name="MainLogin" action="./loginPrc" onsubmit="return loginValidate(this)">
				<div class="login_box">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						
						<tr>
							<th><img src="${pageContext.request.contextPath}/resources/images/login_tit01.gif" alt="아이디" tabindex="1"/></th>
							<td><input type="text" name="id" value="" class="login_input" /></td>
							<td rowspan="2"><input type="image" src="${pageContext.request.contextPath}/resources/images/login_btn01.gif" alt="로그인" tabindex="3"/></td>
						</tr>
						<tr>
							<th><img src="${pageContext.request.contextPath}/resources/images/login_tit02.gif" alt="패스워드" tabindex="2"/></th>
							<td><input type="password" name="pass" value="" class="login_input" /></td>
						</tr>
					</table>
					<p>
						<input type="checkbox" id="id_save" name="id_save" /><img src="${pageContext.request.contextPath}/resources/images/login_tit03.gif" alt="저장" />
						<a href="${pageContext.request.contextPath}/member/id_pw"><img src="${pageContext.request.contextPath}/resources/images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="${pageContext.request.contextPath}/member/join01"><img src="${pageContext.request.contextPath}/resources/images/login_btn03.gif" alt="회원가입" /></a>
					</p>								 
				</div>
				</form>
				
				</c:when>
				<c:otherwise>
				
				<div class="login_box">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>	
												
					</table>
												
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;">${sessionScope.user_info.name }님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<a href=""><img src="${pageContext.request.contextPath}/resources/images/login_btn04.gif" /></a>
						<a href="./logout"><img src="${pageContext.request.contextPath}/resources/images/login_btn05.gif" /></a>
					</p>		 
				</div>
			
				</c:otherwise>
			</c:choose>			
			</div>

			
			<div class="main_con_center">
				<p class="main_title"><img src="${pageContext.request.contextPath}/resources/images/main_title02.gif" alt="공지사항 NOTICE" /><a href="/space/sub01.jsp"><img src="${pageContext.request.contextPath}/resources/images/more.gif" alt="more" class="more_btn" /></a></p>
				
				<c:forEach items="${listsN }" var="row" varStatus="loop">
				<ul class="main_board_list">
					<li><a href="/mycontroller/notice/View?idx=${row.idx }&nowPage=1">${fn:substring(row.title,0,21)}</a><span class="date">${row.pday }</span></li>					
				</ul>
				</c:forEach>
			</div>
			
			
			<div class="main_con_right">
				<p class="main_title"><img src="${pageContext.request.contextPath}/resources/images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="/space/sub03.jsp"><img src="${pageContext.request.contextPath}/resources/images/more.gif" alt="more" class="more_btn" /></a></p>
				<c:forEach items="${listsF }" var="row2" varStatus="loop">
				<ul class="main_board_list">
					<li><a href="/mycontroller/free/View?idx=${row2.idx }&nowPage=1">${fn:substring(row2.title,0,21)}</a><span class="date">${row2.pday }</span></li>					
				</ul>
				</c:forEach>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="${pageContext.request.contextPath}/resources/images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="${pageContext.request.contextPath}/resources/images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="${pageContext.request.contextPath}/resources/images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<div class="cal_top">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="13px;" />
							<col width="*" />
							<col width="13px;" />
						</colgroup>
						<tr>
							<td><a href=""><img src="${pageContext.request.contextPath}/resources/images/cal_a01.gif" style="margin-top:3px;" /></a></td>
							<td><img src="${pageContext.request.contextPath}/resources/images/calender_2012.gif" />&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/resources/images/calender_m1.gif" /></td>
							<td><a href=""><img src="${pageContext.request.contextPath}/resources/images/cal_a02.gif" style="margin-top:3px;" /></a></td>
						</tr>
					</table>
				</div>
				<div class="cal_bottom">
					<table cellpadding="0" cellspacing="0" border="0" class="calendar">
						<colgroup>
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th><img src="${pageContext.request.contextPath}/resources/images/day01.gif" alt="S" /></th>
							<th><img src="${pageContext.request.contextPath}/resources/images/day02.gif" alt="M" /></th>
							<th><img src="${pageContext.request.contextPath}/resources/images/day03.gif" alt="T" /></th>
							<th><img src="${pageContext.request.contextPath}/resources/images/day04.gif" alt="W" /></th>
							<th><img src="${pageContext.request.contextPath}/resources/images/day05.gif" alt="T" /></th>
							<th><img src="${pageContext.request.contextPath}/resources/images/day06.gif" alt="F" /></th>
							<th><img src="${pageContext.request.contextPath}/resources/images/day07.gif" alt="S" /></th>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">1</a></td>
							<td><a href="">2</a></td>
							<td><a href="">3</a></td>
						</tr>
						<tr>
							<td><a href="">4</a></td>
							<td><a href="">5</a></td>
							<td><a href="">6</a></td>
							<td><a href="">7</a></td>
							<td><a href="">8</a></td>
							<td><a href="">9</a></td>
							<td><a href="">10</a></td>
						</tr>
						<tr>
							<td><a href="">11</a></td>
							<td><a href="">12</a></td>
							<td><a href="">13</a></td>
							<td><a href="">14</a></td>
							<td><a href="">15</a></td>
							<td><a href="">16</a></td>
							<td><a href="">17</a></td>
						</tr>
						<tr>
							<td><a href="">18</a></td>
							<td><a href="">19</a></td>
							<td><a href="">20</a></td>
							<td><a href="">21</a></td>
							<td><a href="">22</a></td>
							<td><a href="">23</a></td>
							<td><a href="">24</a></td>
						</tr>
						<tr>
							<td><a href="">25</a></td>
							<td><a href="">26</a></td>
							<td><a href="">27</a></td>
							<td><a href="">28</a></td>
							<td><a href="">29</a></td>
							<td><a href="">30</a></td>
							<td><a href="">31</a></td>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="${pageContext.request.contextPath}/resources/images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="/space/sub04.jsp"><img src="${pageContext.request.contextPath}/resources/images/more.gif" alt="more" class="more_btn" /></a></p>
				<c:forEach items="${listsP }" var="row3" varStatus="loop">
				<ul class="main_photo_list">
					<li>				
						<dl>						
							<dd><a href="/mycontroller/pic/View?idx=${row3.idx }&nowPage=1">
								<img src="${pageContext.request.contextPath}/resources/Upload/${row3.nfile }" width="100px"><br />
								<span class="title">${fn:substring(row3.title,0,21)}</span>
							</a></dd>
						</dl>
					</li>					
				</ul>
				</c:forEach>
			</div>
		</div>
		<%@ include file="./include/quick.jsp"%>
	</div>

	<%@ include file="./include/footer.jsp"%>
	
</center>
</body>
</html>