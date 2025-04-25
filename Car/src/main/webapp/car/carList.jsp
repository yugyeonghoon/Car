<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="carInfo.CarDAO" %>
<%@page import="carInfo.CarVO" %>
<%
	String title = request.getParameter("carKeyword");

	CarDAO dao = new CarDAO();
	List<CarVO> list = dao.searchCars(title);
	
	if(title == null) {
		title = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <title>차량 검색 목록</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #fff;
    }

    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 60px;
      padding: 40px;
      max-width: 1200px;
      margin: 0 auto;
      overflow-y: auto;
      width: 100rem;
      height: 50rem;
    }

    .product-card {
      text-align: center;
    }

    .product-card img {
      width: 100%;
      height: auto;
      border-radius: 8px;
      background-color: #f5f5f5;
    }

    .car-name {
      font-size: 14px;
      margin-top: 10px;
      color: #111;
    }

    .car-type {
      font-size: 13px;
      color: #666;
      margin-top: 5px;
    }
  </style>
</head>
<body>
<%@include file="../header.jsp" %>
<!-- 헤더 검색어에 키워드 클릭 시 관련된 차량 정보 목록 나옴-->
  <div class="product-grid">
    
    <% 
    	for(int i = 0; i < list.size(); i++) {
    		CarVO vo = list.get(i);
    		String mno = vo.getMno();
    		String carName = vo.getCar_name();
    		String img = vo.getCar_img();
    		String carType = vo.getCar_type();
    		String tno = vo.getTno();
    %>
    <div class="product-card">
	      <a href="/Car/car/carDetail.jsp?tno=<%=tno%>"><img src="<%=img %>" alt="..."></a>
	      <div class="car-name"><%=carName %></div>
	      <div class="car-type"><%=carType %></div>
    </div>
      <%
      	}
      %>
    </div>
<%@include file="../footer.jsp" %>
</body>
</html>
