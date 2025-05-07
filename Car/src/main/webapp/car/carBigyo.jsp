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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="../css/font2.css">
	<title>모델 비교 | 차량생각</title>
	<style>
		/* carbygyo 페이지에서만 푸터 스타일 수정 */
		.footer {
			position: static !important;
			margin-top: 100px;
			background-color: #e0f7fa;
		}
		/* 비교 컨테이너 스타일 */
		.comparison-containers {
			padding: 20px;
		}
		/* 차량 컨테이너 스타일 */
		.car-containers {
			display: flex;
			justify-content: center;
			gap: 10px;
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

		/* 차량 모델 스타일 */
		.car-model {
			margin-top: 10px;
			font-weight: bold;
			color: #333;
		}
		/* 트림 선택 스타일 */
		.trim-select {
			margin-top: 10px;
			width: 230px;
			padding: 8px;
			border: 1px solid #ccc;
			border-radius: 4px;
		}
		/* 차량 정보 테이블 스타일 */
		.car-info {
			margin-top: 15px;
			border-collapse: collapse;
			width: 400px;
		}
		/* 차량 정보 테이블 헤더 및 데이터 셀 스타일 */
		.car-info th {
			border: 1px solid #ccc;
			padding: 8px;
			text-align: center;
			background-color: #f5f5f5;
			width: 100px;
		}
		.car-info td {
			border: 1px solid #ccc;
			padding: 8px;
			text-align: left;
		}
		/* 선택 버튼 스타일 */
		.select-button {
			margin-top: 10px;
			background-color: #94b0cf;
			color: white;
			border: none;
			padding: 10px 20px;
			border-radius: 8px;
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
			color: #222;
			text-align: center;
		}
		/* 모달창의 label 스타일 */
		.modal-content label {
			font-weight: 500;
			margin-top: 15px;
			display: block;
			color: #333;
		}
		/* 트림 선택 박스 스타일 */
		.modal-content .trim-select {
			width: 100%;
			padding: 10px;
			margin-top: 6px;
			border: 1px solid #ccc;
			border-radius: 8px;
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
	<body class="abody">
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
							String no = vo.getNo();
					%>
							<option value="<%= company %>" data-value="<%=no %>"><%= company %></option>
					<%
						}
					%>
				</select>
				<label for="model1">모델</label>
				<select id="model1" class="trim-select" onchange="loadTrims('model1', 'trim1')">
					<option value="">선택하세요</option>
				</select>
				<img id="model1-img" src="" alt="차량 이미지" style="display:none; max-width:360px; margin-top:10px;">
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
							String no2 = vo.getNo();
					%>
							<option value="<%= company %>" data-value="<%=no2 %>"><%= company %></option>
					<%
						}
					%>
				</select>
				<label for="model2">모델</label>
				<select id="model2" class="trim-select" onchange="loadTrims('model2', 'trim2')">
					<option value="">선택하세요</option>
				</select>
				<img id="model2-img" src="" alt="차량 이미지" style="display:none; max-width:360px; margin-top:10px;">
				<label for="trim2">트림</label>
				<select id="trim2" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<button class="select-button" onclick="selectCar(2)">선택 완료</button>
			</div>
		</div>
	<!-- 세 번째 차량 모달창 -->  
		<div id="modal3" class="modal">
			<div class="modal-content">
				<span class="close" onclick="closeModal('modal3')">&times;</span>
				<h3>세 번째 차량 선택</h3>
				<label for="maker3">제조사</label>
				<!-- 제조사 선택 -->
				<select id="maker3" class="trim-select" onchange="loadModels('maker3', 'model3')">
					<option value="">선택하세요</option>
					<%
						for(int i = 0; i < list.size(); i++){
							CarVO vo = list.get(i);
							String company = vo.getCompany();
							String no = vo.getNo();
					%>
							<option value="<%= company %>" data-value="<%=no %>"><%= company %></option>
					<%
						}
					%>
				</select>
				<label for="model3">모델</label>
				<select id="model3" class="trim-select" onchange="loadTrims('model3', 'trim3')">
					<option value="">선택하세요</option>
				</select>
				<img id="model3-img" src="" alt="차량 이미지" style="display:none; max-width:360px; margin-top:10px;">
				<label for="trim3">트림</label>
				<select id="trim3" class="trim-select">
					<option value="">선택하세요</option>
				</select>
				<button class="select-button" onclick="selectCar(3)">선택 완료</button>
			</div>
		</div>
		<!-- 차량 비교 컨테이너 -->
		<div class="comparison-containers">
			<div class="car-containers">
				<!-- 첫 번째 차량 -->
				<div class="car">
					<img alt="firstCar" src="../img/model_200_100.png" class="car-image">
					<button class="select-button" onclick="openModal('modal1')">추가하기</button>
					<!-- 차량 기본 정보 테이블 -->
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>이름</th><td></td></tr>
						<tr><th>트림</th><td></td></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
						<tr><th>타입</th><td></td></tr>
						<tr><th>배기량</th><td></td></tr>
						<tr><th>토크</th><td></td></tr>
						<tr><th>전장, 전폭</th><td></td></tr>
						<tr><th>무게</th><td></td></tr>
						<tr><th>변속</th><td></td></tr>
					</table>
				</div>
				<!-- 두 번째 차량 -->
				<div class="car">
					<img alt="secondCar" src="../img/model_200_100.png" class="car-image">
					<button class="select-button" onclick="openModal('modal2')">추가하기</button>
					<!-- 차량 기본 정보 테이블 -->
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>이름</th><td></td></tr>
						<tr><th>트림</th><td></td></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
						<tr><th>타입</th><td></td></tr>
						<tr><th>배기량</th><td></td></tr>
						<tr><th>토크</th><td></td></tr>
						<tr><th>전장, 전폭</th><td></td></tr>
						<tr><th>무게</th><td></td></tr>
						<tr><th>변속</th><td></td></tr>
					</table>
				</div>
				<!-- 3 번째 차량 -->
				<div class="car">
					<img alt="secondCar" src=".././img/model_200_100.png" class="car-image">
					<button class="select-button" onclick="openModal('modal3')">추가하기</button>
					<!-- 차량 기본 정보 테이블 -->
					<table class="car-info">
						<tr><th colspan="2">기본정보</th></tr>
						<tr><th>이름</th><td></td></tr>
						<tr><th>트림</th><td></td></tr>
						<tr><th>가격</th><td></td></tr>
						<tr><th>연료</th><td></td></tr>
						<tr><th>연비</th><td><br></td></tr>
						<tr><th>출력</th><td></td></tr>
						<tr><th>엔진</th><td></td></tr>
						<tr><th>타입</th><td></td></tr>
						<tr><th>배기량</th><td></td></tr>
						<tr><th>토크</th><td></td></tr>
						<tr><th>전장, 전폭</th><td></td></tr>
						<tr><th>무게</th><td></td></tr>
						<tr><th>변속</th><td></td></tr>
					</table>
				</div>
			</div>
		</div>
		<div><!-- 
			<table>
				<tr>
					<td>리뷰</td>
				</tr>
			</table> -->
		</div>
