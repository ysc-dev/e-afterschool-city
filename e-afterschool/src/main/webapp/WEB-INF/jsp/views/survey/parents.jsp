<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/survey.css" rel="stylesheet" type="text/css">

<div class="content mb-0"> 
	<div class="survey-title justify-content-center align-items-center">
		<span class="text-info-600">${city.campus} 방과후학교</span><span>프로그램 및 강사 만족도 설문지(학부모용)</span>
	</div>
	
	<div class="card">
		<form id="surveyRegistForm" class="form-validate" action="${pageContext.request.contextPath}/survey/regist/parents" method="POST"> 
			<div class="card-body">
				<div class="form-group">
					<label class="col-form-label">1. 프로그램명을 선택해주세요.</label>
					<div class="col-12">
						<select data-placeholder="- 선 택 -" class="form-control select-search" name="subjectId" required>
							<option></option>
							<c:forEach var="subject" items="${subjects}" varStatus="status">
								<option value="${subject.id}">${subject.name} - ${subject.teacher.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">2. 프로그램 운영과 관련된 안내가 충분히 이루어졌다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value1" id="radio1_1" value="SCORE10">
							<label class="custom-control-label" for="radio1_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value1" id="radio1_2" value="SCORE8">
							<label class="custom-control-label" for="radio1_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value1" id="radio1_3" value="SCORE6">
							<label class="custom-control-label" for="radio1_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value1" id="radio1_4" value="SCORE4">
							<label class="custom-control-label" for="radio1_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value1" id="radio1_5" value="SCORE10">
							<label class="custom-control-label" for="radio1_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">3. 프로그램 운영시간이 잘 지켜졌다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value2" id="radio2_1" value="SCORE10">
							<label class="custom-control-label" for="radio2_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value2" id="radio2_2" value="SCORE8">
							<label class="custom-control-label" for="radio2_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value2" id="radio2_3" value="SCORE6">
							<label class="custom-control-label" for="radio2_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value2" id="radio2_4" value="SCORE4">
							<label class="custom-control-label" for="radio2_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value2" id="radio2_5" value="SCORE0">
							<label class="custom-control-label" for="radio2_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">4. 프로그램을 운영하기 위한 준비가 잘 되었다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value3" id="radio3_1" value="SCORE10">
							<label class="custom-control-label" for="radio3_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value3" id="radio3_2" value="SCORE8">
							<label class="custom-control-label" for="radio3_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value3" id="radio3_3" value="SCORE6">
							<label class="custom-control-label" for="radio3_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value3" id="radio3_4" value="SCORE4">
							<label class="custom-control-label" for="radio3_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value3" id="radio3_5" value="SCORE0">
							<label class="custom-control-label" for="radio3_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">5. 프로그램 구성이 잘 짜여졌다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value4" id="radio4_1" value="SCORE10">
							<label class="custom-control-label" for="radio4_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value4" id="radio4_2" value="SCORE8">
							<label class="custom-control-label" for="radio4_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value4" id="radio4_3" value="SCORE6">
							<label class="custom-control-label" for="radio4_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value4" id="radio4_4" value="SCORE4">
							<label class="custom-control-label" for="radio4_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value4" id="radio4_5" value="SCORE0">
							<label class="custom-control-label" for="radio4_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">6. 프로그램의 내용과 분량은 학생들에게 적절하였다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value5" id="radio5_1" value="SCORE10">
							<label class="custom-control-label" for="radio5_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value5" id="radio5_2" value="SCORE8">
							<label class="custom-control-label" for="radio5_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value5" id="radio5_3" value="SCORE6">
							<label class="custom-control-label" for="radio5_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value5" id="radio5_4" value="SCORE4">
							<label class="custom-control-label" for="radio5_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value5" id="radio5_5" value="SCORE0">
							<label class="custom-control-label" for="radio5_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">7. 프로그램 운영에 선택된 도서(교재)및 교구(재료)는 학생들의 수준에 맞고 도움이 되었다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value6" id="radio6_1" value="SCORE10">
							<label class="custom-control-label" for="radio6_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value6" id="radio6_2" value="SCORE8">
							<label class="custom-control-label" for="radio6_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value6" id="radio6_3" value="SCORE6">
							<label class="custom-control-label" for="radio6_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value6" id="radio6_4" value="SCORE4">
							<label class="custom-control-label" for="radio6_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value6" id="radio6_5" value="SCORE0">
							<label class="custom-control-label" for="radio6_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">8. 학생의 출결상황, 활동상황 결과에 대한 통지가 적절히 이루어졌다. </label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value7" id="radio7_1" value="SCORE10">
							<label class="custom-control-label" for="radio7_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value7" id="radio7_2" value="SCORE8">
							<label class="custom-control-label" for="radio7_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value7" id="radio7_3" value="SCORE6">
							<label class="custom-control-label" for="radio7_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value7" id="radio7_4" value="SCORE4">
							<label class="custom-control-label" for="radio7_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value7" id="radio7_5" value="SCORE0">
							<label class="custom-control-label" for="radio7_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">9. 프로그램 운영을 통해 자녀의 소질 계발과 실력 향상에 많은 도움이 되었다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value8" id="radio8_1" value="SCORE10">
							<label class="custom-control-label" for="radio8_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value8" id="radio8_2" value="SCORE8">
							<label class="custom-control-label" for="radio8_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value8" id="radio8_3" value="SCORE6">
							<label class="custom-control-label" for="radio8_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value8" id="radio8_4" value="SCORE4">
							<label class="custom-control-label" for="radio8_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value8" id="radio8_5" value="SCORE0">
							<label class="custom-control-label" for="radio8_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">10. 다른사람에게 이 프로그램을 권유하겠다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value9" id="radio9_1" value="SCORE10">
							<label class="custom-control-label" for="radio9_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value9" id="radio9_2" value="SCORE8">
							<label class="custom-control-label" for="radio9_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value9" id="radio9_3" value="SCORE6">
							<label class="custom-control-label" for="radio9_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value9" id="radio9_4" value="SCORE4">
							<label class="custom-control-label" for="radio9_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value9" id="radio9_5" value="SCORE0">
							<label class="custom-control-label" for="radio9_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-form-label">11. 앞으로 이 프로그램에 계속 참여하고싶다.</label>
					<div class="ml-2">
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value10" id="radio10_1" value="SCORE10">
							<label class="custom-control-label" for="radio10_1">매우만족(10)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value10" id="radio10_2" value="SCORE8">
							<label class="custom-control-label" for="radio10_2">만족(8)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value10" id="radio10_3" value="SCORE6">
							<label class="custom-control-label" for="radio10_3">보통(6)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value10" id="radio10_4" value="SCORE4">
							<label class="custom-control-label" for="radio10_4">불만(4)</label>
						</div>
						<div class="custom-control custom-radio">
							<input type="radio" class="custom-control-input" name="value10" id="radio10_5" value="SCORE0">
							<label class="custom-control-label" for="radio10_5">매우불만(0)</label>
						</div>
					</div>
				</div>
				
				<input type="hidden" name="cityId" value="${city.id}"/>
			</div>
			<div class="card-footer text-center">
				<button id="registBtn" type="submit" class="btn bg-teal-600 rounded-round custom-btn mr-2">설문등록</button>
				<a href="${pageContext.request.contextPath}/home/${city.id}" class="btn btn-light rounded-round custom-btn">취 소</a>
			</div>
		</form>
	</div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
	var agent = navigator.userAgent.toLowerCase();
	function checkIE() {
		if ((navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
			return true;
		} else {
			return false;
		}
	}

	//전송 상태 설정 : false
	var isSubmitted = false;

	$("#surveyRegistForm").submit(function(e) {
		e.preventDefault();
		
		// 한번 등록 버튼을 클릭 시 중복으로 클릭이 안되도록
		if (isSubmitted) { 
			isSubmitted = false;
			return;
		}

		if (!$('input:radio[name=value1]').is(':checked') || !$('input:radio[name=value2]').is(':checked')
				|| !$('input:radio[name=value3]').is(':checked') || !$('input:radio[name=value4]').is(':checked')
				|| !$('input:radio[name=value5]').is(':checked') || !$('input:radio[name=value6]').is(':checked')
				|| !$('input:radio[name=value7]').is(':checked') || !$('input:radio[name=value8]').is(':checked')
				|| !$('input:radio[name=value9]').is(':checked')) {
			swalInit.fire({title: "설문에 대해 모두 응답해주세요.", type: "warning", position: 'top'});
			return;
		}

		var form = $(this);
	    var url = form.attr('action');
	    var survey = form.serialize();

		$.ajax({
			type: "POST",
	       	url: url,
	       	data: survey,
	       	success: function(response) {
	           	if (checkIE()) {
	           		location.href = contextPath + "/home/${city.id}";
	           	} else {
	           		swalInit.fire({
	      				title: "설문이 정상 등록 되었습니다.", 
	      				type: "success",
	      				position: 'top'
	      			}).then(function(e) {
	      				location.href = contextPath + "/home/${city.id}";
	      			});
	           	}
	       	},
	       	error: function(response) {
	          	if (checkIE()) {
	            	alert("설문 등록을 실패하였습니다.");
	          	} else {
	          		swalInit.fire({title: "설문 등록을 실패하였습니다.", type: "error", position: 'top'});
	          	}
	          	isSubmitted = false;
	       	}
		});
	});
});
</script>