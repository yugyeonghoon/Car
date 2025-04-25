<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@page import="carInfo.CarVO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
    String no = request.getParameter("no");
    CarDAO dao1 = new CarDAO();
    List<CarVO> models = dao1.model(no); // 제조사에 해당하는 모델 가져오기

    ObjectMapper om = new ObjectMapper();
    String jsonStr = om.writeValueAsString(models);
    System.out.println(jsonStr);
    out.print(jsonStr);
%>