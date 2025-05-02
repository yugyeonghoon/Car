<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
	.signup-container {
		margin: 0;
		top: 100px;
		left: 50%;
		position: absolute;
		text-align: center;
		transform: translateX(-50%);
		/* background-color: #b1dbe900; */
		background-color: #ffffff;
	  	/* opacity : 0.8; */
		border-radius: 12px;
	    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	    box-sizing: border-box;
		width: 500px;
		/* height: 770px; */
		
		/* 추가 */
		min-height: 770px;
		height: auto;
		padding-bottom: 60px;
	}
	h1{
		text-align: center;
		margin-bottom: 70px;
		/* color: #000000; */
		color: #111827;
		font-family: 'Seoul 1980', sans-serif;
	}
	label{
		display: block;
           margin-bottom: 10px;
           margin-top: 7px;
           font-size: 1rem;
           font-weight: bold;
           /* color: #000000; */
           color: #111827;
	}
	input{
		margin: 2px auto;
		/* background: #C2E9F3; */
		/* background-color: #2f2f2f; */
		color: #111827;
		border: none;
		/* border-radius: 5px; */
		border-bottom: 1px solid #d1d5db;
	  	background: transparent;
	  	font-size: 16px;
		outline: none;
		width: 250px;
		height: 35px;
		transition: border-color 0.3s;
	}
	input:focus{
		 border-bottom: 2px solid #1f2937;
	}
	button{
		width: 100%;
		height: 40px;
		font-size: 1rem;
		cursor: pointer;
		border-radius: 5px;
		margin-top: 10px;
		color: black;
		background: gray;
	}
	select{
		width: 110px;
		height: 40px;
		box-sizing: border-box;
		margin-left: 5px;
		padding: 5px 0 5px 10px;
		border-radius: 4px;
		border: 1px solid #d9d6d6;
		color: #383838;
		background-color: #ffffff;
		font-family: 'Montserrat', 'Pretendard', sans-serif;
		font-size: 16px;
		margin-top: 15px;
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
	.btn1 {
	  border:0;
	  /* background: #C2E9F3; */
	  /* background: #1351f9; */
	  /* color: #000000; */
	  /* color: #fff; */
	  background-color: #1f2937;
	  color: #ffffff;
	  /* border-radius: 100px; */
	  border: none;
	  border-radius: 8px;
	  width: 340px;
	  height: 49px;
	  font-size: 16px;
	  /* position: absolute;
	  top: 90%;
	  left: 16%; */
	  /* 추가 */
	  transition: background-color 0.3s;
	  margin: 40px auto 0;
	  display: block;
	  cursor: pointer;
	}
	.btn{
		border: 0;
		/* background: #C2E9F3; */
		/* background: #1351f9; */
		/* color: #000000; */
		/* color: #fff; */
		background-color: #1f2937;
	    color: #ffffff;
		border: none;
	    border-radius: 8px;
		width: 120px;
		position: absolute;
		left: 370px;
		transition: background-color 0.3s;
		cursor: pointer;		
	}
	.email{
		width: 220px;
		height: 35px;
		border-top: none;
		border-left: none;
		border-right: none;
		/* border-bottom: 3px solid black; */
		font-size: 1rem;
	}
	#id, #pw, #pwc, #nickname, #email, #emailCheck {
		color: #111827;
	}
	
	.gender-container {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 10px;
    margin-bottom: 15px;
	}

	.gender-container label {
    display: flex;
    align-items: center;
    color: #111827;
    font-weight: bold;
    font-size: 1rem;
	}

	.gender-container input[type="radio"] {
    margin-right: 5px;
    width: 18px;
    height: 18px;
	}
	
</style>
</head>
<body>
	<div class="bounceInDown">
		<div class="signup-container">
			<h1>회원 가입</h1>
				<form method="post" action="../login/signUpOk.jsp" onsubmit="return formCheck()">
					<label for="username">아이디</label>
					<input type="text" id="id" name="id">
						<div id="id-feedback" class="feedback">아이디 중복확인을 해주세요</div>
					<label>비밀번호</label>
					<input type="password" id="pw" name="pw">
					<label>비밀번호 확인</label>
					<input type="password" id="pwc" name="pwc">
						<div id="pw-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
					<label>닉네임</label>
					<input type="text" id="nickname" name="nickname">
						<div id="nickname-feedback" class="feedback">닉네임 중복확인을 해주세요.</div>
					<div>
						<select id="cartype" name="cartype">
							<option>세단</option>
							<option>스포츠카</option>
							<option>suv</option>
							<option>해치백</option>
							<option>rv</option>
							<option>왜건</option>
							<option>쿠페</option>
						</select>
					</div>	
					<div class="gender-container">
					    <label><input type="radio" id="male" name="gender" value="남">남자</label>
					    <label><input type="radio" id="female" name="gender" value="여">여자</label>
					</div>
					<label>이메일</label>
					<input type="text" id="email" class="email" name="email">
					<input type="button" id="emailBtn" class="btn" value="이메일 인증">
						<div id="email-feedback" class="feedback">인증번호가 일치하지 않습니다.</div>
					<label>인증번호</label>
					<input type="text" id="emailCheck" class="email">
					<input type="button" id="emailCheckBtn" class="btn" value="인증번호 확인">
						<div id="emailCheck-feedback" class="feedback">인증번호가 일치하지 않습니다.</div>
					<input type="submit" value="회원가입" class="btn1" >
					
				</form>
		</div>
	</div>	
