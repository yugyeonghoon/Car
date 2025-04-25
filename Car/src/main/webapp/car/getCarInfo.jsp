<%@page import="java.util.List"%>
<%@page import="carInfo.CarVO"%>
<%@page import="carInfo.CarDAO"%>
<%@page contentType="application/json;charset=UTF-8"%>
<%
    String model = request.getParameter("model");
    String trim = request.getParameter("trim");

    CarDAO dao = new CarDAO();
    List<CarVO> cars = dao.carBigyo(model, trim);
    
    if (!cars.isEmpty()) {
        CarVO car = cars.get(0);
        out.print("{");
        out.print("\"carName\":\"" + car.getCar_name() + "\",");
        out.print("\"price\":\"" + car.getPrice() + "\",");
        out.print("\"gas\":\"" + car.getGas() + "\",");
        out.print("\"output\":\"" + car.getOutput() + "\",");
        out.print("\"engine\":\"" + car.getEngine() + "\",");
        out.print("\"image\":\"" + car.getCar_img() + "\",");
        out.print("\"fuel\":\"" + car.getFuel() + "\",");
        out.print("\"type\":\"" + car.getCar_type() + "\"");
        out.print("}");
    }
%>
