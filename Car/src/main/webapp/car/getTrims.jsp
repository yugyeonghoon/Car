<%@page import="carInfo.CarVO"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 모델 이름을 파라미터로 받아오기
    String model = request.getParameter("model");
    
    // DAO를 통해 해당 모델의 트림 리스트 가져오기
    CarDAO dao = new CarDAO();
    List<CarVO> trimList = dao.trimView(model);  // 모델에 해당하는 트림 목록

    // JSON 응답 문자열 생성
    response.setContentType("application/json");
    String jsonResponse = "[";

    for (CarVO vo : trimList) {
        jsonResponse += "{\"title\": \"" + vo.getCar_name() + "\"},";
    }

    // 마지막 쉼표 제거
    if (jsonResponse.length() > 1) {
        jsonResponse = jsonResponse.substring(0, jsonResponse.length() - 1);
    }
    jsonResponse += "]";

    out.print(jsonResponse);
%>
