<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>차량 비교</title>
		<style>
			.comparison-containers {
				padding: 20px;
			}
			.car-containers {
				display: flex;
				justify-content: center;
				gap: 80px;
				padding: 20px;
			}
			.car {
				display: flex;
				flex-direction: column;
				align-items: center;
			}
			.car-image {
				width: 450px;
				height: 300px;
				object-fit: cover;
			}
			.vs-text {
				font-size: 40px;
				font-weight: bold;
				color: #444;
				padding: 0 20px;
				margin-top: 100px;
			}
			.car-model {
				margin-top: 10px;
				font-size: 20px;
				font-weight: bold;
				color: #333;
			}
			.trim-select {
				margin-top: 10px;
				width: 230px;
				padding: 8px;
				font-size: 16px;
				border: 1px solid #ccc;
				border-radius: 4px;
			}
			.car-info {
				margin-top: 15px;
				border-collapse: collapse;
				width: 300px;
				font-size: 14px;
			}
			.car-info th, .car-info td {
				border: 1px solid #ccc;
				padding: 8px;
				text-align: left;
			}
			.car-info th {
				background-color: #f5f5f5;
				width: 90px;
			}
		</style>
	</head>
	<body>
		<div class="comparison-containers">
			<div class="car-containers">
				<div class="car">
					<img alt="firstCar" src="k3gt.png" class="car-image">
					<div class="car-model">기아 K3 GT</div>
					<select class="trim-select">
						<option>트림 선택</option>
						<option>1.6 가솔린 터보</option>
					</select>
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>가격</th><td>2,784만원</td></tr>
						<tr><th>연료</th><td>가솔린</td></tr>
						<tr><th>연비</th><td>복합 12.1km/ℓ<br>도심 10.8 / 고속 14</td></tr>
						<tr><th>출력</th><td>204hp</td></tr>
						<tr><th>엔진</th><td>I4 싱글터보</td></tr>
					</table>
				</div>
				<div class="vs-text">VS</div>
				<div class="car">
					<img alt="secondCar" src="투싼 nx4.png" class="car-image">
					<div class="car-model">현대 투싼</div>
					<select class="trim-select">
						<option>트림 선택</option>
						<option>1.6 가솔린 터보</option>
						<option>1.6 가솔린 터보 AWD</option>
						<option>2.0 디젤</option>
						<option>2.0 디젤 AWD</option>
						<option>1.6 가솔린 터보 N라인</option>
						<option>1.6 가솔린 터보 N라인 AWD</option>
						<option>2.0 디젤 N라인</option>
						<option>2.0 디젤 N라인 AWD</option>
					</select>
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>가격</th><td>2,603~3,822만원</td></tr>
						<tr><th>연료</th><td>가솔린, 디젤</td></tr>
						<tr><th>연비</th><td>복합 11~14.5km/ℓ<br>도심 10.2~13 / 고속 12~16.8</td></tr>
						<tr><th>출력</th><td>180~184hp</td></tr>
						<tr><th>엔진</th><td>I4 싱글터보</td></tr>
					</table>
				</div>
			</div>
		</div>
		<%@include file="footer.jsp" %>
	</body>
</html>
