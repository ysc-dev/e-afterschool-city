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
.regist-title {color : #f39c12!important;}
.login-title {color : #3498db!important;}
.info-title {color : #2ecc71!important;}
</style>

<div class="content home-content mb-0">
	<div class="home-title justify-content-center align-items-center">
		<c:choose>
		    <c:when test="${fn:contains(city.link, 'educare')}">
		        <span><span class="text-info-600">${city.content}</span> 커뮤니티센터 프로그램에</span><span>오신 것을 환영합니다.</span>
		    </c:when>
		    <c:when test="${fn:contains(city.link, 'jin-ro')}">
		        <span><span class="text-info-600">${city.content}</span>에</span><span>오신 것을 환영합니다.</span>
		    </c:when>
		    <c:otherwise>
		        <span>${city.content} <span class="text-info-600">${city.campus}</span> 방과후학교에</span><span>오신 것을 환영합니다.</span>
		    </c:otherwise>
		</c:choose>
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
		<div class="col-6 border-right">
			<button type="button" id="infoBtn" class="btn btn-block bg-transparent py-4" data-fouc>
				<div class="d-flex flex-column text-center">
					<div class="mb-2">
						<i class="fas fa-info-circle fa-2x info-title"></i>
					</div>
					<div class="btn-title info-title">프로그램 안내</div>
					<div class="fs-12 text-grey-400">안내장 정보입니다.</div>
				</div>
			</button>
		</div>
		<div class="col-6">
			<c:choose>
				<c:when test="${city.survey == 'ON'}">
					<button type="button" id="surveyBtn" class="btn btn-block bg-transparent py-4" data-fouc>
						<div class="d-flex flex-column text-center">
							<div class="mb-2">
								<i class="fas fa-clipboard-list fa-2x text-info-400"></i>
							</div>
							<div class="btn-title text-info-400">만족도 조사 및</div>
							<div class="btn-title text-info-400">설문조사</div> 
						</div>
					</button>
				</c:when>
				<c:otherwise>
					<div class="btn-content py-5 text-grey-800">
						<div class="font-weight-bold text-center">지금은 설문조사 기간이<br>아닙니다.</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<div class="mt-2 d-flex flex-column text-center text-grey-800 fs-12">
		<div>
			수강신청주소 :
			<span class="font-weight-bold">http://e-afterschool.kr/${city.link}</span>
		</div>
		<div>
			수강신청문의 :
			<span class="font-weight-bold">${city.tel1}</span>
		</div>
		<div class="${city.link == 'hy' ? 'display-none' : ''}">
			기타운영문의 :
			<span class="font-weight-bold">${city.tel2}</span>
		</div>
	</div>
</div>

<div id="surveyModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title">
                    <i class="fas fa-clipboard-list mr-2"></i>만족도 조사 및 설문조사 선택
                </h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body text-center">
            	<div class="d-flex">
            		<button type="button" id="surveyParentsBtn" class="btn btn-block bg-transparent py-4" data-fouc>
						<div class="d-flex flex-column text-center">
							<div class="mb-2">
								<i class="icon-users fa-2x text-teal-400"></i>
							</div>
							<div class="btn-title text-teal-400">학부모용</div>
						</div>
					</button>
					
					<button type="button" id="surveyStudentBtn" class="btn btn-block bg-transparent py-4" data-fouc>
						<div class="d-flex flex-column text-center">
							<div class="mb-2">
								<i class="icon-users fa-2x regist-title"></i>
							</div>
							<div class="btn-title regist-title">학생용</div>
						</div>
					</button>
            	</div>
            </div>
        </div>
    </div>
</div>

<script>
$("#registBtn").click(function() {
	var cityId = "${city.id}";
	var cityLink = "${city.link}";
	if (cityLink.includes('educare')) {
		location.href = contextPath + "/student/educare/regist?cityId=" + cityId;
	} else {
		location.href = contextPath + "/student/regist?cityId=" + cityId;
	}
});

$("#loginBtn").click(function() {
	location.href = contextPath + "/login/${city.id}";
});

$("#infoBtn").click(function() {
	location.href = contextPath + "/info?cityId=${city.id}";
});

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