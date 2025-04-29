<%@page import="user.UserVO"%>
<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	UserVO user = (UserVO)session.getAttribute("user");
	String title = request.getParameter("title");
	String refer = request.getParameter("refer");
	String content = request.getParameter("content");
	String boardType = request.getParameter("boardType");
	
	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();
	int boardTypeNum = Integer.parseInt(boardType);
	
	vo.setAuthor(user.getId());
	vo.setTitle(title);
	vo.setContent(content);
	vo.setBoardType(boardTypeNum);
	
	int no = dao.write(vo);
	
	if(boardTypeNum == 1) {
		response.sendRedirect("moviePost.jsp?no="+ no);
	} else {
		response.sendRedirect("post.jsp?no="+ no);
	}
	
	/* if (refer != null) {
	    response.sendRedirect(refer);
	} else {
	    response.sendRedirect("board.jsp");
	} */
%>