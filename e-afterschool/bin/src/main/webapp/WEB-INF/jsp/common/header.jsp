<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="navbar navbar-expand-md navbar-light fixed-top">
	<div class="navbar-brand">
		<a href="#" class="d-inline-block">
		<c:choose>
		    <c:when test="${cityId eq '1'}">
		        <img src="${pageContext.request.contextPath}/images/cw_logo.png" alt="logo">
		    </c:when>
		    <c:when test="${cityId eq '2'}">
		        <img src="${pageContext.request.contextPath}/images/jj_logo.png" alt="logo">
		    </c:when>
		    <c:otherwise>
		        <img src="${pageContext.request.contextPath}/images/logo.png" alt="logo">
		    </c:otherwise>
		</c:choose>
		</a>
		<a href="#" class="d-inline-block ml-1">
			<img src="${pageContext.request.contextPath}/images/logo2.png" alt="logo">
		</a>
	</div>
	
	<div class="ml-auto d-flex align-items-center">
		<c:if test="${param.left ne null}">
			<a href="${pageContext.request.contextPath}/${param.left}" 
				class="btn btn-outline bg-slate-300 text-slate-600 header-icon px-0">
				<i class="icon-arrow-left8"></i>
			</a>
		</c:if>
		
		<c:if test="${param.home ne null}">
			<a href="${pageContext.request.contextPath}/info?cityId=${cityId}" 
				class="btn btn-outline bg-slate-300 text-slate-600 header-icon px-0 ml-2">
				<i class="icon-home4"></i>
			</a>
		</c:if>
	</div>
</div>
