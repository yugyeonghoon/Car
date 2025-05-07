<%@page import="carInfo.CarDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="carLike.carLikeVO"%>
<%@page import="carInfo.CarVO"%>
<%@page import="carLike.carLikeDAO" %>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = user.getId();
	String tno = request.getParameter("tno");
	UserVO users = (UserVO)session.getAttribute("user");
	
	if(id == null){
		response.sendRedirect("../car/carMain.jsp");
		return;
	}
	
	carLikeDAO likeDao = new carLikeDAO();
	List<carLikeVO> likeCar = likeDao.likeCar(id); 
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	</head>
	<style>
		.footer {
			position: static !important;
			margin-top: 100px;
			background-color: #e0f7fa;
		}
		body {
			font-family : 'Source Sans Pro', sans-serif; 
			background: white;
			margin: 0;
			padding: 0;
			color: #333;
		}
		.profile-container{
			padding: 20px;
			max-width: 1200px;
			margin: 40px auto;
			background: #ffffff;
			border-radius: 10px;
			box-shadow: 0 2px 10px rgb(30 88 139 / 20%);
			border: 2px solid #a9a9a9;
		}
		h2{
			color: #000000;
			text-align: center;
			margin-bottom: 20px;
			font-size: 27px;
		}
		.profile-field{
			margin-bottom:15px;
		}
		.profile-field label{
			font-weight: bold;
			margin-bottom: 5px;
			display: block;
			color: black;
			font-size: 17px;
		}
		.profile-field input{
			width: 95%;
			padding: 8px;
			border: 1px solid black;
		    height: 20px;
		    font-size: 15px;
		    padding-left: 10px;
		    box-shadow: 0 1px 10px rgb(30 88 139 / 20%);
			border-radius: 12px;
			border-style: hidden;
		}
		.feedback{
			font-size: 0.9rem;
			color: red;
			margin-bottom: 10px;
		}
		.feedback.success{
			color: green;
		}
		.profile-actions {
			display: flex;
  				justify-content: space-between;
		}
		.profile-actions button{
			background: #000000;
			color: #ffffff;
			border: none;
			padding: 10px 20px;
			border-radius: 5px;
			cursor: pointer;
			transition: background 0.3s ease;
			margin: 0 50px;
			font-size: 14px;
			font-weight: bold;
		}
		.profile-actions button:hover {
		        background: #1a5fc4;
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
		.modal {
				display: none;
				position: fixed;
				z-index: 999;
				left: 0;
				top: 0;
				width: 100%;
				height: 100%;
				background-color: rgba(0, 0, 0, 0.4);
				backdrop-filter: blur(2px);
			}
			/* 모달창 내용 스타일 */
			.modal-content {
				background-color: #ffffff;
				margin: 8% auto;
				padding: 30px 25px;
				border-radius: 16px;
				width: 420px;
				box-shadow: 0 10px 30px rgba(0,0,0,0.2);
				position: relative;
				font-family: 'Segoe UI', sans-serif;
				animation: fadeIn 0.3s ease-in-out;
			}
			/* 모달창 fadeIn 애니메이션 */
			@keyframes fadeIn {
				from { opacity: 0; transform: scale(0.95); }
				to { opacity: 1; transform: scale(1); }
			}
			/* 모달창 제목 스타일 */
			.modal-content h3 {
				margin-bottom: 20px;
				font-size: 22px;
				color: #222;
				text-align: center;
			}
			/* 모달창의 label 스타일 */
			.modal-content label {
				font-weight: 500;
				margin-top: 15px;
				display: block;
				color: #333;
				font-size: 15px;
			}
			/* 트림 선택 박스 스타일 */
			.modal-content .trim-select {
				width: 100%;
				padding: 10px;
				margin-top: 6px;
				border: 1px solid #ccc;
				border-radius: 8px;
				font-size: 15px;
				outline: none;
				transition: border-color 0.2s;
			}
			.modal-content .trim-select:focus {
				border-color: #007BFF;
				box-shadow: 0 0 0 2px rgba(0,123,255,0.1);
			}
			.close {
				color: #aaa;
				position: absolute;
				top: 15px;
				right: 20px;
				font-size: 26px;
				cursor: pointer;
				transition: color 0.2s;
			}
			.close:hover {
				color: #000;
			}
			.select-button {
				margin-top: 10px;
				background-color: black;
				color: white;
				border: none;
				padding: 10px 20px;
				border-radius: 8px;
				font-size: 16px;
				cursor: pointer;
				transition: background-color 0.2s;
			}
			.select-button:hover {
				background-color: #6e859f;
			}
			
			/* 좋아요 목록 조회 css */
			.likecarItem {
				margin-top : 15px;
			}
			.carousel {
				overflow-x : auto;
				overflow-y: hidden;
				display: flex;
				flex-wrap: nowrap;
				padding-bottom: 10px;
			}
			#likecarImg {
				flex : 0 0 320px;
				padding-right : 20px;			
			}
			img {
				width: 100%;
				height: auto;
			}
			#likecarName {
				margin-top: 10px;
			    font-size: 16px;
				text-align: center;
			}
			
			/* 하트 아이콘 css */
			.heart-icon {
				/* transform: translate(15px, 450px); */
				display: block;
				width: 30px;
				height: 30px;
				cursor: pointer;
			}
	</style>
	<body>
		<div class="profile-container">
			<h2>마이페이지</h2>
			<form method="post" action="profileok.jsp" onsubmit="return formCheck()">
				<div class="profile-field">
					<label for="username">아이디</label>
					<input type="text" id="username" name="username" value="<%= user.getId() %>" readonly>
				</div>
				<!-- <div class="profile-field">
					<label for="name">이름</label>
					<input type="text" id="name" name="name" value="네임" readonly>
				</div> -->
				<div class="profile-field">
					<label for="nickname">닉네임</label>
					<input type="text" id="nickname" name="nickname" value="<%= user.getNick() %>" readonly>
					<!-- <div class="feedback">닉네임 중복확인을 해주세요. </div> -->
				</div>
				<div class="profile-field">
					<label for="email">이메일</label>
					<input type="text" id="email" name="email" value="<%= user.getEmail() %>" readonly>
				</div>
				<div id="modal" class="modal">
					<div class="modal-content">
						<span class="close" onclick="closeModal('modal')">&times;</span>
						<div class="profile-field">
							<label for="password">새 비밀번호</label>
							<input type="password" id="password" name="password" placeholder="비밀번호를 다시 입력하세요.">
						</div>
						<div class="profile-field">
							<label>새 비밀번호 확인</label>
							<input type="password" id="password-check" placeholder="새 비밀번호를 다시 입력하세요.">
							<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
						</div>
						<button class="select-button" onclick="selectCar">변경</button>
					</div>
				</div>	
				<div class="likecarItem">
					<span><%=user.getId() %>님의 좋아요한 차량</span>
						<ul class="carousel">
						<% 
							for(int i = 0; i < likeCar.size(); i++) {
								carLikeVO cvo = likeCar.get(i);
								String carTno = cvo.getCarTno();
								String carName = cvo.getCar_name();
								String carImg = cvo.getImg();
								System.out.println(tno);
								
								int likeCount = likeDao.likeFlag(id, carTno);
						        String heartImg = likeCount == 1 ? "/Car/img/heart2.png" : "/Car/img/heart1.png";
								
						%>
								<li id="likecarImg">
									<a href="/Car/car/carDetail.jsp?tno=<%=carTno%>"><img src="<%=carImg %>"></a>
									<div id="likecarName"><%=carName %></div>
									<!-- likeCount가 0이면? 빈하트 아니면? 채워진하트 -->
									<img src="<%=heartImg %>" alt="<%= likeCount == 1 ? "채워진하트" : "빈하트" %>" class="heart-icon" id="heartIcon" data-tno="<%=carTno %>" data-like="<%= likeCount%>">
								</li>
						<%
							}
						%>
						</ul>
				</div>
				<div class="profile-actions">
					<button type="button" onclick="openModal('modal')">비밀번호 변경</button>
					<button type="button" onclick="location.href='../car/carMain.jsp'">취소</button>
					<button type="button" onclick="joinout('')">탈퇴</button>
				</div>
			</form>
		</div>
		<%@include file="../footer.jsp" %>
	</body>
	<script>
	function formCheck(){
		let pw = $("#password");
		let pwc = $("#password-check");
		let pwFeedback = $("#password-feedback");
		
		if(pw.val().trim() == ""){
			pw.focus();
			pw.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("변경할 비밀번호를 입력해주세요.");
			pwFeedback.removeClass("success");
			return false;
		}
		
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
		
		alert("비밀번호가 변경되었습니다.");
	}
	function joinout(id){
		let result = confirm("회원탈퇴를 하시겠습니까 ?")
		if(result == true){
			$.ajax({
				url : "joinout.jsp",
				type : "post",
				data : {
					id : id
				},
				success : function(result){
					if(result.trim() == "success"){
						alert("회원탈퇴를 하셨습니다.");
						location.href = "login.jsp"
					}
				},
				error : function(){
					console.log("error")
				}
			});
		}
		
	}
	
	function closeModal(id) {
		document.getElementById(id).style.display = "none";
	}
	function openModal(id) {
		document.getElementById(id).style.display = "block";
	}
	</script>
<script>
	document.querySelectorAll('.heart-icon').forEach(icon => {
	    icon.addEventListener('click', function () {
	        const tno = this.getAttribute('data-tno');
	        let like = this.getAttribute('data-like');
	        const that = this;
	
	        $.ajax({
	            type: "post",
	            url: "/Car/car/carLikeOk.jsp",
	            data: {
	                carTno: tno,
	                userId: "<%= users.getId() %>",
	                flag: like
	            },
	            success: function (response) {
	                const newLike = response.trim();
	                that.src = newLike == "1" ? '/Car/img/heart2.png' : '/Car/img/heart1.png';
	                that.setAttribute('data-like', newLike);
	            },
	            error: function () {
	                alert("좋아요 처리 실패");
	            }
	        });
	    });
	});

</script>
</html>