</body>
<script>
	let idRegex = /^[a-zA-Z0-9]{4,12}$/;
	let idFeedback = $("#id-feedback");
	let idCheckFlag = false;
	let id = $("#id");
	
	let nick = $("#nickname")
	let nickFeedback = $("#nickname-feedback");
	let nickRegex = /^[a-zA-Z0-9가-힣]{2,8}$/;
	let nickCheckFlag = false;
	
	let pw = $("#pw");
	let pwc = $("#pwc");
	let pwFeedback = $("#pw-feedback");
	
	let email = $("#email");
	let emailFeedback = $("#email-feedback");
	let emc = $("#emailCheck");
	let emcFeedback = $("#emailCheck-feedback");
	let emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	let emailCheckFlag = false;
	
	$("#id").keyup(function(e){
		let id = e.target.value;
		
		idFeedback.css("display", "block");
		idFeedback.removeClass("success");
		idFeedback.text("아이디는 영어 대소문자, 숫자 4~12자리만 사용 가능합니다.")
		idCheckFlag = false;
		
		if(!idRegex.test(id)){
			return;
		}
		$.ajax({
			url : "../login/idCheck.jsp",
			type : "post",
			data : {
				id : id
			},
			success : function(result){
				if(result.trim() == "0"){
					idCheckFlag = true;
					idFeedback.css("display", "block");
					idFeedback.addClass("success");
					idFeedback.text("사용가능한 아이디입니다.");
				}else{
					idCheckFlag = false;
					idFeedback.css("display", "block");
					idFeedback.removeClass("success");
					idFeedback.text("사용불가능한 아이디 입니다.");
				}
			},
			error : function(){
				consloe.log("에러발생");
			}
			
		});
	});
	
	$("#pw").keyup(function(e){
		let pw = e.target.value;
		console.log(pw)
		let pwFeedback = $("#pw-feedback");
		
		let pwc = $("#pwc").val()
		if (pw == "" || pwc == "") {
			pwFeedback.css("display", "block");
			pwFeedback.removeClass("success");
			pwFeedback.text("비밀번호를 입력해주세요.");
			return;
		}
		if(pw == pwc){
			//통과
			pwFeedback.css("display", "block");
			pwFeedback.addClass("success");
			pwFeedback.text("비밀번호 확인이 일치합니다.");
		}else{
			//안돼
			pwFeedback.css("display", "block");
			pwFeedback.removeClass("success");
			pwFeedback.text("비밀번호 확인이 일치하지 않습니다.");
		}
	})
	
	$("#pwc").keyup(function(e){
		let pwc = e.target.value;
		console.log(pwc)
		let pwFeedback = $("#pw-feedback");
		
		let pw = $("#pw").val()
		
		if (pw == "" || pwc == "") {
			pwFeedback.css("display", "block");
			pwFeedback.removeClass("success");
			pwFeedback.text("비밀번호를 입력해주세요.");
			return;
		}
		
		if(pw == pwc){
			//통과
			pwFeedback.css("display", "block");
			pwFeedback.addClass("success");
			pwFeedback.text("비밀번호 확인이 일치합니다.");
		}else{
			//안돼
			pwFeedback.css("display", "block");
			pwFeedback.removeClass("success");
			pwFeedback.text("비밀번호 확인이 일치하지 않습니다.");
		}
	})
	
	$("#nickname").keyup(function(e){
		let nick = e.target.value;
		let nickFeedback = $("#nickname-feedback");
		
		nickFeedback.css("display", "block");
		nickFeedback.removeClass("success");
		nickFeedback.text("닉네임은 2 ~ 8자리만 사용가능합니다.");
		nickCheckFlag = false;
		
		if(!nickRegex.test(nick)){
			return;
		}
		$.ajax({
			url : "../login/nickCheck.jsp",
			type : "post",
			data : {
				nick : nick
			},
			success : function(result){
				if(result.trim() == "0"){
					nickCheckFlag = true;
					nickFeedback.css("display", "block");
					nickFeedback.addClass("success");
					nickFeedback.text("사용 가능한 닉네임입니다.");
				}else{
					nickCheckFlag = false;
					nickFeedback.css("display", "block");
					nickFeedback.removeClass("success");
					nickFeedback.text("중복된 닉네임 입니다.");
				}
			},
			error: function(){
				console.log("에러발생");
			}
		});
	});
	
	$(document).ready(function() {
		  $("#male").prop("checked", true);
	});
	
	$("#emailBtn").click(function(){
		emailCheckFlag = false
		if(email.val().trim() == ""){
			alert("이메일을 입력해주세요");
			return;
		}
		
		if(!emailRegex.test(email.val())){
			email.focus();
			email.val("");
			alert("올바른 이메일 형식이 아닙니다.");
			return;
		}
		
		$("#emailBtn").attr("disabled", true);
		
		$.ajax({
			url : "../login/sendMail.jsp",
			type : "post",
			data : {
				email : email.val()
			},
			success : function(result){
				mailCode = result.trim();
				if(mailCode == "fail"){
					$("#emailBtn").attr("disabled", false);
					emailFeedback.css("display", "block");
					emailFeedback.removeClass("success");
					emailFeedback.text("이메일이 올바르지 않습니다.");
					alert("이메일 전송에 실패하였습니다.");
				}else{
					alert("이메일 전송이 완료되었습니다. 인증코드를 확인해주세요");
					emailFeedback.css("display", "block");
					emailFeedback.addClass("success");
					emailFeedback.text("이메일 전송 완료");
					nickFeedback.css("display", "none");
				}
			},
			error : function(){
				console.log("에러 발생");
				$("#mailBtn").attr("disabled", false);
			}
		});		
	});
	
	$("#emailCheckBtn").click(function(){
		let emailCheck = $("#emailCheck");
		if(emailCheck.val().trim() == ""){
			alert("이메일 인증코드를 입력해주세요");
			return;
		}
		
		if(mailCode == emailCheck.val().trim()){
			emailCheckFlag = true;
			alert("코드가 일치합니다!")
			emailFeedback.css("display", "none");
			emcFeedback.css("display", "none");
			emcFeedback.addClass("success");
			emcFeedback.text("인증완료 되었습니다.");
		}else{
			emailCheckFlag = false;
			alert("코드가 일치하지 않습니다.");
		}
			
	});
	
	function formCheck(){
		
		if(id.val().trim() == ""){
			id.focus();
			id.val("");
			idFeedback.css("display", "block");
			idFeedback.text("아이디를 입력해주세요.");
			idFeedback.removeClass("success");
			return false;
		}
		
		if(!idRegex.test(id.val())){
			id.focus();
			id.val("");
			idFeedback.css("display", "block");
			idFeedback.text("영어 대소문자 숫자 포함 6 ~ 12자");
			idFeedback.removeClass("success");
			return false;
		}
		if(idCheckFlag == false){
			id.focus();
			id.val("");
			idFeedback.css("display", "block");
			idFeedback.text("아이디가 중복되었습니다.");
			idFeedback.removeClass("success");
			return false;
		}
		
		idFeedback.css("display", "block");
		idFeedback.addClass("success");
		idFeedback.text("아이디 확인이 완료되었습니다.");
	
	
		if(pw.val().trim() == ""){
			pw.focus();
			pw.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호를 입력해주세요.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		idFeedback.css("display", "none");
		
		if(pwc.val().trim() == ""){
			pwc.focus();
			pwc.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호 확인을 입력해주세요.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		if(pw.val() != pwc.val()){
			pwc.focus();
			pwc.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호가 일치하지 않습니다.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		pwFeedback.css("display", "block");
		pwFeedback.addClass("success");
		pwFeedback.text("비밀번호가 일치합니다.");
		
		if(nick.val().trim() == ""){
			nick.focus();
			nick.val("");
			nickFeedback.css("display", "block");
			nickFeedback.text("닉네임을 입력해주세요.");
			nickFeedback.removeClass("success");
			return false;
		}
		pwFeedback.css("display", "none");
		
		if(!nickRegex.test(nick.val())){
			nick.focus();
			nick.val("");
			nickFeedback.css("display", "block");
			nickFeedback.text("닉네임은 2 ~ 10자리만 사용 가능합니다.");
			nickFeedback.removeClass("success");
			return false;
		}
		
		if(nickCheckFlag == false){
			nick.focus();
			nick.val("");
			nickFeedback.css("display", "block");
			nickFeedback.text("중복된 닉네임입니다.");
			nickFeedback.removeClass("success");
			return false;
		}
		
		nickFeedback.css("display", "block");
		nickFeedback.addClass("success");
		nickFeedback.text("닉네임 확인이 완료되었습니다.");
		nickFeedback.css("display", "none");
		
		if(email.val().trim() == ""){
			email.focus();
			email.val("");
			emailFeedback.css("display", "block");
			emailFeedback.text("이메일을 입력해주세요")
			emailFeedback.removeClass("success");			
			return false;
		}
			
		if(emc.val().trim() == ""){
			emc.focus();
			emc.val("");
			
			emcFeedback.css("display", "block");
			emcFeedback.text("인증번호를 입력해주세요");
			emcFeedback.removeClass("success");
			emailFeedback.css("display", "none");
			return false;
		}
		
		if(emailCheckFlag == false){
			emc.focus();
			emc.val("");
			emcFeedback.css("display", "block");
			emcFeedback.text("인증되지 않았습니다.");
			emcFeedback.removeClass("success");
			return false;
		}
	
		return true;
	}
	
</script>