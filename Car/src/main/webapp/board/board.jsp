<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	
	String pageNum = request.getParameter("page");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	
	int startNum = (currentPage -1) * 20;
	
	int limitPerPage = 20;

	String searchType = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
	
	BoardDAO dao = new BoardDAO();
	List<BoardVO> list = dao.listView(searchType, keyword, startNum, limitPerPage);
	
	int totalCount = dao.getCount(searchType, keyword);
	
	int pageGroupSize = 10;
	int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize +1;
	
	int totalPage = 
			(int)Math.ceil(totalCount / (double)limitPerPage);
	
	int endPage = 
			Math.min(startPage + pageGroupSize -1, totalPage);
	
	if(searchType == null) {
		searchType = "";
	}
	if(keyword == null) {
		keyword = "";
	}
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유 게시판 | 차량생각</title>
<link rel="stylesheet" href="../css/font2.css">
<style>
	body {
	    /* font-family: 'Arial', sans-serif; */
	    background: #ffffff;
	    margin: 0;
	    padding: 0;
	    color: #000;
	}
	
	h2 {
	    color: #000;
	    text-align: center;
	    padding: 30px 0 10px;
	    font-size: 1.8rem;
	}
	
	.board-container {
	    max-width: 1600px;
	    margin: 0 auto;
	    background: #ffffff;
	    padding: 30px;
	    border-radius: 10px;
	    border: 2px solid #000;
	}
	
	.board-table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 10px;
	    table-layout: auto; 
	}
	
	.board-table th,
	.board-table td {
	    padding: 10px;
	    border: 1px solid #000;
	    text-align: center;
	    font-size: 1rem;
	    background-color: #fff;
	}
	
	.board-table th {
	    font-weight: bold;
	    background-color: #f9f9f9;
	}
	
	.board-table td a {
	    text-decoration: none;
	    color: #000;
	}
	
	.board-table td a:hover {
	    text-decoration: underline;
	}
	
	
	.action {
	    text-align: right;
	    margin-top: 20px;
	}
	
	.action button {
	    background: #000;
	    color: #fff;
	    border: 1px solid #000;
	    padding: 10px 25px;
	    border-radius: 5px;
	    cursor: pointer;
	    font-size: 1rem;
	    transition: background 0.3s ease;
	}
	
	.action button:hover {
	    background: #333;
	}
	
	.pagination {
	    display: flex;
	    justify-content: center;
	    margin-top: 25px;
	}
	
	.pagination a {
	    display: block;
	    padding: 6px 12px;
	    margin: 0 4px;
	    text-decoration: none;
	    color: #000;
	    border: 1px solid #000;
	    border-radius: 5px;
	    transition: background 0.3s ease, color 0.3s ease;
	}
	
	.pagination a.active {
	    background: #000;
	    color: #fff;
	    pointer-events: none;
	}
	
	.pagination a:hover {
	    background: #000;
	    color: #fff;
	}
	
	.search-bar {
	    display: flex;
	    justify-content: flex-end;
	    gap: 10px;
	    margin: 20px 0;
	}
	
	.search-bar select,
	.search-bar input[type="text"],
	.search-bar button {
	    padding: 8px;
	    border: 1px solid #000;
	    border-radius: 5px;
	    font-size: 1rem;
	    background: #fff;
	    color: #000;
	}
	
	.search-bar button {
	    background: #000;
	    color: #fff;
	    cursor: pointer;
	    transition: background 0.3s ease;
	}
	
	.search-bar button:hover {
	    background: #333;
	}
</style>
</head>
<body class="abody">
<%@ include file="../header.jsp" %>
<h2>자유 게시판</h2>
	<div class="board-container">
		<div class="search-bar">
			<form action="board.jsp" method="get" style="display: flex; gap: 10px;">
				<select name="searchType">
					<option value = "title" <%= searchType.equals("title") ? "selected" : "" %>> 제목 </option>
                	<option value = "content" <%= searchType.equals("content") ? "selected" : "" %>> 본문 </option>
                	<option value = "author" <%= searchType.equals("author") ? "selected" : "" %>> 작성자 </option>
				</select>
				<input value="<%= keyword %>" type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="">
				<button type="submit">검색</button>
			</form>
		</div>
		<table class="board-table">
			<colgroup>
				<col style="width: 60px;">
				<col style="width: 65%;">
				<col style="width: 80px;">
				<col style="width: 120px;">
				<col style="width: 60px;">
			</colgroup>
			<thead>
				<tr>
					<th>타입</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i =0; i <list.size(); i++){
						BoardVO vo = list.get(i);
						int no = vo.getNo();
						String title = vo.getTitle();
						String author = vo.getAuthor();
						String createDate = vo.getCreateDate();
						int boardType = vo.getBoardType();
						int views = vo.getViews();
				%>		
						<tr>
							<td><%= boardType == 0 ? "공지" : "자유" %></td>
							<td><a href="post.jsp?no=<%= no %><%= searchType != "" ? "&searchType="+searchType : ""%><%= keyword != "" ? "&searchKeyword="+keyword : "" %>"><%=title %></a></td>
							<td><%= author%> </td>
							<td><%= createDate%> </td>
							<td><%= views%> </td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<div class="action">
			<button onclick="location.href='write.jsp?boardType=2'">글쓰기</button>
		</div>
		<div class="pagination">
        	<%
        		if(currentPage > 1){
	        	%>
				<a href="board.jsp?page=1<%= searchType != "" ? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword="+keyword : "" %>">&lt;&lt;</a>
				<a href="board.jsp?page=<%= currentPage - 1 %><%= searchType != "" ? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword="+keyword : "" %>">&lt;</a>
				<%
        		}
			%>
            <%
            	for(int i = startPage; i <= endPage; i ++){
            		if(i == currentPage){
            			%>
	            			<a class="active" href="board.jsp?page=<%= i %><%= searchType != "" ? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword="+keyword : "" %>"><%= i %></a>
	            		<%
            		}else{
            			%>
	            			<a href="board.jsp?page=<%= i %><%= searchType != "" ? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword="+keyword : "" %>"><%= i %></a>
	            		<%
            		}
            	}
            %>
            <%
            	if(currentPage < totalPage) {
	            %>
		            <a href="board.jsp?page=<%= currentPage + 1 %><%= searchType != "" ? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword="+keyword : "" %>">&gt;</a>
		            <a href="board.jsp?page=<%= totalPage %><%= searchType != "" ? "&searchType="+searchType : "" %><%= keyword != "" ? "&searchKeyword="+keyword : "" %>">&gt;&gt;</a>
	            <%
            	}
            %>
        </div>
	</div>
</body>
</html>