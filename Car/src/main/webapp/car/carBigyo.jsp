<%@page import="carInfo.CarVO"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%
	// CarDAO 객체 생성 및 회사 목록 조회
	CarDAO dao = new CarDAO();
	List<CarVO> list = dao.companyView();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>차량 비교</title>
		<style>
			/* 비교 컨테이너 스타일 */
			.comparison-containers {
				padding: 20px;
			}
			/* 차량 컨테이너 스타일 */
			.car-containers {
				display: flex;
				justify-content: center;
				gap: 80px;
				padding: 20px;
			}
			/* 차량 스타일 */
			.car {
				display: flex;
				flex-direction: column;
				align-items: center;
			}
			/* 차량 이미지 스타일 */
			.car-image {
				width: 460px;
				height: 250px;
				object-fit: cover;
			}
			/* 'VS' 텍스트 스타일 */
			.vs-text {
				font-size: 40px;
				font-weight: bold;
				color: #444;
				padding: 0 20px;
				margin-top: 100px;
			}
			/* 차량 모델 스타일 */
			.car-model {
				margin-top: 10px;
				font-size: 20px;
				font-weight: bold;
				color: #333;
			}
			/* 트림 선택 스타일 */
			.trim-select {
				margin-top: 10px;
				width: 230px;
				padding: 8px;
				font-size: 16px;
				border: 1px solid #ccc;
				border-radius: 4px;
			}
			/* 차량 정보 테이블 스타일 */
			.car-info {
				margin-top: 15px;
				border-collapse: collapse;
				width: 300px;
				font-size: 14px;
			}
			/* 차량 정보 테이블 헤더 및 데이터 셀 스타일 */
			.car-info th, .car-info td {
				border: 1px solid #ccc;
				padding: 8px;
				text-align: left;
			}
			/* 차량 정보 테이블 헤더 배경색 */
			.car-info th {
				background-color: #f5f5f5;
				width: 90px;
			}
			/* 선택 버튼 스타일 */
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
			/* 선택 버튼 hover 효과 */
			.select-button:hover {
				background-color: #6e859f;
			}
			/* 모달창 스타일 */
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
			/* 모달창 내용 스타일 */
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
			/* 모달창 fadeIn 애니메이션 */
			@keyframes fadeIn {
				from { opacity: 0; transform: scale(0.95); }
				to { opacity: 1; transform: scale(1); }
			}
			/* 모달창 제목 스타일 */
			.modal-content h3 {
				margin-bottom: 20px;
				font-size: 22px;
				color: #222;
				text-align: center;
			}
			/* 모달창의 label 스타일 */
			.modal-content label {
				font-weight: 500;
				margin-top: 15px;
				display: block;
				color: #333;
				font-size: 15px;
			}
			/* 트림 선택 박스 스타일 */
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
			/* 트림 선택 박스에 포커스 시 효과 */
			.modal-content .trim-select:focus {
				border-color: #007BFF;
				box-shadow: 0 0 0 2px rgba(0,123,255,0.1);
			}
			/* 모달창 닫기 버튼 스타일 */
			.close {
				color: #aaa;
				position: absolute;
				top: 15px;
				right: 20px;
				font-size: 26px;
				cursor: pointer;
				transition: color 0.2s;
			}
			/* 모달창 닫기 버튼 hover 효과 */
			.close:hover {
				color: #000;
			}
		</style>
	</head>
	<body>
		<!-- 차량 비교 컨테이너 -->
		<div class="comparison-containers">
			<div class="car-containers">
				<!-- 첫 번째 차량 -->
				<div class="car">
					<img alt="firstCar" src="../model_200_100.png" class="car-image">
					<button class="select-button" onclick="openModal('modal1')">추가하기</button>
					<!-- 차량 기본 정보 테이블 -->
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>이름</th><td></td></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
						<tr><th>타입</th><td></td></tr>
						
					</table>
				</div>
				<div class="vs-text">VS</div>
				<!-- 두 번째 차량 -->
				<div class="car">
					<img alt="secondCar" src="../model_200_100.png" class="car-image">
					<button class="select-button" onclick="openModal('modal2')">추가하기</button>
					<!-- 차량 기본 정보 테이블 -->
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>이름</th><td></td></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
						<tr><th>타입</th><td></td></tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 첫 번째 차량 모달창 -->
		<div id="modal1" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeModal('modal1')">&times;</span>
				<h3>첫 번째 차량 선택</h3>
				<label for="maker1">제조사</label>
				<!-- 제조사 선택 -->
				<select id="maker1" class="trim-select" onchange="loadModels('maker1', 'model1')">
					<option value="">선택하세요</option>
					<%
						for(int i = 0; i < list.size(); i++){
							CarVO vo = list.get(i);
							String company = vo.getCompany();
					%>
							<option value="<%= company %>"><%= company %></option>
					<%
						}
					%>
				</select>
				<label for="model1">모델</label>
				<select id="model1" class="trim-select" onchange="loadTrims('model1', 'trim1')">
					<option value="">선택하세요</option>
				</select>
				<label for="trim1">트림</label>
				<select id="trim1" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<button class="select-button" onclick="selectCar(1)">선택 완료</button>
			</div>
		</div>	
		<!-- 두 번째 차량 모달창 -->
		<div id="modal2" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeModal('modal2')">&times;</span>
				<h3>두 번째 차량 선택</h3>
				<label for="maker2">제조사</label>
				<!-- 제조사 선택 -->
				<select id="maker2" class="trim-select" onchange="loadModels('maker2', 'model2')">
					<option value="">선택하세요</option>
					<%
						for(int i = 0; i < list.size(); i++){
							CarVO vo = list.get(i);
							String company = vo.getCompany();
					%>
							<option value="<%= company %>"><%= company %></option>
					<%
						}
					%>
				</select>
				<label for="model2">모델</label>
				<select id="model2" class="trim-select" onchange="loadTrims('model2', 'trim2')">
					<option value="">선택하세요</option>
				</select>
				<label for="trim2">트림</label>
				<select id="trim2" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<button class="select-button" onclick="selectCar(2)">선택 완료</button>
			</div>
		</div>
		
		<script>
			// 선택한 제조사에 따라 모델 로딩
			function loadModels(makerId, modelId) {
				let maker = document.getElementById(makerId).value;
				if (maker === "") {
					document.getElementById(modelId).innerHTML = "<option value=''>모델 선택</option>";
					return;
				}
			
				let xhr = new XMLHttpRequest();
				xhr.open("get", "getModels.jsp?company=" + maker, true);
				xhr.onreadystatechange = function () {
					if (xhr.readyState === 4 && xhr.status === 200) {
						let models = JSON.parse(xhr.responseText);
						let modelSelect = document.getElementById(modelId);
						modelSelect.innerHTML = "<option value=''>선택하세요</option>";
						for (let i = 0; i < models.length; i++) {
							let option = document.createElement("option");
							option.value = models[i].title;
							option.textContent = models[i].title;
							modelSelect.appendChild(option);
						}
					}
				};
				xhr.send();
			}
			
			function loadTrims(modelId, trimId) {
				let model = document.getElementById(modelId).value;
				if (model === "") {
					document.getElementById(trimId).innerHTML = "<option value=''>트림 선택</option>";
					return;
				}
			
				let xhr = new XMLHttpRequest();
				xhr.open("get", "getTrims.jsp?model=" + encodeURIComponent(model), true);
				xhr.onreadystatechange = function () {
					if (xhr.readyState === 4 && xhr.status === 200) {
						let trims = JSON.parse(xhr.responseText);
						let trimSelect = document.getElementById(trimId);
						trimSelect.innerHTML = "<option value=''>선택하세요</option>";
						for (let i = 0; i < trims.length; i++) {
							let option = document.createElement("option");
							option.value = trims[i].title;
							option.textContent = trims[i].title;
							trimSelect.appendChild(option);
						}
					}
				};
				xhr.send();
			}
			// 모달창 닫기
			function closeModal(id) {
				document.getElementById(id).style.display = "none";
			}
			// 모달창 열기
			function openModal(id) {
				document.getElementById(id).style.display = "block";
			}
			// 차량 선택 완료 처리
			/* function selectCar(num) {
				alert("차량 " + num + " 선택 완료!");
				closeModal("modal" + num);
			} */
			
			function selectCar(num) {
				let maker = document.getElementById("maker" + num).value;
				let model = document.getElementById("model" + num).value;
				let trim = document.getElementById("trim" + num).value;

				if (maker === "" || model === "" || trim === "") {
					alert("제조사, 모델, 트림을 모두 선택하세요.");
					return;
				}

				let xhr = new XMLHttpRequest();
				xhr.open("get", "getCarInfo.jsp?model=" + encodeURIComponent(model) + "&trim=" + encodeURIComponent(trim), true);
				xhr.onreadystatechange = function () {
					if (xhr.readyState === 4 && xhr.status === 200) {
						let data = JSON.parse(xhr.responseText);

						let carElements = document.querySelectorAll(".car");
						let img = carElements[num - 1].querySelector("img");
						let td = carElements[num - 1].querySelectorAll(".car-info td");

						img.src = data.image;
						td[0].textContent = data.carName;
						td[1].textContent = data.price;
						td[2].textContent = data.gas;
						td[3].textContent = data.fuel; 
						td[4].textContent = data.output;
						td[5].textContent = data.engine;
						td[6].textContent = data.type;

						closeModal("modal" + num);
					}
				};
				xhr.send();
			}

		</script>
		<%@ include file="../footer.jsp" %>
	</body>
</html>
