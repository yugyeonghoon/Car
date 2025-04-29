<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarVO"%>
<%@page import="carInfo.CarDAO"%>
<%@page contentType="application/json;charset=UTF-8"%>
<%
    String model = request.getParameter("model");
    String trim = request.getParameter("trim");

    CarDAO dao = new CarDAO();
    List<CarVO> cars = dao.carBigyo(model, trim);
    
    ObjectMapper om = new ObjectMapper();
    String jsonStr = om.writeValueAsString(cars);
    System.out.println(jsonStr);
    out.print(jsonStr);
%>
