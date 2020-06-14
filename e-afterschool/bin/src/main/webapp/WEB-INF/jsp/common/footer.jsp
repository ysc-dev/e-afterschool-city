<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="user"></sec:authentication>

<style>
.footer-content {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	padding: 8px 0;
	font-weight: bold;
}

.content~.navbar:not(.navbar-component):last-of-type {
	border-top-color: rgba(0,0,0,.125) !important;
}
</style>

<sec:authorize access="isAuthenticated()">
	<div class="navbar navbar-expand-lg navbar-light fixed-bottom">
		<div class="footer-content">
			학생정보 : ${user.schoolInfo}${user.targetType.info} ${user.grade}학년 ${user.classType}반 ${user.number}번 ${user.name}<br>
			연락번호 : ${user.tel}
		</div>
	</div>
</sec:authorize>
