<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
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
				width: 410px;
				height: 250px;
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
			.select-button {
				margin-top: 10px;
				background-color: #94b0cf;
				color: white;
				border: none;
				padding: 10px 20px;
				border-radius: 8px;
				font-size: 16px;
				cursor: pointer;
				transition: background-color 0.2s;
			}
			.select-button:hover {
				background-color: #6e859f;
			}
			.modal {
				display: none;
				position: fixed;
				z-index: 999;
				left: 0;
				top: 0;
				width: 100%;
				height: 100%;
				background-color: rgba(0, 0, 0, 0.4);
				backdrop-filter: blur(2px);
			}
			.modal-content {
				background-color: #ffffff;
				margin: 8% auto;
				padding: 30px 25px;
				border-radius: 16px;
				width: 420px;
				box-shadow: 0 10px 30px rgba(0,0,0,0.2);
				position: relative;
				font-family: 'Segoe UI', sans-serif;
				animation: fadeIn 0.3s ease-in-out;
			}
			@keyframes fadeIn {
				from { opacity: 0; transform: scale(0.95); }
				to { opacity: 1; transform: scale(1); }
			}
			.modal-content h3 {
				margin-bottom: 20px;
				font-size: 22px;
				color: #222;
				text-align: center;
			}
			.modal-content label {
				font-weight: 500;
				margin-top: 15px;
				display: block;
				color: #333;
				font-size: 15px;
			}
			.modal-content .trim-select {
				width: 100%;
				padding: 10px;
				margin-top: 6px;
				border: 1px solid #ccc;
				border-radius: 8px;
				font-size: 15px;
				outline: none;
				transition: border-color 0.2s;
			}
			.modal-content .trim-select:focus {
				border-color: #007BFF;
				box-shadow: 0 0 0 2px rgba(0,123,255,0.1);
			}
			.close {
				color: #aaa;
				position: absolute;
				top: 15px;
				right: 20px;
				font-size: 26px;
				cursor: pointer;
				transition: color 0.2s;
			}
			.close:hover {
				color: #000;
			}
		</style>
	</head>
	<body>
		<div class="comparison-containers">
			<div class="car-containers">
				<div class="car">
					<img alt="firstCar" src="../none_car.png" class="car-image">
					<button class="select-button" onclick="openModal('modal1')">추가하기</button>
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
					</table>
				</div>
				<div class="vs-text">VS</div>
				<div class="car">
					<img alt="secondCar" src="../none_car.png" class="car-image">
					<button class="select-button" onclick="openModal('modal2')">추가하기</button>
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
					</table>
				</div>
			</div>
		</div>
		<div id="modal1" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeModal('modal1')">&times;</span>
				<h3>첫 번째 차량 선택</h3>
				<label for="maker1">제조사</label>
				<select id="maker1" class="trim-select">
					<option value="">선택하세요</option>
					<option value="hyundai">현대</option>
					<option value="kia">기아</option>
					<option value="chevrolet">쉐보레</option>
					<option value="renault">르노코리아</option>
					<option value="kg">KG모빌리티</option>
					<option value="kg">제네시스</option>
				</select>
				<label for="model1">모델</label>
				<select id="model1" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<label for="trim1">트림</label>
				<select id="trim1" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<button class="select-button" onclick="selectCar(1)">선택 완료</button>
			</div>
		</div>
		<div id="modal2" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeModal('modal2')">&times;</span>
				<h3>두 번째 차량 선택</h3>
				<label for="maker2">제조사</label>
				<select id="maker2" class="trim-select">
					<option value="">선택하세요</option>
					<option value="hyundai">현대</option>
					<option value="kia">기아</option>
					<option value="chevrolet">쉐보레</option>
					<option value="renault">르노코리아</option>
					<option value="kg">KG모빌리티</option>
				</select>
				<label for="model2">모델</label>
				<select id="model2" class="trim-select">
					<option value="">선택하세요</option>
					<option value="">K3 GT</option>
				</select>
				<label for="trim2">트림</label>
				<select id="trim2" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<button class="select-button" onclick="selectCar(2)">선택 완료</button>
			</div>
		</div>
	
		<script>
			function closeModal(id) {
				document.getElementById(id).style.display = "none";
			}
			function openModal(id) {
				document.getElementById(id).style.display = "block";
			}
			function selectCar(num) {
				alert("차량 " + num + " 선택 완료!");
				closeModal("modal" + num);
			}
		</script>
	<%@ include file="../footer.jsp" %>
	</body>
</html>