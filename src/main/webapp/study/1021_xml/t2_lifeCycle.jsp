<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t2_lifeCycle.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">로그인</h2>
	<form name="myform" method="post" action="${ctp}/1021/T2_lifeCycleOk">
	  <table class="table table-bordered">
	    <tr>
	      <th>아이디</th>
	      <td><input type="text" name="mid" value="admin" class="form-control mb-2" autofocus required /></td> 
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td><input type="password" name="pwd" id="pwd" value="1234" class="form-control mb-2" required /></td>
	    </tr>
	    <tr>
	      <td colspan="2">
		      <button type="submit" class="btn btn-info mr-2">로그인</button>
		      <button type="reset" class="btn btn-warning mr-2">다시입력</button>
	      </td>
	    </tr>
    </table>
  </form>
</div>
<p><br/></p>
</body>
</html>