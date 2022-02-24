<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/student.css" rel="stylesheet" type="text/css">

<div class="content d-flex justify-content-center align-items-center"> 
	<form id="studentUpdateForm" class="form-validate" action="${pageContext.request.contextPath}/student/educare/update"> 
		<div class="card mb-0">
			<div class="card-header bg-teal-400 text-white py-2">
				<h2>방과후학교 학생 정보 변경</h2>
			</div>
			<div class="card-body student-content">
				<input type="hidden" name="id" value="${student.id}">
				<p class="info-text">* 정보 입력 후 하단 [정보변경]을 클릭하세요.<br>핸드폰에 반드시 수업관련안내를 받으실 번호<br>(학부모 전화번호)를 입력하세요.
				<div class="form-group row pt-2">
					<label class="col-form-label col-3">아파트</label>
					<div class="col-9">
						<input type="text" class="form-control" name="apartment" value="${student.apartment}" readonly>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">동</label>
					<div class="col-9">
						<input type="number" class="form-control" name="dong" value="${student.dong}" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">호 수</label>
					<div class="col-9">
						<input type="number" class="form-control" name="ho" value="${student.ho}" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-3">학 교</label>
					<div class="col-9">
						<select data-placeholder="- 선 택 -" class="form-control select-search" name="school" required>
							<option></option>
							<option value="${city.apartment}-유치부">유치부</option>
							<option value="${city.apartment}-성인부">성인부</option>
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
					<label class="text-grey-600">개인정보제공에 동의를 해 주셔야 가입이 가능합니다.<br>수집된 개인정보를 방과후학교 외의 용도로는 사용하지 않습니다.</label>
					<div class="form-check mt-1 mb-0">
						<label class="form-check-label">
							<input id="agreeCheckBtn" type="checkbox" name="agree" class="form-check-input-styled" data-fouc
								<c:if test="${student.agree == true}">checked</c:if>>
							개인정보를 제공하는 것에 동의합니다.
						</label>
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

	/** 개인정보 동의 체크 버튼 클릭 시 */
	$("#agreeCheckBtn").click(function(){
	    if ($(this).is(':checked')) {
	    	$("#updateBtn").prop("disabled", false);
	    } else {
	    	$("#updateBtn").prop("disabled", true);
	    }
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
	       			location.href = contextPath + "/home/${cityId}";
	       		} else {
	       			swalInit.fire({
	      				title: "학생 정보 수정 되었습니다.", 
	      				type: "success",
	      				position: 'top'
	      			}).then(function(e) {
	      				location.href = contextPath + "/home/${cityId}";
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
	    var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
	    var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    // 이메일이 적합한지 검사할 정규식
	
	    var num1 = document.getElementById("jumin1");
	    var num2 = document.getElementById("jumin2");
	
	    var arrNum1 = new Array(); // 주민번호 앞자리숫자 6개를 담을 배열
	    var arrNum2 = new Array(); // 주민번호 뒷자리숫자 7개를 담을 배열
	
	    // -------------- 주민번호 -------------
	    for (var i = 0; i < num1.value.length; i++) {
	        arrNum1[i] = num1.value.charAt(i);
	    } // 주민번호 앞자리를 배열에 순서대로 담는다.
	
	    for (var i = 0; i < num2.value.length; i++) {
	        arrNum2[i] = num2.value.charAt(i);
	    } // 주민번호 뒷자리를 배열에 순서대로 담는다.
	
	    var tempSum = 0;
	
	    for (var i = 0; i < num1.value.length; i++) {
	        tempSum += arrNum1[i] * (2+i);
	    } // 주민번호 검사방법을 적용하여 앞 번호를 모두 계산하여 더함
	
	    for (var i = 0; i < num2.value.length-1; i++) {
	        if (i >= 2) {
	            tempSum += arrNum2[i] * i;
	        }
	        else {
	            tempSum += arrNum2[i] * (8+i);
	        }
	    } // 같은방식으로 앞 번호 계산한것의 합에 뒷번호 계산한것을 모두 더함
	
	    if ((11-(tempSum%11))%10 != arrNum2[6]) {
	        //alert("올바른 주민번호가 아닙니다.");
	        num1.value = "";
	        num2.value = "";
	        num1.focus();
	        return false;
	    } else{
	    	//alert("올바른 주민등록번호 입니다.");
	    	return true;
	    }
	}
});
</script>