<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/student.css" rel="stylesheet" type="text/css">

<div class="content d-flex justify-content-center align-items-center"> 
	<form id="studentUpdateForm" class="form-validate" action="${pageContext.request.contextPath}/student/update"> 
		<div class="card mb-0">
			<div class="card-header bg-teal-400 text-white py-2">
				<h2>방과후학교 학생 정보 변경</h2>
			</div>
			<div class="card-body student-content">
				<input type="hidden" name="id" value="${student.id}">
				<p class="info-text">* 정보 입력 후 하단 [정보변경]을 클릭하세요.<br>핸드폰에 반드시 수업관련안내를 받으실 번호<br>(학부모 전화번호)를 입력하세요.
				<div class="form-group row pt-2">
					<label class="col-form-label col-3">학 교</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control select-search" name="school" required>
							<option></option>
							<c:forEach var="school" items="${schools}" varStatus="status">
								<option <c:if test="${student.school == school}">selected</c:if> value="${school}">${school}</option>
							</c:forEach>
						</select >
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">학 년</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="grade" required>
							<option></option>
							<c:forEach var="item" begin="1" end="6" step="1">
								<option <c:if test="${student.grade == item}">selected</c:if> value="${item}">${item} 학년</option>
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
								<option <c:if test="${student.classType == item}">selected</c:if> value="${item}">${item} 반</option>
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
								<option <c:if test="${student.number == item}">selected</c:if> value="${item}">${item} 번</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">이 름</label>
					<div class="col-9">
						<input type="text" class="form-control" name="name" value="${student.name}" disabled>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">핸드폰</label>
					<div class="col-9 d-flex">
						<input type="tel" class="form-control" name="tel" value="${student.tel}" disabled>
					</div>
				</div>
				
				<fieldset class="mb-0">
					<legend class="text-uppercase font-weight-bold">개인정보제공 동의</legend>
					<label class="text-grey-600">학생보험 가입 시 필요한 개인정보제공에 동의를 해 주셔야 가입이 가능합니다.<br>보험가입목적 외에는 절대 사용하지 않습니다.</label>
					<div class="form-check mt-2">
						<label class="form-check-label">
							<input id="agreeCheck" type="checkbox" name="agree" class="form-check-input-styled" data-fouc
								<c:if test="${student.agree == true}">checked</c:if>>
							보험가입에 필요한 개인정보를 보험사에 제공하는 것에 동의합니다.
						</label>
					</div>
					<div id="residentNumberInput" class="mt-1 mb-0">
						<div class="form-group mt-2">
							<button id="modalBtn" type="button" class="btn bg-teal-600 px-2" data-toggle="modal" data-target="#modal">보험관련 규약추가항목 확인</button>
						</div>
						<div class="form-group mt-3 mb-0">
							<label class="font-weight-bold">학생주민등록번호 입력 :</label>
							<div class="d-flex align-items-center">
								<input type="text" class="form-control format-jumin1" id="jumin1" name="jumin1" value="${student.jumin1}">
								<span class="font-weight-bold mx-2">-</span>
								<input type="password" class="form-control format-jumin2" id="jumin2" name="jumin2" value="${student.jumin2}">
							</div>
						</div>
					</div>
				</fieldset>
			</div>
			<div class="card-footer text-center">
				<button id="updateBtn" type="submit" class="btn bg-teal-600 rounded-round custom-btn mr-2">정보변경</button>
				<a href="${pageContext.request.contextPath}/subject/group?infoId=${infoId}" class="btn btn-light rounded-round custom-btn">취 소</a>
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
		} else {
			return false;
		}
	}
	
	$('[name="tel"]').formatter({
	    pattern: '{{9999}}-{{9999}}'
	});
	
	if ("${student.agree}" == "true") {
		$("#updateBtn").prop("disabled", true);
	}

	// 보험관련 규약추가항목 확인 여부
	var isConfirm = false;
	
	$("#agreeCheck").click(function(){
	    if ($(this).is(':checked')){
	    	//$("#residentNumberInput").removeClass("d-none");
	    	$("#updateBtn").prop("disabled", false);
	    	$("#modalBtn").prop("disabled", false);
	    } else {
	    	//$("#residentNumberInput").addClass("d-none");
	    	$("#updateBtn").prop("disabled", true);
	    	isConfirm = false;
	    }
	});
	
	$("#confirmBtn").click(function() {
		$("#modalBtn").prop("disabled", true);
		$("#modal").modal('hide');
		$("#updateBtn").prop("disabled", false);
		isConfirm = true;
	});
	
	//전송 상태 설정 : false
	var isSubmitted = false;
	
	$("#studentUpdateForm").submit(function(e) {
		e.preventDefault();

		$("#updateBtn").prop("disabled", true);
		
		// 한번 등록버튼을 클릭 시 중복으로 클릭이 안되도록
		if (isSubmitted) { 
			isSubmitted = false;
			return;
		}

		if (!isConfirm) {
			if (checkIE()) {
				alert("보험관련 규악추가항목을 확인하세요.");
			} else {
				swalInit.fire({title: "보험관련 규악추가항목을 확인하세요.", type: "warning", position: 'top'});
			}
			
			updateError();
			return;
		}
		
		isSubmitted = true;
		
		var form = $(this);
	    var url = form.attr('action');
	    var student = form.serialize();
	
	    if ($("#agreeCheck").is(":checked")) {
			if ($("#jumin1").val() == '' || $("#jumin2").val() == '') {
				$("#jumin1").focus();
				updateError();
				return;
			}
			
			if (!validate()) {
				if (checkIE()) {
					alert("올바른 주민번호가 아닙니다.");
				} else {
					swalInit.fire({title: "올바른 주민번호가 아닙니다.", type: "warning", position: 'top'});
				}
				updateError();
				return;
			}
	
			if (!${student.agree}) { // 처음에 개인정보제공 동의가 안되어 있을 때
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
							updateError();
						} else {
							updateStudent(student, url);
						}
					}
				});
			} else {
				updateStudent(student, url);
			}
		} else {
			updateStudent(student, url);
	   	}
	});
	
	function updateStudent(student, url) {
		$.ajax({
	       	url: url,
			type: "PUT",
	       	data: student,
	       	success: function(response) {
	       		if (checkIE()) {
	       			location.href = contextPath + "/home/${city.id}";
	       		} else {
	       			swalInit.fire({
	      				title: "학생 정보 수정 되었습니다.", 
	      				type: "success",
	      				position: 'top'
	      			}).then(function(e) {
	      				location.href = contextPath + "/home/${city.id}";
	      			});
	       		}
	       	},
	        error: function(response) {
	        	if (checkIE()) {
	            	alert("학생 정보 수정을 실패하였습니다.");
	        	} else {
	        		swalInit.fire({title: "학생 정보 수정을 실패하였습니다.", type: "error", position: 'top'});
	           	}
	        	updateError();
	        }
		});
	}

	// 수정 오류
	function updateError() {
		isSubmitted = false;
		$("#updateBtn").prop("disabled", false);
	}
	
	//주민번호 검증 확인
	function validate() {
	    var num1 = document.getElementById("jumin1");
	    var num2 = document.getElementById("jumin2");
	
	    var ssn1 = num1.value;
        var ssn2 = num2.value;

        return CommonUtil.validateJumin(ssn1, ssn2);
	}
});
</script>