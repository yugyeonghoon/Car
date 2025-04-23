<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserVO" %>
<%@page import="user.UserDAO" %>
<%
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경</title>
	<script src="./jquery-3.7.1.js"></script>
	<style>
		body{
				font-family: 'Pretendard', sans-serif;
				background-color: #f3f4f6;
				margin: 0;
				padding: 0;
				height: 100vh;
				display: flex;
				justify-content: center;
				align-items: center;
			}
		.findpw-container {
				margin: 0;
				text-align: center;
				background-color: #ffffff;
				border-radius: 12px;
			    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
			    box-sizing: border-box;
				width: 800px;
				height: 300px;
				display: flex;
			 	flex-direction: column;
				justify-content: center;
				align-items: center;
			}
			h2{
				text-align: center;
				margin-bottom: 20px;
				color: #111827;
				font-family: 'Seoul 1980', sans-serif;
			}
			label{
				display: block;
	            margin-bottom: 5px;
	            font-weight: bold;
	            color: black;
			}
			input{
				margin: 5px auto;
				border: 0;
				color: #111827;
				border: none;
				border-bottom: 1px solid #d1d5db;
			  	background: transparent;
				outline: none;
				width: 250px;
				height: 35px;
				font-size: 0.9rem;
				text-align: center;
			}
			input:focus{
				border-bottom: 2px solid #1f2937;
			}
			
			.btn{
				font-size: 1rem;
				cursor: pointer;
				margin-top: 10px;
				border: 0;
				background-color: #1f2937;
			    color: #ffffff;
				border: none;
				border-radius: 8px;
				width: 80px;
				height: 30px;
				transition: background-color 0.3s;
			}
			.feedback{
				font-size: 1rem;
				color: red;
				margin-bottom: 10px;
				display : none;
			}
			.feedback.success{
				color: green;
			}
	</style>
</head>
<body>
	<div class="findpw-container">
		<h2>비밀번호 변경</h2>
			<form method="post" action="../login/changePw.jsp" onsubmit="return formCheck()">
				<div class="profile-field">
					<label for="password">새 비밀번호</label>
					<input type="hidden" value="<%=id %>" name="id">
					<input type="password" id="password" name="password" placeholder="비밀번호를 다시 입력하세요.">
				</div>
				<div class="profile-field">
					<label>새 비밀번호 확인</label>
					<input type="password" id="password-check" name="password-check" placeholder="새 비밀번호를 다시 입력하세요.">
					<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
				</div>
				<div>
					<button type="submit" class="btn" id="btnClick">확인</button>
				</div>
			</form>
	</div>
</body>
<script>
	let pw = $("#password");
	let pwc = $("#password-check");
	let pwFeedback = $("#password-feedback");
	
	$("#btnClick").click(function(){
		
	});
	
	function formCheck(){
		if(pw.val().trim() == ""){
			pw.focus();
			pw.val("");
			alert("비밀번호를 입력해주세요.")
			return false;
		}
		
		
		if(pwc.val().trim() == ""){
			pwc.focus();
			pwc.val("");
			alert("비밀번호 확인을 입력해주세요.")
			return false;
		}
		
		if(pw.val() != pwc.val()){
			pwc.focus();
			pwc.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호가 일치하지 않습니다.");
			pwFeedback.removeClass("success");
			return false;
		}else{
			pwFeedback.css("display", "block");
			pwFeedback.addClass("success");
			pwFeedback.text("비밀번호가 일치합니다.");
			alert("비밀번호 변경이 완료되었습니다.");
		}
		
		return true;
	}
</script>