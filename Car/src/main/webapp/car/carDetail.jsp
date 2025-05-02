<%@page import="carFeedback.CarFeedbackVO"%>
<%@page import="java.util.List"%>
<%@page import="carFeedback.CarFeedbackDAO"%>
<%@page import="carView.carViewVO"%>
<%@page import="carView.carViewDAO"%>
<%@page import="rating.RatingVO"%>
<%@page import="rating.RatingDAO"%>
<%@page import="carInfo.CarVO"%>
<%@page import="carInfo.CarDAO"%>
<%@page import="user.UserVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String tno = request.getParameter("tno");
	System.out.println(tno);
	
	CarDAO dao = new CarDAO();
	CarVO vo = dao.carDetail(tno);
	String title = vo.getCar_name();
	RatingDAO rdao = new RatingDAO();
	RatingVO rvo = rdao.selectRating(tno);
	
	UserVO users = (UserVO)session.getAttribute("user");
	System.out.println(users);
	if(users != null){
		carViewDAO carViewDao = new carViewDAO();
		carViewVO carViewVo = new carViewVO();
		
		String userId = users.getId();
		String carName = vo.getCar_name();
		
		carViewVo.setUserId(userId);
		carViewVo.setCarTno(tno);
		carViewVo.setCarName(carName);
		
		carViewDao.viewInsert(carViewVo);
	}
	//getAttribute는 항상 Object로 반환
	
    String cardStyle = "width: 65%"; // 기본 width 

    if (rvo.getRating() != null && rvo.getRating().trim().equals("평점없음")) {
        cardStyle = "width: 98%"; //평점없음일때
    }
    
    CarFeedbackDAO fdao = new CarFeedbackDAO();
    List<CarFeedbackVO> goodList = fdao.goodfeedback(tno);
    List<CarFeedbackVO> badList = fdao.badfeedback(tno);
    List<CarFeedbackVO> feddbackList = fdao.feedback(tno);
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>차량 상세 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<%@ include file="../header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js 추가 -->
<style>
	body{
		font-family: Arial, sans-serif;
		/* margin: 20px; */
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
	    width: 100px;
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
		border : none;
      }		       
	div.table {
       	padding: 20px;
       	border : none;
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
	.poster {
		width: 100%;
		height: 100%;
		max-width: 100%;
		max-height: 500px;
		object-fit: contain;
		display: block;
		margin: auto;
		border-radius: 8px;
	}
	.card-body p {
		margin-bottom: 0.3rem;
		font-size: 15px;
	}
	.card-body hr {
		margin: 0.5rem 0;
	}
	.trim-box {
		width: 30%;
		padding: 5px;
		border: 1px solid #ccc;
		border-radius: 8px;
		font-size: 15px;
		outline: none;
		transition: border-color 0.2s;
	}
	
	.table>:not(:last-child)>:last-child>* {
	    border-bottom-color: #bcd0c7;

	}
	.table-bordered>:not(caption)>*>* {
		text-align: left;
		font-size: 1rem;
	}
</style>
</head>
<body>
<div class="container my-4">
  <div class="row g-4">
  
    <!-- 차량 상세 정보 카드 -->
    <div class="col-lg-8" style="<%= cardStyle %>">
      <div class="card shadow-sm">
        <div class="row g-0">
          <div class="col-md-5">
            <img src="<%=vo.getCar_img() %>" alt="포스터" id="posterImage" class="poster">
          </div>
          <div class="col-md-7">
            <div class="card-body">
              <h5 class="card-title fw-bold" id="carTitle"><%=vo.getCar_name() %></h5>
              <p class="card-text text-muted mb-2" id="carModel"><%=vo.getCar_type() %>, <%=vo.getYear() %></p>
              
              <ul class="list-group list-group-flush">
                	<li class="list-group-item"><strong>가격:</strong> <%= vo.getPrice() %></li>
					<li class="list-group-item"><strong>연료:</strong> <%= vo.getGas() %></li>
					<li class="list-group-item"><strong>출력:</strong> <%= vo.getOutput() %></li>
					<li class="list-group-item"><strong>토크:</strong> <%= vo.getTorque() %></li>
					<li class="list-group-item"><strong>배기:</strong> <%= vo.getExhaust() %></li>
					<li class="list-group-item"><strong>엔진:</strong> <%= vo.getEngine() %></li>
					<li class="list-group-item"><strong>과급방식:</strong> <%= vo.getCompressor() %></li>
					<li class="list-group-item"><strong>변속:</strong> <%= vo.getShift() %></li>
					<li class="list-group-item"><strong>전장/전폭:</strong> <%= vo.getLength_width() %></li>
					<li class="list-group-item"><strong>차량 무게:</strong> <%= vo.getWeight() %></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
<%
   // null 체크 후 trim() 사용
   if (rvo.getRating() != null && rvo.getRating().trim().equals("평점없음") == false) {
%>
    <!-- 차량 종합 평가 카드 -->
    <div class="col-lg-4">
      <div class="card shadow-sm h-100">
        <div class="card-body">
          <h5 class="card-title fw-bold">차량 종합 평점</h5>
          <p class="card-text">평점: <span id="rating"><%= rvo.getRating() %>/10</span>
          <span> 참여인원: <%= rvo.getRating_people() %></span></p>
          <hr>
          <div class="row row-cols-2">
            <div class="col"><strong>주행:</strong> <%= rvo.getDrive() %></div>
            <div class="col"><strong>가격:</strong> <%= rvo.getPrice() %></div>
            <div class="col"><strong>거주성:</strong> <%= rvo.getHabitability() %></div>
            <div class="col"><strong>품질:</strong> <%= rvo.getQuality() %></div>
            <div class="col"><strong>디자인:</strong> <%= rvo.getDesign() %></div>
            <div class="col"><strong>연비:</strong> <%= rvo.getFuel() %></div>
          </div>
          <div class="my-4">
            <canvas id="carRadarChart" width="350px" height="250px"></canvas> <!-- 차트 크기 줄이기 -->
          </div>
        </div>
      </div>
    </div>
	<%
	   }
	%>
	</div>
	<% if(goodList != null && !goodList.isEmpty()){%>
	<div class="row mt-4">
    <div class="col-md-6">
		  <h4><%= title %>의 장점</h4>
		  <table class="table table-success table-bordered">
		    <tbody>
		    <%for(int i = 0; i < goodList.size(); i++){
		    	CarFeedbackVO fvo = goodList.get(i);
		    	String content = fvo.getContent();
		    	%>
					<tr><td><%=fvo.getContent() %></td></tr>
		    	<%
		    }
		    %>
		    </tbody>
		  </table>
		  </div>
		  <div class="col-md-6">
		  <h4><%= title %>의 단점</h4>
		  <table class="table table-warning table-bordered">
		    <tbody>
		    <%for(int i = 0; i < badList.size(); i++){
		    	CarFeedbackVO fvo = badList.get(i);
		    	String content = fvo.getContent();
		    	%>
					<tr><td><%=fvo.getContent() %></td></tr>
		    	<%
		    }
		    %>
		    </tbody>
		</table>
		</div>
		  <div class="row mt-4">
    		<div class="col-12">
			<h4><%= title %>의 개선점</h4>
			<table class="table table-danger table-bordered">
				<tbody>
					<%for(int i = 0; i < feddbackList.size(); i++){
						CarFeedbackVO fvo = feddbackList.get(i);
						String content = fvo.getContent();
					%>
						<tr><td><%=fvo.getContent() %></td></tr>
					<%
					}
					%>
				</tbody>
		  </table>
			</div>
		</div>
	</div>
	<%
	}else{%>
	<br>
	<br>
		<h4>해당 차량의 리뷰가 없습니다.</h4>
		<%
	}%>
	<div>
	
	</div>
</div>

</body>
<script>
  let data = [<%=rvo.getDrive() %>,<%=rvo.getPrice() %>,<%=rvo.getHabitability() %>,<%=rvo.getQuality() %>,<%=rvo.getDesign() %>,<%=rvo.getFuel() %>];
  data = data.map(value => Math.max(0, Math.min(10, value)));

  let chartData = {
    labels: ['주행', '가격', '거주성', '품질', '디자인', '연비'],
    datasets: [{
      label: '<%= vo.getCar_name() %> 차량 평가',
      data: data,
      backgroundColor: 'rgba(255, 108, 61, 0.2)',
      borderColor: 'rgba(255, 108, 61, 1)',
      borderWidth: 2
    }]
  };

  let chartOptions = {
    responsive: false,
    scales: {
      r: {
        beginAtZero: true,
        min: 0,
        max: 10,
        ticks: {
          stepSize: 2,
          display: true,
          color: "#333"
        },
        pointLabels: {
          font: {
            size: 10,
            weight: '700',
            family: 'Arial'
          },
          color: '#333'
        },
        angleLines: {
          display: false
        }
      }
    },
    plugins: {
      legend: {
        display: true
      }
    }
  };

  if (window.radarChartInstance) {
    window.radarChartInstance.destroy();
  }

  let ctx = document.getElementById('carRadarChart').getContext('2d');
  window.radarChartInstance = new Chart(ctx, {
    type: 'radar',
    data: chartData,
    options: chartOptions
  });
</script>

<!--<script type="importmap">
      {
        "imports": {
          "@google/generative-ai": "https://esm.run/@google/generative-ai"
        }
      }
    </script>
    <script type="module">
      import { GoogleGenerativeAI } from "@google/generative-ai";

      // Fetch your API_KEY
      const API_KEY = "AIzaSyBJhJikEu7eUy_qxqtxttTaqXu1aYoG-I4";
      // Reminder: This should only be for local testing

      // Access your API key (see "Set up your API key" above)
      const genAI = new GoogleGenerativeAI(API_KEY);

      // ...

      // The Gemini 1.5 models are versatile and work with most use cases
      const model = genAI.getGenerativeModel({ model: "gemini-2.0-flash"});

	  const prompt = "최적의 연비로 안정감 있는 승차 넓고 쾌적한 드라이빙으로 손색없는 한국의 최고의 자랑 차량입니다" + " 이런 리뷰들이 있는데 이 차량에 대한 피드백과 개선점을 정리해서 줘 "

		const result = await model.generateContent(prompt);
  		const response = await result.response;
  		const text = response.text();
  		console.log(text);

      // ...
    </script>  -->
<!-- <script>
let param = [{"parts":[{"text": "최적의 연비로 안정감 있는 승차 넓고 쾌적한 드라이빙으로 손색없는 한국의 최고의 자랑 차량입니다" + " 이런 리뷰들이 있는데 이 차량에 대한 피드백과 개선점을 정리해서 줘 "}]}]; 
$.ajax({
	url : "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyBJhJikEu7eUy_qxqtxttTaqXu1aYoG-I4",
	type : "post",
	data : {
		contents : param
	},
	success : function(result){
		console.log(result)
	},
	error : function(){
		alert("에러!")
	}
})
</script> -->
</html>