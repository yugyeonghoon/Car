<%@page import="reply.ReplyVO"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String rauthor = request.getParameter("rauthor");
	String rcontent = request.getParameter("rcontent");
	
	if(no == null || rauthor == null || rcontent == null){
		out.print(0);
		return;
	}
	
	if(no.isEmpty() || rauthor.isEmpty() || rcontent.isEmpty()){
		out.print(0);
		return;
	}
	
	ReplyDAO dao = new ReplyDAO();
	ReplyVO vo = new ReplyVO();
	vo.setBno(no);
	vo.setReply_author(rauthor);
	vo.setReply_content(rcontent);
	
	int result = dao.write(vo);
	
	out.print(result);
%>