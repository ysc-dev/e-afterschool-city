<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/subject.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content subject-content px-0"> 
	<div class="content-title justify-content-center align-items-center mt-2">
		<span class="fs-18">${subjectGroup.name} 과목(${fn:length(subjects)})</span>
	</div>
	
	<div class="navbar navbar-expand navbar-dark bg-info-700 navbar-component border-transparent mt-3">
		<div class="navbar-collapse">
			<ul class="navbar-nav navbar-nav-highlight">
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/notice/list?infoId=${infoId}" class="navbar-nav-link">
						<i class="icon-bubble-notification mr-1"></i>전체공지사항
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/subject/mylist?infoId=${infoId}" class="navbar-nav-link nav-border-left">
						<i class="icon-folder-search mr-1"></i>수강신청확인
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/student/update?infoId=${infoId}" class="navbar-nav-link nav-border-left">
						<i class="icon-user mr-1"></i>학생정보변경
					</a>
				</li>
				<li class="nav-item bg-grey">
					<a href="${pageContext.request.contextPath}/logout" class="navbar-nav-link nav-border-left">
						<i class="icon-exit mr-1"></i>로그아웃
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="card-group-control"> 
		<c:forEach var="subject" items="${subjects}" varStatus="status">
			<div class="card ${status.last ? 'card-last' : '' }">
				<div class="card-header bg-light header-elements-inline">
					<h6 class="card-title">
						<span class="font-size-md text-default font-weight-bold">${subject.name}</span>
					</h6>
					<div class="header-elements">
						<a href="micro?infoId=${infoId}&id=${subject.id}" 
							class="btn ${subject.applyNumber == subject.fixedNumber ? 'bg-slate-300' : 'bg-teal' } btn-sm px-2">
							상세보기 (${subject.applyNumber}/${subject.fixedNumber})
						</a>
		           	</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>