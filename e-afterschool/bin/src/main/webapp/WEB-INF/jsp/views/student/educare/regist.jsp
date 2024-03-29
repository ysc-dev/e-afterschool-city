<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/student.css" rel="stylesheet" type="text/css">

<div class="content d-flex justify-content-center align-items-center mb-0"> 
	<form id="studentRegistForm" class="form-validate" action="${pageContext.request.contextPath}/student/educare/regist" method="POST"> 
		<div class="card mb-0">
			<div class="card-header bg-teal-400 text-white py-2">
				<h2>방과후학교 학생 등록</h2>
			</div>
			<div class="card-body student-content">
				<p class="info-text">정보 입력 후 하단 [학생등록]을 클릭하세요.<br>핸드폰에 반드시 수업관련안내를 받으실 번호<br>
					<span class="text-orange" style="font-size: 18px; font-weight: bold;">학부모 전화번호</span>를 입력하세요.
				<div class="form-group row pt-2">
					<label class="col-form-label col-3">아파트</label>
					<div class="col-9">
						<input type="text" class="form-control" name="apartment" value="${city.apartment}" readonly>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">동</label>
					<div class="col-9">
						<input type="number" class="form-control" name="dong" autocomplete="off" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">호 수</label>
					<div class="col-9">
						<input type="number" class="form-control" name="ho" autocomplete="off" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">학 교</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control select-search" name="school" required>
							<option></option>
							<option value="${city.apartment}-유치부">유치부</option>
							<option value="${city.apartment}-성인부">성인부</option>
							<option value="${city.apartment}-고등부">고등부</option>
							<c:forEach var="school" items="${schools}" varStatus="status">
								<option value="${school}">${school}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">학 년</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="grade" required>
							<option></option>
							<c:forEach var="item" begin="0" end="6" step="1">
								<option value="${item}">${item} 학년</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">반</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="classType" required>
							<option></option>
							<c:forEach var="item" begin="0" end="15" step="1">
								<option value="${item}">${item} 반</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">번 호</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="number" required>
							<option></option>
							<c:forEach var="item" begin="0" end="40" step="1">
								<option value="${item}">${item} 번</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">이 름</label>
					<div class="col-9">
						<input type="text" class="form-control" name="name" autocomplete="off" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">핸드폰</label>
					<div class="col-9 d-flex">
						<select class="form-control select2-size" name="service" data-width="120">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						<input type="tel" class="form-control ml-2" name="tel" autocomplete="off" required placeholder="1234-5678">
					</div>
				</div>
				
				<fieldset class="mb-0">
					<legend class="fs-14 font-weight-bold">개인정보제공 동의</legend>
					<label class="text-grey-600">개인정보제공에 동의를 해 주셔야 가입이 가능합니다.<br>수집된 개인정보를 방과후학교 외의 용도로는 사용하지 않습니다.</label>
					<div class="form-check mt-1 mb-0">
						<label class="form-check-label">
							<input id="agreeCheckBtn" type="checkbox" name="agree" class="form-check-input-styled" data-fouc>
							개인정보를 제공하는 것에 동의합니다.
						</label>
					</div>
				</fieldset>
			</div>
			<div class="card-footer text-center">
				<button id="registBtn" type="submit" class="btn bg-teal-600 rounded-round custom-btn mr-2" disabled>학생등록</button>
				<a href="${pageContext.request.contextPath}/home/${city.id}" class="btn btn-light rounded-round custom-btn">취 소</a>
			</div>
		</div>
	</form>
</div>

<script>
$(function() {
	var agent = navigator.userAgent.toLowerCase();
	function checkIE() {
		if ((navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
			return true;
		} 
		return false;
	}
	
	$('[name="tel"]').formatter({
	    pattern: '{{9999}}-{{9999}}'
	});

	/** 개인정보 동의 체크 버튼 클릭 시 */
	$("#agreeCheckBtn").click(function(){
	    if ($(this).is(':checked')) {
	    	$("#registBtn").prop("disabled", false);
	    } else {
	    	$("#registBtn").prop("disabled", true);
	    }
	});
	
	// 전송 상태 설정 : false
	var isSubmitted = false;
	
	$("#studentRegistForm").submit(function(e) {
		e.preventDefault();
		
		$("#registBtn").prop("disabled", true);

		// 한번 등록 버튼을 클릭 시 중복으로 클릭이 안되도록
		if (isSubmitted) { 
			registError();
			return;
		}
		
		isSubmitted = true;
		
		var form = $(this);
	    var url = form.attr('action');
	    var student = form.serialize();
	    
		if ($("#agreeCheck").is(":checked")) {
			if ($("#jumin1").val() == '' || $("#jumin2").val() == '') {
				$("#jumin1").focus();
				registError();
				return;
			}
			
			if (!validate()) {
				if (checkIE()) {
					alert("올바른 주민번호 형식이 아닙니다.");
				} else {
					swalInit.fire({title: "올바른 주민번호 형식이 아닙니다.", type: "warning", position: 'top'});
				}
				registError();
				return;
			}
			
			$.ajax({
				url: contextPath + "/student/search/jumin",
				type: "GET",
				data: student,
				success: function(response) {
					if (response) {
						if (checkIE()) {
							alert("이미 등록된 주민번호입니다.");
						} else {
							swalInit.fire({title: "이미 등록된 주민번호입니다.", type: "warning", position: 'top'});
						}
						registError();
					} else {
						registStudent(student, url);
					}
				}
			});
		} else if ($("#agreeCheckBtn").is(":checked")) {
			registStudent(student, url);
		}
	});

	// 학생 등록
	function registStudent(student, url) {
		$.ajax({
			url: contextPath + "/student/search",
			type: "GET",
			data: student,
			success: function(response) {
	       		if (response) {
	       			if (checkIE()) {
						alert("이미 등록된 학생 정보입니다.");
					} else {
						swalInit.fire({title: "이미 등록된 학생 정보입니다.", type: "warning", position: 'top', confirmButtonClass: 'btn btn-warning',});
					}
	       			registError();
	       		} else {
	       			$.ajax({
	       				type: "POST",
	       	           	url: url,
	       	           	data: student,
	       	           	success: function(response) {
		       	           	if (checkIE()) {
		       	           		location.href = contextPath + "/home/${city.id}";
		       	           	} else {
		       	           		swalInit.fire({
				       				title: "학생 등록 되었습니다.", 
				       				type: "success",
				       				position: 'top'
				       			}).then(function(e) {
				       				location.href = contextPath + "/home/${city.id}";
				       			});
		       	           	}
	       	           	},
	       	            error: function(response) {
	       	            	if (checkIE()) {
	           	            	alert("학생 등록을 실패하였습니다.");
	       	            	} else {
	       	            		swalInit.fire({title: "학생 등록을 실패하였습니다.", type: "error", position: 'top'});
	       	            	}
	       	            	registError();
	       	            }
	       			});
	       		}
	       	}
		});
	}

	// 등록 오류
	function registError() {
		isSubmitted = false;
		$("#registBtn").prop("disabled", false);
	}
	
	// 주민번호 검증 확인
	function validate() {
	    var num1 = document.getElementById("jumin1");
	    var num2 = document.getElementById("jumin2");
	
	    var ssn1 = num1.value;
        var ssn2 = num2.value;

        return CommonUtil.validateJumin(ssn1, ssn2);
	}
});
</script>