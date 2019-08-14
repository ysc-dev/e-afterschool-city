<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/table.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/micro?infoId=${infoId}&id=${subject.id}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-3 px-2">
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="card mt-4">
		<div class="card-header text-center bg-info-600 text-white">
			<h6 class="card-title font-weight-bold">커 뮤 니 티</h6>
		</div>
		
		<table class="table" id="noticeTable">
			<tbody class="tbody-xs">
				<c:forEach var="notice" items="${subjectNotices}" varStatus="status">
					<tr>
						<td>${notice.id}</td>
						<td class="font-size-sm text-center">${status.count}</td>
						<td class="font-size-sm text-center">${notice.userName}</td>
						<td class="font-size-sm">${notice.title}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<script>
var table = $("#noticeTable").DataTable({
	select: {
        style: 'single'
    },
	pageLength: 10,
	order: [[0, 'asc']],
	columns: [
		{ width: "0%" },
		{ width: "10%" },
		{ width: "20%" },
		{ width: "70%" }
	],
 	columnDefs: [
 		{ visible: false, targets: 0 }
 	]
});

$('#noticeTable tbody').on( 'click', 'tr', function () {
    var noticeId = table.row(this).data()[0];
    location.href = contextPath + "/subject/community/detail?infoId=${infoId}&subjectId=${subject.id}&id=" + noticeId;
} );
</script>