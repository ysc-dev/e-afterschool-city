<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/subject.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content mylist-group">
	<div class="content-title justify-content-center align-items-center mt-2">
		<span class="fs-18">수강신청 확인</span>
	</div>

	<c:choose>
		<c:when test="${fn:length(applies) == 0}">
	       	<div class="result-empty mt-4"> 
				수강신청내역이 없습니다.
			</div>
	    </c:when>
	     <c:otherwise>
	     	<div class="card-group-control card-group-control-left mt-4" id="accordion-group">
	     		<c:forEach var="apply" items="${applies}" varStatus="status">
	     			<div class="card ${status.last ? 'card-last' : '' }">
						<div class="card-header bg-light header-elements-inline">
							<h6 class="card-title">
								<a data-toggle="collapse" class="collapsed font-size-md text-default font-weight-bold" 
									href="#accordion-item-group${apply.id}">
									${apply.subject.name}
								</a>
							</h6>
							<div class="header-elements mylist-header">
								<button type="button" class="btn btn-danger btn-sm" onclick="applyCancel(${apply.id})">신청취소</button>
				           	</div>
						</div>
				
						<div id="accordion-item-group${apply.id}" class="collapse" data-parent="#accordion-group">
							<div class="card-body">
								<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수강기간 :</label>
						    		<label class="col-form-label ml-1">${apply.subject.period}</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수업일시 :</label>
						    		<label class="col-form-label ml-1">${apply.subject.week} (${apply.subject.time})</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>대상학년 :</label>
						    		<label class="col-form-label ml-1">${apply.subject.target}</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>재료,교구비 :</label>
						    		<label class="col-form-label ml-1">${apply.subject.cost}</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>강사이름 :</label>
						    		<label class="col-form-label ml-1">${apply.subject.teacher.name}</label>
						    	</div>
						    	<div class="align-items-stretch">
						    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>수업장소 :</label>
						    		<label class="col-form-label ml-3">${apply.subject.location}</label>
						    	</div>
						    	<div class="align-items-stretch">
						    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>과목특징 :</label>
						    		<label class="col-form-label ml-3">${apply.subject.description}</label>
						    	</div>
							</div>
						</div> 
					</div>
	     		</c:forEach>
			</div>
	     </c:otherwise>
	</c:choose>
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

function deleteApply(applyId) {
	$.ajax({
		url: contextPath + "/apply/delete",
  		data: {"applyId": applyId},
  		type: "DELETE",
       	success: function(response) {
       		if (checkIE()) {
           		alert("수강 취소 되었습니다.");
           		location.reload();
       	 	} else {
	       	 	swal({
	   				title: "수강 취소 되었습니다.", 
	   				type: "success",
	   				position: 'top'
	   			}).then(function(e) {
	   				location.reload();
	   			});
       	 	}
       	},
        error: function(response) {
            if (response.responseText == "취소불가") {
            	location.reload();
            } else {
                if (checkIE()) {
                    alert(response.responseText);
                } else {
                	swal({title: response.responseText, type: "error", position: 'top'});
                }
            }
        }
	});
}

function applyCancel(applyId) {
	if (checkIE()) {
		var result = confirm("수강취소 하시겠습니까?");
		if (result) {
			deleteApply(applyId);
		}
	} else {
		swal({
	        title: "수강취소 하시겠습니까?",
	        type: "question",
	        confirmButtonText: "확인",
	        confirmButtonClass: "btn btn-danger",
	        showCancelButton: true, 
	        cancelButtonText: "닫기",
	        position: "top"
	    }).then(function(e) {
	    	if (e.value) {
	    		deleteApply(applyId);
	    	}
	    });
	}
}
</script>