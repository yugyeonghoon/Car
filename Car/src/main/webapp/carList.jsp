<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="carInfo.CarDAO" %>
<%@page import="carInfo.CarVO" %>
<%
	
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
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 40px;
      padding: 40px;
      max-width: 1200px;
      margin: 0 auto;
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

    .product-name {
      font-size: 14px;
      margin-top: 10px;
      color: #111;
    }

    .product-price {
      font-size: 13px;
      color: #666;
      margin-top: 5px;
    }
  </style>
</head>
<body>
<%@include file="header.jsp" %>
  <div class="product-grid">
    <div class="product-card">
      <img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250415165505614_GO6DM3ULW.png%2F20250415165321_E.png%3Ftype%3Dm1500" alt="상품">
      <div class="product-name">혼다 어코드 하이브리드</div>
      <div class="product-price">중형 세단2025</div>
    </div>
    <div class="product-card">
      <img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250404170119967_WDJ92V4C6.png%2F20250404165251_N.png%3Ftype%3Dm1500" alt="상품">
      <div class="product-name">푸조 308</div>
      <div class="product-price">준중형 해치백2025</div>
    </div>
    <div class="product-card">
      <img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250408102010155_RR0O55GK9.png%2F20250408101516_e.png%3Ftype%3Dm1500" alt="상품">
      <div class="product-name">토요타 GR 86</div>
      <div class="product-price">스포츠카 쿠페2025</div>
    </div>
    <div class="product-card">
      <img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250403140618669_032SXFOE4.png%2F20250403135907_1.png%3Ftype%3Dm1500" alt="상품">
      <div class="product-name">KGM 토레스 EVX</div>
      <div class="product-price">중형 SUV2025</div>
    </div>
  </div>
<%@include file="footer.jsp" %>
</body>
</html>
