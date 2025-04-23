<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
	.findid{
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
	h1{
		text-align: center;
		margin-bottom: 20px;
		color: #111827;
		font-family: 'Seoul 1980', sans-serif;
	}
	.idform{
        font-size: 1rem;
        width: 50%;
        display: inline-block;
        color: #dfdeee;
    }
     .fi1, #email{
		color: #111827;
	}
	input{
		margin: 10px auto;
		border: 0;
		color: #111827;
		border: none;
		border-bottom: 1px solid #d1d5db;
	  	background: transparent;
		outline: none;
		width: 250px;
		height: 35px;
		font-size: 0.9rem;
		
	}
	input:focus{
		border-bottom: 2px solid #1f2937;
	}
	
	input::placeholder {
		color: #a5a5a5;
	}
	.btn{
		font-size: 0.8rem;
		cursor: pointer;
		margin-top: 10px;
		border: 0;
		background-color: #1f2937;
	    color: #ffffff;
		border: none;
		border-radius: 8px;
		width: 50px;
		height: 35px;
		transition: background-color 0.3s;
	}	
	.btn1{
		font-size: 0.8rem;
		cursor: pointer;
		margin-top: 10px;
		margin-left: 15px;
		border: 0;
		background-color: #1f2937;
		color: #ffffff;
		border-radius: 8px;
		width: 130px;
		height: 35px;
		transition: background-color 0.3s;
	}
	.btn1Class {
		display: flex;
		justify-content: center;
		gap: 15px; /* 버튼 사이 간격 */
		margin-top: 20px;
	}
</style>
</head>
<body>
	<div class="findid">
		<h1>아이디 찾기</h1>
		<form class="idform" method="post" action="../login/findIdOk.jsp" >
			<div class="fi1">이메일 :
				<input type="text" name="email" id="email" placeholder="email을 입력하세요" autocomplete="off">
				<button type="submit" class="btn" id="btn">찾기</button>
			</div>
		</form>
			<div class="btn1Class">
				<button onclick="location.href='../login/login.jsp'" class="btn1">login</button>
				<button onclick="location.href='../login/findPassword.jsp'" class="btn1">비밀번호 찾기</button>
			</div>
		</div>
</body>
<script>
	let email = $("#email");
	let check = "";
	$("#btn").click(funtion(){
		if(email.val().trim() == "") {
			email.focus();
			email.val("");
			confirm("이메일을 입력해주세요.")
			return false;
		}
	}
</script>
</html>