<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/box.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content">  
	<div class="content-title justify-content-center align-items-center mt-3 px-2">  
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="">
		<div class="row mt-4 mx-0">
			<div class="col-6">
				<button type="button" id="subjectInfoBtn" class="btn btn-box btn-outline bg-white border-slate-300">
					<div class="fs-20 text-info-600 py-3">
						<p><span>과 목 정 보 및</span></p>
						<p class="mb-0"><span>과 목 특 징</span></p>
					</div>
				</button>
			</div>
			<div class="col-6"> 
				<button type="button" id="communityBtn" class="btn btn-box btn-outline bg-light border-slate-300">
					<div class="fs-20 text-info-600">
						<span>커 뮤 니 티</span>
					</div>
				</button>
			</div>
		</div>
		
		<div class="row mt-3 mx-0">
			<div class="col-6">
				<button type="button" id="classContentsBtn" class="btn btn-box btn-outline bg-light border-slate-300">
					<div class="fs-20 text-info-600">
						<p><span>횟수별</span></p>
						<p class="mb-0"><span>수 업 내 용</span></p>
					</div>
				</button>
			</div>
			<div class="col-6">
				<div class="guidance-content">
					<div class="card mb-2"> 
						<div class="card-body">
							<div class="card-box">
								<p class="mb-1">현재 정원</p>
								<p>${subject.applyNumber}/${subject.fixedNumber}명</p>
							</div>
						</div>
					</div>
				</div>
				
				<c:choose>
					<c:when test="${subject.applyType == 'APPLY'}">
				       <button type="button" class="btn btn-small-box bg-info-600" disabled="disabled"><span>신 청 완 료</span></button>
				    </c:when>
				    <c:when test="${subject.applyType == 'APPLYWAIT'}">
				       <button type="button" class="btn btn-small-box bg-info-600" disabled="disabled"><span>신청 대기 중</span></button>
				    </c:when>
	  				<c:when test="${subject.applyType == 'NOTAPPLY'}">
	 					<button type="button" class="btn btn-small-box bg-danger-600" disabled="disabled"><span>신 청 불 가</span></button>
	  				</c:when>
	  				<c:when test="${subject.applyType == 'FILL'}">
				       <button type="button" class="btn btn-small-box bg-orange-600" onclick="applyWait(${subject.id})"><span>정 원 초 과</span></button>
				    </c:when>
	  				<c:when test="${subject.applyType == 'WAITING'}">
				       <button type="button" class="btn btn-small-box bg-warning-600" disabled="disabled"><span>대기인원 초과</span></button>
				    </c:when>
	 				<c:otherwise>
	 					<button type="button" class="btn btn-small-box bg-info-600" onclick="apply(${subject.id})"><span>신 청 하 기</span></button>
	 				</c:otherwise>
				</c:choose>
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

$("#subjectInfoBtn").click(function() {
	location.href = contextPath + "/subject/info?infoId=${infoId}&id=${subject.id}";
});

$("#communityBtn").click(function() {
	location.href = contextPath + "/subject/community/list?infoId=${infoId}&id=${subject.id}";
});

$("#classContentsBtn").click(function() {
	location.href = contextPath + "/subject/class?infoId=${infoId}&id=${subject.id}";
});

function registWait(subjectId) {
	$.ajax({
		url: contextPath + "/apply/wait/regist",
  		data: {"infoId": ${infoId}, "subjectId": subjectId},
  		type: "POST",
       	success: function(response) {
       		location.reload();
       	},
        error: function(response) {
            if (checkIE()) {
                alert(response.responseText);
            } else {
            	swal({title: response.responseText, type: "error", position: "top"});
            }
        }
	});
}

function commonWait(subjectId) {
	if (checkIE()) {
		var result = confirm("정원 초과입니다.\n수강신청 대기하시겠습니까?");
		if (result) {
			registWait(subjectId);
		}
	} else {
		swal({
	        title: "정원 초과입니다.\n수강신청 대기하시겠습니까?",
	        type: "info",
	        confirmButtonText: "삭제",
	        confirmButtonClass: "btn btn-info",
	        showCancelButton: true, 
	        cancelButtonText: "취소",
	        position: "top"
	    }).then(function(e) {
	    	if (e.value) {
		    	registWait(subjectId);
	    	}
	    });
	}
}

function apply(subjectId) {
	$.ajax({
		url: contextPath + "/apply/regist",
  		data: {"infoId": ${infoId}, "subjectId": subjectId},
  		type: "POST",
       	success: function(response) {
       		if (checkIE()) {
           		alert("수강 신청이 되었습니다.");
           		location.reload();
       		} else {
       			swal({
       				title: "수강 신청이 되었습니다.", 
       				type: "success",
       				position: "top"
       			}).then(function(e) {
       				location.reload();
       			});
       		}
       	},
        error: function(response) {
			if (response.responseText == "정원초과") {
				commonWait(subjectId);
			} else {
				if (checkIE()) {
					alert(response.responseText);
				} else {
					swal({title: response.responseText, type: "error", position: "top"});
				}
			}
        }
	});
	/* swal({
	    title: "수강신청 하시겠습니까?",
	    type: "question",
	    confirmButtonText: "확인",
	    confirmButtonClass: "btn btn-primary",
	    showCancelButton: true, 
	    cancelButtonText: "닫기",
	    position: "top"
	}).then(function(e) {
		
	}); */
}

function applyWait(subjectId) {
	commonWait(subjectId);
}
</script>