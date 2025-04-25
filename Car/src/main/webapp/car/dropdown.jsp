<%@page import="carInfo.CarVO"%>
<%@page import="java.util.List"%>
<%@page import="carInfo.CarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    CarDAO dao1 = new CarDAO();
    List<CarVO> company = dao1.company();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인 드롭다운</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<p>최근 본 차량 : 아반떼. 소나타</p>
<div id="dropdown">
<!-- 제조사 -->
<div class="custom-select" id="maker-select">
  <div class="select-selected">제조사 선택</div>
  <div class="select-items">
  <%for (int i = 0; i < company.size(); i ++){
	  CarVO car = company.get(i);
	  %>
	  <div data-value="<%= car.getNo() %>"><%=car.getCompany()%></div>
	  <%
  }
  %>
  
  
  
  
  
<%--     <div data-value="hyundai"><%=company%></div>
    <div data-value="kia">기아</div> --%>
  </div>
</div>

<!-- 모델 -->
	<div class="custom-select hidden" id="model-select">
	  <div class="select-selected">모델 선택</div>
	  <div class="select-items" id="model-options"></div>
	</div>
	
	<!-- 트림 -->
	<div class="custom-select hidden" id="trim-select">
	  <div class="select-selected">트림 선택</div>
	  <div class="select-items" id="trim-options"></div>
	</div>
	<div class="click">
		<button type="button" class="select-submit" id="search">검색</button>
	</div>
	</div>
</body>
<script>

	let tno = 0;
  const makerSelect = document.querySelector("#maker-select");
  //document.getElementById("maker-select")
  
  const makerSelected = makerSelect.querySelector(".select-selected");
  //document.getElementsByClassName("select-select")
  
  const makerItems = makerSelect.querySelector(".select-items");

  const modelSelect = document.querySelector("#model-select");
  const modelSelected = modelSelect.querySelector(".select-selected");
  const modelItems = document.querySelector("#model-options");

  const trimSelect = document.querySelector("#trim-select");
  const trimSelected = trimSelect.querySelector(".select-selected");
  const trimItems = document.querySelector("#trim-options");


  function toggleDropdown(selectedEl, itemsEl) {
    const isOpen = itemsEl.style.display === "block";
    itemsEl.style.display = isOpen ? "none" : "block";
    selectedEl.classList.toggle("open", !isOpen);
  }

  // 제조사 선택
  makerSelected.addEventListener("click", () => {
    toggleDropdown(makerSelected, makerItems);
  });

  makerItems.querySelectorAll("div").forEach(item => {
    item.addEventListener("click", () => {
    	tno = 0
      const maker = item.dataset.value;
      console.log(maker)
      makerSelected.textContent = item.textContent;
      makerItems.style.display = "none";
      makerSelected.classList.remove("open");

      // 모델 표시
      modelSelect.classList.remove("hidden");
      modelSelected.textContent = "모델 선택";
      modelItems.innerHTML = "";
      tno = 0;
      trimSelect.classList.add("hidden");
      trimSelected.textContent = "트림 선택";
      trimItems.innerHTML = "";
      trimSelected.classList.remove("open");
      
      //ajax요청 보내서 maker번에 해당하는 모델들 가져오기
      $.ajax({
    	  url : "modelok.jsp",
    	  type : "get",
    	  data : {
    		  no : maker
    	  },
    	  success : function(result){
    		  console.log(result)
    		  for (let i = 0; i < result.length; i ++) {
    			  const div = document.createElement("div");
    			  let data = result[i]
    			  div.textContent = data.car_name;
    			  div.dataset.value = data.mno;
    			  modelItems.appendChild(div);
    			  
    			  div.addEventListener("click", () => {
    				tno = 0
   		          modelSelected.textContent = data.car_name;
   		          modelItems.style.display = "none";
   		          modelSelected.classList.remove("open");
	   		       tno = 0;
	   		      trimSelect.classList.add("hidden");
	   		      trimSelected.textContent = "트림 선택";
	   		      trimItems.innerHTML = "";
	   		      trimSelected.classList.remove("open");
	   		      
    		      console.log(data.mno)
    		          $.ajax({
				    	  url : "trimok.jsp",
				    	  type : "get",
				    	  data : {
				    		  mno : data.mno
				    	  },
					 	  success : function(result2){
								console.log(result2)
								for (let i = 0; i < result2.length; i++){
									const trimDiv = document.createElement("div");
									let data = result2[i]
									trimDiv.textContent = data.trim;
									trimItems.appendChild(trimDiv);
									
									trimDiv.addEventListener("click", () => {
										console.log("트림 번호 : " + data.tno)
										tno = data.tno
										trimSelect.classList.remove("hidden");
						                trimSelected.textContent = data.trim;
						                trimItems.style.display = "none";
						                trimSelected.classList.remove("open");
							        });
								}
				    	  },error : function(xhr, status, error){
				    		    console.error("트림 에러:", status, error);
				    	  }
    		          })
    		          
    			  })
    		  }
    	  }
      })
      

    });
  });

  // 모델/트림 드롭다운 열기
  modelSelected.addEventListener("click", () => {
    toggleDropdown(modelSelected, modelItems);
  });

  trimSelected.addEventListener("click", () => {
    toggleDropdown(trimSelected, trimItems);
  });

  // 외부 클릭 시 닫기
  document.addEventListener("click", function(e) {
    if (!e.target.closest(".custom-select")) {
      document.querySelectorAll(".select-items").forEach(el => el.style.display = "none");
      document.querySelectorAll(".select-selected").forEach(el => el.classList.remove("open"));
    }
  });
  
  $("#search").click(function(){
	  //트림이 있을 때만
	  //tno 가져오기 0
	  //상세페이지 이동
	  if(tno && tno != 0){
		  location.href="carDetail.jsp?tno="+tno
	  }else{
		  alert("차량을 선택해주세요.")
	  }
  })
</script>
</html>


    