<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="carLike.carLikeVO"%>
<%@page import="carLike.carLikeDAO"%>
<%
	request.setCharacterEncoding("utf-8");

	String carTno = request.getParameter("carTno");
	String userId = request.getParameter("userId");
	String flag = request.getParameter("flag");
	
	System.out.println(carTno);
	System.out.println(userId);
	
	carLikeDAO dao = new carLikeDAO();
	carLikeVO vo = new carLikeVO();
	vo.setCarTno(carTno);
	vo.setUserId(userId);
	
	//flag 0이면? like ? unlike
	if(flag.equals("0")){
		dao.like(vo);
		out.print("1");
	}else{
		dao.unlike(vo);	
		out.print("0");
	}
	
%>