<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%String id = (String) session.getAttribute("idKey");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BRAND STORY | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/brandStory.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
</head>
<body>
<!-- 전체감싸는 .wrapper -->
<div class="wrapper">
	<!-- Start. header -->
	<div class="header">
		<!-- 메뉴 열리면 gnbOn 클래스 추가 -->
		<div class="headArea">
			<strong class="logo"><a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp; RESORTS</a></strong>
			<button type="button" class="btnMenu">메뉴 열기</button>
			<!-- 클릭하면 menuOn 클래스 추가, 메뉴 닫기 텍스트 변경 -->
			<!-- //20200709 수정 -->
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
	</div>
	<!-- End. header -->
	<!-- Start. container -->
	<div class="container brand" id="container">
		<script>
    		function fnMove(){
        		var offset = $("#intro").offset();
        		$('html, body').animate({scrollTop : offset.top}, 400);
    		}
		</script>
		<!-- Start. 상단 이미지 -->
		<div class="topViewCont">
			<div class="img">
				<img alt="" src="img/brandstory/topbg.jpg">
			</div>
			<div class="txtCont">
				<div class="category">
					<span>BRAND STORY</span>
				</div>
				<h2 class="tit">Grand Josun Jeju</h2>
			</div>
			<button type="button" onclick="fnMove()"><span class="hidden">자세히 보기</span></button>
		</div>
		<!-- End. 상단 이미지 -->
		<!-- Start. 인트로 -->
		<div id="intro" class="brandIntro">
			<strong class="tit">조선호텔앤리조트가 그랜드 조선 부산에 이어 새롭게 선보이는 그랜드 조선 제주,<br>에메랄드 빛 바다와 천혜의 자연이 만들어내는 특별한 여행을 선사합니다.</strong>
            <p class="txt">그랜드 조선 제주는&nbsp;자연과 마주한 쾌적한&nbsp;객실, 6개의 레스토랑&amp;바 그리고 머무는 즐거움이 있는 사계절 온수풀, 피트니스, 스파, 키즈클럽까지.<br>오직 그랜드 조선 제주에서만 경험할 수 있는 가장 완벽한 휴식을 만끽해보세요.</p>
        </div>
		<!-- End. 인트로 -->
		<!-- Start. 브랜드슬로건 -->
		<div class="brandSlogan">
			<div class="inner">
            	<strong class="tit">Journey<br>To Delightful Moments</strong>
                <span class="txt">그랜드 조선의 모든 순간은 즐거움으로 가득 찬 하나의 여정이 됩니다.</span>
        	</div>
        </div>
		<!-- End. 브랜드슬로건 -->
		<!-- Start. 호텔스토리 -->
		<div class="propertyList brandStory">
			<div class="inner">
				<div class="infoCont">
					<div class="txtCont">
						<strong class="tit">HOTEL STORY</strong> 
						<span class="txt">조선호텔이 지난 100여 년간 고객과 함께 해온 역량과 경험을 집대성하여 발전시킨 그랜드 조선 제주는 호스피탈리티 산업의 본질 탐구와 혁신을 통해 세계적 수준의 호텔 경험을 제공합니다.<br>아무런 준비 없이 찾아도 머무는 동안 최적의 편안함과 최고의 즐거움을 느낄 수 있는 곳. 선제적이고 유연한 서비스와 끊임없이 새로운 경험들로 잊지 못할 즐거운 여정을 선사합니다.</span>
					</div>
				</div>
				<img alt="" src="img/brandstory/content01.jpg">
			</div>
		</div>
		<!-- End. 호텔스토리 -->
		<!-- Start. 나머지 내용 -->
		<div class="inner">
			<h3 class="titDep3">SIGNATURE EXPERIENCE</h3>
			<ul class="brandSignatureList">
				<li>
					<div class="info">
						<figure class="thum">
							<img alt="" src="img/brandstory/content02.jpg">
							<figcaption>JOSUN JUNIOR</figcaption>
						</figure>
						<strong class="tit">여정마다 세심하게 마련된 키즈 프로그램</strong>
						<div class="txt">
							<p>
								조선 주니어는 체크인부터 체크아웃, 그리고 그 이후까지 호텔 여정 전반에<br>걸쳐 어린이 고객에게는
								잊지 못할 추억을, 부모에게는 여행의 편안한 쉼과<br>여유를 선사하는 그랜드 조선의 키즈 특화
								브랜드입니다.
							</p>
						</div>
					</div>
				</li>
				<li>
					<div class="info">
						<figure class="thum">
							<img alt="" src="img/brandstory/content03.jpg">
							<figcaption>LENDING LIBRARY</figcaption>
						</figure>
						<strong class="tit">마음이 가벼울 수록 즐거워지는 여행</strong>
						<div class="txt">
							<p>
								여행의 짐이 간편해야 보다 즐거운 여행이 가능합니다.<br> 렌딩 라이브러리에서는 투숙하시는 고객님의
								편의를 위해 유아용품부터 일반 여행용품까지 세심하게 준비된 다양한 물품을 제공해 드립니다.
							</p>
						</div>
					</div>
				</li>
				<li>
					<div class="info">
						<figure class="thum">
							<img alt="" src="img/brandstory/content04.jpg">
							<figcaption>HEAVENLY POOL</figcaption>
						</figure>
						<strong class="tit">프라이빗하게 즐길 수 있는 공간</strong>
						<div class="txt">
							<p>
								그랜드 조선의 수영장은 특별함을 더합니다. 이국적인 분위기로 천국에 와 있는<br>듯한 인피니트 풀부터
								성인 전용 풀, 키즈 풀 등 다양한 재미를 느낄 수 있는<br>수영장과 추억을 더욱 특별한 기억으로 남게
								해줄 그랜드 조선만의 수영용품을 함께 제공해 드립니다.
							</p>
						</div>
					</div>
				</li>
				<li>
					<div class="info">
						<figure class="thum">
							<img alt="" src="img/brandstory/content05.jpg">
							<figcaption>THE BEST SOFT TOUCH</figcaption>
						</figure>
						<strong class="tit">최상의 숙면, 최고의 부드러움</strong>
					    <div class="txt">
							<p>여행지에서의 고단함을 잊게 해줄 최고의 잠자리. 그랜드 조선은 최상의 숙면,<br>최고의 부드러움을 위해 시몬스의 프리미엄급 모델인 뷰티레스트 더원과<br>160년 전통의 이태리 명품 침구 브랜드 프레떼의 침구를 선보입니다.<br>
			                               편안한 안락함이 느껴지는 침대에서 실크처럼 부드러운 광택과<br>촉감의 침구로 최상의 숙면을 보장합니다.</p>
						</div>
					</div>
				</li>
				<li>
					<div class="info">
						<figure class="thum">
							<img alt="" src="img/brandstory/content06.jpg">
						<figcaption>THE MOMENT</figcaption>
						</figure>
						<strong class="tit">그랜드 조선의 향</strong>
						<div class="txt">
							<p>햇살을 가득 머금은 열매의 향기가 있다면 그랜드 조선에 들어서는 순간<br>경험하게 될 것입니다.
			                                   신선한 에너지와, 바람에 흔들리는 푸른 잎을 연상시키는<br>향은 더 큰 여행의 설레임을 제공합니다.
			                               여정의 모든 순간에 그랜드 조선의<br>THE MOMENT 가 함께 합니다.</p>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<!-- End. 나머지 내용 -->
		<div style="background:#000;"><!-- Start. footer -->
			<div id="footer">
				<div class="foot-logo"><img src="img/01.main/bg_logo_footer.png" alt="그랜드 조선 제주"></div>
				<div class="foot-txt">
					서울시 중구 소공로 106 대표이사 한채양 T. 02-771-0500<br>
					사업자등록번호 104-81-27386 통신판매신고번호 중구 0623호<br>
					2020 JOSUN HOTELS &amp; RESORTS Co. All rights reserved.
				</div>
			</div>
		</div><!-- End. footer -->
	</div>
	<!-- End. container -->
</div>
<!-- 전체감싸는 .wrapper -->
</body>
</html>