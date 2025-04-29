$(document).ready(function () {
  // 모달 띄우기
  //header의 dropdown-item 클래스 클릭했을 때
  $('.dropdown-item').click(function (event) {
    const url = $(this).data('url');
    if (url) {
      event.preventDefault(); // 링크 이동 막기

      // ajax로 JSP 내용 불러와서 모달에 삽입
      $('#modal-body').load(url, function () {
        $('#modal').fadeIn(); // 모달 보이기
      });
    }
  });

  // 모달 닫기 (X 버튼 클릭 시)
  $('.close').click(function () {
    $('#modal').fadeOut();
  });

  // 모달 바깥 영역 클릭 시 닫기
  $(window).click(function (event) {
    if ($(event.target).is('#modal')) {
      $('#modal').fadeOut();
    }
  });
});
