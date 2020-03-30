<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	

<c:forEach items="${lists }" var="row" varStatus="loop">
<c:set var="pid" value="${row.pid }"/>		
<c:set var="idx" value="${row.idx }"/>										
	<tr>		
		<td><input type="checkbox" name="choice" value="${row.price+row.dprice }" class="choice"/></td>									
		<td>
			<img src="../resources/Upload/${row.nfile }" width="80px" />														
		</td>
		<td class="t_left" style="text-align: center;">${row.name }</td>		
		<td style="text-align: center;" class="price">${row.price }</td>
		<td>${row.dispoint }</td>
		<td><input type="text" name="cstock" value="${row.cstock}" class="cstock" onkeyup="onumSet()"/></td>
		<td><c:choose><c:when test="${not empty row.deli}">${row.deli }</c:when>	
		<c:otherwise>무료배송</c:otherwise>
		</c:choose></td>
		<td><c:choose><c:when test="${not empty row.dprice}"><span class="dprice">${row.dprice }</span>원</c:when>	
		<c:otherwise><span class="dprice">0</span>원</c:otherwise>
		</c:choose></td>												
		<td name="tp" style="color:green">${row.price+row.dprice } 원</td>																			
	</tr>										
</c:forEach>