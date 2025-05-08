<%@page import="user.UserDAO"%>
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
	request.setCharacterEncoding("UTF-8"); 
	String id = user.getId();
	String tno = request.getParameter("tno");
	UserVO users = (UserVO)session.getAttribute("user");
	
	UserDAO dao = new UserDAO();
	
	UserVO vo = dao.getOneUser(id);
	
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
			max-width: 1000px;
			margin: 80px auto;
			background: #ffffff;
			/* border-radius: 10px;
			box-shadow: 0 2px 10px rgb(30 88 139 / 20%); */
			border: 2px solid /* #a9a9a9 */;
			/* height: 600px; */
		    margin: 60px auto;
		    padding: 40px;
		    background: white;
		    border-radius: 16px;
		    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.06);
		}
		h2{
			color: #000000;
			text-align: center;
			margin-bottom: 20px;
			font-size: 27px;
		}
		.profile-field{
			margin-bottom:15px;
			margin-left: 28px;
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
			padding: 12px;
			border: 1px solid #dee2e6;
		    height: 40px;
		    font-size: 15px;
		    padding-left: 10px;
		    border-radius: 8px;
    		background: #f9f9f9;
		    /* box-shadow: 0 1px 10px rgb(30 88 139 / 20%);
			border-radius: 12px; */
			/* border-style: hidden; */
		}
		
		input:focus {
		    outline: none; /* 테두리 스타일 없애기 */
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
  			/* justify-content: space-between; */
  			justify-content: center;
  			gap: 20px;
		}
		.profile-actions button{
			/* background: #000000;
			color: #ffffff;
			border: none;
			padding: 10px 20px;
			border-radius: 5px;
			cursor: pointer;
			transition: background 0.3s ease;
			margin: 0 50px;
			font-size: 14px;
			font-weight: bold; */
			
			background-color: #343a40;
		    color: white;
		    font-size: 15px;
		    font-weight: 500;
		    padding: 12px 28px;
		    border: none;
		    border-radius: 8px;
		    cursor: pointer;
		    transition: background 0.3s;
		}
		
		.profile-actions button:hover {
		    background-color: #212529;
		}
		/* .profile-actions button:hover {
		        background: #1a5fc4;
		} */
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
				margin-top : 20px;
			}
			.carousel {
				overflow-x : auto;
				overflow-y: hidden;
				display: flex;
				flex-wrap: nowrap;
				padding-bottom: 10px;
				margin-top: 20px;
				gap: 16px;
			}
			#likecarImg {
				flex : 0 0 320px;
				/* padding-right : 20px; */
				background: white;
			    border: 1px solid #dee2e6;
			    border-radius: 12px;
			    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
			    padding: 12px;
			    transition: transform 0.2s;			
			}
			
			#likecarImg:hover {
			    transform: translateY(-4px);
			}
			img {
				width: 100%;
				height: auto;
			}
			#likecarName {
				margin-top: 10px;
			    font-size: 16px;
				text-align: center;
				font-weight: bold;
			}
			
			/* 하트 아이콘 css */
			.heart-icon {
				/* transform: translate(15px, 450px); */
				display: block;
				width: 30px;
				height: 30px;
				cursor: pointer;
			}
			
			span {
				margin-left: 28px;
			}
			
			/* 차량 선택바 css */
			#cartype {
			    width: 100%;
			    max-width: 400px;
			    padding: 10px 14px;
			    font-size: 15px;
			    font-family: inherit;
			    color: #333;
			    background-color: #f9f9f9;
			    border: 1px solid #ccc;
			    border-radius: 8px;
			    appearance: none;
			    background-image: url("data:image/svg+xml;utf8,<svg fill='gray' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
			    background-repeat: no-repeat;
			    background-position: right 12px center;
			    background-size: 18px;
			    cursor: pointer;
			}
			#cartype:focus {
				outline: 2px solid #d50000;
				outline: none;
			}
	</style>
	<body>
		<div class="profile-container">
			<h2>마이페이지</h2>
			<form method="get" action="/Car/user/profileok.jsp" onsubmit="return formCheck()" accept-charset="UTF-8">
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
<!-- 				<div id="modal" class="modal">
					<div class="modal-content">
						<span class="close" onclick="closeModal('modal')">&times;</span> -->
						<div class="profile-field">
							<label for="password">새 비밀번호</label>
							<input type="password" id="password" name="password" placeholder="비밀번호를 다시 입력하세요.">
						</div>
						<div class="profile-field">
							<label>새 비밀번호 확인</label>
							<input type="password" id="password-check" placeholder="새 비밀번호를 다시 입력하세요.">
							<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
						</div>
						<div class="profile-field">
							<label for="carselect">차량 선택</label>
							<select id="cartype" name="cartype">
								<option value="세단" <%= "세단".equals(vo.getCarType()) ? "selected" : "" %>>세단</option>
								<option value="스포츠카" <%= "스포츠카".equals(vo.getCarType()) ? "selected" : "" %>>스포츠카</option>
								<option value="suv" <%= "suv".equals(vo.getCarType()) ? "selected" : "" %>>suv</option>
								<option value="해치백" <%= "해치백".equals(vo.getCarType()) ? "selected" : "" %>>해치백</option>
								<option value="rv" <%= "rv".equals(vo.getCarType()) ? "selected" : "" %>>rv</option>
								<option value="왜건" <%= "왜건".equals(vo.getCarType()) ? "selected" : "" %>>왜건</option>
								<option value="쿠페" <%= "쿠페".equals(vo.getCarType()) ? "selected" : "" %>>쿠페</option>
							</select>
						</div>
						<!-- <button class="select-button" onclick="selectCar">변경</button> -->
					<!-- </div> -->
<!-- 				</div>	 -->
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
					<!-- <button type="button" onclick="openModal('modal')">비밀번호 변경</button> -->
					<button type="submit">저장</button>
					<button type="button" onclick="location.href='../car/carMain.jsp'">취소</button>
					<button type="button" onclick="joinout('<%= id %>')">탈퇴</button>
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
		let result = confirm("회원탈퇴를 하시겠습니까?")
		if(result == true){
			$.ajax({
				url : "/Car/login/joinout.jsp",
				type : "post",
				data : {
					id : id
				},
				success : function(result){
					if(result.trim() == "success"){
						alert("회원탈퇴를 하셨습니다.");
						location.href = "/Car/car/carMain.jsp"
					}
				},
				error : function(){
					console.log("error")
				}
			});
		}
		
	}
	
	/* function closeModal(id) {
		document.getElementById(id).style.display = "none";
	}
	function openModal(id) {
		document.getElementById(id).style.display = "block";
	} */
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