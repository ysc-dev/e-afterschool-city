<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="home/${cityId}" />
</c:import>

<div class="content info-content"> 
	<div class="info-title justify-content-center align-items-center mt-2">
		<span class="ml-2">회원 등록 후 수강신청 할 수 있습니다.</span>
	</div>
	
	<table class="table table-border-solid mt-4" id="invitationTable">
		<thead class="text-center">
			<tr class="bg-info-600">
				<th>번호</th> 
				<th>안내장 제목</th>
				<th>신청<br>마감일</th>
				<th>수강<br>신청</th>
			</tr>
		</thead>
		<tbody class="tbody-xs text-center">
			<c:forEach var="invitation" items="${invitations}" varStatus="status">
				<tr class="">
					<td class="font-size-sm">${status.count}</td>
					<td>${invitation.name}</td>
					<td class="font-size-sm">${invitation.deadlineDate}</td>
					<td class="font-size-sm">
						<c:choose>
							<c:when test="${invitation.type.id == 1}">
								<a href="#" class="text-shadow font-weight-bold" onclick="applyClick(${invitation.id})">${invitation.type.name}</a>
							</c:when>
							<c:when test="${invitation.type.id == 2}">
								<a href="#" class="text-dark" onclick="deadlineClick()">${invitation.type.name}</a>
							</c:when>
							<c:otherwise>
								${invitation.type.name}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
$("#invitationTable").DataTable({
	pageLength: 5,
	order: [[0, 'asc']],
	columns: [
	{ width: "5%" },
	{ width: "50%" },
	{ width: "19%" },
	{ width: "26%" }],
});

function applyClick(id) {
	var student = "${student}";
	if (student) {
		location.href = contextPath + "/subject/group?infoId=" + id;
	} else {
		swal({
			title: "로그인 한 후에 수강신청 할 수 있습니다.", 
			type: "warning",
			position: 'top'
		});
		return;
	}
}

function deadlineClick() {
	swal({
		title: "추가접수 문의는 274–0518", 
		type: "info",
		position: 'top'
	});
}
</script>