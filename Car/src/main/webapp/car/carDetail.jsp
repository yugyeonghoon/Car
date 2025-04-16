<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>차량 상세 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<style>
			body {
	            font-family: Arial, sans-serif;
	            margin: 20px;
	            background-color: white;
	        }
	        h3 {
	        	text-align: center;
	        }
	        .car-container {
	            display: flex;
	            max-width: 900px;
	            margin: 0 auto;
	            padding: 20px;
	            background-color: white;
	            border-radius: 10px;
	            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	        }
	        .car-poster {
	            flex: 2;
	            margin-right: 20px;
	        }
	        .car-poster img {
	            max-width: 100%;
	            border-radius: 8px;
	            height: 80%;
	        }
	        .car-info {
	            flex: 1;
	        }
	        .car-info h2 {
	            font-size: 25px;
	            color: #333;
	        }
	        .car-info p {
	            font-size: 16px;
	            color: #555;
	        }
	        th, td {
	        	text-align: center;
	        	font-size: 20px;
	        }
	        div.table {
	        	padding: 20px;
	        }
</style>
</head>
<body>
	<h3>차량 상세정보</h3>
	    <div class="car-container">
	        <div class="car-poster">
	        <div class="position-absolute top-50 start-50 translate-middle"></div>
	            <img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250415103120800_H0Q5YTNQ0.png%2F20250415102117_a.png%3Ftype%3Dm1500" alt="포스터" id="posterImage" class="poster">
	        </div>
	        <div class="car-info">
	            <h2 id="carTitle">현대 아반떼 하이브리드</h2>
	            <h4 id="carModel">준중형 세단 2026</h4>
		            <p>
		            	<strong>가격</strong>
		            	<span id="price">2,523~3,184만원</span>
		           	</p>
		           	<p>
		            	<strong>연료</strong>
		            	<span id="fuel">가솔린, 하이브리드</span>
		           	</p>
		           	<p>
		            	<strong>연비</strong>
		            	<span id="gasMileage">복합 19.2~21.1km/</span>
		           	</p>
		           	<p>
		            	<strong>출력</strong>
		            	<span id="power">141hp/105hp</span>
		           	</p>
		           	<p>
		            	<strong>토크</strong>
		            	<span id="Torque">15kg.m</span>
		           	</p>
		           	<p>
		            	<strong>배기</strong>
		            	<span id="exhaust">1,580cc</span>
		           	</p>
		            <p>
		            	<strong>엔진</strong>
		            	<span id="engine">I4</span>
		           	</p>
		           	<p>
		            	<strong>구동</strong>
		            	<span id="drivingSystem">FF</span>
		           	</p>
		           	<p>
		            	<strong>변속</strong>
		            	<span id="gearshift">DCT6단</span>
		           	</p>
		           	<p>
		            	<strong>전장</strong>
		            	<span id="Overall Length">4,710mm</span>
		           	</p>
		           	<p>
		            	<strong>전고</strong>
		            	<span id="Overall Height">1,420mm</span>
		           	</p>
		           	<p>
		            	<strong>전폭</strong>
		            	<span id="Overall Width">1,825mm</span>
		           	</p>
		           	<p>
		            	<strong>축거</strong>
		            	<span id="wheelbase">2,720mm</span>
		           	</p>
		         	<!-- 평가 없는 경우 안 뜨게 -->
		           	<p class="rating">
		           		<strong>평점:</strong>
		           		<span id="rating"></span>/10 | <span class="ratingPeople">명 참여</span>
		           	</p>
	        </div>
	    </div>
	   	<div class="table">
	   		<table class="table">
  				<thead>
			    <tr>
			      <th scope="col">개선점</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td scope="row">개선점1 가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하</td>
			    </tr>
			    <tr>
			      <td scope="row">개선점2 가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하</td>
			    </tr>
			    <tr>
			      <td scope="row">개선점3 가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하</td>
			    </tr>
			  </tbody>
			</table>
	   	</div>
</body>
</html>