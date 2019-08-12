<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<div class="content d-flex justify-content-center align-items-center"> 
	<form class="login-form form-validate" action="${pageContext.request.contextPath}/login" method="POST"> 
		<div class="card mb-0">
			<div class="card-body">
				<div class="text-center mt-2 mb-4">
					<i class="icon-reading icon-2x text-slate-300 border-slate-300 border-3 rounded-round p-3 mb-2 mt-1"></i>
					<h3 class="mb-1">로그인</h3>
					<span class="d-block text-muted">학생 이름과 학부모 전화번호를 입력하세요.</span>
				</div>
				
				<c:if test="${not empty error}">
					<div class="alert alert-danger border-0 alert-dismissible">
						<button type="button" class="close" data-dismiss="alert"><span>×</span></button>
						<span class="font-weight-semibold">학생 정보가 일치하지 않습니다.</span>
				    </div>
				</c:if>
				
				<div class="form-group form-group-feedback form-group-feedback-left">
					<input type="text" class="form-control" placeholder="학생 이름" autocomplete="off" value="${username}" name="username" required>
					<div class="form-control-feedback">
						<i class="icon-user text-muted"></i>
					</div>
				</div>
				
				<div class="form-group form-group-feedback form-group-feedback-left">
					<input type="text" class="form-control" data-mask="999-9999-9999" placeholder="전화 번호" autocomplete="off" name="password" required>
					<div class="form-control-feedback">
						<i class="icon-phone2 text-muted"></i>
					</div>
				</div>
				
				<input type="hidden" value="${cityId}" name="cityId"/>

				<div class="form-group">
					<button type="submit" class="btn bg-info-600 btn-block">로그인<i class="icon-circle-right2 ml-2"></i></button>
				</div>
				
				<div class="form-group mt-4">
					<a href="${pageContext.request.contextPath}/home/${cityId}" class="btn btn-light btn-block">
						뒤로가기<i class="icon-circle-right2 ml-2"></i>
					</a>
				</div>
			</div>
		</div>
	</form>
</div>