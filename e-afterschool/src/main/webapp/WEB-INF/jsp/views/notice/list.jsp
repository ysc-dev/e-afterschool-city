<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content px-0">
	<div class="content-title d-flex justify-content-center align-items-center mt-2">
		<span class="fs-18">전체 공지사항</span>
	</div>
	
	<table class="table table-border-solid mt-3" id="noticeTable">
		<thead class="text-center">
			<tr class="bg-info-600">
				<th>No</th> 
				<th>제목</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody class="tbody-xs text-center">
			<c:forEach var="notice" items="${notices}" varStatus="status">
				<tr>
					<td class="font-size-sm">${status.count}</td>
					<td class="text-left">
						<a href="${pageContext.request.contextPath}/notice/detail?infoId=${infoId}&noticeId=${notice.id}" 
							class="text-primary font-weight-bold">${notice.title}</a>
					</td>
					<td class="font-size-sm">
						<fmt:parseDate dateStyle="full" value="${notice.createDate}" pattern="yyyy-MM-dd" var="parsedDateTime"  />
						<fmt:formatDate pattern="yyyy년 M월 d일" value="${parsedDateTime}" />
					</td>
				</tr> 
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- 이미지 모달창 -->
<div id="imageModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title">
                    <i class="icon-images2 mr-2"></i>공지사항 첨부파일
                </h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body image-modal-body text-center">
               <div id="image-viewer"></div>
            </div>
        </div>
    </div>
</div>

<!-- <script>
$("#noticeTable").DataTable({
	pageLength: 10,
	order: [[0, 'asc']],
	columns: [ 
	{ width: "12%" },
	{ width: "65%" },
	{ width: "23%" }],
});
</script> -->