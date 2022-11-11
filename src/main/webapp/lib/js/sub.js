( function( $ ) {
	$( document ).ready(function() {
		var txt_y = '메뉴열림';
		var txt_n = '메뉴닫힘';
		$("#left_menu .has_sub ul a.on").closest("ul").css("display", "block");
		$("#left_menu .has_sub ul a.on").closest("#left_menu > ul > li.has_sub").addClass('active');
		$("#left_menu > ul > li > .util_line > span.util").html(txt_y);
		$("#left_menu > ul > li > .util_line > span.util").click(function() {
		  $("#left_menu li").removeClass("active");
		  $(this).closest("li").addClass("active");
		  var checkElement = $(this).parent().next();
		  if((checkElement.is("ul")) && (checkElement.is(":visible"))) {
			$(this).closest('li').removeClass("active");
			checkElement.slideUp("normal");
			$("span.util").html(txt_y);
		  }
		  if((checkElement.is("ul")) && (!checkElement.is(":visible"))) {
			$("#left_menu > ul > li > ul:visible").slideUp();
			checkElement.slideDown('normal');
			$("#left_menu > ul > li > .util_line > span.util").html(txt_n);
		  }
		  if($(this).closest('li').find('ul').children().length == 0) {
			return true;
		  } else {
			return false;	
		  }		
		});
$(".c_state ul li").hover(
  function() {
   $(this).find("img").animate({scale:"+=0.2"}, 300);
  },
  function() {
   $(this).find("img").animate({scale:"-=0.2"}, 300);
  }
 );
$(".report").toggle(function() {
		$(this).attr("src","/images/board/report_on.gif");
		$(".report_insert").css("display", "block");
	}, function() {
		$(this).attr("src","/images/board/report_off.gif");
		$(".report_insert").css("display", "none");
	});
//left menu
$('#left_menu li a.on').parent("li").next("li").children("a").addClass("off");

	});
} )( jQuery );
$(document).ready(function () {

var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
    center: new daum.maps.LatLng(37.258258, 127.031193), //지도의 중심좌표.
    level: 3, //지도의 레벨(확대, 축소 정도)
    draggable: false,
    scrollwheel: false,
    disableDoubleClick: true,
    disableDoubleClickZoom: true
};

var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
// 지도에 마커를 표시합니다
var marker = new daum.maps.Marker({
    map: map,
    position: new daum.maps.LatLng(37.258258, 127.031193)
});
// 커스텀 오버레이에 표시할 컨텐츠 입니다
var content = '<div class="map_wrap">' +
    '    <div class="map_info">' +
    '        <div class="map_title">' +
    '            (주)미디어코어시스템즈' +
    '        </div>' +
    '        <div class="body">' +
    '            <div class="map_desc">' +
    '                <div class="ellipsis">경기도 수원시 팔달구 권선로 731 삼부르네상스빌딩 2층</div>' +
    '                <div class="jibun ellipsis">(우) 16491 (지번) 인계동 1135-8</div>' +
    '            </div>' +
    '        </div>' +
    '    </div>' +
    '</div>';

// 마커 위에 커스텀오버레이를 표시합니다
// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
var overlay = new daum.maps.CustomOverlay({
    content: content,
    map: map,
    position: marker.getPosition()
});
});