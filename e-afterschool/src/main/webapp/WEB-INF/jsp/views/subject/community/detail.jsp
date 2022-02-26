<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/notice.css" rel="stylesheet" type="text/css">

<sec:authentication property="principal" var="user"></sec:authentication>

<c:import url="/WEB-INF/jsp/common/header.jsp" >
  	<c:param name="left" value="subject/community/list?infoId=${infoId}&id=${subjectId}" />
  	<c:param name="home" value="info?cityId=${city.id}" />
</c:import>

<div class="content">
	<div class="content-title d-flex justify-content-center align-items-center mt-2">
		<span class="fs-18">커뮤니티 상세정보</span>
	</div>
	
	<div class="card notice-detail mt-4">
		<div class="card-header bg-info-600">
			<h5 class="card-title font-weight-bold">${notice.title}</h5>
		</div>
		<div class="card-body">
			<div class="subject">
				<label class="font-weight-bold">작성자 :</label>
				<label class="ml-1">${notice.userName}</label>
				
				<fmt:formatDate var="createDate" value="${localDateTimeFormat.parse(notice.createDate)}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<label class="font-weight-bold ml-3">날짜 :</label>
				<label class="ml-1">${createDate}</label>
			</div>
			<div class="content">
				<p>${notice.content}</p>
			</div>
		</div>
		<div class="comment-body"> 
			<h6 class="mb-2 font-weight-bold">댓글 ${fn:length(comments)}개</h6>
			<div class="d-flex mt-2">
				<textarea class="form-control m-input" id="commentInput" rows="1"></textarea>
				<button type="button" id="commentRegistBtn" class="btn btn-info ml-2">추가</button> 
			</div>
		</div>
		<c:if test="${fn:length(comments) > 0}">
			<div class="comment-list-body">
				<c:forEach var="comment" items="${comments}" varStatus="status">
					<div class="comment-list">
						<div class="d-flex justify-content-between media-title">
							<div>
								<a href="#" class="text-primary-800 font-weight-bold">${comment.userName}</a>
								<fmt:formatDate var="createDate" value="${localDateTimeFormat.parse(comment.createDate)}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<span class="text-muted ml-2">${createDate}</span>
							</div>
							
							<c:if test="${user.id == comment.userId && user.name == comment.userName}">
								<div>
									<a href="#" onclick="updateBtnClick(${comment.id})" class="text-primary font-weight-bold">수정</a>
									<a href="#" onclick="deleteCommentClick(${comment.id})" class="text-danger font-weight-bold ml-1">삭제</a>
								</div>
							</c:if>
						</div>
						<div id="content_${comment.id}">
							<p>${comment.content}</p>
						</div>
						<div id="update_${comment.id}" class="d-none mt-1">
							<div class="d-flex">
								<textarea class="form-control" id="updateInput_${comment.id}" rows="1"></textarea>
								<button type="button" onclick="updateComment(${comment.id})" class="btn btn-primary px-2 ml-2">수정</button>
								<button type="button" onclick="cancel(${comment.id})" class="btn btn-light px-2 ml-1">취소</button>
							</div>
						</div>
					</div>
					<c:if test="${status.last == false}">
						<hr class="my-0">
					</c:if>
				</c:forEach> 
			</div>
		</c:if>
		<c:if test="${user.id == notice.userId && user.name == notice.userName}">
			<div class="card-footer text-right">
				<button type="button" class="btn bg-danger-400 btn-sm" onclick="deleteNoticeClick(${notice.id})">
					<i class="icon-trash mr-2"></i>삭 제
				</button>
			</div>
		</c:if>
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

