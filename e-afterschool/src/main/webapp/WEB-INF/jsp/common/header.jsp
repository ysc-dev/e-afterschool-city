<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<div class="navbar navbar-expand-md navbar-light fixed-top px-1 px-md-2 d-flex justify-content-between">
	<div class="d-flex align-items-center">
		<c:choose>
			 <c:when test="${param.home ne null}">
		     	<a href="${pageContext.request.contextPath}/info?cityId=${city.id}"
					class="btn btn-outline bg-slate-300 text-slate-600 header-icon px-1">
					<i class="icon-home8 pl-1 pr-1"></i>
				</a>
		    </c:when>
		    <c:otherwise>
		       	<div class="px-3">&nbsp;&nbsp;&nbsp;&nbsp;</div>
		    </c:otherwise>
		</c:choose>
	</div>
	
	<div class="navbar-brand">
		<a href="#" class="d-inline-block mr-2">
			 <img src="${pageContext.request.contextPath}/images/${city.logo}" alt="logo">
		</a>
		<c:choose>
		    <c:when test="${fn:contains(city.link, 'jin-ro')}">
		    	<a href="#" class="d-inline-block">
					<img src="${pageContext.request.contextPath}/images/jinro_logo.png" alt="logo">
				</a>
		    </c:when>
		    <c:otherwise>
		        <a href="#" class="d-inline-block">
					<img src="${pageContext.request.contextPath}/images/logo2.png" alt="logo">
				</a>
		    </c:otherwise>
		</c:choose>
	</div>
	
	<div class="d-flex align-items-center">
		<c:if test="${param.left ne null}">
			<a href="${pageContext.request.contextPath}/${param.left}" 
				class="btn btn-outline bg-slate-300 text-slate-600 header-icon px-2">
				<i class="icon-arrow-left32"></i>
			</a>
		</c:if>
	</div>
</div>
