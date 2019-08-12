<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/notice.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="notice/list?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>


<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-3">
		<span>공지사항 상세정보</span>
	</div>
	
	<div class="card notice-detail mt-4">
		<div class="card-header bg-info-600">
			<h4 class="card-title font-weight-bold">${notice.title}</h4>
		</div>
		<div class="card-body">
			<div class="subject">
				<label class="font-weight-bold">작성자 :</label>
				<label class="ml-1">${notice.userName}</label>

				<label class="font-weight-bold ml-3">조회수 :</label>
				<label class="ml-1">${notice.hit}</label>
			</div>
			<div class="subject">
				<fmt:formatDate var="createDate" value="${localDateTimeFormat.parse(notice.createDate)}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<label class="font-weight-bold">날짜 :</label>
				<label class="ml-1">${createDate}</label>
			</div>
			<div class="content">
				<p>${notice.content}</p>
			</div>
		</div>
	</div>
</div>