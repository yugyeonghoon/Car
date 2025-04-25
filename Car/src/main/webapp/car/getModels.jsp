<%@page import="carInfo.CarVO"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String company = request.getParameter("company");
    CarDAO dao = new CarDAO();
    List<CarVO> modelList = dao.modelView(company);  // 회사에 기반한 모델 리스트 가져오기
    
    // 응답 준비
    response.setContentType("application/json");
    String jsonResponse = "[";

    for (CarVO vo : modelList) {
        jsonResponse += "{\"title\": \"" + vo.getCar_name() + "\"},"; // 모델 제목 추가
    }

    // 마지막 쉼표 제거하고 JSON 배열 닫기
    if (jsonResponse.length() > 1) {
        jsonResponse = jsonResponse.substring(0, jsonResponse.length() - 1);
    }
    jsonResponse += "]";

    // JSON 응답 전송
    out.print(jsonResponse);
%>
