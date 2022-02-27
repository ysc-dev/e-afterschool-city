<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet" type="text/css">

<style>
.regist-title {color : #f39c12!important;}
.login-title {color : #3498db!important;}
.info-title {color : #2ecc71!important;}
</style>

<div class="content home-content mb-0">
	<div class="home-title justify-content-center align-items-center">
		<span><span class="text-info-600">${city.content}</span>에</span><span>오신 것을 환영합니다.</span>
	</div>
	
	<div class="row mt-3">
		<div class="col-6 border-right border-bottom">
			<button type="button" id="registBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="fas fa-user-plus fa-2x regist-title"></i>
					</div>
					<div class="btn-title regist-title">학생 등록</div>
					<div class="fs-12 text-grey-400">처음이신가요?</div>
				</div>
			</button>
		</div>
		<div class="col-6 border-bottom"> 
			<button type="button" id="loginBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="fas fa-sign-in-alt fa-2x login-title"></i>
					</div>
					<div class="btn-title text-grey-800 login-title">로그인</div>
					<div class="fs-12 text-grey-400">&nbsp;로그인하시겠습니까?</div>
				</div>
			</button>
		</div>
		<div class="col-6 border-right border-bottom">
			<button type="button" id="infoBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="fas fa-info-circle fa-2x info-title"></i>
					</div>
					<div class="btn-title info-title">아이꿈틀 진로체험<br>프로그램 안내</div>
					<div class="fs-12 text-grey-400">준비중입니다.</div>
				</div>
			</button>
		</div>
		<div class="col-6 border-bottom">
			<button type="button" id="infoBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="fas fa-info-circle fa-2x text-teal-400"></i>
					</div>
					<div class="btn-title text-teal-400">꿈길안내</div>
					<div class="fs-12 text-grey-400">준비중입니다.</div>
				</div>
			</button>
		</div>
		<div class="col-6 border-right">
			<button type="button" id="infoBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="icon-bubble-notification icon-2x text-slate-400"></i>
					</div>
					<div class="btn-title text-slate-400">공지사항</div>
					<div class="fs-12 text-grey-400">수강신청관련 가오픈입니다.<br>홈페이지 운영에 지장 없습니다.</div>
				</div>
			</button>
		</div>
		<div class="col-6">
			<button type="button" id="infoBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="icon-clipboard3 icon-2x text-brown-400"></i>
					</div>
					<div class="btn-title text-brown-400">센터 소개</div>
					<div class="fs-12 text-grey-400">준비중입니다.</div>
				</div>
			</button>
		</div>
	</div>
	
	<div class="mt-2 d-flex flex-column text-center text-grey-800 fs-13">
		<div>
			이용안내 : <span class="font-weight-bold">김해진로교육지원센터</span> 
		</div>
		<div>
			Tel. <span class="font-weight-bold">055-325-1577</span>
		</div>
		<div>
			FAX. <span class="font-weight-bold">055-338-1588</span>
		</div>
		<div>
			E-mail. <span class="font-weight-bold">ghjinro2022@naver.com</span>
		</div>
		<div>
			<span class="font-weight-bold">운영시간  월~토 09:00~17:00</span>
		</div>
		<div>
			<span class="font-weight-bold">(일요일/공휴일 휴무)</span>
		</div>
		<div class="mt-2">
			<span class="font-weight-bold">경상남도 김해시 주촌면 골든루트로 80-16<br>김해중소기업비지니스센터 2층 206~7호</span>
		</div>
	</div>
</div>

<script>
$("#registBtn").click(function() {
	var cityId = "${city.id}";
	location.href = contextPath + "/student/jinro/regist?cityId=" + cityId;
});

/* $("#loginBtn").click(function() {
	location.href = contextPath + "/login/${city.id}";
}); */

/* $("#infoBtn").click(function() {
	location.href = contextPath + "/info?cityId=${city.id}";
}); */

$("#surveyBtn").click(function() {
	$('#surveyModal').modal();
});

$("#surveyStudentBtn").click(function() {
	location.href = contextPath + "/survey/student?cityId=${city.id}";
});

$("#surveyParentsBtn").click(function() {
	location.href = contextPath + "/survey/parents?cityId=${city.id}";
});
</script>