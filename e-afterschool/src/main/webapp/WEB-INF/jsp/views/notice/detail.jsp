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
				<div class="image-file"></div>
			</div>
		</div>
	</div>
</div>

<script>
var agent = navigator.userAgent.toLowerCase();
function checkIE() {
	if ((navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
		return true;
	} else {
		return false;
	}
}

$.ajax({
    url: contextPath + "/notice/get",
    type: "GET",
    data: {"id" : '${notice.id}'},
    success : function(response) {
    	$.each(response.uploadedFiles, function(index, file) {
        	var a = document.createElement("a");
        	a.setAttribute("href", "#");
        	a.setAttribute("onclick", "fileDownload(" + file.id + ")");
        	//a.setAttribute("download", "download");
            
        	var img = document.createElement("img");
        	img.setAttribute("src", "data:" + file.contentType + ";base64," + file.content);
        	img.setAttribute("class", "img-fluid");
        	a.appendChild(img);
        	
	        $(".image-file").append(a);
        });
    }
});

function fileDownload(id) {
	if (checkIE()) {
		var result = confirm("다운로드 하시겠습니까?");
		if (result) {
			$.ajax({
		  		url: contextPath + "/notice/get/file",
		  		data: {"id": id},
		  		type: "get",
		  		dataType: "json",
		  		success: function(response) {
		  			var file = base64ToArrayBuffer(response.content);
		  			var fileURL = window.URL.createObjectURL(new Blob([file]));
	  		 	 	window.navigator.msSaveBlob(new Blob([file]), response.fileName);
		 		}
			});
		} 
	} else {
		swal({
	        title: "다운로드 하시겠습니까?",
	        type: "question",
	        confirmButtonText: "확인",
	        confirmButtonClass: "btn btn-info",
	        showCancelButton: true, 
	        cancelButtonText: "닫기",
	        position: "top"
	    }).then(function(e) {
	    	if (e.value) {
	    		$.ajax({
	    	  		url: contextPath + "/notice/get/file",
	    	  		data: {"id": id},
	    	  		type: "get",
	    	  		dataType: "json",
	    	  		success: function(response) {
	    	  			var file = base64ToArrayBuffer(response.content);
        	  		   	var a = document.createElement('a');
        	  		   	a.href = window.URL.createObjectURL(new Blob([file]));
        	  		   	a.download = response.fileName;
        	  		   	// Firefox에서 다운로드 안되는 문제 수정용 코드
        	  		   	// (Firefox는 a가 화면에 실존할 때만 다운로드 가능)
        	  		   	document.body.appendChild(a);
        	  		   	a.click();
        	  		   	document.body.removeChild(a); 
	    	 		}
	    		});
	    	}
	    });
	}
}

/** 버퍼 변환 */
function base64ToArrayBuffer(base64) {
    var binaryString = window.atob(base64);
    var binaryLen = binaryString.length;
    var bytes = new Uint8Array(binaryLen);
    for (var i = 0; i < binaryLen; i++) {
       var ascii = binaryString.charCodeAt(i);
       bytes[i] = ascii;
    }
    return bytes;
}
</script>