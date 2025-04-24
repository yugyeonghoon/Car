<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%
	String boardType = request.getParameter("boardType");
	if (boardType == null) boardType = ""; 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 작성</title>
	<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #fff;
			margin: 0;
			padding: 0;
			color: #333;
		}

		h2 {
			text-align: center;
			padding: 40px 0 20px;
			font-size: 2rem;
			color: #333;
		}

		.write-container {
			max-width: 900px;
			margin: 20px auto;
			background: #fff;
			padding: 30px;
			border-radius: 12px;
			box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
		}

		select, .input, textarea {
			width: 100%;
			padding: 12px 15px;
			margin-bottom: 20px;
			border: 1px solid #ccc;
			border-radius: 8px;
			font-size: 1rem;
			box-sizing: border-box;
			transition: border 0.3s ease;
		}

		select:focus, input:focus, textarea:focus {
			border-color: #000;
			outline: none;
		}

		textarea {
			resize: vertical;
			min-height: 300px;
		}

		.button-group {
			display: flex;
			justify-content: flex-end;
			gap: 10px;
			margin-top: 20px;
		}

		.btn {
			padding: 10px 20px;
			font-size: 1rem;
			border: none;
			border-radius: 8px;
			cursor: pointer;
			transition: background 0.3s ease;
		}

		.btn.submit {
			background-color: #000;
			color: #fff;
		}

		.btn.submit:hover {
			background-color: #333;
		}

		.btn.cancel {
			background-color: #eee;
			color: #333;
		}

		.btn.cancel:hover {
			background-color: #ccc;
		}
	</style>
</head>
<body>
	<h2>글 쓰기</h2>
	<div class="write-container">
		<form action="writeok.jsp" method="post">
			<input class="input" type="hidden" name="refer" value="<%-- <%= last %> --%>">

			<div class="search-bar">
				<select name="boardType">
				<%if(user != null && user.getUserType() == 0){
					%>
					<option value="0" >공지사항</option><%
					
				}%>
					<option value="1" >일반 게시판</option>
				</select>
			</div>

			<input class="input" name="title" type="text" placeholder="제목을 입력해주세요." autocomplete="off">

			<textarea name="content" placeholder="내용을 입력해주세요." autocomplete="off"></textarea>

			<div class="button-group">
				<button type="submit" class="btn submit">확인</button>
				<button type="button" class="btn cancel" onclick="history.back();">취소</button>
			</div>
		</form>
	</div>
</body>
</html>
