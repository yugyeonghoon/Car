<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	UserDAO dao = new UserDAO();
	int result = dao.findPw(id, email);
	out.println(result);
%>