<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/table.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/micro/${city.id}/${infoId}/${subject.id}" />
  	<c:param name="home" value="info?cityId=${city.id}" />
</c:import>

<div class="content px-0">
	<div class="content-title d-flex justify-content-center align-items-center mt-2">
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="card card-table mt-3">
		<div class="card-header bg-info-600 text-white d-flex justify-content-between p-2">
			<div>&nbsp;</div>
			<h5 class="card-title font-weight-bold">커 뮤 니 티</h5>
			<div class="text-right">
				<a href="${pageContext.request.contextPath}/subject/community/regist/${city.id}/${infoId}/${subject.id}"
					class="btn bg-primary-700 btn-sm"><i class="icon-pencil7 mr-2"></i>등록</a>
			</div>
		</div>
		
		<table class="table" id="noticeTable">
			<tbody class="tbody-xs">
				<c:forEach var="notice" items="${subjectNotices}" varStatus="status">
					<tr>
						<td class="font-size-sm text-center">${status.count}</td>
						<td class="font-size-sm text-center">${notice.userName}</td>
						<td class="font-size-sm">
							<a href="${pageContext.request.contextPath}/subject/community/detail/${city.id}/${infoId}/${subject.id}/${notice.id}" 
								class="text-default font-weight-bold">
								<c:if test="${notice.important}">
									<span class="text-danger font-weight-bold mr-1">[공지사항]</span>
								</c:if>
								${notice.title}
							</a>
						</td>
						<td class="font-size-sm">
							<button type="button" class="btn btn-outline bg-primary text-primary-600 btn-sm font-weight-bold" 
								onClick="imageModal(${notice.id})"><i class="icon-images2"></i></button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<!-- 모달창 -->
<div id="fileModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-header-sm bg-info">
                <h6 class="modal-title">
                    <i class="icon-images2 mr-2"></i>수업내용 첨부파일
                </h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body file-modal-body text-center">
               <div id="file-viewer"></div>
            </div>
        </div>
    </div>
</div>

<script>
function imageModal(id) {
	$("#file-viewer").empty();
	
	$.ajax({
        url: contextPath + "/subject/community/file/get",
        type: "GET",
        data: {"id" : id},
        success: function(response) {
	        response.uploadedFiles.forEach(function(file, index) {
	        	var img = document.createElement("img");
	        	img.setAttribute("src", contextPath + "/uploads/community/" + file.fileName);
	        	img.setAttribute("class", "img-fluid");
		        $("#file-viewer").append(img);
            });
            
        	$("#fileModal").modal();
        }
    });
}
</script>