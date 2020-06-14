<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet" type="text/css">

<style>
/* #registBtn { background-color: #ffffcc!important; }
#loginBtn { background-color: #ffcc66!important; }
#infoBtn { background-color: #99cc99!important; }
.info-card { background-color: #cccc66!important; } */
/* #registBtn { background-color: #fdffab!important; }
#loginBtn { background-color: #eaffd0!important; }
#infoBtn { background-color: #ffd3b6!important; }
.info-card { background-color: #ffd3e1!important; border-radius: .5rem; }  */
/* #registBtn { background-color: #EAF6F6!important; box-shadow: 5px 5px 5px #eee;} 
#loginBtn { background-color: #F3E9E8!important; box-shadow: 5px 5px 5px #eee;}
#infoBtn { background-color: #E4D4DE!important; box-shadow: 5px 5px 5px #eee;}
.info-card { background-color: #F4F9FC!important; border-radius: .5rem; }  */
</style>

<div class="content home-content">
	<div class="home-title justify-content-center align-items-center">
		<span>${city.content} <span class="text-info-600">캠퍼스형</span> 방과후학교에</span><span>오신 것을 환영합니다.</span>
	</div>
	
	<div class="row mt-3">
		<div class="col-6 p-3 px-md-5 border-right border-bottom">
			<div class="d-flex flex-column text-center">
				<div class="mb-2">
					<i class="fas fa-user-plus fa-2x text-grey-400"></i>
				</div>
				<div class="btn-title text-grey-800">학생 등록</div>
				<div class="text-grey-400">처음이신가요?</div>
				<button type="button" id="registBtn" class="btn btn-outline-info btn-lg rounded-round mt-2">들어가기</button>
			</div>
		</div>
		<div class="col-6 p-3 px-md-5 border-bottom"> 
			<div class="d-flex flex-column text-center">
				<div class="mb-2">
					<i class="fas fa-sign-in-alt fa-2x text-grey-400"></i>
				</div>
				<div class="btn-title text-grey-800">로그인</div>
				<div class="text-grey-400">&nbsp;로그인 하시겠습니까?</div>
				<button type="button" id="loginBtn" class="btn btn-outline-info btn-lg rounded-round mt-2">들어가기</button>
			</div>
		</div>
		<div class="col-6 p-3 px-md-5 border-right">
			<div class="d-flex flex-column text-center">
				<div class="mb-2">
					<i class="fas fa-info-circle fa-2x text-grey-400"></i>
				</div>
				<div class="btn-title text-grey-800">프로그램 안내</div>
				<div class="text-grey-400">안내장 정보입니다.</div>
				<button type="button" id="infoBtn" class="btn btn-outline-info btn-lg rounded-round mt-2">들어가기</button>
			</div>
		</div>
		<div class="col-6 py-3 px-0">
			<div class="d-flex flex-column align-items-center text-center">
				<div>
					<div>수강신청주소</div>
					<span class="fs-10 font-weight-bold" style="letter-spacing:0rem">
						http://e-afterschool.kr/${city.link}
					</span>
				</div>
				<div class="mt-1">
					<div>수강신청문의</div>
					<div class="font-weight-bold">${city.tel1}</div>
				</div>
				<div class="mt-1">
					<div>기타운영문의</div>
					<div class="font-weight-bold">${city.tel2}</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$("#registBtn").click(function() {
	location.href = contextPath + "/student/regist?cityId=${city.id}";
});

$("#loginBtn").click(function() {
	location.href = contextPath + "/login/${city.id}";
});

$("#infoBtn").click(function() {
	location.href = contextPath + "/info?cityId=${city.id}";
});
</script>