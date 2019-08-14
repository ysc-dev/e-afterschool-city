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
			<h5 class="card-title font-weight-bold">횟수별 수업내용</h5>
		</div>
		<table class="table table-bordered" id="contentTable">
			<tbody class="tbody-xs">
				<c:forEach var="content" items="${classContents}" varStatus="status">
					<tr>
						<td class="font-size-sm text-center">${status.count}</td>
						<td class="font-size-sm">${content.content}</td>
						<td class="font-size-sm">
							<button type="button" class="btn btn-outline bg-primary text-primary-600 btn-sm" 
								onClick="imageModal(${content.id})"><i class="icon-images2"></i></button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<!-- 모달창 -->
<div id="imageModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-header-sm bg-info">
                <h6 class="modal-title">
                    <i class="icon-images2 mr-2"></i>수업내용 첨부파일
                </h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
               <div id="image-viewer"></div>
            </div>
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

function imageModal(id) {
	$("#image-viewer").empty();
	
	$.ajax({
        url: contextPath + "/subject/class/file/get",
        type: "GET",
        data: {"id" : id},
        success : function(response) {
	        response.uploadedFiles.forEach(function(file, index) {
		        console.log(file);
				var imageContent = `<img src="data:\${file.fileContentType};base64,\${file.content}" class="img-fluid"/>`;
		        $("#image-viewer").append(imageContent);
            });
        	$("#imageModal").modal();
        }
    });
}
</script>