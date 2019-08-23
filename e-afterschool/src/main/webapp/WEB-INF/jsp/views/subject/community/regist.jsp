<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/community/list?infoId=${infoId}&id=${subject.id}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>

<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-2">
		<span class="fs-18">커뮤니티 글 등록</span>
	</div>
	
	<div class="card mt-4">
		<form id="registForm" role="form" method="POST" action="${pageContext.request.contextPath}/subject/community/regist">
			<div class="card-body">
				<input type="hidden" id="subjectId" name="subjectId" value="${subject.id}"/>
				<div class="form-group row">
					<label class="col-md-3 col-form-label text-md-right">과목 이름 :</label>
					<div class="col-md-7">
						<input type="text" class="form-control" value="${subject.name}" readonly>
					</div>
				</div>
				
				<div class="form-group row mt-2">
					<label class="col-md-3 col-form-label text-md-right">제 목 :</label>
					<div class="col-md-7">
						<input type="text" class="form-control" name="title" autocomplete="off" required>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-md-3 col-form-label text-md-right">내 용 :</label>
					<div class="col-md-7">
						<textarea class="form-control" name="content" rows="5" required></textarea>
					</div>
				</div>
			</div>
			<div class="card-footer text-center">
				<button type="submit" class="btn bg-teal-400 px-4"><i class="icon-pencil5 mr-2"></i>저 장</button>
			</div>
		</form>
	</div>
</div>

<script>
$('#registForm').submit(function(e) {
	e.preventDefault();

	var form = $(this);
    var url = form.attr('action');
    var formData = new FormData($("#registForm")[0]);

    console.log(form);
    console.log(formData);

    $.ajax({
		type: "POST",
       	url: url,
       	data: formData,
       	processData: false,
       	contentType: false,
       	success: function(response) {
           	console.log(response);
       		swal({
   				title: "글 등록이 되었습니다.", 
   				type: "success",
   				position: "top"
   			}).then(function(e) {
   				location.replace(contextPath + "/subject/community/list?infoId=${infoId}&id=${subject.id}");
   			});
       	},
        error: function(response) {
        	swal({title: "글 등록을 실패하였습니다.", type: "error", position: "top"})
        }
	});
});
</script>