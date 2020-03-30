<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/volunteer/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">

				<%@ include file = "../include/volunteer_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/volunteer/sub01_title.gif" alt="후원신청" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;자원봉사/후원&nbsp;>&nbsp;후원신청<p>
				</div>
				<img src="../images/volunteer/sub01_img01.jpg" />
				<img src="../images/volunteer/sub01_tit01.gif" style="margin:30px 0px 10px 0px;"/>
				<p class="dot_tit">후원가입신청서[개인용]</p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<form name="personal">
					<tbody>
						<tr>
							<th>접수번호</th>
							<td style="text-align:left;"><input type="text" name="rid" class="join_input" /></td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="name"   class="join_input" /></td>
							<th>주민등록번호</th>
							<td style="text-align:left;"><input type="text" name="pNumber"   class="join_input" style="width:100px;" /> - <input type="text" name=""  maxlength="1" class="join_input" style="width:10px;" /></td>
						</tr>
						<tr>
							<th>성별</th>
							<td style="text-align:left;"><input type="radio" name="gender" value="male"/> 남&nbsp;&nbsp;&nbsp;<input type="radio" name="gender" value="female"/> 여</td>
							<th>생년월일</th>
							<td style="text-align:left;">
								<input type="text" name="birth1"   class="join_input" style="width:50px;" /> 년 
								<input type="text" name="birth2"   class="join_input" style="width:50px;" /> 월 
								<input type="text" name="birth3"   class="join_input" style="width:50px;" /> 일
							</td>
						</tr>
						<tr>
							<th>직업</th>
							<td style="text-align:left;"><input type="text" name="job"   class="join_input" /></td>
							<th>종교</th>
							<td style="text-align:left;"><input type="radio" name="rel" value="christ"/> 기독교&nbsp;&nbsp;
							<input type="radio" name="rel" value="budd"/> 불교&nbsp;&nbsp;
							<input type="radio" name="rel" value="chatolic"/> 천주교<br />
							<input type="radio" name="rel" value="none"/> 무교&nbsp;&nbsp;
							<input type="radio" name="rel" /> 기타 
							<input type="text" name="rel" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="email1"   class="join_input" style="width:100px;" /> @ 
							<input type="text" name="email2"   class="join_input" style="width:100px;" /></td>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="mobile1"   class="join_input" style="width:50px;" /> - 
							<input type="text" name="mobile2"   class="join_input" style="width:50px;" /> - 
							<input type="text" name="mobile3"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th rowspan="2">주소</th>
							<td style="text-align:left;" colspan="3">자택 : <input type="text" name="addrHome"   class="join_input" style="width:300px;" /></td>
						</tr>
						<tr>
							<td style="text-align:left;" colspan="3">직장 : <input type="text" name="addrCom"   class="join_input" style="width:300px;" /></td>
						</tr>
						<tr>
							<th>우편물 수령처</th>
							<td style="text-align:left;" colspan="3">
							<input type="radio" name="deliPoint" value="직장"/> 직장&nbsp;&nbsp;&nbsp;
							<input type="radio" name="deliPoint" value="자택" /> 자택&nbsp;&nbsp;&nbsp;
							<input type="radio" name="deliPoint" value="거부"/> 수령거부</td>
						</tr>
					</tbody>
				</table>

				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr><th colspan="2">후 원 세 부 내 용</th></tr>
						<tr>
							<th>후원기간</th>
							<td style="text-align:left;">
							<input type="radio" name="term" value="일시"/> 일시후원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="term" value="정기"/> 정기후원(1년, 2년, 3년, 4년, 5년)</td>
						</tr>
						<tr>
							<th>후원종류</th>
							<td style="text-align:left;"><input type="radio" name="type" value="결연"/> 결연후원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="type" value="기금"/> 기금후원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="type" value="물품"/> 물품후원</td>
						</tr>
						<tr>
							<th>후원방법</th>
							<td style="text-align:left;">
							<input type="radio" name="tMethod" value="자동"/> 자동이체&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tMethod" value="방문"/> 직접방문&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tMethod" value="통장"/> 통장입금</td>
						</tr>
						<tr>
							<th>후원금액</th>
							<td style="text-align:left;">
							<input type="radio" name="donation" value="5000"/> 5,000원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="donation" value="100000"/> 10,000원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="donation" value="200000"/> 20,000원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="donation" /> 기타 
							<input type="text" name="donation2" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>입 금 일</th>
							<td style="text-align:left;">
							<input type="radio" name="tDate" value="1"/> 1일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate" value="10"/> 10일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate" value="20"/> 20일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate" value="30"/> 30일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate"   /> 기타  
							<input type="text" name="tDate2"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>후원물품일  경우</th>
							<td style="text-align:left;">품명 : <input type="text" name="pName"   class="join_input" />&nbsp;&nbsp;&nbsp;
							수량 : <input type="text" name="pAmount"   class="join_input" /></td>
						</tr>
						<tr>
							<th>후원경로</th>
							<td style="text-align:left;">
							<input type="radio" name="dPath"  value="local"/> 구청/동사무소&nbsp;&nbsp;&nbsp;
						    <input type="radio" name="dPath" value="friend"/> 이웃/친구&nbsp;&nbsp;&nbsp;
						    <input type="radio" name="dPath" value="crew"/> 직원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dPath" value="ad"/> 홍보물/안내문&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dPath" value="web"/> 홈페이지&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dPath"   /> 기타 
							<input type="text" name="dPath2"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>후원동기</th>
							<td style="text-align:left;"><input type="radio" name="dMotiv"   /> 사회적 환원을 위해&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 지역사회에 기여하기 위해&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 어려운 이웃을 돕기 위해<br />
							<input type="radio" name="dMotiv"   /> 보람 있는 일을 하고 싶어서&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 종교적 신념으로&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 기타 
						    <input type="text" name="dMotiv2"   class="join_input" style="width:50px;" /></td>
						</tr>
					</tbody>
				</table>
					<p style="font-weight:bold; text-align:center; margin-bottom:20px">
					본인은 위와 같이 마포구립장애인직업재활센터의 후원회원으로 가입하고자 본 신청서를 제출합니다.</p>
					<p style="text-align:center; margin-bottom:40px">
					<input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;
					<a href="../"><img src="../images/btn02.gif" /></a></p>
				</form>
				
				<form name="org">
				<p class="dot_tit">후원가입신청서[단체용]</p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>접수번호</th>
							<td style="text-align:left;"><input type="text" name="rid"   class="join_input" /></td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<th>단체명</th>
							<td style="text-align:left;"><input type="text" name="name"   class="join_input" /></td>
							<th>사업자번호</th>
							<td style="text-align:left;"><input type="text" name="orgNum"   class="join_input" /></td>
						</tr>
						<tr>
							<th>대표자명</th>
							<td style="text-align:left;"><input type="text" name="bossName"   class="join_input" /></td>
							<th>홈페이지</th>
							<td style="text-align:left;"><input type="text" name="webPage"   class="join_input" /></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;"><input type="text" name="tel1"   class="join_input" style="width:50px;" /> - 
							<input type="text" name="tel2"   class="join_input" style="width:50px;" /> - 
							<input type="text" name="tel3"   class="join_input" style="width:50px;" /></td>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="mobile1"   class="join_input" style="width:50px;" /> - 
							<input type="text" name="mobile2"   class="join_input" style="width:50px;" /> - 
							<input type="text" name="mobile3"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;" colspan="3"><input type="text" name="addr"   class="join_input" style="width:300px;" /></td>
						</tr>
					</tbody>
				</table>

				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr><th colspan="2">후 원 세 부 내 용</th></tr>
						<tr>
							<th>후원기간</th>
							<td style="text-align:left;">
							<input type="radio" name="term" value="일시"/> 일시후원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="term" value="정기"/> 정기후원(1년, 2년, 3년, 4년, 5년)</td>
						</tr>
						<tr>
							<th>후원종류</th>
							<td style="text-align:left;">
							<input type="radio" name="type" value="결연"/> 결연후원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="type" value="기금"/> 기금후원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="type" value="물품"/> 물품후원</td>
						</tr>
						<tr>
							<th>후원방법</th>
							<td style="text-align:left;">
							<input type="radio" name="tMethod" value="자동"/> 자동이체&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tMethod" value="방문"/> 직접방문&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tMethod" value="통장"/> 통장입금</td>
						</tr>
						<tr>
							<th>후원금액</th>
							<td style="text-align:left;">
							<input type="radio" name="donation" value="5000"/> 5,000원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="donation" value="10000"/> 10,000원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="donation" value="20000" /> 20,000원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="donation"   /> 기타 
							<input type="text" name="donation2"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>입 금 일</th>
							<td style="text-align:left;">
							<input type="radio" name="tDate" value="1"/> 1일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate" value="10"/> 10일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate" value="20"/> 20일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate" value="30"/> 30일&nbsp;&nbsp;&nbsp;
							<input type="radio" name="tDate"   /> 기타  
							<input type="text" name="tDate2"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>후원물품일  경우</th>
							<td style="text-align:left;">
							품명 : <input type="text" name="pName"   class="join_input" />&nbsp;&nbsp;&nbsp;
							수량 : <input type="text" name="pAmount"   class="join_input" /></td>
						</tr>
						<tr>
							<th>후원경로</th>
							<td style="text-align:left;">
							<input type="radio" name="dPath"  value="local"/> 구청/동사무소&nbsp;&nbsp;&nbsp;
						    <input type="radio" name="dPath" value="friend"/> 이웃/친구&nbsp;&nbsp;&nbsp;
						    <input type="radio" name="dPath" value="crew"/> 직원&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dPath" value="ad"/> 홍보물/안내문&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dPath" value="web"/> 홈페이지&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dPath"   /> 기타
							<input type="text" name="dPath2"   class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>후원동기</th>
							<td style="text-align:left;"><input type="radio" name="dMotiv"   /> 사회적 환원을 위해&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 지역사회에 기여하기 위해&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 어려운 이웃을 돕기 위해<br />
							<input type="radio" name="dMotiv"   /> 보람 있는 일을 하고 싶어서&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 종교적 신념으로&nbsp;&nbsp;&nbsp;
							<input type="radio" name="dMotiv"   /> 기타 
						    <input type="text" name="dMotiv2"   class="join_input" style="width:50px;" /></td>
						</tr>
					</tbody>
				</table>
					<p style="font-weight:bold; text-align:center; margin-bottom:20px">
					본 단체는 위와 같이 마포구립장애인직업재활센터의 후원회원으로 가입하고자 본 신청서를 제출합니다.</p>
					<p style="text-align:center; margin-bottom:20px">
					<input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="../">
					<img src="../images/btn02.gif" /></a></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
