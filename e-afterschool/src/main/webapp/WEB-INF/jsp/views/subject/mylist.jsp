<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/subject.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${invitation.id}" />
  	<c:param name="home" value="info?cityId=${city.id}" />
</c:import>

<div class="content mylist-group">
	<div class="content-title justify-content-center align-items-center mt-3">
		<span class="fs-18">수강신청 확인</span>
	</div>

	<c:choose>
		<c:when test="${fn:length(applies) == 0}">
	       	<div class="result-empty mt-2"> 
				수강신청 내역이 없습니다.
			</div>
	    </c:when>
	     <c:otherwise>
	     	<div class="card-group-control card-group-control-left mt-2" id="accordion-group">
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
								<c:choose>
									<c:when test="${invitation.type.id == 2}">
										<button type="button" id="deleteBtn" class="btn btn-danger btn-sm" onclick="applyCancel(${apply.id})">수강신청 취소</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-danger btn-sm" disabled>수강신청 취소</button>
									</c:otherwise>
								</c:choose>
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
						    		<label class="col-form-label ml-1">${apply.subject.location}</label>
						    	</div>
						    	<div class="align-items-stretch">
						    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>과목특징 :</label>
						    		<label class="col-form-label ml-1">${apply.subject.description}</label>
						    	</div>
							</div>
						</div> 
					</div>
	     		</c:forEach>
			</div>
	     </c:otherwise>
	</c:choose>
	
	<div class="content-title justify-content-center align-items-center mt-4">
		<span class="fs-18">수강대기 확인</span>
	</div>
	
	<c:choose>
		<c:when test="${fn:length(applyWaits) == 0}">
	       	<div class="result-empty mt-2">
				수강대기 내역이 없습니다.
			</div>
	    </c:when>
     	<c:otherwise>
     		<div class="card-group-control card-group-control-left mt-2" id="accordion-group">
	     		<c:forEach var="applyWait" items="${applyWaits}" varStatus="status">
	     			<div class="card ${status.last ? 'card-last' : '' }">
						<div class="card-header bg-light header-elements-inline">
							<h6 class="card-title">
								<a data-toggle="collapse" class="collapsed font-size-md text-default font-weight-bold" 
									href="#accordion-item-group-wait${applyWait.id}">
									${applyWait.subject.name}
								</a>
							</h6>
							<div class="header-elements mylist-header">
								<c:choose>
									<c:when test="${invitation.type.id == 2}">
										<button type="button" id="waitCancelBtn" class="btn btn-danger btn-sm" onclick="applyWaitCancel(${applyWait.id})">수강대기 취소</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-danger btn-sm" disabled>수강대기 취소</button>
									</c:otherwise>
								</c:choose>
				           	</div>
						</div>
				
						<div id="accordion-item-group-wait${applyWait.id}" class="collapse" data-parent="#accordion-group">
							<div class="card-body">
								<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수강기간 :</label>
						    		<label class="col-form-label ml-1">${applyWait.subject.period}</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수업일시 :</label>
						    		<label class="col-form-label ml-1">${applyWait.subject.week} (${applyWait.subject.time})</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>재료,교구비 :</label>
						    		<label class="col-form-label ml-1">${applyWait.subject.cost}</label>
						    	</div>
						    	<div>
						    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>강사이름 :</label>
						    		<label class="col-form-label ml-1">${applyWait.subject.teacher.name}</label>
						    	</div>
						    	<div class="align-items-stretch">
						    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>수업장소 :</label>
						    		<label class="col-form-label ml-1">${applyWait.subject.location}</label>
						    	</div>
						    	<div class="align-items-stretch">
						    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>과목특징 :</label>
						    		<label class="col-form-label ml-1">${applyWait.subject.description}</label>
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

/**
 * 수강신청 삭제
 */
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
       	 	swalInit.fire({
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
                    location.reload();
                } else {
                	swalInit.fire({title: response.responseText, type: "error", position: 'top'}).then(function(e) {
						location.reload();
	       			});
                }
            }
        }
	});
}

/**
 * 수강신청 취소
 */
function applyCancel(applyId) {
	$("#deleteBtn").prop("disabled", true);
	
	if (checkIE()) {
		var result = confirm("수강을 취소 하시겠습니까?");
		if (result) {
			deleteApply(applyId);
		} else {
			$("#deleteBtn").prop("disabled", false);
		}
	} else {
		swalInit.fire({
	        title: "수강을 취소 하시겠습니까?",
	        type: "question",
	        confirmButtonText: "확인",
	        confirmButtonClass: "btn btn-danger",
	        showCancelButton: true, 
	        cancelButtonText: "닫기",
	        position: "top"
	    }).then(function(e) {
	    	if (e.value) {
	    		deleteApply(applyId);
	    	} else {
	    		$("#deleteBtn").prop("disabled", false);
	    	}
	    });
	}
}

/**
 * 수강대기 삭제
 */
function deleteApplyWait(applyWaitId) {
	$.ajax({
		url: contextPath + "/apply/wait/delete",
  		data: {"applyWaitId": applyWaitId},
  		type: "DELETE",
       	success: function(response) {
       		if (checkIE()) {
           		alert("수강대기가 취소 되었습니다.");
           		location.reload();
       	 	} else {
       	 	swalInit.fire({
	   				title: "수강대기가 취소 되었습니다.", 
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
                    location.reload();
                } else {
                	swalInit.fire({title: response.responseText, type: "error", position: 'top'}).then(function(e) {
						location.reload();
	       			});
                }
            }
        }
	});
}

/**
 * 수강대기 취소
 */
function applyWaitCancel(applyWaitId) {
	$("#waitCancelBtn").prop("disabled", true);
	
	if (checkIE()) {
		var result = confirm("수강대기를 취소 하시겠습니까?");
		if (result) {
			deleteApplyWait(applyWaitId);
		} else {
			$("#waitCancelBtn").prop("disabled", false);
		}
	} else {
		swalInit.fire({
	        title: "수강대기를 취소 하시겠습니까?",
	        type: "question",
	        confirmButtonText: "확인",
	        confirmButtonClass: "btn btn-danger",
	        showCancelButton: true, 
	        cancelButtonText: "닫기",
	        position: "top"
	    }).then(function(e) {
	    	if (e.value) {
	    		deleteApplyWait(applyWaitId);
	    	} else {
	    		$("#waitCancelBtn").prop("disabled", false);
	    	}
	    });
	}
}
</script>