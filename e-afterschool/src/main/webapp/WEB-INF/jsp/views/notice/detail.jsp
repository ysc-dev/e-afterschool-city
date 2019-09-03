<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/notice.css" rel="stylesheet" type="text/css">

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="notice/list?infoId=${infoId}" />
  	<c:param name="home" value="info?cityId=${cityId}" />
</c:import>


<div class="content">
	<!-- <div class="content-title d-flex justify-content-center align-items-center mt-2">
		<span class="fs-18">공지사항 상세정보</span>
	</div> -->
	
	<div class="card notice-detail">
		<div class="card-header bg-info-600">
			<h5 class="card-title font-weight-bold">${notice.title}</h5>
		</div>
		<div class="card-body">
			<div class="subject">
				<label class="font-weight-bold">작성자 :</label>
				<label class="ml-1">${notice.userName}</label>

				<label class="font-weight-bold ml-3">조회수 :</label>
				<label class="ml-1">${notice.hit}</label>
			</div>
			<div class="subject">
				<fmt:formatDate var="createDate" value="${localDateTimeFormat.parse(notice.createDate)}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<label class="font-weight-bold">날짜 :</label>
				<label class="ml-1">${createDate}</label>
			</div>
			<div class="content mb-0">
				<p>${notice.content}</p>
			</div>
			<div class="image-content">
				<label class="font-weight-bold">첨부파일 :</label>
				<div class="image-file">
				
				</div>
				<%-- <c:forEach var="file" items="${notice.uploadedFiles}">
					<img src="data:${file.contentType};base64,${file.content}" class="img-fluid"/>
				</c:forEach> --%>
			</div>
		</div>
	</div>
</div>

<script>
$.ajax({
    url: contextPath + "/notice/get",
    type: "GET",
    data: {"id" : '${notice.id}'},
    success : function(response) {
        console.log(response);
        response.uploadedFiles.forEach(function(file, index) {
        	var img = document.createElement("img");
        	img.setAttribute("src", "data:" + file.fileContentType + ";base64," + file.content);
        	img.setAttribute("class", "img-fluid");
	        $(".image-file").append(img);
        });
    }
});
</script>