<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/student.css" rel="stylesheet" type="text/css">

<div class="content d-flex justify-content-center align-items-center mb-0"> 
	<form id="studentRegistForm" class="form-validate" action="${pageContext.request.contextPath}/student/regist" method="POST"> 
		<div class="card mb-0">
			<div class="card-header bg-teal-400 text-white py-2">
				<h2>방과후학교 학생 등록</h2>
			</div>
			<div class="card-body student-content">
				<p class="info-text">* 정보 입력 후 하단 [학생등록]을 클릭하세요.<br>핸드폰에 반드시 수업관련안내를 받으실 번호<br>
					<span class="text-orange" style="font-size: 18px; font-weight: bold;">학부모 전화번호</span>를 입력하세요.
				<div class="form-group row pt-2">
					<label class="col-form-label col-3">학 교</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control select-search" name="school" required>
							<option></option>
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
							<c:forEach var="item" begin="1" end="6" step="1">
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
							<c:forEach var="item" begin="1" end="15" step="1">
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
							<c:forEach var="item" begin="1" end="40" step="1">
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
				
				<c:choose>
	   				<c:when test="${fn:contains(city.link, 'hy')}">
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
	   				</c:when>
	   				<c:otherwise>
	   					<fieldset class="mb-0">
							<legend class="fs-14 font-weight-bold">개인정보제공 동의</legend>
							<label class="text-grey-600">학생보험 가입 시 필요한 개인정보제공에 동의를 해 주셔야 가입이 가능합니다.<br>보험가입목적 외에는 절대 사용하지 않습니다.</label>
							<div class="form-check mt-1 mb-0">
								<label class="form-check-label">
									<input id="agreeCheck" type="checkbox" name="agree" class="form-check-input-styled" data-fouc>
									보험가입에 필요한 개인정보를 보험사에 제공하는 것에 동의합니다.
								</label>
							</div>
							<div id="residentNumberInput" class="mt-1 mb-0">
								<div class="form-group mt-2">
									<button id="modalBtn" type="button" class="btn bg-teal-600 px-2" disabled
										data-toggle="modal" data-target="#modal">보험관련 규약추가항목 확인</button>
								</div>
								<div class="form-group mt-3 mb-0">
									<label class="font-weight-bold">학생주민등록번호 입력 :</label>
									<div class="d-flex align-items-center">
										<input type="text" class="form-control format-jumin1" id="jumin1" name="jumin1" required>
										<span class="font-weight-bold mx-2">-</span>
										<input type="password" class="form-control format-jumin2" id="jumin2" name="jumin2" required>
									</div>
								</div>
							</div>
						</fieldset>
	   				</c:otherwise>
   				</c:choose>
			</div>
			
			<div class="card-footer text-center">
				<button id="registBtn" type="submit" class="btn bg-teal-600 rounded-round custom-btn mr-2" disabled>학생등록</button>
				<a href="${pageContext.request.contextPath}/home/${city.id}" class="btn btn-light rounded-round custom-btn">취 소</a>
			</div>
		</div>
	</form>
</div>

<div id="modal" class="modal fade" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title">[단체보험 가입-규약]</h1>
			</div>

			<div class="modal-body">
				<p>1. 회사는 회사를 계약자로, 회원을 피보험자로 하는 단체상해보험을 체결할 수 있습니다.</p>
				<p>2. 회원은 회사가 회원을 피보험자로 하는 단체상해보험을 체결함에 있어 회사가 일괄로 가입하는 방식에 동의합니다.</p>
				<p>3. 회원은 제1항의 보험계약에 따른 담보항목 및 내용을 회사가 제공하는 범주 내에서 선택할 수 있으며, 소정의 절차에 따라 보험 청약을 합니다.</p>
				<p>4. 회원이 가입하는 단체상해보험의 보험금 수익자는 사망보험금인 경우에는 피보험자의 법정상속인, 그 외의 경우에는 피보험자 본인으로 합니다.</p>
				<p>5. 보험계약에 관한 세부내용은 보험사가 제공하는 보험약관에 따르며 이 규약에서 정하지 않은 사항은 회사가 보험사와 약정한 바에 따릅니다.</p>
			</div>

			<div class="modal-footer text-center">
				<button id="confirmBtn" type="button" class="btn bg-teal-600 px-4">확 인</button>
			</div>
		</div>
	</div>
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

	// 보험관련 규약추가항목 확인 여부
	var isConfirm = false;

	/** 개인정보 동의 체크 버튼 클릭 시 */
	$("#agreeCheckBtn").click(function(){
	    if ($(this).is(':checked')) {
	    	isConfirm = true;
	    	$("#registBtn").prop("disabled", false);
	    } else {
	    	$("#registBtn").prop("disabled", true);
	    }
	});
	
	/** 개인정보 동의 체크 버튼 클릭 시 */
	$("#agreeCheck").click(function(){
	    if ($(this).is(':checked')) {
	    	//$("#residentNumberInput").removeClass("d-none");
	    	$("#registBtn").prop("disabled", false);
	    	$("#modalBtn").prop("disabled", false);
	    } else {
	    	//$("#residentNumberInput").addClass("d-none");
	    	$("#registBtn").prop("disabled", true);
	    	isConfirm = false;
	    }
	});
	
	/** 단체보험 가입 확인 버튼 클릭 시 */
	$("#confirmBtn").click(function() {
		$("#modalBtn").prop("disabled", true);
		$("#modal").modal('hide');
		//$("#registBtn").prop("disabled", false);
		isConfirm = true;
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

		if (!isConfirm) {
			if (checkIE()) {
				alert("보험관련 규악추가항목을 확인하세요.");
			} else {
				swalInit.fire({title: "보험관련 규악추가항목을 확인하세요.", type: "warning", position: 'top'});
			}
			
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