$("#commentRegistBtn").click(function() {
	var content = $("#commentInput").val();
	if (content) {
		$.ajax({
    		url: contextPath + "/comment/regist",
    		type: "POST",
    		data: {"subjectNoticeId": "${notice.id}", "content": content},
    		success: function(response) {
        		if (checkIE()) {
        			location.reload();
           		} else {
           			swalInit.fire({
               			title: "댓글이 추가되었습니다.",
           				type: "success"
           			}).then(function(e) {
           				location.reload();
           			});
           		}
    		},
    		error: function(response) {
    			if (checkIE()) { 
        			alert("댓글 추가을 실패하였습니다.");
    			} else {
    				swalInit.fire({title: "댓글 추가을 실패하였습니다.", type: "error"});
       			}
            }
    	});
	} else {
		if (checkIE()) { 
			alert("댓글 내용을 입력하세요.");
		} else {
			swalInit.fire({title: "댓글 내용을 입력하세요.", type: "warning"});
		}
	}
});

/** 댓글 수정 버튼 클릭 시 */
function updateBtnClick(id) {
	$.ajax({
  		url: contextPath + "/comment/get",
  		data: {"id": id},
  		type: "GET",
  		dataType: "json",
  		success: function(response) {
  			$("#content_" + id).addClass("d-none");
  			$("#update_" + id).removeClass("d-none");
  			$("#updateInput_" + id).val(response.content);
 		}
	});
}

function updateComment(id) {
	var content = $("#updateInput_" + id).val();
	if (content) {
		$.ajax({
      		url: contextPath + "/comment/update",
      		data: {"id": id, "content": content},
      		type: "PUT",
      		success: function(response) {
      			location.reload();
     		},
            error: function(response) {
            	swalInit.fire({title: "댓글 수정을 실패하였습니다.", type: "error"})
            }
		});
	} else {
		swalInit.fire({title: "댓글 내용을 입력하세요.", type: "warning"});
	}
}

function cancel(id) {
	$("#content_" + id).removeClass("d-none");
	$("#update_" + id).addClass("d-none");
	$("#updateInput_" + id).val("");
}

function deleteComment(id) {
	$.ajax({
		url: contextPath + "/comment/delete",
		type: "DELETE",
		data: {"id": id},
		success: function(response) {
			location.reload();
       	},
        error: function(response) {
        	if (checkIE()) {
            	alert("댓글 삭제를 실패하였습니다.");
           	} else {
           		swalInit.fire({title: "댓글 삭제를 실패하였습니다.", type: "error"});
           	}
        }
	}); 
}

/** 댓글 삭제 버튼 클릭 시 */
function deleteCommentClick(id) {
	if (checkIE()) {
		var result = confirm("삭제하시겠습니까?");
		if (result) {
			deleteComment(id);
		}
	} else {
		swalInit.fire({
	        title: "삭제하시겠습니까?",
	        type: "warning",
	        confirmButtonText: "삭제",
	        confirmButtonClass: "btn btn-danger",
	        showCancelButton: true, 
	        cancelButtonText: "취소",
	    }).then(function(e) {
	    	if (e.value) {
	    		deleteComment(id);
	    	}
	    });
	}
}

/** 공지사항 삭제 버튼 클릭 시 */
function deleteNoticeClick(id) {
	if (checkIE()) {
		var result = confirm("등록 된 글을 삭제하시겠습니까?");
		if (result) {
			deleteNotice(id);
		}
	} else {
		swalInit.fire({
	        title: "등록 된 글을 삭제하시겠습니까?",
	        type: "warning",
	        confirmButtonText: "삭제",
	        confirmButtonClass: "btn btn-danger",
	        showCancelButton: true, 
	        cancelButtonText: "취소",
	    }).then(function(e) {
	    	if (e.value) {
	    		deleteNotice(id);
	    	}
	    });
	}
}

function deleteNotice(id) {
	$.ajax({
		url: contextPath + "/subject/community/delete",
		type: "DELETE",
		data: {"id": id},
		success: function(response) {
			swalInit.fire({
   				title: "글이 삭제 되었습니다.", 
   				type: "success"
   			}).then(function(e) {
   				location.replace(contextPath + "/subject/community/list?infoId=${infoId}&id=${subjectId}");
   			});
       	},
        error: function(response) {
        	swalInit.fire({title: "글 삭제를 실패하였습니다.", type: "error"})
        }
	}); 
}
</script>