<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    let nickCheckSw = 0;
    
  	// 정규식을 이용한 유효성검사처리.....
    let regNickName = /^[가-힣0-9_]{2,20}$/;			// 닉네임은 한글, 숫자, 밑줄만 2~20자 가능
    let regName = /^[가-힣a-zA-Z0-9]{2,20}$/;				// 이름은 한글/영문/숫자 2~20자 가능
    
    function fCheck() {
    	let nickName = myform.nickName.value;
    	let name = myform.name.value;
    	
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	if(tel2 == "") tel2 = " ";
    	if(tel3 == "") tel3 = " ";
    	
    	let tel = myform.tel1.value + "-" + tel2 + "-" + tel3;
    	let email = myform.email1.value + "@" + myform.email2.value;
    	let address = myform.postcode.value+" /"+myform.address.value+" /"+myform.detailAddress.value+" /"+myform.extraAddress.value+" ";
    	
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 2자리 이상 한글만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 2자리 이상 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
			// 이메일 주소형식체크
			
			// 전화번호 형식 체크
    	
    	myform.tel.value = tel;
    	myform.email.value = email;
    	myform.address2.value = address;
    	
		  // 닉네임 중복버튼 눌렀는지 체크
    	if(nickCheckSw == 0) {
    		alert("닉네임 중복체크버튼을 눌러주세요");
    		document.getElementById("nickNameBtn").focus();
    		return false;
    	}
    	
  		myform.email.value = email;
  		myform.tel.value = tel;
  		myform.address.value = address;
  		//myform.submit();
    	
    }
    
    // 닉네임 중복체크(AJax처리)
    function nickNameAjaxCheck() {
    	let nickName = myform.nickName.value;
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 2자리 이상 한글만 사용가능합니다.");
        myform.nickName.focus();
        //return false;
      }
    	else if(nickName == '${sNickName}') {
    		alert("현재 닉네임을 그대로 사용합니다.");
    		nickCheckSw = 1;
    		//return false;
    	}
    	else {
	    	nickCheckSw = 1;
	    	
	    	$.ajax({
	    		type : "get",
	    		url  : "NickNameAjaxCheck.mem",
	    		data : {nickName : nickName},
	    		success:function(res) {
	    			if(res != "0") alert("닉네임이 중복되었습니다.\n다른 닉네임을 사용하세요.");
	    			else alert("사용하실구 있는 닉네임 입니다.\n계속 처리해 주세요.");
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="MemberUpdateOk.mem" onsubmit="return fCheck()">
    <h3 class="text-center">회원 정보 수정</h3>
    <table class="table table-bordered">
      <tr>
        <th class="text-center"><label for="mid" class="form-label">아이디</label></th>
        <td>${sMid}</td>
      </tr>
      <tr>
        <th class="text-center"><label for="name" class="form-label">성명</label></th>
        <td><input type="text" name="name" id="name" value="${vo.name}" class="form-control" required /></td>
      </tr>
      <tr>
        <th class="text-center"><label for="nickName" class="form-label">닉네임</label></th>
        <td>
          <div class="input-group">
	          <input type="text" name="nickName" id="nickName" value="${vo.nickName}" class="form-control" required />
	          <div class="input-group-append ml-1">
	          	<input type="button" value="닉네임 중복체크" onclick="nickNameAjaxCheck()" id="nickNameBtn" class="form-control btn-secondary" />
	          </div>
          </div>
        </td>
      </tr>
      <tr>
        <th class="text-center">성별</th>
        <td>
          <input type="radio" name="gender" id="male" value="남자"   <c:if test="${vo.gender == '남자'}">checked</c:if> class="mr-1" /><label for="male" class="form-label mr-3">남자</label>
          <input type="radio" name="gender" id="female" value="여자" <c:if test="${vo.gender == '여자'}">checked</c:if> class="mr-1" /><label for="female" class="form-label">여자</label>
        </td>
      </tr>
      <tr>
        <th class="text-center"><label for="birthday" class="form-label">생일</label></th>
        <%-- <td><input type="date" name="birthday" id="birthday" value="${vo.birthday.substring(0,10)}" class="form-control"></td> --%>
        <td><input type="date" name="birthday" id="birthday" value="${fn:substring(vo.birthday,0,10)}" class="form-control"></td>
      </tr>
      <tr>
        <th class="text-center"><label for="tel1" class="form-label">전화번호</label></th>
        <td>
          <div class="input-group">
            <div class="input-group-prepend">
	        	<select id="tel1" name="tel1" class="form-control mr-1">
	            <%-- <option <c:if test="${vo.tel1=='010'}">selected</c:if> >010</option> --%>
	            <option ${tel1=='010' ? 'selected' : ''}>010</option>
	            <option ${tel1=='02' ? 'selected'  : ''} value="02">서울</option>
	            <option ${tel1=='041' ? 'selected' : ''} value="041">천안</option>
	            <option ${tel1=='042' ? 'selected' : ''} value="042">대전</option>
	            <option ${tel1=='043' ? 'selected' : ''} value="043">청주</option>
	            <option ${tel1=='031' ? 'selected' : ''} value="031">인천</option>
	          </select>
	          </div>
	          -<input type="text" name="tel2" id="tel2" value="${tel2}" maxlength="4" class="form-control ml-1 mr-1">
	          -<input type="text" name="tel3" id="tel3" value="${tel3}" maxlength="4" class="form-control ml-1">
          </div>
        </td>
      </tr>
      <tr class="mb-2">
        <th class="text-center"><label for="address" class="form-label">주소</label></th>
        <td>
          <div class="input-group mb-1">
		      	<input type="text" name="postcode" id="sample6_postcode" value="${postcode}" onclick="sample6_execDaumPostcode()" placeholder="우편번호" class="form-control mr-1" readonly>
		      	<div class="input-group-append">
							<input type="button" value="우편번호 찾기" onclick="sample6_execDaumPostcode()" class="btn btn-secondary">
						</div>
					</div>
					<input type="text" name="address" id="sample6_address" value="${address}" onclick="sample6_execDaumPostcode()" placeholder="주소" class="form-control mb-1" readonly>
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" class="form-control mr-1">
						<div class="input-group-append">
							<input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" onclick="sample6_execDaumPostcode()" placeholder="참고항목" class="form-control" readonly>
						</div>
					</div>
        </td>
      </tr>
      <tr class="mb-2">
        <th class="text-center">이메일</th>
        <td>
          <div class="input-group">
	          <input type="text" name="email1" id="email1" value="${email1}" class="form-control mr-1" required />@
	          <div class="input-group-append ml-1">
		          <select id="email2" name="email2" class="form-control">
		            <option ${email2 == 'naver.com' ? 'selected' : ''} value="naver.com">naver.com</option>
		            <option ${email2 == 'hanmail.net'  ? 'selected' : ''} value="hanmail.net">hanmail.net</option>
		            <option ${email2 == 'daum.net'  ? 'selected' : ''} value="daum.net">daum.net</option>
		            <option ${email2 == 'gmail.com' ? 'selected' : ''} value="gmail.com">gmail.com</option>
		          </select>
	          </div>
          </div>
        </td>
    	</tr>
      <tr class="mb-2">
        <th class="text-center"><label for="content" class="form-label">자기소개</label></th>
        <td><textarea rows="4" name="content" id="content" class="form-control">${vo.content}</textarea></td>
      </tr>
      <tr class="mb-2">
        <th class="text-center"><label for="photo" class="form-label">사진</label></th>
        <td>
          <img src="${ctp}/images/member/${vo.photo}" width="100px"/>
          <input type="file" name="photo" id="photo" class="form-control-file border" />
        </td>
      </tr>
      <tr class="mb-2">
        <th class="text-center"><label for="userInfor" class="form-label">정보공개</label></th>
        <td>
          <input type="radio" name="userInfor" id="YES" value="공개" class="mr-1" <c:if test="${vo.userInfor == '공개'}">checked</c:if>  /><label for="YES">공개</label> &nbsp;&nbsp;
          <input type="radio" name="userInfor" id="NO" value="비공개" class="mr-1" <c:if test="${vo.userInfor == '비공개'}">checked</c:if>/><label for="NO">비공개</label>
        </td>
      </tr>
    </table>
    <table class="table table-borderless">
      <tr>
        <td>
			    <button type="submit" class="btn btn-success mb-2">회원정보수정</button>
			    <button type="reset" class="btn btn-warning mb-2">다시입력</button>
			  </td>
			  <td class="text-right">
		    	<%-- <button type="button" onclick="location.href='${ctp}/'" class="btn btn-info mb-2">돌아가기</button> --%>
		    	<button type="button" onclick="location.href='MemberMain.mem'" class="btn btn-info mb-2">돌아가기</button>
        </td>
      </tr>
    </table>
    <input type="hidden" name="tel" id="tel" />
    <input type="hidden" name="email" id="email" />
    <input type="hidden" name="address2" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>