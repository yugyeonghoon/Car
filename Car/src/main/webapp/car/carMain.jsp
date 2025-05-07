<%@page import="java.util.ArrayList"%>
<%@page import="carView.carViewVO"%>
<%@page import="carView.carViewDAO"%>
<%@page import="carInfo.CarVO"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    CarDAO dao = new CarDAO();
	List<CarVO> list = new ArrayList<>();
    List<carViewVO> carViewList = new ArrayList<>();
    
    UserVO userVO = (UserVO)session.getAttribute("user");
    
    if(userVO != null){
        String id = userVO.getId();
        String carType = userVO.getCarType();
		list = dao.carView(id, carType);
    }else{
    	list = dao.carView();
    }
    
    if(userVO != null){
        carViewDAO carViewDAO = new carViewDAO();
        carViewList = carViewDAO.viewList(userVO.getId());
    }

%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="title" content="자동차의 다양한 정보를 확인하자 | 차량생각">
	    <meta name="description" content="차량생각에서 다양한 차량정보와 실 사용자들의 현실적인 리뷰를 만나보세요.">
	    <meta name="Keywords" content="자동차, 자동차 평가, 자동차 제원, 제원, 차량비교, 자동차 리뷰">
	    <meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv="Pragma" content="no-cache" />
	    <meta property="og:type" content="website">
	    <meta property="og:url" content="http://localhost:8080/Car/car/carMain.jsp">
	    <meta property="og:title" content="자동차의 다양한 정보를 확인하자 | 차량생각"> 
	    <meta property="og:image" content="">
	    <meta property="og:site_name" content="차량생각">
	    <meta property="og:description" content="차량생각에서 다양한 차량정보와 실 사용자들의 현실적인 리뷰를 만나보세요." />
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <title>자동차의 다양한 정보를 확인하자 | 차량생각</title>
	    <link rel="stylesheet" href="../css/font2.css">
	    <style>
	        #dropdown {
	            margin-bottom: 50px;
	            display: flex;
	            justify-content: center;
	            align-items: center;
	        }
	        .custom-select {
	            position: relative;
	            width: 300px;
	            margin-bottom: 20px;
	            display: inline-block;
	        }
	        .select-selected, .select-submit {
	            background-color: #fff;
	            padding: 10px;
	            border: 1px solid #ccc;
	            cursor: pointer;
	        }
	        .select-items {
	            position: absolute;
	            top: 100%;
	            left: 0;
	            right: 0;
	            background-color: #fff;
	            border: 1px solid #ccc;
	            border-top: none;
	            z-index: 99;
	            display: none;
	            max-height: 200px;
	            overflow-y: auto;
	        }
	        .select-items div {
	            padding: 10px;
	            cursor: pointer;
	        }
	        .select-items div:hover {
	            background-color: #f1f1f1;
	        }
	        .select-selected:after {
	            content: "▼";
	            float: right;
	        }
	        .select-selected.open:after {
	            content: "▲";
	        }
	        .click {
	            margin-bottom: 20px;
	            display: inline-block;
	            position: relative;
	        }
	        .select-submit {
	            width: 150px;
	            height: 43.44px;
	        }
	        #content {
	            margin: 100px auto;
	            width: 1400px;
	            position: relative;
	        }
	        .car {
	            width: 100%;
	            border: none;
	            transition: transform 0.2s;
	            border-radius: 8px;
	            overflow: hidden;
	            background-color: #fff;
	            padding: 10px;
	        }
	        .car img {
	            width: 105%;
	            height: 320px;
	            object-fit: contain;
	            display: block;
	            margin: auto;
	        }
	        .car:hover {
	            transform: scale(1.05);
	        }
	        .car-title {
	            text-align: center;
	            font-size: 1rem;
	            font-weight: 500;
	            margin-top: -3.5rem;
	        }
	        .carousel-control-prev,
	        .carousel-control-next {
	            width: 10%;
	            z-index: 10;
	        }
	        .carousel-control-prev-icon,
	        .carousel-control-next-icon {
	            background-color: rgba(0, 0, 0, 0.5);
	            border-radius: 50%;
	        }
	        .carousel-inner {
	            padding: 0 60px;
	        }
	        .modal {
	            display: none;
	            position: fixed;
	            z-index: 9999;
	            left: 0;
	            top: 100px;
	            width: 100%;
	            height: 100%;
	            background-color: rgba(0,0,0,0.5);
	        }
	        .modal-content {
	            background-color: white;
	            position: absolute;
	            top: 50%;
	            left: 50%;
	            transform: translate(-50%, -50%);
	            width: 100%;
	            max-width: 600px;
	            height: 605px;
	            border-radius: 10px;
	            overflow: hidden;
	        }
	        .close {
	            position: absolute;
	            right: 15px;
	            top: 5px;
	            font-size: 20px;
	            cursor: pointer;
	            color: white;
	        }
	        .carList {
	            display: flex;
	            justify-content: center;
	            margin-bottom: 10px;
	        }
	        
	    </style>
	</head>
	<body class="abody">
	<%@include file="../header.jsp" %>
	<div id="content">
	    <div class="carList">
	    <% if(user != null){
	    	%>
	        <span>최근 본 차량 목록:&nbsp;</span>
				<% for(int i = 0; i < carViewList.size(); i++){ %>
					<% carViewVO vo = carViewList.get(i); %>
					<span>
            			<a class="atag" href="carDetail.jsp?tno=<%= vo.getCarTno() %>"><%= vo.getCarName() %></a>
							<% if (i != carViewList.size() - 1) { %>
							,&nbsp;
							<% } %>
        			</span>
				<% } %>
	        <%
	        }
	        %>
	    </div>
	    <%@include file="dropdown.jsp" %>
	
	    <div id="carCarousel" class="carousel slide" data-bs-ride="carousel">
	        <div class="carousel-inner">
	            <% int size = list.size(); int chunk = 3; for (int i = 0; i < size; i += chunk) { %>
	            <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
	                <div class="row g-4">
	                    <% for (int j = i; j < i + chunk && j < size; j++) {
	                        CarVO car = list.get(j); %>
	                        <div class="col-md-4">
	                            <div class="car">
	                                <a href="carDetail.jsp?tno=<%=car.getTno()%>">
	                                    <img src="<%= car.getCar_img() %>" alt="...">
	                                    <div class="car-title">
	                                       <a class="atag" href="carDetail.jsp?tno=<%=car.getTno()%>"><%= car.getCar_name() %></a>
	                                    </div>
	                                </a>
	                            </div>
	                        </div>
	                    <% } %>
	                </div>
	            </div>
	            <% } %>
	        </div>
	        <button class="carousel-control-prev" type="button" data-bs-target="#carCarousel" data-bs-slide="prev" style="width: 4%;">
	            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	        </button>
	        <button class="carousel-control-next" type="button" data-bs-target="#carCarousel" data-bs-slide="next" style="width: 4%;">
	            <span class="carousel-control-next-icon" aria-hidden="true"></span>
	        </button>
	    </div>
	</div>
	<!-- 챗봇 열기 버튼 -->
	<div onclick="openChatModal()" style="position: fixed; bottom: 250px; right: 20px; cursor: pointer; z-index: 10000;">
	    <img src="../img/icons8-챗봇-48.png" alt="챗봇 열기">
	</div>
	<!-- 챗봇 모달 -->
	<div id="chatbot-modal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closeChatModal()">&times;</span>
	        <iframe src="../bot/bot.jsp" style="width: 100%; height: 100%; border: none; border-radius: 10px;"></iframe>
	    </div>
	</div>
		<%@include file="../footer.jsp" %>
	<script>
	function openChatModal() {
	    document.getElementById("chatbot-modal").style.display = "block";
	}
	function closeChatModal() {
	    document.getElementById("chatbot-modal").style.display = "none";
	}
	window.onclick = function(event) {
	    const modal = document.getElementById("chatbot-modal");
	    if (event.target === modal) {
	        modal.style.display = "none";
	    }
	}
	</script>
	</body>

</html>