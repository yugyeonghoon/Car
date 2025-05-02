<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	String ckeyword = request.getParameter("ckeyword");
	if(ckeyword == null){
		ckeyword = "";
	}
%>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="../js/modal.js"></script>
		<style>
			.header-container {
				font-family: 'Gugi' !important;
			}
			.navbar {
		 	    display: flex;
		 	    justify-content: center;
		 	    align-items: center; 
		 	    background-color: white;
		 		padding: 10px 30px;
		 		border-bottom :2px solid gray;
		 		position:relative;
		 	}
		 	.logo {
		 		position: absolute;
				top: 20px;
				left: 70px;
				font-size: 25px;
				color: black;
		 	}
		 	.logo a {
			    text-decoration: none;
   			    color: black; 
			}
			.menu {
				display: flex;
		 	    justify-content: space-between;
		 	    list-style: none;
		 	    padding-left: 0;
		 	    position:relative;
		 	    top: 13px;
		 	    right: 120px;
			}
			.menu li {
				padding: 5px 100px;
				font-size: 25px;
			}
			.menu a {
				text-decoration: none;
				color: black;
			}
			.search {
				position: absolute;
				top: 30px;
				right: 400px;
			}
			.dropdown {
				position: absolute;
				top: 25px;
				right: 200px;
			}
			.dropdown .btn {
				background: none !important;
				border: none !important;
				padding: 0;
				box-shadow: none;
			}
			.menu-icon {
				width: 40px;
				height: 40px;
			}
			
			/* 모달창 css */
			.modalLogin {
		  display: none;
		  position: fixed;
		  z-index: 9999;
		  left: 0;
		  top: 0;
		  width: 100%;
		  height: 100%;
		  background-color: rgba(0,0,0,0.5);
		}
		
		.modalLogin-content {
		  background-color: white;
		  position: absolute;
		  top: 50%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		  padding: 30px;
		  width: 100%;
		  max-width: 400px;
		  border-radius: 10px;
		  box-sizing: border-box;
		  display: flex;
		  flex-direction: column;
		}
		
		.closeLogin {
		  position: absolute;
		  right: 15px;
		  top: 10px;
		  font-size: 20px;
		  cursor: pointer;
		}
		</style>
	</head>
	<body>
		<div class="header-container">
			<nav class="navbar">
				<div class="logo">
					<h1><a href="/Car/car/carMain.jsp"><span>차량생각</span></a></h1>
				</div>	
				<ul class="menu">
					<li><a href="/Car/board/board.jsp">게시판</a></li>
					<li><a href="/Car/car/carBigyo.jsp">차량비교</a></li>
				</ul>
				<form action="/Car/car/carList.jsp" method="get">
				<div class="search">
					<input value="<%=ckeyword %>" type="text" name="carKeyword" id="carKeyword" placeholder="검색어를 입력해주세요">
					<button class="searchBtn" id="searchBtn">검색</button>
				</div>
				</form>
				<div class="dropdown">
					<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false"><img src="../img/icons8-메뉴-64.png" alt="메뉴 아이콘" class="menu-icon"></button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
						<%
							if(user == null) {
								%>
								<li><a class="dropdown-item" data-url="/Car/login/modalLogin.jsp">로그인</a></li>
								<%
							}else {
								%>
								<li><a class="dropdown-item" href="../user/profile.jsp">마이페이지</a></li>
		 						<li><a class="dropdown-item" href="../login/logout.jsp">로그아웃</a></li>
								<%
							}
						%>
						</ul>
				</div>
			</nav>
		</div>
		<div id="modal" class="modalLogin">
			<div class="modalLogin-content">
				<span class="closeLogin">&times;</span>
	   			<div id="modal-body"></div>
			</div>
		</div>
	</body>
	<script>
	let carKeyword = $("#carKeyword");
	
	$("#searchBtn").click(function(e){
		e.preventDefault(); 
		searchCheckFlag = false;
		if(carKeyword.val().trim() == ""){
			alert("검색어를 입력해주세요."); 
			return;
		}
	});
	</script>
</html>