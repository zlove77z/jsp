<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberList.jsp(admin)</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
  	body {
  	  font-size: 0.8em;
  	}
    th, td {
      text-align: center;
    }
  </style>
  <script>
    'use strict';
    
    function levelChange(e) {
    	//let level = document.getElementById("level").value;
    	let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
    	//alert("레벨 : " + e.value);
    	let items = e.value.split("/");
    	
    	$.ajax({
    		type : "post",
    		url  : "MemberLevelChange.ad",
    		data : {
    			level : items[0],
    			idx   : items[1]
    		},
    		success:function(res) {
    			if(res != 0) {
    				alert("등급 수정 완료!!");
    				location.reload();
    			}
    			else alert("등급 수정 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 등급별 조회
    function levelViewCheck() {
    	let level = document.getElementById("levelView").value;
    	location.href = "MemberList.ad?pageSize=${pageSize}&pag=${pag}&level="+level;
    }
    
    // 사용자 페이지 설정
    function pageSizeChange() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "MemberList.ad?pageSize="+pageSize+"&pag=${pag}&level=${level}";
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">회 원 리 스 트</h2>
  <table class="table table-borderless m-0">
    <tr>
      <td class="text-right">등급별조회
        <select name="levelView" id="levelView" onchange="levelViewCheck()">
          <option value=""   <c:if test="${empty level}">selected</c:if> >전체회원</option>
          <option value="1"  <c:if test="${level == 1}" >selected</c:if> >준회원</option>
          <option value="2"  <c:if test="${level == 2}" >selected</c:if> >정회원</option>
          <option value="3"  <c:if test="${level == 3}" >selected</c:if> >우수회원</option>
          <option value="99" <c:if test="${level == 99}">selected</c:if> >탈퇴신청회원</option>
          <option value="0"  <c:if test="${level == 0}" >selected</c:if>  >관리자</option>
        </select>
      </td>
    </tr>
  </table>
  <table class="table table-hover">
    <tr class="table-secondary">
      <th>번호</th>
      <th>닉네임</th>
      <th>아이디</th>
      <th>성명</th>
      <th>성별</th>
      <th>생일</th>
      <th>이메일</th>
      <th>최종방문일</th>
      <th>활동여부</th>
      <th>현재레벨</th>
    </tr>
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	    <tr <c:if test="${vo.userInfor != '공개'}"> style="background-color:#fcc" </c:if>>
	      <td>${vo.idx}</td>
	      <td>${vo.nickName}</td>
	      <td><a href="MemberDetailView.ad?idx=${vo.idx}">${vo.mid}</a></td>
	      <td>${vo.name}</td>
	      <td>${vo.gender}</td>
	      <td>${fn:substring(vo.birthday,0,10)}</td>
	      <td>${vo.email}</td>
	      <td>
	        <c:if test="${sMid == vo.mid}">${fn:substring(sLastDate,0,16)}</c:if>
	        <c:if test="${sMid != vo.mid}">${fn:substring(vo.lastDate,0,16)}</c:if>
	      </td>
	      <td>
	        <c:if test="${vo.userDel == 'NO'}">활동중</c:if>
	        <c:if test="${vo.userDel != 'NO'}"><font color='red'>탈퇴신청중</font>(${vo.elapsed_date})</c:if>
	      </td>
	      <td>
	        <select name="level" id="level" onchange="levelChange(this)">
	          <option value="1/${vo.idx}"  ${vo.level == 1 ? 'selected' : ''}>준회원</option>
	          <option value="2/${vo.idx}"  ${vo.level == 2 ? 'selected' : ''}>정회원</option>
	          <option value="3/${vo.idx}"  ${vo.level == 3 ? 'selected' : ''}>우수회원</option>
	          <option value="0/${vo.idx}"  ${vo.level == 0 ? 'selected' : ''}>관리자</option>
	          <option value="99/${vo.idx}" ${vo.level == 99 ? 'selected' : ''}>탈퇴신청회원</option>
	        </select>
	      </td>
	    </tr>
  	</c:forEach>
  	<tr><td colspan="10" class="m-0 p-0"></td></tr>
  </table>
  
  <!-- 사용자 페이지 설정 -->
  <table class="table table-borderless m-0">
    <tr>
      <td class="text-right">
        <select name="pageSize" id="pageSize" onchange="pageSizeChange()">
          <option <c:if test="${pageSize == 3}"  >selected</c:if> >3</option>
          <option <c:if test="${pageSize == 5}"  >selected</c:if> >5</option>
          <option <c:if test="${pageSize == 10}" >selected</c:if> >10</option>
          <option <c:if test="${pageSize == 15}" >selected</c:if> >15</option>
          <option <c:if test="${pageSize == 20}" >selected</c:if> >20</option>
          <option <c:if test="${pageSize == 30}" >selected</c:if> >30</option>
        </select>
      </td>
    </tr>
  </table>
  
<!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=1">첫페이지</a></li></c:if>
	  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li></c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
	    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${(curBlock+1)*blockSize+1}">다음블록</a></li></c:if>
	  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="MemberList.ad?level=${level}&pageSize=${pageSize}&pag=${totPage}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->
</div>
<p><br/></p>
</body>
</html>