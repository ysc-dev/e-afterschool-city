<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/micro?infoId=${infoId}&id=${subject.id}" />
  	<c:param name="home" value="info?cityId=${city.id}" />
</c:import>

<style>
.col-form-label {
    padding-top: 4px;
    padding-bottom: 4px;
}

.card {
	border: 0px;
    border-bottom: 1px solid rgba(0,0,0,.125);
}
</style>
 
<div class="content px-0">
	<div class="content-title d-flex justify-content-center align-items-center mt-2">
		<span class="fs-18">${subject.name}</span>
	</div>
	
	<div class="card mt-3">
		<div class="card-header text-center bg-info-600 text-white">
			<h6 class="card-title font-weight-bold">과 목 특 징&nbsp;&nbsp;&nbsp;및&nbsp;&nbsp;&nbsp;과 목 정 보</h6>
		</div>
		<div class="card-body subject-info-body">
			<div class="d-flex">
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수강기간 : </label>
	    		<label class="col-form-label ml-2">${subject.period}</label>
	    	</div>
	    	<div class="d-flex">
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수업일시 : </label>
	    		<label class="col-form-label ml-2">${subject.week} (${subject.time})</label>
	    	</div>
	    	<div class="d-flex">
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>대상학년 : </label>
	    		<label class="col-form-label ml-2">${subject.target}</label>
	    	</div>
	    	<div class="d-flex">
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>재료,교구비 : </label>
	    		<label class="col-form-label ml-2">${subject.cost}</label>
	    	</div>
	    	<div class="d-flex">
	    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>강사이름 : </label>
	    		<label class="col-form-label ml-2">${subject.teacher.name}</label>
	    	</div>
	    	<div class="d-flex flex-column">
	    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>수업장소 : </label>
	    		<label class="col-form-label mx-3">${subject.location}</label>
	    	</div>
	    	<div class="d-flex flex-column">
	    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>과목특징 : </label>
	    		<label class="col-form-label mx-3">${subject.description}</label>
	    	</div>
		</div>
	</div>
</div>