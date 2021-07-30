<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String id = (String) session.getAttribute("idKey");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/fullpage.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/fullpage.js"></script>
<script type="text/javascript" src="js/header.js"></script>
</head>
<body>
<div class="wrapper mainWrapper">
		<div class="header type03">
			<div class="headArea">
				<strong class="logo"><a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp;	RESORTS</a></strong>
				<button type="button" class="btnMenu">메뉴 열기</button>
				<div class="allMenu">
					<!-- 화면 높이값 계산 height:적용, body:overflow:hidden -->
					<div class="inner">
						<ul class="menuDepth01">
							<li>BRAND STORY
								<ul class="menuDepth02">
									<li><a href="/ProjectWepJosun/brandStory.jsp">그랜드 조선 제주</a></li>
								</ul>
							</li>
							<li>EVENT & NOTICE
								<ul class="menuDepth02">
									<li><a href="/ProjectWepJosun/event_noticeList.jsp">EVENT & NOTICE</a></li>
								</ul>
							</li>
							<li>RESERVATION
								<ul class="menuDepth02">
									<li><a href="/ProjectWepJosun/memberReservation.jsp">예약확인</a></li>
								</ul>
							</li>
							<li>CUSTOMER SERVICE
								<ul class="menuDepth02">
									<li><a href="/ProjectWepJosun/qna.jsp">Q&amp;A</a></li>
									<li><a href="reviewboard?command=reviewmain">REVIEW</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<!-- //allMenu -->
				<div class="gnbUtil">
					<ul>
						<%if(id == null || id == ""){%>
						<li><a href="Login?url=<%= request.getServletPath() %>">로그인</a></li>
						<li><a href="Join">회원가입</a></li>
						<%}else if(id.equals("admin")){ %>
						<li><a href="Logout">로그아웃</a></li>
						<li><a href="/ProjectWepJosun/memberReservation.jsp">마이페이지</a></li>
						<li><a href="/ProjectWepJosun/Controller?command=adminMemberList">관리자페이지</a></li>
						<%}else{ %>
						<li><a href="Logout">로그아웃</a></li>
						<li><a href="/ProjectWepJosun/memberReservation.jsp">마이페이지</a></li>
						<%} %>
					</ul>
				</div>
				<!-- //gnbUtil -->
			</div>
		</div><!-- End. header -->
		<div id="fullpage"><!-- Start. fullPage -->
			<div class="section"><!-- Start. mainArea01 -->
				<div class="mainArea01">
					<div class="contents">
						<div class="mainBg">
							<img src="img/01.main/01.main_HOME/01.main_HOME.jpg" alt="Experience the Difference">
						</div>				
						<div class="mainTxt">
							<strong>Experience the Difference<span>Grand Josun Jeju</span></strong>
						</div>
					</div>
				</div>
			</div><!-- End. mainArea01 -->
			<div class="section"><!-- Start. mainArea02 -->
				<div class="mainArea02">
					<div class="contents swiper-container mySwiper">
						<!-- swiper -->
						<div class="swiper-wrapper">
							<div class="swiper-slide"
								style="background: url(img/01.main/02.main_HOTELS/02.main_HOTELS.jpg)">
								<div class="homeBox">
									<div class="cont">
										<strong class="tit">Meet Our Hotel</strong>
										<span class="sTit">HERITAGE LEADS TO ONE FOR ALL</span>
										<ul class="hList lg9">
											<li class="hType09"><a href="#none">조선팰리스</a></li>
											<li class="hType01"><a href="#none">웨스틴 조선 서울</a></li>
											<li class="hType03"><a href="#none">웨스틴 조선 부산</a></li>
											<li class="hType02"><a href="#none">그랜드 조선 부산</a></li>
											<li class="hType07"><a href="#none">그랜드 조선 제주</a></li>
											<li class="hType05"><a href="#none">레스케이프 호텔</a></li>
											<li class="hType08"><a href="#none">그래비티 서울 판교</a></li>
											<li class="hType04"><a href="#none">포포인츠 바이 쉐라톤 조선 서울역</a></li>
											<li class="hType06"><a href="#none">포포인츠 바이 쉐라톤 조선 명동</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="swiper-slide"
								style="background: url(img/01.main/02.main_HOTELS/bg_main01_02.jpg)">
								<div class="homeBox">
									<div class="cont">
										<strong class="tit">Meet Our Hotel</strong> 
										<span class="sTit">HERITAGE LEADS TO ONE FOR ALL</span>
										<p class="txt01">
											어디서나 한결같이 품격있는 서비스와 시설로<br>고객에게 깊은 감동을 주는 호텔
										</p>
										<p class="txt02">
											균형있는 라이프스타일을 추구하며 품격의 가치를 아는 고객을 위해<br>세련되고 모던한 감각을 지닌
											안락한 객실과 세심한 배려가 묻어나는 서비스를 준비합니다.<br>조선호텔앤리조트에서 품격 있는 휴식을
											즐기실 수 있습니다.
										</p>
										<a href="#none" class="btnSC btnM">VIEW MORE</a>
									</div>
								</div>
							</div>
						</div>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
					</div>
				</div>
				<!-- Swiper JS -->
				<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
				<!-- Initialize Swiper -->
				<script>
					var swiper = new Swiper(".mySwiper", {
						allowTouchMove: false,
						effect: "fade",
						loop: false,
						navigation : {
							nextEl : ".swiper-button-next",
							prevEl : ".swiper-button-prev",
						},
					});
				</script>
			</div><!-- End. mainArea02 -->
			<div class="section"><!-- Start. mainArea03 -->
				<div class="mainArea03">
					<div class="inner">
						<strong class="titDep1">Club Josun</strong>
						<p class="txt">품격 있는 서비스와 다채로운 라이프 스타일을 선사하는<br>조선호텔앤리조트의 통합 멤버십 프로그램, 클럽조선(CLUB JOSUN)<br>지금 회원만을 위한 특별한 혜택과 경험을 확인해보세요.</p>
					</div>
				</div>
			</div><!-- End. mainArea03 -->
			<div class="section"><!-- Start. mainArea05 -->
				<script>
				function changeBg(bimg){
					var mainArea05bg = document.getElementsByClassName('mainArea05');
					mainArea05bg[0].style.backgroundImage="url(" + bimg + ")";
				}
				</script>
				<div class="mainArea05">
					<div class="contBox">
						<div class="txtArea">
							<strong class="titDep1">Retail Business</strong>
							<p class="txt">조선호텔앤리조트의 라이프 스타일 브랜드<br>호스피탈리티 전문성을 바탕으로 확장한 라이프 스타일 브랜드를 소개합니다.
							</p>
						</div>
						<div class="obList">
							<ul>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/1.png" alt="호경전" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/1bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/2.png" alt="호무랑" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/2bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/3.png" alt="호경전 IN 뱅커스클럽" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/3bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/4.png" alt="JAJU TABLE" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/4bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/5.png" alt="조선호텔 김치" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/5bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/6.png" alt="Kyukmul Gongboo" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/6bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/7.png" alt="Jane Packer" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/7bg.jpg')"></li>
								<li class="obList"><img src="img/01.main/04.main_RETAILBUSINESS/8.png" alt="State Tower" onmouseover="changeBg('img/01.main/04.main_RETAILBUSINESS/8bg.jpg')"></li>
							</ul>
						</div>
					</div>
				</div>
			</div><!-- End. mainArea05 -->
			<div class="section"><!-- Start. mainArea06 -->
				<div class="mainArea06">
					<div class="inner">
						<strong class="titDep1">Brands</strong>
						<ul class="brandList">
							<li><img src="img/01.main/05.main_BRAND/1.png" alt="조선 팰리스"></li>
							<li><img src="img/01.main/05.main_BRAND/2.png" alt="서울 웨스틴조선 호텔"></li>
							<li><img src="img/01.main/05.main_BRAND/3.png" alt="부산 웨스틴조선 호텔"></li>
							<li><img src="img/01.main/05.main_BRAND/4.png" alt="그랜드 조선 부산"></li>
							<li><img src="img/01.main/05.main_BRAND/5.png" alt="그랜드 조선 제주"></li>
							<!-- 20200924 추가 -->
							<li><img src="img/01.main/05.main_BRAND/6.png" alt="레스케이프 호텔"></li>
							<li><img src="img/01.main/05.main_BRAND/7.png" alt="그래비티 서울 판교"></li>
							<!-- 20200924 추가 -->
							<li><img src="img/01.main/05.main_BRAND/8.png" alt="포포인츠 바이 쉐라톤 조선 서울역"></li>
							<li><img src="img/01.main/05.main_BRAND/9.png" alt="포포인츠 바이 쉐라톤 조선 명동"></li>
							<li><img src="img/01.main/05.main_BRAND/10.png" alt="호경전 in 뱅커스클럽"></li>
							<li><img src="img/01.main/05.main_BRAND/11.png" alt="호무랑"></li>
							<li><img src="img/01.main/05.main_BRAND/12.png" alt="호경전"></li>
							<li><img src="img/01.main/05.main_BRAND/13.png" alt="JAJU TABLE"></li>
							<li><img src="img/01.main/05.main_BRAND/14.png" alt="조선호텔 김치"></li>
							<li><img src="img/01.main/05.main_BRAND/15.png" alt="Kyukmul Gongboo"></li>
							<li><img src="img/01.main/05.main_BRAND/16.png" alt="Jane Packer"></li>
							<li><img src="img/01.main/05.main_BRAND/17.png" alt="State Tower"></li>
						</ul>
					</div>
				</div>
			</div><!-- End. mainArea06 -->
			<div class="section fp-auto-height" style="background:#000;"><!-- Start. footer -->
				<div id="footer">
					<div class="foot-logo"><img src="img/01.main/bg_logo_footer.png" alt="그랜드 조선 제주"></div>
					<div class="foot-txt">
						서울시 중구 소공로 106 대표이사 한채양 T. 02-771-0500<br>
						사업자등록번호 104-81-27386 통신판매신고번호 중구 0623호<br>
						2020 JOSUN HOTELS &amp; RESORTS Co. All rights reserved.
					</div>
				</div>
			</div><!-- End. footer -->
		</div><!-- End. fullPage -->
		<script>
		function searchFn(){
			if(""==$('#date1').attr('value') || ""==$('#date2').attr('value')){
				alert("날짜를 선택해주세요.");
			}else{
				var date = $('#datetxt').text();
				var adltCntArr = $('#adltCntArr').val();
				var chldCntArr = $('#chldCntArr').val();
				if(chldCntArr == 0){
					if(confirm("예약일 : " + date + "\n객실수 : 1개\n인원수 : 성인 " + adltCntArr + "명\n해당 날짜로 예약하시겠습니까?")){
						//alert("확인");
						$('#mainResveForm').submit();
					}else{
						return false;
					}
				}else{
					if(confirm("예약일 : " + date + "\n객실수 : 1개\n인원수 : 성인 " + adltCntArr + "명, 어린이 "+ chldCntArr +"명\n해당 날짜로 예약하시겠습니까?")){
						//alert("확인");
						$('#mainResveForm').submit();
					}else{
						return false;
					}
				}
			}
		}
		</script>
		<div id="reservation" class="revArea">
			<form id="mainResveForm" name="mainResveForm" method="post" action="Controller">
				<input type="hidden" name="command" value="searchRoom">
				<input type="hidden" name="ckinDate" id="date1" value="">
				<input type="hidden" name="ckoutDate" id="date2" value="">
				<div class="selectRoom" role="area">
					<div class="selectHotel">
						<strong class="tit">HOTEL</strong>
						<span class="hotelName" id="hotelName">그랜드 조선 제주</span>
					</div>
					<div class="chkInout">
						<a href="#none" id="datebtn"> 
							<strong class="tit">CHECK IN / OUT</strong> 
							<span class="date" id="datetxt">날짜를 선택해주세요.</span>
						</a>
						<!-- Start. mainCalendar -->
						<div id="datepicker"></div>
						<!-- End. mainCalendar -->
					</div>
					<script type="text/javascript">
					$.datepicker._defaults.onAfterUpdate = null;
					var datepicker__updateDatepicker = $.datepicker._updateDatepicker;
					$.datepicker._updateDatepicker = function( inst ) {
					   datepicker__updateDatepicker.call( this, inst );
					   var onAfterUpdate = this._get(inst, 'onAfterUpdate');
					   if (onAfterUpdate)
					      onAfterUpdate.apply((inst.input ? inst.input[0] : null),
					         [(inst.input ? inst.input.val() : ''), inst]);
					}
					$(function() {
						var cur = -1, prv = -1;
						$('#datepicker').datepicker({
							dateFormat: 'yy.mm.dd',
						    prevText: '이전 달',
						    nextText: '다음 달',
						    monthNames: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
						    monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
						    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
						    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
						    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
						    showMonthAfterYear: true,
						    yearSuffix: '.',
							minDate:0, //최소날짜 지정, 0 : today 이전에는 선택 X
							numberOfMonths : 2, //2개월로 표시
							changeMonth : false, //개월 선택
							changeYear : false, //년도 선택
							showButtonPanel : true, //버튼 패널 추가
							beforeShowDay : function(date) {
								return [
									true, ((date.getTime() >= Math.min(prv, cur) && date.getTime() <= Math.max(prv, cur)) ? 'date-range-selected': '')
								];
								if (date1.getTime() || date2.getTime()) {
							          return [true, 'ui-red', ''];
							        }
								
							},
							//날짜 선택할 경우
							onSelect : function(dateText, inst) {
								var d1, d2;
								prv = cur;
								cur = (new Date(inst.selectedYear, inst.selectedMonth, inst.selectedDay)).getTime();
								if (prv == -1 || prv == cur) {
									prv = cur;
									$('#date1').val(dateText);
								} else {
									d1 = $.datepicker.formatDate('yy.mm.dd', new Date(Math.min(prv, cur)), {});
									d2 = $.datepicker.formatDate('yy.mm.dd', new Date(Math.max(prv, cur)), {});
									$('#date1').val(d1);
									$('#date1').attr('value', d1);
									$('#date2').val(d2);
									$('#date2').attr('value', d2);
									$('#datetxt').text(d1  + ' - ' + d2);
									$('#datepicker').fadeOut('fast');
								}
							},
							onChangeMonthYear : function(year, month, inst) {
								//prv = cur = -1;
							},
							onAfterUpdate: function ( inst ) {
				                $('<button type="button" class="ui-datepicker-close ui-state-default ui-priority-primary ui-corner-all" data-handler="hide" data-event="click">Done</button>')
				                   .appendTo($('#datepicker .ui-datepicker-buttonpane'))
				                   .on('click', function () { 
				                	   	$('#datepicker').fadeOut('fast');
				                	   	//if($('#reservation').hasClass('first')){
				                	   		//$('#reservation').removeClass('on').css({'margin-top': '55px'});
				                	   	//}
				                	});
				             }
				       }).position({
				          my: 'left top',
				          at: 'left bottom',
				          of: $('#datetxt')
				       }).hide();
						$('#datebtn').click('focus', function (e) {
							//if($('#reservation').hasClass('first')){
								//$('#reservation').addClass('on').css({'margin-top': '210px'});
	                	   	//}
							
							var v = this.value, d;
					         try {
					            if ( v.indexOf(' - ') > -1 ) {
					               d = v.split(' - ');
					               prv = $.datepicker.parseDate( 'yy.mm.dd', d[0] ).getTime();
					               cur = $.datepicker.parseDate( 'yy.mm.dd', d[1] ).getTime();

					            } else if ( v.length > 0 ) {
					               prv = cur = $.datepicker.parseDate( 'yy.mm.dd', v ).getTime();
					            }
					         } catch ( e ) {
					            cur = prv = -1;
					         }
					         if ( cur > -1 ){
					            $('#datepicker').datepicker('setDate', new Date(cur));
					         }
					         $('#datepicker').datepicker('refresh').fadeIn('fast');
					   	});
					});
					</script>
					<div class="roomWrap">
						<a href="#none" id="roomcnt"> <span class="rBox"> <strong
								class="tit">ROOM</strong> <span id="roomCntText">1</span>
						</span> <span class="rBox"> <strong class="tit">ADULT</strong> <span
								id="adultCntText">2</span>
						</span> <span class="rBox"> <strong class="tit">CHILDREN</strong>
								<span id="childCntText">0</span>
						</span>
						</a>
						<!-- 클릭 시 하단 mainRoom 펼쳐짐 -->
						<div class="mainRoom clearCont">
							<div class="roomContainer">
								<div class="roomWrap">
									<div class="roomSel on">
										<div class="roomInner">
											<strong class="roomTit">객실1</strong>
											<div class="numWrap" data-roomnum="1">
												<div class="numPeople" data-target="adult">
													<input type="hidden" id="adltCntArr" name="adltCntArr" value="2">
													<button type="button" class="btnDown">인원 수 감소</button>
													<span>성인 <em>2</em></span>
													<button type="button" class="btnUp">인원 수 증가</button>
												</div>
												<div class="numPeople" data-target="child">
													<input type="hidden" id="chldCntArr" name="chldCntArr" value="0">
													<button type="button" class="btnDown">인원 수 감소</button>
													<span>어린이 <em>0</em></span>
													<button type="button" class="btnUp">인원 수 증가</button>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- //roomWrap -->
								<ul class="txtGuide">
									<li>성인 최대 3명까지 가능</li>
									<li>어린이 최대 2명까지 가능</li>
									<li id="ageTxtGuide">어린이 기준 : 37개월 ~ 만 12세</li>
								</ul>
								<button type="button" class="btnSC btnL peopleCheck">
									확인
									<!-- 확인 -->
								</button>
							</div>
							<button type="button" class="btnClose">닫기</button>
						</div>
						<!-- //mainRoom -->
					</div>
					<button type="button" class="btnSC btnSearch" onclick="searchFn(); return false;">SEARCH</button>
				</div>
			</form>
		</div>
	</div><!-- 전체 감싸기 -->
</body>
</html>