<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/subjectGroup.css" rel="stylesheet" type="text/css">

<div class="navbar navbar-expand-md navbar-light">
	<div class="navbar-brand">
		<a href="#" class="d-inline-block">
			<img src="${pageContext.request.contextPath}/images/logo.png" alt="logo">
		</a>
	</div>
	<div class="ml-auto d-flex align-items-center">
		<a href="${pageContext.request.contextPath}/info/${cityId}" class="btn btn-outline bg-slate-300 text-slate-600 btn-sm header-icon px-0">
			<i class="icon-circle-left2"></i>
		</a>
	</div>
</div>

<div class="content subject-group-content"> 
	<div class="content-title d-flex justify-content-center align-items-center mt-3">
		<span>${invitation.name}</span>
	</div>
	
	<div class="navbar navbar-expand navbar-dark bg-info-700 navbar-component border-transparent mt-4">
		<div class="navbar-collapse">
			<ul class="navbar-nav navbar-nav-highlight">
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/apply/info" class="navbar-nav-link">
						<i class="icon-home mr-1"></i>전체공지사항
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/apply/subscribe1" class="navbar-nav-link nav-border-left">
						<i class="icon-folder-search mr-1"></i>수강신청확인
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/apply/mylist" class="navbar-nav-link nav-border-left">
						<i class="icon-list mr-1"></i>로그아웃
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/apply/mylist" class="navbar-nav-link nav-border-left">
						<i class="icon-list mr-1"></i>학생정보변경
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="card-group-control card-group-control-left subject-group mt-3" id="accordion-group"> 
		<c:forEach var="subjectGroup" items="${subjectGroups}" varStatus="status">
			<div class="card">
				<div class="card-header bg-light header-elements-inline">
					<h6 class="card-title">
						<a data-toggle="collapse" class="collapsed text-default font-weight-bold" href="#accordion-item-group${subjectGroup.id}">
							${subjectGroup.name}
						</a>
					</h6>
					<div class="header-elements subscribe-header">
						<a href="subscribe2?groupId=${subjectGroup.id}" class="btn bg-info-600 btn-sm">과목 리스트</a>
		           	</div>
				</div>
		
				<div id="accordion-item-group${subjectGroup.id}" class="collapse" data-parent="#accordion-group">
					<div class="card-body">
						<label class="col-form-label">${subjectGroup.description}</label>
					</div>
				</div> 
			</div>
		</c:forEach>
	</div>
</div>