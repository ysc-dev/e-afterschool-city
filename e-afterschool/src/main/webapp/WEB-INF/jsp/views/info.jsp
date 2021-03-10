<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<link href="${pageContext.request.contextPath}/css/info.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="home/${cityId}" />
</c:import>

<div class="content px-0"> 
	<div class="info-title justify-content-center align-items-center mt-2">
		<span class="ml-2">학생 등록 후 수강신청 할 수 있습니다.</span>
	</div>
	
	<table class="table table-border-solid mt-3" id="invitationTable">
		<thead class="text-center">
			<tr class="bg-info-600">
				<th>안내장 제목</th>
				<th>마감일</th>
				<th>수강안내</th>
			</tr>
		</thead>
		<tbody class="tbody-xs text-center">
			<c:forEach var="invitation" items="${invitations}" varStatus="status">
				<tr>
					<td class="font-size-sm info-title-text"><a href="#" class="text-dark font-weight-bold" onclick="showInfo(${invitation.id})">${invitation.name}</a></td>
					<td class="font-size-xs info-content-text">${invitation.deadlineDate}</td>
					<td class="font-size-xs info-content-text">
						<c:choose>
							<c:when test="${invitation.type.id == 1}">
								<a href="#" class="text-grey-600" onclick="deadlineClick(${invitation.id})">${invitation.type.name}</a>
							</c:when>
							<c:when test="${invitation.type.id == 2}">
								<a href="#" class="text-shadow font-weight-bold" onclick="applyClick(${invitation.id})">${invitation.type.name}</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="text-warning-400" onclick="deadlineClick(${invitation.id})">${invitation.type.name}</a>
							</c:otherwise>
						</c:choose>
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
            <div class="modal-header modal-header-sm bg-info">
                <h5 class="modal-title">
                    <i class="icon-images2 mr-2"></i>안내장 상세정보
                </h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body image-modal-body text-center">
               <div id="image-viewer"></div>
            </div>
        </div>
    </div>
</div>

<script>
var agent = navigator.userAgent.toLowerCase();
function checkIE() {
	if ((navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
		return true;
	} else {
		return false;
	}
}

/* $("#invitationTable").DataTable({
	pageLength: 5,
	order: [[0, 'asc']],
	columns: [
	{ width: "4%" },
	{ width: "51%" },
	{ width: "18%" },
	{ width: "27%" }],
}); */

function showInfo(id) {
	$("#image-viewer").empty();
	
	$.ajax({
        url: contextPath + "/info/get",
        type: "GET",
        data: {"id" : id},
        success : function(response) {
	        $.each(response.uploadedFiles, function(index, file){ 
	        	var imageContent = '<img src="' + contextPath + '/uploads/invitation/' + file.fileName + '" class="img-fluid"/>';
		        $("#image-viewer").append(imageContent);
	        });
            
        	$("#imageModal").modal();
        }
    });
}

function applyClick(id) {
	var student = "${student}";
	if (student) {
		location.href = contextPath + "/subject/group?infoId=" + id;
	} else {
		if (checkIE()) {
			alert("로그인 한 후에 수강신청 할 수 있습니다.");
		} else {
			swalInit.fire({
				title: "로그인 한 후에 수강신청 할 수 있습니다.", 
				type: "warning",
				position: 'top'
   			}).then(function(e) {
   				location.href = contextPath + "/login/${cityId}";
   			});
		}
		return;
	}
}

function deadlineClick(id) {
	var student = "${student}";
	if (student) {
		location.href = contextPath + "/subject/group?infoId=" + id;
	} else {
		if (checkIE()) {
			alert("로그인 한 후에 확인 할 수 있습니다.");
		} else {
			swalInit.fire({
				title: "로그인 한 후에 확인 할 수 있습니다.", 
				type: "warning",
				position: 'top'
   			}).then(function(e) {
   				location.href = contextPath + "/login/${cityId}";
   			});
		}
		return;
	}
	
	/* if (checkIE()) {
		alert("추가접수 문의는 274–0518");
	} else {
		swalInit.fire({title: "추가접수 문의는 274–0518", type: "info", position: 'top'});
	} */
}
</script>