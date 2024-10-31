<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberLogin.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">회 원 로 그 인</h2>
	<form name="myform" method="post" action="MemberLoginOk.mem">
    <table class="table table-bordered">
      <tr>
        <th>아이디</th>
        <td>
		      <input type="text" name="mid" value="${mid}" class="form-control mb-3" autofocus required /> 
        </td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" value="1234" class="form-control mb-3" required></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
		      <button type="submit" class="btn btn-success mr-2">로그인</button>
		      <button type="reset" class="btn btn-warning mr-2">다시입력</button>
		      <button type="button" onclick="location.href='MemberJoin.mem'" class="btn btn-info mr-3">회원가입</button>
		      <input type="checkbox" name="idSave" checked /> 아이디 저장
		    </td>
		  </tr>
		</table>
		<div class="text-center">
		  <a href="#" class="badge badge-secondary">아이디찾기</a> |
		  <a href="#" class="badge badge-secondary">비밀번호찾기</a>
		</div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>