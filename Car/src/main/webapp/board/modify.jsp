<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../header.jsp"  %>
<%
	String no = request.getParameter("no");
		
	BoardDAO dao = new BoardDAO();
	BoardVO vo = dao.view(no);
	String title = vo.getTitle();
	String content = vo.getContent();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
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

	label {
		display: block;
		margin: 20px 0 8px;
		font-size: 1rem;
		font-weight: bold;
	}

	.input, textarea {
		width: 100%;
		padding: 12px 15px;
		border: 1px solid #ccc;
		border-radius: 8px;
		font-size: 1rem;
		box-sizing: border-box;
		transition: border 0.3s ease;
	}

	input:focus, textarea:focus {
		border-color: #000;
		outline: none;
	}

	textarea {
		resize: vertical;
		min-height: 300px;
	}

	.action {
		display: flex;
		justify-content: flex-end;
		gap: 10px;
		margin-top: 30px;
	}

	.btn1, .btn2 {
		padding: 10px 20px;
		font-size: 1rem;
		border: none;
		border-radius: 8px;
		cursor: pointer;
		transition: background 0.3s ease;
	}

	.btn1 {
		background-color: #000;
		color: #fff;
	}

	.btn1:hover {
		background-color: #333;
	}

	.btn2 {
		background-color: #eee;
		color: #333;
	}

	.btn2:hover {
		background-color: #ccc;
	}
</style>
</head>
	<body>
		<div class="write-container">
			<h2>글 수정</h2>
				<form action="modifyok.jsp" method="post">
					<input class="input" type="hidden" name="no" value="<%= no %>">
	        	
		            <label for="title">제목</label>
		            <input class="input" type="text" id="title" name="title" class="title" placeholder="제목을 입력하세요" value="<%= title %>">
		
		            <label for="content">내용</label>
		            <textarea id="content" name="content" class="content" placeholder="내용을 입력하세요"><%= content %></textarea>
		          
		            <div class="action">
		                <button class="btn1" type="submit">수정</button>
		                <button type="button" class="btn2" onclick="history.back()">취소</button>
		            </div>
			</form>	
		</div>
	</body>
</html>