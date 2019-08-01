<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<!DOCTYPE html>
<html>
	<tiles:insertAttribute name="head"/>
<body class="layout-boxed-bg">
	<div class="d-flex flex-column flex-1 layout-boxed">
	 	<tiles:insertAttribute name="header"/>
	 	
	 	<div class="page-content">
			<div class="content-wrapper">
				<tiles:insertAttribute name="content"/>
			</div>
		</div>
	</div>
</body>
</html>
