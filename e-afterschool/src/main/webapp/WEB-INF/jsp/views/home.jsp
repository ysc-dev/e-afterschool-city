<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<link href="${pageContext.request.contextPath}/css/home.css" rel="stylesheet" type="text/css">

<style>
.regist-title {color : #f39c12!important;}
.login-title {color : #3498db!important;}
.info-title {color : #2ecc71!important;}
</style>

<div class="content home-content mb-0">
	<c:choose>
	    <c:when test="${fn:contains(city.link, 'jin-ro')}">
	    	<div class="d-flex justify-content-center">
	    		<div class="navbar-brand mr-3">
	    			<a href="#">
			    		<img style="height: 70px;" src="${pageContext.request.contextPath}/images/jinro_logo.png" alt="logo">
					</a>
	    		</div>
	    		<div class="home-title justify-content-center align-items-center">
					<span><span class="text-info-600">${city.content}</span>에</span><span>오신 것을 환영합니다.</span>
				</div>
	    	</div>
			<div class="row mt-3">
				<div class="col-6 border-right border-bottom">
					<button type="button" id="registBtn_jinro" class="btn btn-block bg-transparent py-4" data-fouc>
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
	    </c:when>
	    <c:otherwise>
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
	    </c:otherwise>
	</c:choose>
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

<div id="modal_jinro" class="modal fade jinro-popup" data-backdrop="true" data-keyboard="false" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title font-weight-bold">2022 김해진로교육지원센터 진로체험 프로그램 지원 안내</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<div class="modal-body">
				<table class="table table-bordered">
					<thead class="text-center">
						<tr>
							<th class="thead-no">No.</th>
							<th class="thead-title" colspan="2">프로그램명</th>
							<th class="thead-content">내용</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<tr>
							<td class="tbody-no">1</td>
							<td class="tbody-title" colspan="2">찾아가는 직업인 특강</td>
							<td class="tbody-content">다양한 진로 탐색 기회제공,<br>전문직업인의 진로체험경험 제공</td>
						</tr>
						<tr>
							<td class="tbody-no">2</td>
							<td class="tbody-title" colspan="2">메타버스 타고 가야古go</td>
							<td class="tbody-content">메타버스 세상과 현실 세계가 융합된 플랫폼을<br>이해하고, 메타버스 플랫폼을 활용하여<br>가야문화와 진로체험 경험 제공</td>
						</tr>
						<tr>
							<td class="tbody-no" rowspan="2">3</td>
							<td class="tbody-title td-border-righr" rowspan="2">환경체험캠프</td>
							<td class="tbody-title">온그린 생태환경 교육</td>
							<td class="tbody-content">아쿠아포닉스-친환경 자원순환 시스템이해,<br>일회용 플라스틱컵 재사용 제로웨이스트 실천</td>
						</tr>
						<tr>
							<td class="tbody-title">환경진로캠프</td>
							<td class="tbody-content">친환경 신재생 에너지에 대해 배움으로써<br>탄소 중립에 대한 이해<br>-수소에너지와 신재생에너지</td>
						</tr>
						<tr>
							<td class="tbody-no">4</td>
							<td class="tbody-title" colspan="2">찾아가는 고교학점제 설명회</td>
							<td class="tbody-content">전문강사와 함께 하는 달라지는 입시제도<br>‘고교학점제’ 실질적인 체험와 이해</td>
						</tr>
						<tr>
							<td class="tbody-no" rowspan="2">5</td>
							<td class="tbody-title td-border-righr" rowspan="2">진로·진학교실<br>및 박람회</td>
							<td class="tbody-title">진로진학박람회</td>
							<td class="tbody-content">진로를 설계할 수 있는 다양한 방법 모색 및<br>직접 체험으로 경험의 폭 확장, 학과 탐색을<br>통한 진로설계</td>
						</tr>
						<tr>
							<td class="tbody-title">A+전문가 진학상담</td>
							<td class="tbody-content">학교장 추천 취약계층 1:1 입시 전문가<br>진학 상담</td>
						</tr>
						<tr>
							<td class="tbody-no">6</td>
							<td class="tbody-title" colspan="2">인성캠프</td>
							<td class="tbody-content">창의성, 리더십, 협동심 등 다방면 역량 확대<br>참여형 팀빌딩 프로그램</td>
						</tr>
						<tr>
							<td class="tbody-no" rowspan="2">7</td>
							<td class="tbody-title td-border-righr" rowspan="2">미래체험캠프</td>
							<td class="tbody-title">로봇랜드 V-pro<br>미래캠프</td>
							<td class="tbody-content">로봇랜드와 함께하는 현장체험형 진로캠프</td>
						</tr>
						<tr>
							<td class="tbody-title">디월드 드론캠프</td>
							<td class="tbody-content">항공우주연구소 ANH스트럭쳐의 디월디와<br>함께하는 현장체험형 진로캠프</td>
						</tr>
					</tbody>
				</table>
				<div class="font-weight-bold mt-2" style="font-size: 1rem">
					☆ 홈페이지를 이용자 신청 편의를 위하여 반응형 웹버전으로 업그레이드 중입니다. 4월전에 완료예정입니다. 
					그 전에는 불편하시더라도 첨부된 신청서를 작성하시어 진로교육지원센터 이메일로 보내주시면 정말 감사하겠습니다. !!
				</div>
				<div class="mt-2">
					☆ 김해진로교육지원센터 운영시간: 월~금 09:00~18:00 (토요일은 프로그램 운영시)
				</div>
				<div>
					☆ 프로그램 문의: T.055-325-1577, F.055-338-1588
				</div>
				<div>
					☆ E-mail: <a href="#">ghjinro2022@naver.com</a><br>
					☆ 홈페이지: <a href="http://www.김해진로센터.com">www.김해진로센터.com</a>
				</div>
			</div>

			<div class="modal-footer" style="margin-top: -60px;"> 
				<button type="button" class="btn bg-info" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
var cityId = "${city.id}";
var cityLink = "${city.link}";

if (cityLink.includes('jin-ro')) {
	$('#modal_jinro').modal();
}

$("#registBtn").click(function() {
	if (cityLink.includes('educare')) {
		location.href = contextPath + "/student/educare/regist?cityId=" + cityId;
	} else {
		location.href = contextPath + "/student/regist?cityId=" + cityId;
	}
});

$("#registBtn_jinro").click(function() {
	var cityId = "${city.id}";
	location.href = contextPath + "/student/jinro/regist?cityId=" + cityId;
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