<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, board.review.ReviewVO , room.RoomDTO" %> 
<%
	String id = (String) session.getAttribute("idKey"); 
	ReviewVO vo = (ReviewVO)request.getAttribute("review");
	RoomDTO dto = (RoomDTO)request.getAttribute("room");
%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CUSTOMER SERVICE - 리뷰 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/detailViewReview.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script>
	function boardMain(){
		let form = document.getElementById("detailReviewForm");
		form.command.value="reviewmain";
		form.action = "reviewboard";
		form.submit();
	}
	function reviewDelete(){
		let form = document.getElementById("detailReviewForm");
		form.command.value="reivewDelete";
		form.action = "reviewboard";
		form.submit();
	}
	function reviewModify(){
		let form = document.getElementById("detailReviewForm");
		form.command.value="goReivewModifyPage";
		form.action = "reviewboard";
		form.submit();
	}
</script>
</head>
<body>
	<div class="wrapper ">
		<div class="header">
				<!-- 메뉴 열리면 gnbOn 클래스 추가 -->
				<div class="headArea">
					<strong class="logo"><a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp;
							RESORTS</a></strong>
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
							<li><a href="Login">로그인</a></li>
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
		<form action="" id = "detailReviewForm" name="detailReviewForm">
		<input type="hidden" id="idx" name="idx" value="<%=vo.getIdx()%>"/>
		<input type="hidden" id="command" name="command" value=""/> 
		<div id="container" class="container mypage ctmService">
				<!-- 컨텐츠 S -->
				<h1 class="hidden">고객센터</h1>
				<div class="topArea">
					<div class="topInner">
						<h2 class="titDep1">Customer Service</h2>
						<p class="pageGuide">
							 조선호텔앤리조트는 언제나 고객의 목소리에 귀기울이고 있습니다.<br>
							 소중한 충고와 격려, 또는 제안의 말씀을 남겨 주시면 최대한 반영하여 더 나은 서비스로 보답하겠습니다.
						</p>
					</div>
				</div>
				<div class="inner">
					<!-- LNB -->
					<div class="lnbArea">
						<ul class="lnb ctmType">
							<li><a href="/ProjectWepJosun/qna.jsp">Q&amp;A</a></li>
							<li class="on"><a href="reviewboard?command=reviewmain">REVIEW</a></li>
						</ul>
					</div>
					<!-- //LNB -->
					<!-- detailView -->
					<h3 class="titDep2" style="margin-left: 400px;">REVIEW</h3>
					<div class="detailView">
						<ul class="roomlist">
							<li id="room">
								<dl class="roomIntro">
									<dt class="roomName">
										<%=dto.getName()%>
									</dt>
									<dd class="roomBenefit">NUMBER |  <%=vo.getRoomNumber() %>호</dd>
									<dd class="roomBenefit">BEDS |  <%=dto.getBeds() %></dd>
									<dd class="roomBenefit"><%=dto.getDetailView() %> |  Size: <%=dto.getrSize() %>㎡</dd>
									<dd class="roomBenefit">ROOM FEATURES |  <%=dto.getFeatures() %></dd>
									<dd class="thum">
										<img src="<%=dto.getImg() %>" alt="<%=dto.getName()%>">										
									</dd>
								</dl>
							</li>
						</ul>
						<h2 class="tit"><%=vo.getTitle() %></h2> 
						<ul class="infoData">
						<li>그랜드 조선 제주</li>
						<li><%=vo.getWriteDate() %></li>
						<li> 조회수 : <%=vo.getHitCount() %></li>
						<li><%=vo.getMemberID() %></li>
					</ul>
					<p class="txtBox">
						<%=vo.getContent() %>
					</p>	
					<%if(vo.getFileName() != null){ %>
					<div class="imgBox" style="background-image: url(img/review/<%=vo.getFileName() %>);">
					</div>
					<% }%>
					<div class="btnArea">
						<a href="#none" onclick="boardMain()" class="btnSC btnL">목록</a>
						
						<%if(id==null){ }
						else if(id.equals(vo.getMemberID()) || id.equals("admin") ){%>
						<a class="btnEdit" onclick="reviewDelete()">삭제</a>
						<a class="btnEdit" onclick="reviewModify()">수정</a>
						<% }%>
					</div>
					</div>
					<!-- //myContents -->
				</div>
				<!-- //inner -->
			</div>
			<!-- //container -->
		</form>
		<!-- footer -->
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
</body>
</html>