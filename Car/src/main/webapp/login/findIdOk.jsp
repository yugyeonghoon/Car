<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserVO" %>
<%@page import="user.UserDAO" %>
<%
	request.setCharacterEncoding("utf-8");

	UserVO user = (UserVO)session.getAttribute("user");
	
	String email = request.getParameter("email");
	if(email == null || email.isEmpty()){
		response.sendRedirect("../login/findId.jsp");
		return;
	}
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	
	List<String> list = dao.findId(email);
	System.out.print(list);
	if(list == null){
		response.sendRedirect("../login/findId.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 확인</title>
<script src="./jquery-3.7.1.js"></script>
<style>
	body {
		font-family: 'Pretendard', sans-serif;
		background-color: #f3f4f6;
		margin: 0;
		padding: 0;
		height: 100vh;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.findid {
		background-color: #ffffff;
		border-radius: 12px;
		box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
		box-sizing: border-box;
		width: 800px;
		padding: 40px 20px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.find-box {
		display: flex;
		flex-direction: column;
		align-items: center;
		color: #111827;
		margin-bottom: 20px;
	}

	label {
		display: block;
		margin-bottom: 8px;
		font-weight: bold;
		color: #111827;
		font-family: 'Seoul 1980', sans-serif;
	}

	input {
		margin: 10px 0;
		border: none;
		border-bottom: 2px solid #1f2937;
		background: transparent;
		color: #111827;
		outline: none;
		width: 250px;
		height: 35px;
		font-size: 0.9rem;
		text-align: center;
	}

	.btn1Class {
		display: flex;
		justify-content: center;
		gap: 15px;
	}

	.btn1 {
		font-size: 1rem;
		cursor: pointer;
		background-color: #1f2937;
		color: #ffffff;
		border: none;
		border-radius: 100px;
		width: 130px;
		height: 35px;
		transition: background-color 0.3s;
	}
</style>
</head>
<body>
	<div class="findid">
		<form>
			<div class="find-box">
				<label>사용자님의 아이디는</label>
				<% 
					for(int i = 0; i < list.size(); i++){
							String id = list.get(i);
					%>
					<input type="text" value="<%=id %>" readonly>
					<%
					}
				%>
				<label>입니다.</label>
			</div>	
		</form>
			<div>
				<button onclick="location.href='../login/login.jsp'" class="btn1">login</button>
				<button onclick="location.href='../login/findPassword.jsp'" class="btn1">비밀번호 찾기</button>
			</div>
	</div>
</body>
</html>