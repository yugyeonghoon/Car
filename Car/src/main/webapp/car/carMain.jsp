<%@page import="carLike.carLikeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="carView.carViewVO"%>
<%@page import="carView.carViewDAO"%>
<%@page import="carInfo.CarVO"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String tno = request.getParameter("tno");
    CarDAO dao = new CarDAO();
    List<CarVO> list = dao.carView();
    
    List<carViewVO> carViewList = new ArrayList<>();
    
    UserVO userVO = (UserVO)session.getAttribute("user");
    if(userVO != null){
    	
    	String id = userVO.getId();
    	carViewDAO carViewDAO = new carViewDAO();
    	carViewList = carViewDAO.viewList(id);
    }
    
    System.out.println(carViewList.size());
    
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>차량 메인</title> 
    <style>
	   	#dropdown {
			/* height: 1000px; */
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
		    max-height: 200px;   /* 드롭다운 최대 높이 */
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
		  .hidden {
		    /* display: none; */
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
        .carImg {
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
        
        /* 모달창 css */
        .modal {
		  display: none;
		  position: fixed;
		  z-index: 9999;
		  left: 0;
		  top: 0;
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
		  padding: 30px;
		  width: 100%;
		  max-width: 400px;
		  border-radius: 10px;
		  box-sizing: border-box;
		  display: flex;
		  flex-direction: column;
		}
		
		.close {
		  position: absolute;
		  right: 15px;
		  top: 10px;
		  font-size: 20px;
		  cursor: pointer;
		}
		span {
			align-items: center;
		}
		.carList {
			display: flex;
  			justify-content: center;
  			margin-bottom: 10px;
		}
    </style>
</head>
<body>
<%@include file="../header.jsp" %>
<div id="content">
<!-- <p>최근 본 차량 목록: 현대 더 뉴 아반떼, 현대 더 뉴 아반떼 하이브리드</p> -->
<div class="carList">
	<span>최근 본 차량 목록:&nbsp;</span>
<%
	for(int i = 0; i < carViewList.size(); i++){
		carViewVO vo = carViewList.get(i);
		String carName = vo.getCarName();
		String carTno = vo.getCarTno();
		%>
			<span><a href="carDetail.jsp?tno=<%=carTno%>"><%= carName %></a>,&nbsp;</span>
		<%
	}
%>
</div>
    <%@include file="dropdown.jsp" %>

    <div id="carCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <%
                int size = list.size();
                int chunk = 3;
                for (int i = 0; i < size; i += chunk) {
            %>
            <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
                <div class="row g-4">
                    <% for (int j = i; j < i + chunk && j < size; j++) {
                        CarVO car = list.get(j); %>
                        <div class="col-md-4">
                            <div class="car">
                                <a href="carDetail.jsp?tno=<%=car.getTno()%>">
                                    <img src="<%= car.getCar_img() %>" alt="..." class="carImg">
                                    <div class="car-title">
                                        <%= car.getCompany() %> <%= car.getCar_name() %>
                                    </div>
                                </a>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
        </button>
    </div>
</div>
<!-- 모달 창 -->
	<div id="modal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
   			<div id="modal-body"></div>
		</div>
	</div>
<%@include file="../footer.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../js/modal.js" defer></script>
</html>
