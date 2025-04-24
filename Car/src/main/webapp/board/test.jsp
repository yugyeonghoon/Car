<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유 게시판 (다크 모드)</title>
<style>
        body {
            font-family: 'Arial', sans-serif;
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

        .pagination a:hover {
            background: #000;
            color: #fff;
        }

        .pagination a.active {
            background: #000;
            color: #fff;
            pointer-events: none;
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
<body>
    <h2>자유 게시판</h2>

    <div class="board-container">

        <!-- 검색창 -->
        <div class="search-bar">
            <form action="board.jsp" method="get" style="display: flex; gap: 10px;">
                <select name="searchType">
                    <option value="title">제목</option>
                    <option value="content">본문</option>
                    <option value="author">작성자</option>
                </select>
                <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="">
                <button type="submit">검색</button>
            </form>
        </div>

        <!-- 게시글 리스트 -->
        <table class="board-table">
            <thead>
                <tr>
                	<th>종류</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                	<td>공지</td>
                    <td><a href="post.jsp?id=1">자유롭게 글을 남겨보세요!</a></td>
                    <td>관리자</td>
                    <td>2025-04-21</td>
                    <td>128</td>
                </tr>
                <tr>
                	<td>자유</td>
                    <td><a href="post.jsp?id=2">첫 방문했습니다~</a></td>
                    <td>홍길동</td>
                    <td>2025-04-20</td>
                    <td>74</td>
                </tr>
                <!-- 반복되는 게시글 row -->
            </tbody>
        </table>

        <!-- 글쓰기 버튼 -->
        <div class="action">
            <button onclick="location.href='write.jsp?boardType=2'">글쓰기</button>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <a href="board.jsp?page=1">&laquo;</a>
            <a href="board.jsp?page=1">&lt;</a>
            <a href="board.jsp?page=1" class="active">1</a>
            <a href="board.jsp?page=2">2</a>
            <a href="board.jsp?page=2">&gt;</a>
            <a href="board.jsp?page=10">&raquo;</a>
        </div>

    </div>

</body>
</html>
