<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 --> 
<%String id = (String) session.getAttribute("idKey");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약확인 | 그랜드 조선 호텔</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href=css/default.css>
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/memberReservation.css"/>
<link rel="stylesheet" href="css/Reserve-SelectBox.css"/>
<!-- <script type="text/javascript" src="js/jquery.nice-select.js"></script> -->
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script>
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
		
		//ALL selectBox
		//$(".my_select_reserve").niceSelect();
		
		$('#searchCtgry').on("change",function(){
			console.log(this.value);
			if(this.value == "RESERVED"){
				var lilength = $('.cardList li.reserved').length;
				$('.listBox .countList .count em').text(lilength);
				$('.cardList li.canceled').hide();
				$('.cardList li.reserved').show();
			}else if(this.value == "CANCELED"){
				var lilength = $('.cardList li.canceled').length;
				$('.listBox .countList .count em').text(lilength);
				$('.cardList li.reserved').hide();
				$('.cardList li.canceled').show();
			}else{
				var lilength = $('.cardList li').length;
				$('.listBox .countList .count em').text(lilength);
				$('.cardList li.reserved').show();
				$('.cardList li.canceled').show();
			}
		});
		
		//달력
	     //datepicker 한국어로 사용하기 위한 언어설정
	     $.datepicker.setDefaults($.datepicker.regional['ko']);     
	     
	     //datepicker 옵션
	     $.datepicker.setDefaults({
	    	 dateFormat: 'yy-mm-dd',	//날짜 포맷이다. 보통 yy-mm-dd 를 많이 사용하는것 같다.
	    	 prevText: 'Prev',	// 마우스 오버시 이전달 텍스트
	    	 nextText: 'Next',	// 마우스 오버시 다음달 텍스트
	    	 monthNames: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],	//한글 캘린더중 월 표시를 위한 부분
	    	 monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],	//한글 캘린더 중 월 표시를 위한 부분
	    	 dayNames: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],	//한글 캘린더 요일 표시 부분
	    	 dayNamesShort: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],	//한글 요일 표시 부분
	    	 dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],	// 한글 요일 표시 부분
	    	 //closeText: false, // 닫기 버튼 텍스트 변경
	         currentText: '', // 오늘 텍스트 변경
	    	 showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
	    	 yearSuffix: '.',	//
	     });
	     
	     // Datepicker            
	     $(".datepicker").datepicker({
	         //showButtonPanel: true,
	         dateFormat: "yy-mm-dd",
	         onClose : function ( selectedDate ) {
	         
	             var eleId = $(this).attr("id");
	            // var optionName = "";
	
	             if(eleId.indexOf("StartDate") > 0) {
	                 eleId = eleId.replace("StartDate", "EndDate");
	                 //optionName = "minDate";
	             } else {
	                 eleId = eleId.replace("EndDate", "StartDate");
	                 //optionName = "maxDate";
	             }
	             //$("#"+eleId).datepicker( "option", optionName, selectedDate );  
	             $("#"+eleId).datepicker( "option", selectedDate );        
	             $(".searchDate").find(".chkbox2").removeClass("on"); 
	
	         }
	     }); 
	     $(".dateclick").dateclick();    // DateClick
	     $(".searchDate").schDate();        // searchDate
	});
	
	// Search Date
	jQuery.fn.schDate = function(){
	    var $obj = $(this);
	    var $chk = $obj.find("input[type=radio]");
	    $chk.click(function(){                
	        $('input:not(:checked)').parent(".chkbox2").removeClass("on");
	        $('input:checked').parent(".chkbox2").addClass("on");                    
	    });
	};
	
	// DateClick
	jQuery.fn.dateclick = function(){
	    var $obj = $(this);
	    $obj.click(function(){
	        $(this).parent().find("input").focus();
	    });
	};
	
	function setSearchDate(start) {
		//m1, m3, m6
		var num = start.substring(0, 1);
		var str = start.substring(1, 2);

		var number = Number(num);
		var today;
		
		if($("#searchStartDate").val() == ""){
			alert("날짜를 선택해주세요.");
		}else{
			today = new Date($("#searchStartDate").datepicker({dateFormat:"yy-mm-dd"}).val());

			var endDate = $.datepicker.formatDate('yy-mm-dd', today);
			$('#searchStartDate').val(endDate);
	
			if (str == 'm') {
				today.setMonth(today.getMonth() + number);
				today.setDate(today.getDate() + 1);
			}
	
			var startDate = $.datepicker.formatDate('yy-mm-dd', today);
			$('#searchEndDate').val(startDate);
	
			// 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
			//$("#searchEndDate").datepicker("option", "minDate", startDate);
	
			// 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
			//$("#searchStartDate").datepicker("option", "maxDate", endDate);
		}

	};
