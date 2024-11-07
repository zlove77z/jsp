<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileDownload.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
    // 전체 선택
    function allCheck() {
    	for(let i=0; i<myform.fileFlag.length; i++) {
    		myform.fileFlag[i].checked = true;
    	}
    }
    
    // 전체 해제
    function allReset() {
    	for(let i=0; i<myform.fileFlag.length; i++) {
    		myform.fileFlag[i].checked = false;
    	}
    }
    
    // 선택반전
    function reverseCheck() {
    	for(let i=0; i<myform.fileFlag.length; i++) {
    		myform.fileFlag[i].checked = !myform.idxFlag[i].checked;
    	}
    }
    
    // 현재 파일 삭제 처리
    function fileDelete(fileName) {
		$.ajsx({
			type : "post",
			url : "FileDelete.st",
			data : {vileName : fileName},
			success:function(res) {
				if(res != "0") {
					alert("삭제완료");
					location.reload();
				}
				else alert("삭제 실패~~");
			}
			error : function() {
				alert("전송오류!");
			}
		});
	}
    
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>저장된 파일 정보</h2>
  <hr/>
  <div class="row">
    <div class="col"><a href="FileUpload.st" class="btn btn-warning">돌아가기</a></div>
    <div class="col"><input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm mr-1"/></div>
    <div class="col"><input type="button" value="전체취소" onclick="allReset()" class="btn btn-warning btn-sm mr-1"/></div>
    <div class="col"><input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm mr-1"/></div>
    <div class="col"><input type="button" value="선택항목삭제" onclick="selectDeleteCheck()" class="btn btn-danger btn-sm mr-1"/></div>
  </div>
  <hr/>
  <br/>
  <div>
    <form name="myform">
    	<c:forEach var="file" items="${files}" varStatus="st">
	      <input type="checkbox" name="fileFlag" id="fileFlag${st.index}" value="file"/>
	      ${st.count} : <a href="${ctp}/images/pdstest/${file}" title="다운로드" download="${file}">${file}</a>
	      <c:set var="fNameArr" value="${fn:split(file,'.')}"/>
	      <c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1])}"/>
	      <font color="blue"><b>
		      <c:if test="${extName == 'zip'}">압축파일</c:if>
		      <c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일</c:if>
		      <c:if test="${extName == 'xlsx'}">엑셀파일</c:if>
		      <c:if test="${extName == 'txt'}">텍스트파일</c:if>
	      </b></font>
	      <c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'}">
	        <img src="${ctp}/images/pdstest/${file}" width="150px" />
	      </c:if>
	      <a href="javascript:fileDelete('${file}')" class="btn btn-danger">삭제</a>
	      <a href="JavaFileDownload.st?file=${file}" class="btn btn-primary ml-3">자바다운로드</a>
	      <br/><br/>
	    </c:forEach>
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>