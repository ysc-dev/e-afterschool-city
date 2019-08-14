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
			<h5 class="card-title font-weight-bold">커 뮤 니 티</h5>
		</div>
		
		<table class="table" id="noticeTable">
			<tbody class="tbody-xs">
				<c:forEach var="notice" items="${subjectNotices}" varStatus="status">
					<tr>
						<td>${notice.id}</td>
						<td class="font-size-sm text-center">${status.count}</td>
						<td class="font-size-sm text-center">${notice.userName}</td>
						<td class="font-size-sm">
							<c:if test="${notice.important}">
								<span class="text-danger font-weight-bold mr-1">[공지사항]</span>
							</c:if>
							${notice.title}
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="text-right">
		<a href="${pageContext.request.contextPath}/subject/community/regist?infoId=${infoId}&subjectId=${subject.id}"
			class="btn btn-primary btn-sm"><i class="icon-pencil7 mr-2"></i>글 등록</a>
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