</script>
<script>
	function deleteReservation(num, roomNumber){
		var startDate = $(".cardList li.data"+num+"").find('#startDate').val();
		var endDate = $(".cardList li.data"+num+"").find('#endDate').val();
		console.log(num + ", " + startDate);
		if(confirm('예약을 취소하시겠습니까?')){
			$.ajax({
				type : 'POST',
				url : 'SearchReserveCancleServlet',
				data : {num : num, roomNumber : roomNumber, startDate : startDate, endDate : endDate},
				datatype : 'JSON',
				success : function(data){
					console.log("result : " + data.result);
					if(data.result > 1){
						$('.data'+num+' button').removeClass('active');
						$('.data'+num+' button').attr('onclick','');
					}
				}
			})
		}else{
			return false;
		}
	}
</script>
</head>
<body>
<%
	if(session.getAttribute("idKey")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입 또는 로그인 후 확인 가능합니다.')");
		script.println("location.href = 'login.jsp?url="+request.getServletPath()+"'");
		script.println("</script>");
	}
%>
<div class="wrapper">
	<div class="header">
		<!-- 메뉴 열리면 gnbOn 클래스 추가 -->
		<div class="headArea">
			<strong class="logo"><a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp; RESORTS</a></strong>
			<button type="button" class="btnMenu">메뉴 열기</button>
			<!-- 클릭하면 menuOn 클래스 추가, 메뉴 닫기 텍스트 변경 -->
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
					<%if(id.equals("admin")){%>
					<li><a href="Logout">로그아웃</a></li>
					<li><a href="/ProjectWepJosun/memberReservation.jsp">마이페이지</a></li>
					<li><a href="/ProjectWepJosun/Controller?command=adminMemberList">관리자페이지</a></li>
					<%}else{%>
					<li><a href="Logout">로그아웃</a></li>
					<li><a href="/ProjectWepJosun/memberReservation.jsp">마이페이지</a></li>
					<%}%>
				</ul>
			</div>
			<!-- //gnbUtil -->
		</div>
	</div>
	<!-- End. header -->
	<div id="container" class="container">
		<div class="topArea">
			<div class="topInner">
				<h2 class="titDep1">My Page</h2>
				<p class="pageGuide">멤버십 회원을 위한 다양한 혜택이 준비되어 있습니다.</p>
			</div>
		</div>
	
		<div class="inner">
			<div class="lnbArea">
				<div class="myInfo">
					<p class="name">
						<a href="#"><em id="nm1"><%= session.getAttribute("nameKey") %>  </em>님</a>
					</p>
				</div>
				<ul class="lnb">
					<li>예약확인
						<ul>
							<li><a href="/ProjectWepJosun/memberReservation.jsp">객실 · 예약 내역</a></li>
						</ul>
					</li>
					<li>개인정보관리
						<ul>
							<li><a href="/ProjectWepJosun/memberModify.jsp">회원 정보 수정 </a></li>
							<li><a href="/ProjectWepJosun/memberPwChange.jsp">비밀번호 변경</a></li>
							<li><a href="/ProjectWepJosun/memberDelete1.jsp">회원 탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<script>
				function fncSearch(){
					var searchStartDate = $('#searchStartDate').val();
					var searchEndDate = $('#searchEndDate').val();
					if(searchStartDate == "" || searchEndDate == ""){
						alert('날짜를 선택해주세요.');
					}else{
						$('.cardList li').remove(); //list 안에 태그 지움
						$("#searchCtgry option:eq(0)").prop("selected", true);
						var html = "";
						$.ajax({
							type :'POST',
							url : 'SearchReserveServlet',
							data : {'searchStartDate':searchStartDate, 'searchEndDate':searchEndDate},
							datatype:'JSON',
							success : function(data){
								var listtest = data.list;
								if(listtest.length == 0){
									html += "<li class=\'noData'\>";
									html += "<p class=\'txt'\>검색 결과가 없습니다.</p>";
									html += "</li>";
									$('.cardList').append(html);
									$('.listBox .countList .count em').text(listtest.length);
								}else{
									$.each(listtest, function(){
										if(this.username == "#"){
											html += "<li class=\'data data"+this.num+" canceled'\>";
											html += "<div class=\'left'\>";
											html += "<div class=\'thum'\><img src="+this.img+"></div>";
											html += "</div>";
											html += "<div class=\'right'\>";
											html += "<div class=\'contents'\>";
											html += "<p class=\'title'\>"+this.name+"</p>";
											html += "<p class=\'benefit'\>"+this.detailView+" | Size : "+this.rSize+"㎡</p>";
											html += "</div>";
											html += "<div class=\'mycontents'\>";
											html += "<p class=\'checkDate'\><span>CHECK IN / OUT</span>"+this.startDate.substring(0,10).replaceAll("-", ".")+" - "+this.endDate.substring(0,10).replaceAll("-", ".")+"</p>";
											html += "<p class=\'adult'\><span>ADULT</span>"+this.adult+"</p>";
											html += "<p class=\'children'\><span>CHILDREN</span>"+this.children+"</p>";
											html += "</div>";
											html += "<div class=\'reserveinfo'\>";
											html += "<p class=\'price'\>"+this.totalPay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"<span> KRM</span></p>";
											html += "<button type=\'button'\ class=\'btnSC btnL'\ style=\'cursor: inherit;'\>예약취소</button>";
											html += "</div>";
											html += "</div>";
											html += "</li>";
										}else{
											html += "<li class=\'data data"+this.num+" reserved'\>";
											html += "<input type=\'hidden'\ id=\'startDate'\ value=\'"+this.startDate.substring(0,10).replaceAll("-", ".")+"'\>";
											html += "<input type=\'hidden'\ id=\'endDate'\ value=\'"+this.endDate.substring(0,10).replaceAll("-", ".")+"'\>";
											html += "<div class=\'left'\>";
											html += "<div class=\'thum'\><img src="+this.img+"></div>";
											html += "</div>";
											html += "<div class=\'right'\>";
											html += "<div class=\'contents'\>";
											html += "<p class=\'title'\>"+this.name+"</p>";
											html += "<p class=\'benefit'\>"+this.detailView+" | Size : "+this.rSize+"㎡</p>";
											html += "</div>";
											html += "<div class=\'mycontents'\>";
											html += "<p class=\'checkDate'\><span>CHECK IN / OUT</span>"+this.startDate.substring(0,10).replaceAll("-", ".")+" - "+this.endDate.substring(0,10).replaceAll("-", ".")+"</p>";
											html += "<p class=\'adult'\><span>ADULT</span>"+this.adult+"</p>";
											html += "<p class=\'children'\><span>CHILDREN</span>"+this.children+"</p>";
											html += "</div>";
											html += "<div class=\'reserveinfo'\>";
											html += "<p class=\'price'\>"+this.totalPay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"<span> KRM</span></p>";
											html += "<button type=\'button'\ class=\'btnSC btnL active'\ onclick=\'deleteReservation("+this.num+","+this.roomNumber+")'\>예약취소</button>";
											html += "</div>";
											html += "</div>";
											html += "</li>";
										}
									});
									$('.cardList').append(html);
									$('.listBox .countList .count em').text(listtest.length);
								}
							}
						});
					}
				}
			</script>
			<!-- My Contents -->
			<div class="myContents">
				<h3 class="titDep2">예약확인</h3>
				<form autocomplete="off" method="post" id="searchReserveForm" name="searchReserveForm" action="SearchReserveServlet">
		        	<div class="searchBox">
		        		<div class="searchOp">
							<span class="hidden">기간 조회</span>
							<div class="period">
								<span class="hidden">날짜선택</span> 
	                        	<span class="intArea">
	                            	<input type="text" class="datepicker inpType" name="searchStartDate" id="searchStartDate" style="width: 143px;">
	                            	<a href="#none" class="btncalendar dateclick"></a>
	                        	</span>
	                        	<span class="hBar">-</span>
	                        	<!-- 종료일 -->
	                        	<span class="intArea">
	                            	<input type="text" class="datepicker inpType" name="searchEndDate" id="searchEndDate" style="width: 143px;">
	                            	<a href="#none" class="btncalendar dateclick"></a>
	                        	</span>
	                    	</div>   
	                    	<div class="frmList periodOp">
	                    		<ul class="searchDate">
	                    			<li>
			                        	<span class="chkbox2">
			                            	<input type="radio" id="dateType5" name="dateType" onclick="setSearchDate('1m')"/>
			                            	<label for="dateType5">1개월</label>
			                        	</span>
			                        	<span class="chkbox2">
			                            	<input type="radio" id="dateType6" name="dateType" onclick="setSearchDate('3m')"/>
			                            	<label for="dateType6">3개월</label>
			                        	</span>
			                        	<span class="chkbox2">
			                            	<input type="radio" id="dateType7" name="dateType" onclick="setSearchDate('6m')"/>
			                            	<label for="dateType7">6개월</label>
			                        	</span>
		                        	</li>
	                        	</ul>
	                    	</div>
	                	</div>
						<div class="btnWrap" style="text-align: center">
							<button type="button" class="btnSC btnM" onclick="fncSearch();">기간조회</button>
						</div>
						<ul class="txtGuide">
							<li>온라인 예약 건에 한하여 조회가 가능하며, 현재일 기준 1년까지 제공됩니다.</li>
							<li>예약날짜 기준으로 현재부터 3개월 이후의 예약 내역이 우선 조회됩니다.</li>
							<li>과거 또는 미래의 예약내역을 조회하시려면 상단의 날짜를 변경해주십시오.</li>
							<li>레스케이프는 레스케이프 홈페이지에서 예약 확인이 가능합니다.</li>
							<li>메리어트 브랜드의 예약 내역은 해당 사이트에서 조회하실 수 있습니다.</li>
						</ul>
					</div>
		        </form>
				<div class="listBox">
					<div class="countList">
						<span class="count">총 <em>0</em>건</span>
						<div class="selectWrap" style="width: 200px;">
							<select id="searchCtgry" name="searchCtgry" title="목록정렬" data-height="150px">
								<option value="ALL">ALL</option>
								<option value="RESERVED">RESERVED</option>
								<option value="CANCELED">CANCELED</option>
							</select>
							<!-- <div class="ui-selectmenu-menu ui-front">
								<div class="tweenDiv">
									<ul aria-hidden="true" aria-labelledby="searchCtgry-button" id="searchCtgry-menu" role="listbox" tabindex="0"
										class="ui-menu ui-corner-bottom ui-widget ui-widget-content" style="max-height: 150px;">
									</ul>
								</div>
							</div> -->
						</div>
					</div>
					<ul class="cardList reserveInfo">
						<!-- 검색결과 출력 부분 -->
						<li class='noData'>
							<p class='txt'>검색 결과가 없습니다.</p>
						</li>
					</ul>
				</div>
	        </div>
		</div>
		<div class="dimmed"></div>
		<!-- Start. footer -->
		<div style="background: #000;">
			<div id="footer">
				<div class="foot-logo">
					<img src="img/01.main/bg_logo_footer.png" alt="그랜드 조선 제주">
				</div>
				<div class="foot-txt">
					서울시 중구 소공로 106 대표이사 한채양 T. 02-771-0500<br> 사업자등록번호 104-81-27386
					통신판매신고번호 중구 0623호<br> 2020 JOSUN HOTELS &amp; RESORTS Co. All
					rights reserved.
				</div>
			</div>
		</div>
		<!-- End. footer -->
	</div>
</div>
</body>
</html>