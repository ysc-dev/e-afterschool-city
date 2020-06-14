<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/table.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/micro?infoId=${infoId}&id=${subject.id}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-2 px-2">
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="card card-table mt-4">
		<div class="card-header text-center bg-info-600 text-white">
			<h5 class="card-title font-weight-bold">횟수별 수업내용</h5>
		</div>
		<table class="table" id="contentTable">
			<tbody class="tbody-xs">
				<c:forEach var="content" items="${classContents}" varStatus="status">
					<tr>
						<td class="font-size-sm text-center">${status.count}</td>
						<td class="font-size-sm font-weight-bold">${content.content}</td>
						<td class="font-size-sm">
							<button type="button" class="btn btn-outline bg-primary text-primary-600 btn-sm font-weight-bold" 
								onClick="imageModal(${content.id})">사진/동영상</button>
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
$("#contentTable").DataTable({
	pageLength: 10,
	order: [[0, 'asc']],
	columns: [
	{ width: "10%" },
	{ width: "70%" },
	{ width: "12%" }],
});

function imageModal(id) {
	$("#file-viewer").empty();
	
	$.ajax({
        url: contextPath + "/subject/class/file/get",
        type: "GET",
        data: {"id" : id},
        success : function(response) {
	        response.uploadedFiles.forEach(function(file, index) {
				if (file.fileType == 'IMAGE') {
					var img = document.createElement("img");
		        	img.setAttribute("src", contextPath + "/uploads/class/" + file.fileName);
		        	img.setAttribute("class", "img-fluid");
			        $("#file-viewer").append(img);
				} else {
					var div = document.createElement("div");
					div.setAttribute("class", "card-img embed-responsive embed-responsive-16by9");
					var video = document.createElement("video");
					video.setAttribute("class", "embed-responsive-item");
					video.setAttribute("controls", "controls");
					video.setAttribute("src", contextPath + "/uploads/class/" + file.fileName);
					div.append(video);
					
					/* fileContent = `<div class="card-img embed-responsive embed-responsive-16by9">`
						+ `<video class="embed-responsive-item" src="data:\${file.contentType};base64,\${file.content}" controls></video>`
						+ `</div>`; */
					$("#file-viewer").append(div);
				}
            });
        	$("#fileModal").modal();
        }
    });
}
</script>