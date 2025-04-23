<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%
	String nick = request.getParameter("nick");
	System.out.print(nick);
	UserDAO dao = new UserDAO();
	int result = dao.nickCheck(nick);
	out.println(result);
%>