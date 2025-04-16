<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
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
    		.car-wrapper {
			    display: flex;
			    gap: 30px;
			    max-width: 1200px;
			    margin: 0 auto;
			    padding: 20px;
			    background: white;
			    border-radius: 10px;
			    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
			}
				
			.car-image img {
			    width: 300px;
			    border-radius: 8px;
			    object-fit: cover;
			}
			
			.car-info-box {
			    flex: 2;
			}
			
			.car-rating-box {
			    flex: 1;
			}
					
		    .car-container {
		        flex: 1;
		        min-width: 400px;
	            margin: 0 auto;
	            padding: 20px;
	            background-color: white;
	            border-radius: 10px;
	            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
	        .card-title {
  color: #343a40;
}
.card-text {
  font-size: 16px;
}
.list-group-item {
  font-size: 15px;
  padding: 0.5rem 1rem;
}
</style>
</head>
<body>
<div class="container my-4">
  <div class="row g-4">
  
    <!-- 차량 상세 정보 카드 -->
    <div class="col-lg-8">
      <div class="card shadow-sm">
        <div class="row g-0">
          <div class="col-md-5">
            <img src="https://search.pstatic.net/common?quality=75&direct=true&ttype=input&src=https%3A%2F%2Fdbscthumb-phinf.pstatic.net%2F5662_000_74%2F20250415103120800_H0Q5YTNQ0.png%2F20250415102117_a.png%3Ftype%3Dm1500" alt="포스터" id="posterImage" class="poster">
          </div>
          <div class="col-md-7">
            <div class="card-body">
              <h5 class="card-title fw-bold" id="carTitle">현대 아반떼 하이브리드</h5>
              <p class="card-text text-muted mb-2" id="carModel">준중형 세단 2026</p>
              
              <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>가격:</strong> 2,523~3,184만원</li>
                <li class="list-group-item"><strong>연료:</strong> 가솔린, 하이브리드</li>
                <li class="list-group-item"><strong>연비:</strong> 복합 19.2~21.1km/</li>
                <li class="list-group-item"><strong>출력:</strong> 141hp/105hp</li>
                <li class="list-group-item"><strong>토크:</strong> 15kg.m</li>
                <li class="list-group-item"><strong>배기:</strong> 1,580cc</li>
                <li class="list-group-item"><strong>엔진:</strong> I4</li>
                <li class="list-group-item"><strong>구동:</strong> FF</li>
                <li class="list-group-item"><strong>변속:</strong> DCT6단</li>
                <li class="list-group-item"><strong>전장:</strong> 4,710mm</li>
                <li class="list-group-item"><strong>전고:</strong> 1,420mm</li>
                <li class="list-group-item"><strong>전폭:</strong> 1,825mm</li>
                <li class="list-group-item"><strong>축거:</strong> 2,720mm</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 차량 종합 평가 카드 -->
    <div class="col-lg-4">
      <div class="card shadow-sm h-100">
        <div class="card-body">
          <h5 class="card-title fw-bold">차량 종합 평점</h5>
          <p class="card-text">평점: <span id="rating">2</span>/10</p>
          <hr>
          <p><strong>주행:</strong> 2</p>
          <p><strong>가격:</strong> 2</p>
          <p><strong>거주성:</strong> 2</p>
          <p><strong>품질:</strong> 2</p>
          <p><strong>디자인:</strong> 2</p>
          <p><strong>연비:</strong> 2</p>
        </div>
      </div>
    </div>

  </div>
</div>
		<div class="table">
		  <h4>👍 긍정적인 피드백</h4>
		  <table class="table table-success table-bordered">
		    <thead><tr><th>내용</th></tr></thead>
		    <tbody>
		      <tr><td>디자인이 세련되고 만족스러워요.</td></tr>
		      <tr><td>연비가 기대 이상입니다.</td></tr>
		    </tbody>
		  </table>
		  <h4>👎 부정적인 피드백</h4>
		  <table class="table table-danger table-bordered">
		    <thead><tr><th>내용</th></tr></thead>
		    <tbody>
		      <tr><td>실내 소음이 다소 큽니다.</td></tr>
		      <tr><td>가격이 조금 비싼 편입니다.</td></tr>
		    </tbody>
		  </table>
		</div>
</body>
</html>