<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	if(no == null){
		response.sendRedirect("board.jsp");
		return;
	}
	
	BoardDAO dao = new BoardDAO();
	dao.delete(no);
	response.sendRedirect("board.jsp");
%>