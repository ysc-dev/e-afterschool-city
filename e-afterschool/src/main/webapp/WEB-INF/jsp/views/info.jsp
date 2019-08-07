<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<div class="navbar navbar-expand-md navbar-light">
	<div class="navbar-brand">
		<a href="#" class="d-inline-block">
			<img src="${pageContext.request.contextPath}/images/logo.png" alt="logo">
		</a>
	</div>
	<div class="ml-auto d-flex align-items-center">
		<a href="${pageContext.request.contextPath}/home/${cityId}" class="btn btn-outline bg-slate-300 text-slate-600 btn-sm header-icon px-0">
			<i class="icon-circle-left2"></i>
		</a>
	</div>
</div>

<div class="content"> 
	<div class="cotent-title justify-content-center align-items-center">
		<span>회원 등록 후 수강신청 할 수 있습니다.</span>
	</div>
	
	<table class="table table-bordered mt-4" id="invitationTable">
		<thead class="text-center">
			<tr class="table-active">
				<th>번<br>호</th>
				<th>안내장<br>제목</th>
				<th>신청<br>마감일</th>
				<th>수강<br>신청</th>
			</tr>
		</thead>
		<tbody class="tbody-xs text-center">
			<c:forEach var="invitation" items="${invitations}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${invitation.name}</td>
					<td>${invitation.deadlineDate}</td>
					<td>${invitation.type.name}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
Datatables.basic("#invitationTable", 5);
</script>