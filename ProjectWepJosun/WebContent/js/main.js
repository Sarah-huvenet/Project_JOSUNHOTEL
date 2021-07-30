$(document).ready(function () {
	//전체 페이지 스크롤 이동
	$('#fullpage').fullpage({
		licenseKey:"OPEN-SOURCE-GPLV3-LICENSE",
		autoScrolling:true,
		scrollHorizontally: true,
		scrollBar:true,
		scrollingSpeed: 800,
		menu:"#menu",
		onLeave: function(origin, destination, direction){
			if(destination.index == 0 && direction == 'down'){
				$('#reservation').css({
					'transform':'translateY(0px)'
				});
			}else{
				$('#reservation').fadeOut('fast');
			}
			
			if(destination.index == 1 && direction == 'down') {
				$('#reservation').css({
					'transform':'translateY(150px)'
				});
			}else{
				$('#reservation').fadeOut('fast');
			}
			
			if(destination.index == 0 && direction == 'up'){
				$('#reservation').css({
					'transform':'translateY(0px)'
				});
			}
		},
		
		afterLoad: function(origin, destination, direction){
			var loadedSection = this;

			//using index
			if(destination.index == 0){
				$('#reservation').fadeIn('fast').addClass('first');
			}else if(destination.index == 1) {
				$('#reservation').fadeIn('fast').removeClass('first');
			}
			
			if(destination.index == 2 || destination.index == 4  || destination.index == 5){
				//alert("2번으로");
				$('.header').addClass('type02');
				if(destination.index == 2){
					$('.mainArea03 .inner').addClass('moveDown');					
				}
			}else if(destination.index != 2 || destination.index != 4 || destination.index != 5){
				$('.header').removeClass('type02');
				if(destination.index != 2){
					$('.mainArea03 .inner').removeClass('moveDown');					
				}
			}
		}
	});
	
	//메인섹션 5
	$('.mainArea05 .contBox .obList ul li').mouseover(function(){
		$(this).addClass('on');
	});
	
	$('.mainArea05 .contBox .obList ul li').mouseleave(function(){
		$(this).removeClass('on');
	});	
	
	//인원수 선택
	$('#roomcnt').click(function(){
		$('.revArea .mainRoom').fadeIn('fast');
	});
	
	//-를 클릭할때 1씩 감소, 성인은 무조건 1명이상
	$('.numPeople button.btnDown').click(function(){
		var target = jQuery(this).closest(".numPeople").data("target"); //성인, 어린이 여부
		var adltNum = $(".numPeople input[name='adltCntArr']").val(); //현재 성인 인원수 값
		var chldNum = $(".numPeople input[name='chldCntArr']").val(); //현재 어린이 인원수 값
		
		//성인 1이 될때까지만 1씩 감소
		if(target == "adult" && adltNum != 1){ //성인 영역 && 1이 아니라면
			adltNum--;
			$(".numPeople input[name='adltCntArr']").val(adltNum);
			$(this).next().children().text(adltNum);
			$('#adultCntText').text(adltNum);
		}
		
		//어린이 0이 될때까지만 1씩 감소
		if(target == "child" && chldNum != 0){ //어린이 영역 && 0이 아니라면
			chldNum--;
			$(".numPeople input[name='chldCntArr']").val(chldNum);
			$(this).next().children().text(chldNum);
			$('#childCntText').text(chldNum);
		}
	});
	
	//+를 클랙할때 1씩 증가, 성인과 어린이가 총 4명일때 까지만
	$('.numPeople button.btnUp').click(function(){
		var target = jQuery(this).closest(".numPeople").data("target"); //성인, 어린이 여부
		var adltNum = $(".numPeople input[name='adltCntArr']").val(); //현재 성인 인원수 값
		var chldNum = $(".numPeople input[name='chldCntArr']").val(); //현재 어린이 인원수 값
		
		//성인 3 될때까지만 1씩 증가
		if(target == "adult" && adltNum != 3){ //성인 영역 && 3 아니고
			adltNum++;
			$(".numPeople input[name='adltCntArr']").val(adltNum);
			$(this).prev().children().text(adltNum);
			$('#adultCntText').text(adltNum);
		}
		
		//어린이 2 될때까지만 1씩 증가
		if(target == "child" && chldNum != 2){ //어린이 영역 && 2가 아니라면
			chldNum++;
			$(".numPeople input[name='chldCntArr']").val(chldNum);
			$(this).prev().children().text(chldNum);
			$('#childCntText').text(chldNum);
		}
	});

	$('.peopleCheck').click(function(){
		$('.revArea .mainRoom').fadeOut('fast');
	});
	
	$('.btnClose').click(function(){
		$('.revArea .mainRoom').fadeOut('fast');
	});
});


