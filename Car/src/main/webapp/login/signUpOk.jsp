<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserVO"%>
<%@page import="user.UserDAO" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String email = request.getParameter("email");
	String nick = request.getParameter("nickname");
	String gender = request.getParameter("gender");
	
	System.out.println(id);
	System.out.println(pw);
	System.out.println(email);
	System.out.println(nick);
	System.out.println(gender);
	
	if(id == null || pw == null || email ==null || nick == null ) {
		response.sendRedirect("../login/signUp.jsp");
		return;
	}
	
	if(id.isEmpty() || pw.isEmpty() || email.isEmpty() || nick.isEmpty()){
		response.sendRedirect("../login/signUp.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	vo.setId(id);
	vo.setPw(pw);
	vo.setEmail(email);
	vo.setNick(nick);
	vo.setGender(gender);
	
	dao.join(vo);
	
	response.sendRedirect("../login/login.jsp");
%>