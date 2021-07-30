$(document).ready(function () {
	//객실 상세보기 팝업창 닫기버튼
	$('#layerPopup .btnClose').click(function(){
		$('#tab01 ul').empty();
		$('#tab02 ul').empty();
		$('#tab03 ul').empty();
		$('#tab04 ul').empty();
		$('#layerPopup .scrollWrap').scrollTop(0);
		$('#layerPopup').fadeOut('fast');
	});
	
	
	//비교함 열기/닫기
	var compCont = $('.compCont');
	var contIsOpen = false;
	var speed = 80;
	//비교함 보이기
	$('.roomIntro .btnRsv2').on('click',function(){
		if($(this).hasClass('on')){
			$(this).removeClass('on');
		}else{
			$(this).addClass('on');
			contIsOpen = true;
			$('.comparison').show();
			compCont.css({
				'display':'block',
				'height':'296px'
			});
			$('.btnComp').addClass('on');
		}
	});

	$('.btnComp').on('click', function (e) {
        if (compCont.is(':visible')) {
        	//close
            compCont.css({'display': 'block', 'overflow': 'hidden'}).stop().animate({
                    'height': 0
                }, speed, function () {
                    compCont.css({'display': 'none', 'overflow': '', 'height': ''})
                });
            $('.btnComp').removeClass('on');
            contIsOpen = false;
        } else {
            //open
            compCont.css({'display': 'block', 'overflow': 'hidden', 'height': '0'}).stop().animate({
                    'height': '296px'
                }, speed, function () {
                    compCont.removeAttr('style');
                });
            $('.btnComp').addClass('on');
            contIsOpen = true;
        }
    });
    
    //비교함 스크롤 이벤트
    $(window).on('scroll',function() {
    	var footerScrollT = $('body > div > div:nth-child(3)').offset().top; //footer offset.top 값
    	var footerScrollH = $('body > div > div:nth-child(3)').height(); //footer 높이값
    	var scrollT = $(this).scrollTop();
    	var scrollH = $(this).height();
    	var scrollBar = scrollT + scrollH;
    	//펼쳐져있으면 닫기
    	if(contIsOpen){
    		//펼쳤을 때, + footer높이
    		scrollBar += footerScrollH;
    		if(footerScrollT >= scrollBar){
    			//close
    			compCont.css({'display': 'block', 'overflow': 'hidden'}).stop().animate({
    				'height': 0
    			}, speed, function () {
    				compCont.css({'display': 'none', 'overflow': '', 'height': ''});
    			});
    			$('.btnComp').removeClass('on');
    			contIsOpen = false;
    		}
    	}
    	if(footerScrollT <= scrollBar){  // "0개 비교하기"가 떠있도록 표시./ footer는 이때 보이도록. 
    		$('.comparison').css({'position': 'relative'});
    	}else{	// "0개 비교하기"가 바닥에 붙어서 표시.
    		$('.comparison').css({'position': 'fixed'});
    	}
    });
});


$(window).on('load', function () {
	commonJs.initTab('.tabToggle');
});

var commonJs = {};
this.commonJs = commonJs;
/**
 * 탭
 * @param tabToggle (string) .tabToggle 클래스가 존재해야만 토글 스크립트 작동.
 */
commonJs.initTab = function (tabToggle) {
    $(tabToggle).each(function (idx, itm) {
        var _itm = $(itm);
        if (!_itm.hasClass('tabToggle')) {
            return;
        };
        var contList = _itm.nextUntil($('.tabToggle'), '.tabCont');
        _itm
            .find('li>a')
            .on('click', function (e) {
                e.preventDefault();

                $(this)
                    .closest('li')
                    .addClass('on')
                    .siblings('li')
                    .removeClass('on');
                contList.hide();

                if ($(this).attr('href') != '#') {
                    $('.tabCont' + $(this).attr('href')).show();
                }
            });
    });
};

