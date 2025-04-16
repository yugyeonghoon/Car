<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
		<style>
			.navbar {
		 	    display: flex;
		 	    justify-content: center;
		 	    align-items: center; 
		 	    background-color: white;
		 		padding:1px 30px;
		 		border-bottom :2px solid gray;
		 		position:relative;
		 	}
		 	.logo {
		 		font-size: 20px; 
 	    		color: black; 
		 	}
		 	.logo a {
			    text-decoration: none;
   			    color: black; 
   			    margin-left: -700px;
			}
		 	.menu {
        		text-align : center
		 	}
		</style>
	</head>
	<body>
		<nav class="navbar">
			<div class="logo">
				<h1><a href="main.jsp"><span style="font-family: 'Gugi' !important;">차량생각</span></a></h1>
			</div>	
			<ul class="menu">
				<li>게시판</li>
			</ul>
				<input type="text" placeholder="검색어를 입력해주세요">
				<button>검색</button>
		</nav>
	</body>
</html>