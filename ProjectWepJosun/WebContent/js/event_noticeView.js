$(document).ready(function () {	
	//코드 작성 영역
	//윈도우 높이 구하기
	$('.allMenu').css({
		'height' : $(window).outerHeight()
	});

	//헤더 메뉴
	$('.header .btnMenu').click(function(){
		$(this).toggleClass('menuOn');
		$('.header').toggleClass('gnbOn');
		$('body').toggleClass('over');
		$('.allMenu').slideToggle();
	});
	
});
