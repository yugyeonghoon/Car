<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="/Car/jquery-3.7.1.js"></script>
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
	.findpw {
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
	h1 {
		margin-bottom: 30px;
		color: #111827;
		font-family: 'Seoul 1980', sans-serif;
	}
	form {
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
	}
	.input-group {
		display: flex;
		align-items: center;
		gap: 10px;
	}
	
	label {
		width: 60px;
		text-align: right;
		color: #111827;
		font-weight: bold;
	}
	input[type="text"] {
		border: none;
		border-bottom: 1px solid #d1d5db;
		background: transparent;
		outline: none;
		width: 250px;
		height: 35px;
		font-size: 0.9rem;
		color: #111827;
	}
	input[type="text"]:focus {
		border-bottom: 2px solid #1f2937;
	}
	input::placeholder {
		color: #a5a5a5;
	}
	
	.email-wrap {
	display: flex;
	align-items: center;
	gap: 10px;
}
	.btn, .check {
		font-size: 0.8rem;
		cursor: pointer;
		background-color: #1f2937;
		color: #ffffff;
		border: none;
		border-radius: 8px;
		width: 60px;
		height: 35px;
		transition: background-color 0.3s;
	}
	.pwcheck {
		width: 180px;
		height: 35px;
		text-align: center;
	}
	.feedback {
		font-size: 0.9rem;
		color: red;
		margin-top: 5px;
		display: none;
	}
	.feedback.success {
		color: green;
	}
	.button-wrapper {
		margin-top: 20px;
	}
</style>
</head>
<body>
	<div class="bounceInDown">
		<div class="findpw">
			<h1>비밀번호 찾기</h1>
				<form class="pwform" method="post" action="../login/findPasswordOk.jsp" onsubmit="return formCheck()">
					<div class="fi1">아이디 :
						<input type="text" name="id" id="id" placeholder="ID을 입력하세요" autocomplete="off">
					</div>
					<div class="fi1">이메일 :
						<input type="text" name="email" id="email" placeholder="email을 입력하세요" autocomplete="off">
						<input type="button" class="btn" id="checkBtn" value="전송">		
					</div>
					<div class="fi2"> 
						<input type="text" class="pwcheck" id="mailCheck" placeholder="인증번호">
						<input type="submit" id="mailCheckBtn" value="확인" class="check">
						<div id="mailCheck-feedback" class="feedback">인증번호가 일치하지 않습니다.</div>
					</div>
				</form>
				<div class="button-wrapper">			
						<button onclick="location.href='../login/login.jsp'" class="btn">취소</button>
				</div>
		</div>
	</div>	
</body>
<script>
	let emailCheckFlag = false;
	
	let id = $("#id")
	let mail = $("#email")
	let emc = $("#mailCheck");
	let emcFeedback = $("#mailCheck-feedback");
	
	let mailCode = "";
	$("#checkBtn").click(function() {
		if(mail.val().trim() == "") {
			alert("이메일을 입력해주세요");
			return;
		}
		
		$("#checkBtn").attr("disabled", true);
		//입력한 아이디와 이메일이 일치하는 회원정보가 있는지 확인
		$.ajax({
			url : "../login/mailCheck.jsp",
			//select count(*) from user where id = ? and mail = ?
			type : "post",
			async : false,
			//비동기를 강제로 동기화
			data : {
				id : id.val(),
				email : mail.val()
			},
			success : function(result){
				mailCode = result.trim();
				//여기 return은 success를 종료
			},
			error : function(){
				console.log("에러 발생");
				$("#checkBtn").attr("disabled", false);
			}
		});
		
		if(mailCode === "0"){
			$("#checkBtn").attr("disabled", false);
			alert("아이디와 이메일이 동일하지 않습니다.");
			return;
		}
		
		$.ajax({
			url : "../login/sendMail.jsp",
			type : "post",
			data : {
				email : mail.val()
			},
			success : function(result){
				mailCode = result.trim();
				if(mailCode == "fail"){
					$("#checkBtn").attr("disabled", false);
					alert("이메일이 올바르지 않습니다.");
				}else{
					alert("이메일 전송 완료");
				}
			},
			error : function(){
				console.log("에러 발생");
				$("#checkBtn").attr("disabled", false);
			}
		});
		
	});
	
	$("#mailCheckBtn").click(function(){
		
		if(id.val().trim() == ""){
			id.focus();
			id.val("");
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		if(mail.val().trim() ==""){
			mail.focus();
			mail.val();
			alert("이메일을 입력해주세요.");
			return false;
		}
		
		let mailCheck = $("#mailCheck");
		if(mailCheck.val().trim() == ""){
			
			return false;
		}
		
		if(mailCode == mailCheck.val().trim()){
			emailCheckFlag = true;
			alert("코드가 일치합니다!")
		}else{
			emailCheckFlag = false;
			alert("코드가 일치하지 않습니다.");
			return false;
		}
	});
</script>