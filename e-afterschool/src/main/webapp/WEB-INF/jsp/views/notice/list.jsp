<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-3">
		<span>전체 공지사항</span>
	</div>
	
	<table class="table table-border-solid mt-4" id="noticeTable">
		<thead class="text-center">
			<tr class="bg-info-600">
				<th>번호</th> 
				<th>제목</th>
				<th>파일</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody class="tbody-xs text-center">
			<c:forEach var="notice" items="${notices}" varStatus="status">
				<tr>
					<td class="font-size-sm">${status.count}</td>
					<td>
						<a href="${pageContext.request.contextPath}/notice/detail?infoId=${infoId}&noticeId=${notice.id}" 
							class="text-primary font-weight-bold">${notice.title}</a>
					</td>
					<td class="font-size-sm"></td>
					<td class="font-size-sm">
						<fmt:parseDate value="${notice.createDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"  />
						<fmt:formatDate pattern="yyyy년 M월 d일" value="${parsedDateTime}" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
$("#noticeTable").DataTable({
	pageLength: 10,
	order: [[0, 'asc']],
	columns: [
	{ width: "12%" },
	{ width: "55%" },
	{ width: "15%" },
	{ width: "18%" }],
});
</script>