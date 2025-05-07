<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>    
<%
	request.setCharacterEncoding("utf-8");	
	
	String pw = request.getParameter("password");
	
	if(pw == null || pw.isEmpty()){
		response.sendRedirect("/Car/user/profile.jsp");
		return;
	}
	
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	vo.setPw(pw);
	vo.setId(user.getId());
	
	dao.update(vo);
	
	user.setPw(pw);
	session.setAttribute("user", user);
	
	response.sendRedirect("/Car/user/profile.jsp");
%>