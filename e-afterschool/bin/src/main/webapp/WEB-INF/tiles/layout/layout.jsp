<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<!DOCTYPE html>
<html>
	<tiles:insertAttribute name="head"/>
<body>
	<div class="d-flex flex-column flex-1 layout-boxed">
		<tiles:insertAttribute name="content"/>
		
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>
