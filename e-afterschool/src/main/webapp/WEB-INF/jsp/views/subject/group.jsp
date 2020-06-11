<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/subject.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="info?cityId=${cityId}" />
</c:import>

<div class="content subject-content">
	<div class="content-title d-flex justify-content-center align-items-center mt-3">
		<span class="fs-18">${invitation.name}</span>
	</div>
	
	<div class="navbar navbar-expand navbar-dark bg-info-700 navbar-component border-transparent mt-4">
		<div class="navbar-collapse">
			<ul class="navbar-nav navbar-nav-highlight">
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/notice/list?infoId=${invitation.id}" class="navbar-nav-link">
						<i class="icon-bubble-notification mr-1"></i>전체공지사항
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/subject/mylist?infoId=${invitation.id}" class="navbar-nav-link nav-border-left">
						<i class="icon-folder-search mr-1"></i>수강신청확인
					</a>
				</li>
				<li class="nav-item">
					<a href="${pageContext.request.contextPath}/student/update?infoId=${invitation.id}" class="navbar-nav-link nav-border-left">
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
	
	<div class="card-group-control card-group-control-left subject-group mt-3" id="accordion-group"> 
		<c:forEach var="subjectGroup" items="${subjectGroups}" varStatus="status">
			<div class="card ${status.last ? 'card-last' : '' }">
				<div class="card-header bg-light header-elements-inline">
					<h6 class="card-title">
						<a data-toggle="collapse" class="collapsed text-default font-weight-bold" href="#accordion-item-group${subjectGroup.id}">
							${subjectGroup.name}
						</a>
					</h6>
					<div class="header-elements subscribe-header">
						<a href="list?infoId=${invitation.id}&groupId=${subjectGroup.id}" class="btn bg-info-600 btn-sm">과목 리스트</a>
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