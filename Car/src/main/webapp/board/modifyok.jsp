<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();
	int Num = Integer.parseInt(no);
	
	vo.setTitle(title);
	vo.setContent(content);
	vo.setNo(Num);
	
	dao.modify(vo);
	
	response.sendRedirect("post.jsp?no="+no);
%>