<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="carView.carViewVO"%>
<%@page import="carView.carViewDAO"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String carTno = request.getParameter("carTno");
	String userId = request.getParameter("userId");
	String carName = request.getParameter("carName");
	String carViewDate = request.getParameter("carViewDate");
	
	System.out.println(carTno);
	System.out.println(userId);
	System.out.println(carName);
	System.out.println(carViewDate);
	
	carViewDAO dao = new carViewDAO();
	carViewVO vo = new carViewVO();
	vo.setCarTno(carTno);
	vo.setUserId(userId);
	vo.setCarName(carName);
	vo.setCarViewDate(carViewDate);
	
	dao.viewInsert(vo);
	
	response.sendRedirect("/Car/car/carMain.jsp");
%>