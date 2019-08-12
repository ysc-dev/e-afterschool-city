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
		<div class="card-header text-center bg-primary text-white">
			<h6 class="card-title font-weight-bold">횟수별 수업내용</h6>
		</div>
		<div class="table-responsive">
			<table class="table table-bordered table-striped" id="contentTable">
				<tbody class="tbody-xs">
					<c:forEach var="content" items="${classContents}" varStatus="status">
						<tr>
							<td class="font-size-sm text-center">${status.count}</td>
							<td class="font-size-sm">${content.content}</td>
							<td class="font-size-sm"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script>
$("#contentTable").DataTable({
	pageLength: 10,
	order: [[0, 'asc']],
	columns: [
	{ width: "10%" },
	{ width: "70%" },
	{ width: "20%" }],
});
</script>