<script>
    // 제조사 선택 시 모델 로딩
    function loadModels(makerId, modelId) {
        const maker = $('#' + makerId).val();
        const $modelSelect = $('#' + modelId);

        if (maker === "") {
            $modelSelect.html("<option value=''>모델 선택</option>");
            return;
        }

        $.ajax({
            url: 'getModels.jsp',
            type: 'GET',
            data: {
            	company: maker 
            },
            dataType: 'json',
            success: function (models) {
                $modelSelect.html("<option value=''>선택하세요</option>");
                $.each(models, function (i, model) {
                    const option = $('<option>')
                        .val(model.title)
                        .text(model.title)
                        .attr('data-img', model.img);
                    $modelSelect.append(option);
                });
            }
        });
    }
    
    $('#model1').on('change', function () {
        const selectedOption = $(this).find('option:selected');
        const imgSrc = selectedOption.data('img');

        if (imgSrc && imgSrc !== "none_car.png" && imgSrc.trim() !== "") {
            $('#model1-img')
                .attr('src', imgSrc)
                .show(); // 이미지 보여주기
        } else {
            $('#model1-img')
                .removeAttr('src') // src 제거
                .hide();           // 이미지 숨기기
        }
    });  
    
    $('#model2').on('change', function () {
        const selectedOption = $(this).find('option:selected');
        const imgSrc = selectedOption.data('img');

        if (imgSrc && imgSrc !== "none_car.png" && imgSrc.trim() !== "") {
            $('#model2-img')
                .attr('src', imgSrc)
                .show(); // 이미지 보여주기
        } else {
            $('#model2-img')
                .removeAttr('src') // src 제거
                .hide();           // 이미지 숨기기
        }
    });  
    
    $('#model3').on('change', function () {
        const selectedOption = $(this).find('option:selected');
        const imgSrc = selectedOption.data('img');

        if (imgSrc && imgSrc !== "none_car.png" && imgSrc.trim() !== "") {
            $('#model3-img')
                .attr('src', imgSrc)
                .show(); // 이미지 보여주기
        } else {
            $('#model3-img')
                .removeAttr('src') // src 제거
                .hide();           // 이미지 숨기기
        }
    });  

    // 모델 선택 시 트림 로딩
    function loadTrims(modelId, trimId) {
        const model = $('#' + modelId).val();
        const $trimSelect = $('#' + trimId);

        if (model === "") {
            $trimSelect.html("<option value=''>트림 선택</option>");
            return;
        }

        $.ajax({
            url: 'getTrims.jsp',
            type: 'GET',
            data: {
            	model: model
            },
            dataType: 'json',
            success: function (trims) {
                $trimSelect.html("<option value=''>선택하세요</option>");
                $.each(trims, function (i, trim) {
                    const option = $('<option>')
                        .val(trim.title)
                        .text(trim.title);
                    $trimSelect.append(option);
                });
            }
        });
    }

    // 모달 열기
    function openModal(id) {
        $('#' + id).show();
    }

    // 모달 닫기
    function closeModal(id) {
        $('#' + id).hide();
    }

    // 차량 선택 처리
    function selectCar(num) {
        const maker = $('#maker' + num).val();
        const $modelSelect = $('#model' + num);
        const model = $modelSelect.val();
        const trim = $('#trim' + num).val();

        if (!maker || !model || !trim) {
            alert("제조사, 모델, 트림을 모두 선택하세요.");
            return;
        }

        const imgSrc = $modelSelect.find(':selected').data('img');

        $.ajax({
            url: 'getCarInfo.jsp',
            type: 'GET',
            data: { 
            	model: model,
            	trim: trim 
            },
            dataType: 'json',
            success: function (data) {
                const $car = $('.car').eq(num - 1);
                const $img = $car.find('img');
                const $td = $car.find('.car-info td');
                const carData = data[0];
                if (imgSrc && imgSrc.startsWith('http')) {
                    $img.attr('src', imgSrc);
                } else {
                    $img.attr('src', '../img/' + (imgSrc || 'model_200_100.png'));
                }
                $td.eq(0).text(carData.car_name);
                $td.eq(1).text(carData.trim);
                $td.eq(2).text(carData.price);
                $td.eq(3).text(carData.gas);
                $td.eq(4).text(carData.fuel);
                $td.eq(5).text(carData.output);
                $td.eq(6).text(carData.engine);
                $td.eq(7).text(carData.car_type);
                $td.eq(8).text(carData.exhaust);
                $td.eq(9).text(carData.torque);
                $td.eq(10).text(carData.length_width);
                $td.eq(11).text(carData.weight);
                $td.eq(12).text(carData.shift);

                closeModal("modal" + num);
            }
        });
    }
   /*  $("#model1").hover(function (e){
	     let target = $(e.target); 
	     if(target.is('option')){
	         alert(target.attr("id"));//Will alert id if it has id attribute
	         alert(target.text());//Will alert the text of the option
	         alert(target.val());//Will alert the value of the option
	     }
	}); */
</script>
		<%@ include file="../footer.jsp" %>
	</body>
</html>
