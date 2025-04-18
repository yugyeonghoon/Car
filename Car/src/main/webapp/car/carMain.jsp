<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>메인</title>
<link href="../css/carMain.css" rel="stylesheet">
<link href="../css/carMainDropdown.css" rel="stylesheet">
<link href="../css/footer.css" rel="stylesheet">
</head>
<body>
<%@include file="../header.jsp" %>
<div id="content">
<%@include file="../dropdown.jsp" %>
<div id="sildeShow">
	<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-touch="false">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	    	<div class="first">
	    		<a href="carDetail.jsp"><img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250415165505614_GO6DM3ULW.png%2F20250415165321_E.png%3Ftype%3Dm1500" class="d-block w-100" alt="..."></a>
	    		<h4><span>혼다 어코드 하이브리드</span></h4>
	    	</div>
	      	<div class="second">
	    		<a href="carDetail.jsp"><img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250404170119967_WDJ92V4C6.png%2F20250404165251_N.png%3Ftype%3Dm1500" class="d-block w-100" alt="..."></a>
	    		<h4><span>푸조 308</span></h4>
	    	</div>
	    	<div class="third">
	    		<a href="carDetail.jsp"><img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250408102010155_RR0O55GK9.png%2F20250408101516_e.png%3Ftype%3Dm1500" class="d-block w-100" alt="..."></a>
	    		<h4><span>토요타 GR 86</span></h4>
	    	</div>
	    </div>
	    <div class="carousel-item">
	      <div class="first">
	    		<a href="carDetail.jsp"><img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250403140618669_032SXFOE4.png%2F20250403135907_1.png%3Ftype%3Dm1500" class="d-block w-100" alt="..."></a>
	    		<h4><span>KGM 토레스 EVX</span></h4>
	    	</div>
	      	<div class="second">
	    		<a href="carDetail.jsp"><img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250403101615970_E8YQO9PPY.png%2F20250403100640_O.png%3Ftype%3Dm1500" class="d-block w-100" alt="..."></a>
	    		<h4><span>테슬라 모델 Y</span></h4>
	    	</div>
	    	<div class="third">
	    		<a href="carDetail.jsp"><img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250403134012336_RQF0VF7WN.png%2F20250403133024_r.png%3Ftype%3Dm1500" class="d-block w-100" alt="..."></a>
	    		<h4><span>현대 베뉴</span></h4>
	    	</div>
	    </div>
	    <div class="carousel-item">
	      	<div class="first">
	    		<img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250403101615970_E8YQO9PPY.png%2F20250403100640_O.png%3Ftype%3Dm1500" class="d-block w-100" alt="...">
	    		<h4><span>테슬라 모델 Y</span></h4>
	    	</div>
	      	<div class="second">
	    		<img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250403134012336_RQF0VF7WN.png%2F20250403133024_r.png%3Ftype%3Dm1500" class="d-block w-100" alt="...">
	    		<h4><span>현대 베뉴</span></h4>
	    	</div>
	    	<div class="third">
	    		<img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250305132621064_DW71SUTEI.png%2F20250305132049_2.png%3Ftype%3Dm1500" class="d-block w-100" alt="...">
	    		<h4><span>KGM 무쏘 칸</span></h4>
	    	</div>
	    </div>
	  </div>
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
  </div>
</div>

</div>
<%@include file="../footer.jsp" %>
</body>
</html>