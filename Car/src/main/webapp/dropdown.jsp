<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인 드롭다운</title>
</head>
<body>
<div id="dropdown">
<!-- 제조사 -->
<div class="custom-select" id="maker-select">
  <div class="select-selected">제조사 선택</div>
  <div class="select-items">
    <div data-value="hyundai">현대</div>
    <div data-value="kia">기아</div>
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
		<button type="submit" class="select-submit">검색</button>
	</div>
	</div>
</body>
<script>
  const makerSelect = document.querySelector("#maker-select");
  const makerSelected = makerSelect.querySelector(".select-selected");
  const makerItems = makerSelect.querySelector(".select-items");

  const modelSelect = document.querySelector("#model-select");
  const modelSelected = modelSelect.querySelector(".select-selected");
  const modelItems = document.querySelector("#model-options");

  const trimSelect = document.querySelector("#trim-select");
  const trimSelected = trimSelect.querySelector(".select-selected");
  const trimItems = document.querySelector("#trim-options");

  // 데이터 구조
  const carData = {
    hyundai: {
      아반떼: ["더 뉴 아반떼", "더 뉴 아반떼 하이브리드", "아반떼 하이브리드", 
    	  	"아반떼", "더 뉴 아반떼 AD", "아반떼 AD", "더 뉴 아반떼", "아반떼 쿠페",
    	  	"아반떼 MD", "아반떼 하이브리드"],
      쏘나타: ["모던", "인스퍼레이션"]
    },
    kia: {
      K3: ["프레스티지", "노블레스"],
      K5: ["프레스티지", "시그니처"]
    }
  };

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
      const maker = item.dataset.value;
      makerSelected.textContent = item.textContent;
      makerItems.style.display = "none";
      makerSelected.classList.remove("open");

      // 모델 표시
      modelSelect.classList.remove("hidden");
      modelSelected.textContent = "모델 선택";
      modelItems.innerHTML = "";
      trimSelect.classList.add("hidden");
      trimSelected.textContent = "트림 선택";
      trimItems.innerHTML = "";

      for (let model in carData[maker]) {
        const div = document.createElement("div");
        div.textContent = model;
        div.dataset.value = model;
        modelItems.appendChild(div);

        div.addEventListener("click", () => {
          modelSelected.textContent = model;
          modelItems.style.display = "none";
          modelSelected.classList.remove("open");

          // 트림 표시
          trimSelect.classList.remove("hidden");
          trimSelected.textContent = "트림 선택";
          trimItems.innerHTML = "";

          carData[maker][model].forEach(trim => {
            const trimDiv = document.createElement("div");
            trimDiv.textContent = trim;
            trimItems.appendChild(trimDiv);

            trimDiv.addEventListener("click", () => {
              trimSelected.textContent = trim;
              trimItems.style.display = "none";
              trimSelected.classList.remove("open");
            });
          });
        });
      }
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
</script>
</html>


    