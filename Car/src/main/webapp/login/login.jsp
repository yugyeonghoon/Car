<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String error = request.getParameter("error");
	String cookie = "";
	
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("id")) {
				cookie = cookies[i].getValue();
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="./jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Pretendard&display=swap');
	body, html {
	  font-family: 'Pretendard', sans-serif;
	  background-color: #f3f4f6;
	  margin: 0;
	  padding: 0;
	  height: 100vh;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	}
	
	.container {
	  background-color: #ffffff;
	  width: 400px;
	  padding: 50px 40px;
	  border-radius: 12px;
	  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	  box-sizing: border-box;
	}
	
	h4 {
	  font-size: 24px;
	  font-weight: 600;
	  color: #111827;
	  text-align: center;
	  margin-bottom: 30px;
	}
	
	input[type="text"],
	input[type="password"] {
	  width: 100%;
	  padding: 12px 0;
	  margin-bottom: 16px;
	  border: none;
	  border-bottom: 1px solid #d1d5db;
	  background: transparent;
	  font-size: 16px;
	  color: #111827;
	  outline: none;
	  transition: border-color 0.3s;
	}
	
	input[type="text"]:focus,
	input[type="password"]:focus {
	  border-bottom: 2px solid #1f2937;
	}
	
	input::placeholder {
	  color: #9ca3af;
	}
	
	input[type="submit"] {
	  width: 100%;
	  background-color: #1f2937;
	  color: #ffffff;
	  padding: 14px;
	  border: none;
	  border-radius: 8px;
	  font-size: 16px;
	  font-weight: 500;
	  cursor: pointer;
	  transition: background-color 0.3s;
	  margin-top: 10px;
	}
	
	label {
	  display: flex;
	  align-items: center;
	  margin-top: 10px;
	  font-size: 14px;
	  color: #6b7280;
	}
	
	.rmb {
	  margin-left: 6px;
	}
	
	.links {
	  display: flex;
	  justify-content: space-between;
	  margin-top: 15px;
	  font-size: 14px;
	}
	
	.links a {
	  color: #2563eb;
	  text-decoration: none;
	}
	
	.links a:hover {
	  text-decoration: underline;
	}
	
	.find-links {
	  display: flex;
  	  justify-content: center;
	  align-items: center;
	  gap: 12px; /* 링크 사이 간격 */
	  margin-top: 10px;
	  font-size: 14px;
	}
	
	.forgetid, .forgetpass {
	  font-size: 14px;
	  color: #6b7280;
	  text-decoration: none;
	}
	
	.forgetid:hover, .forgetpass:hover {
	  text-decoration: underline;
	}
	
	.dnthave {
	  display: block;
	  text-align: center;
	  margin-top: 25px;
	  font-size: 14px;
	  color: #6b7280;
	  text-decoration: none;
	}
	
	.dnthave:hover {
	  text-decoration: underline;
	}

</style>
</head>
<body>
	<div class="container">
		<span class="error animated tada" id="msg"></span>
		<form method="post" name="form1" class="box" onsubmit="return formCheckId()" action="../login/loginOk.jsp">
			<h4>로그인 페이지<span></span></h4>
			<h5></h5>
				<input type="text" id="id" value="<%= cookie %>" name="id" placeholder="Id" autocomplete="off">
					<i class="typcn typcn-eye" id="eye"></i>
				<input type="password" name="password" placeholder="Password" id="pw" autocomplete="off">
				<label>
					<input type="checkbox" <%= !cookie.equals("") ? "checked" : "" %>id="checkId" name="checkId" class="checkId">
					<span></span>
					<small class="rmb">아이디 저장</small>
				</label>
				<div class="find-links">
					<a href="../login/findId.jsp" class="forgetid">아이디 찾기</a>
					<a href="../login/findPassword.jsp" class="forgetpass">비밀번호 찾기</a>
				</div>
					<input type="submit" value="로그인" class="btn1" >
		</form>
			<a href="/Car/login/signUp.jsp" class="dnthave">회원가입</a>
	</div> 
		
</body>
<script>
	$(document).ready(function() {
		console.log("html 로딩 완료")
		let error = "<%= error%>";
		if(error == "fail") {
			alert("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
	})
	
	console.log("스크립트 로딩 완료")
	function formCheckId() {
		let id = $("#id");
		let pw = $("#pw");
		
		if(id.val().trim() == "") {
			id.focus();
			id.val("");
			alert("아이디를 입력해주세요.")
			return false;
		}
		if(pw.val().trim() == "") {
			pw.focus();
			pw.val("");
			alert("비밀번호를 입력해주세요.")
			return false;
		}
	}
	
</script> 