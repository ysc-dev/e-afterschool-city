<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/micro?infoId=${infoId}&id=${subject.id}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<style>
.col-form-label {
    padding-top: 2px;
    padding-bottom: 2px;
}

@media (max-width: 576px) {
	.long-label {
	    margin-left: 1.25rem!important;
	    padding-bottom: .3125rem!important;
	}
}
</style>
 
<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-2 px-2">
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="card mt-3">
		<div class="card-header text-center bg-info-600 text-white">
			<h6 class="card-title font-weight-bold">과 목 특 징&nbsp;&nbsp;&nbsp;및&nbsp;&nbsp;&nbsp;과 목 정 보</h6>
		</div>
		<div class="card-body subject-info-body">
			<div>
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수강기간 : </label>
	    		<label class="col-form-label ml-1">${subject.period}</label>
	    	</div>
	    	<div>
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수업일시 : </label>
	    		<label class="col-form-label ml-1 long-label">${subject.week} (${subject.time})</label>
	    	</div>
	    	<div>
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>대상학년 : </label>
	    		<label class="col-form-label ml-1">${subject.target}</label>
	    	</div>
	    	<div>
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>재료,교구비 : </label>
	    		<label class="col-form-label ml-1">${subject.cost}</label>
	    	</div>
	    	<div>
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>강사이름 : </label>
	    		<label class="col-form-label ml-1">${subject.teacher.content}</label>
	    	</div>
	    	<div class="align-items-stretch">
	    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>수업장소 : </label>
	    		<label class="col-form-label ml-1 long-label">${subject.location}</label>
	    	</div>
	    	<div class="align-items-stretch">
	    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>과목특징 : </label>
	    		<label class="col-form-label ml-1 long-label">${subject.description}</label>
	    	</div>
		</div>
	</div>
</div>