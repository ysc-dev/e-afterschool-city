<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<sec:authentication property="principal" var="user"></sec:authentication>

<style>
.footer-content {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	padding: 4px 0;
	font-weight: bold;
}

.content~.navbar:not(.navbar-component):last-of-type {
	border-top-color: rgba(0,0,0,.125) !important;
}
</style>

<sec:authorize access="isAuthenticated()">
	<div class="navbar navbar-expand-lg navbar-light fixed-bottom px-3">
		<div class="footer-content">
		<c:choose>
			<c:when test="${fn:contains(city.link, 'educare')}">
		       	학생정보 : ${user.schoolInfo} ${user.dong}동 ${user.ho}호 ${user.name}<br>
				연락번호 : ${user.tel}
		    </c:when>
		    <c:when test="${fn:contains(city.link, 'jin-ro')}">
	        	학생정보 : ${user.schoolInfo}${user.targetType.info} ${user.grade}학년 ${user.classType}반 ${user.number}번 ${user.name}<br>
				연락번호 : ${user.tel}
		    </c:when>
		    <c:otherwise>
		       	학생정보 : ${user.schoolInfo}${user.targetType.info} ${user.grade}학년 ${user.classType}반 ${user.number}번 ${user.name}<br>
				연락번호 : ${user.tel}
		    </c:otherwise>
		</c:choose>
		</div>
	</div>
</sec:authorize>
