<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<div id="top" style="border:0px solid #000;"> 
	<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/logo.gif" alt="마포구립장애인 직업재활센터" id="top_logo" /></a>
	<ul id="lnb">
	
		<c:choose>
		<c:when test="${empty sessionScope.user_info }">
		<!-- 로그인전 -->
		<li><a href="${pageContext.request.contextPath}/member/login"><img src="${pageContext.request.contextPath}/resources/images/lnb01.gif" alt="LOGIN" /></a></li>
		<li><a href="${pageContext.request.contextPath}/member/join01"><img src="${pageContext.request.contextPath}/resources/images/lnb02.gif" alt="JOIN" /></a></li>
		
		</c:when>
		<c:otherwise>
		<!-- 로그인후 -->
		<li><a href="${pageContext.request.contextPath}/logout"><img src="${pageContext.request.contextPath}/resources/images/lnb05.gif" alt="LOG OUT" /></a></li>
		<li><a href="${pageContext.request.contextPath}/center/sub07"><img src="${pageContext.request.contextPath}/resources/images/lnb06.gif" alt="MODIFY" /></a></li>
		</c:otherwise>
		</c:choose>
		<li><a href="${pageContext.request.contextPath}/member/sitemap"><img src="${pageContext.request.contextPath}/resources/images/lnb03.gif" alt="SITEMAP" /></a></li>
		<li><a href="${pageContext.request.contextPath}/center/sub06"><img src="${pageContext.request.contextPath}/resources/images/lnb04.gif" alt="CONTACT US" /></a></li>
		
	</ul>	 
	
	<!-- <a href="${pageContext.request.contextPath}/center/sub01"><img src="${pageContext.request.contextPath}/resources/images/navi.jpg" id="navigation" /></a> -->
	<img src="${pageContext.request.contextPath}/resources/images/gnb.jpg" id="navigation"  width="753" height="65" usemap="#GNB"/>
	<map name="GNB">
		<area shape="rect" alt="" title="" coords="0,0,80,33" href="${pageContext.request.contextPath}/center/sub01" target="" />
		<area shape="rect" alt="" title="" coords="86,0,188,33" href="${pageContext.request.contextPath}/business/sub01" target="" />
		<area shape="rect" alt="" title="" coords="193,0,316,33" href="${pageContext.request.contextPath}/product/sub01" target="" />
		<area shape="rect" alt="" title="" coords="321,0,420,33" href="${pageContext.request.contextPath}/market/market" target="" />
		<area shape="rect" alt="" title="" coords="428,0,529,33" href="${pageContext.request.contextPath}/space/notice" target="" />
		<area shape="rect" alt="" title="" coords="536,0,638,33" href="${pageContext.request.contextPath}/space/crew" target="" />
		<area shape="rect" alt="" title="" coords="641,0,749,33" href="${pageContext.request.contextPath}/volunteer/sponsor" target="" />
	</map>
	
	<!--  <div style="position:absolute; margin:-25px 0 0 200px;  border:0px solid #000;">	
		<object type="application/x-shockwave-flash" data="${pageContext.request.contextPath}/swf/navi.swf" width="753" height="65">
			<param name="wmode" value="transparent" />
		</object>		
	</div>  -->
</div>