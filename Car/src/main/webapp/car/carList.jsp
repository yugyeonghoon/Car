<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="carInfo.CarDAO" %>
<%@ page import="carInfo.CarVO" %>
<%
    String title = request.getParameter("carKeyword");
    if (title == null) title = "";

    CarDAO dao = new CarDAO();
    List<CarVO> list = dao.searchCars(title);
%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="../css/font2.css">
	    <title><%=title%> 검색결과 | 차량생각</title>
	    <style>
 	        body {
	            /* font-family: 'Segoe UI', sans-serif; */
	            margin: 0;
	            padding: 0;
	            background-color: #fff;
	        } 
	        .car-list {
	            display: grid;
	            grid-template-columns: repeat(2, minmax(300px, 1fr));
	            gap: 50px;
	            max-width: 1200px;
	            margin: 40px auto;
	            padding: 0 20px;
	        }
	        .car-card {
	            display: flex;
	            flex-direction: column;
	            border: 1px solid #ddd;
	            border-radius: 10px;
	            background-color: #fff;
	            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	            overflow: hidden;
	        }
	        .car-card img {
	            width: 100%;
	            height: 180px;
	            object-fit: contain;
	            background-color: #f9f9f9;
	        }
	        .car-details {
	            padding: 15px;
	        }
	        .car-name {
	            font-weight: bold;
	            margin-bottom: 8px;
	        }
	        .car-spec {
	            color: #333;
	        }
	    </style>
	</head>
	<body class="abody">
	<%@ include file="../header.jsp" %>
	<div class="car-list">
	  <% for (CarVO vo : list) { %>
	    <div class="car-card">
	      <a class="atag" href="/Car/car/carDetail.jsp?tno=<%= vo.getTno() %>">
	        <img src="<%= vo.getCar_img() %>" alt="<%= vo.getCar_name() %>">
	      </a>
	      <div class="car-details">
	        <div class="car-name"><%= vo.getCar_name() %></div>
	        <div class="car-spec">타입: <%= vo.getCar_type() %></div>
	        <div class="car-spec">연식: <%= vo.getYear() %></div>
	      </div>
	    </div>
	  <% } %>
	</div>
	<%@ include file="../footer.jsp" %>
	</body>
</html>
