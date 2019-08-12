<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/box.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/group?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content mt-5">  
	<div class="content-title justify-content-center align-items-center mt-3 px-2">  
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="row mt-5 mx-0">
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
  				<c:when test="${subject.applyType == 'NOTAPPLY'}">
 					<button type="button" class="btn btn-small-box bg-danger-600" disabled="disabled"><span>신 청 불 가</span></button>
  				</c:when>
  				<c:when test="${subject.applyType == 'FILL'}">
			       <button type="button" class="btn btn-small-box bg-orange-800" disabled="disabled"><span>정 원 초 과</span></button>
			    </c:when>
 				<c:otherwise>
 					<button type="button" class="btn btn-small-box bg-info-600" onclick="apply(${subject.id})"><span>신 청 하 기</span></button>
 				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script>
$("#subjectInfoBtn").click(function() {
	location.href = contextPath + "/subject/info?infoId=${infoId}&id=${subject.id}";
});

$("#communityBtn").click(function() {
	location.href = contextPath + "/subject/community?infoId=${infoId}&id=${subject.id}";
});

$("#classContentsBtn").click(function() {
	location.href = contextPath + "/subject/class?infoId=${infoId}&id=${subject.id}";
});

function apply(subjectId) {
	swal({
	    title: "수강신청 하시겠습니까?",
	    type: "question",
	    confirmButtonText: "확인",
	    confirmButtonClass: "btn btn-primary",
	    showCancelButton: true, 
	    cancelButtonText: "닫기",
	    position: "top"
	}).then(function(e) {
		$.ajax({
			url: contextPath + "/apply/regist",
	  		data: {"infoId": ${infoId}, "subjectId": subjectId},
	  		type: "POST",
	       	success: function(response) {
	       		swal({
       				title: "수강 신청이 되었습니다.", 
       				type: "success",
       				position: 'top'
       			}).then(function(e) {
       				location.reload();
       			});
	       	},
	        error: function(response) {
	        	swal({title: response.responseText, type: "error", position: 'top'});
	        }
		});
	});
}
</script>