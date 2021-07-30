<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %>
<% String id = (String) session.getAttribute("idKey"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원탈퇴 | 그랜드 조선 호텔</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/memberDelete2.css">
<script type="text/javascript" src="js/header.js"></script>
<script>
	function withdrawalApi() {
		var notichk = document.getElementById('notice').checked;
		
		if(!notichk) {
			alert('유의사항 숙지에 동의해주시기 바랍니다.');
			//$("#notice").focus();
		} else {
			jQuery("#delInfoForm2").submit();
		}
	}
</script>
</head>
<body>
	<div class="header">
		<div class="headArea">
			<strong class="logo"><a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp; RESORTS</a></strong>
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
	</div>
	<!-- End. header -->
	
	<!-- Start. contents -->
	<div id="container" class="container mypage">
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
						<a href="#"><em id="nm1"><%= session.getAttribute("nameKey") %> </em>님</a>
					</p>
				</div>
				<ul class="lnb">
					<li>
						<!-- 예약확인 -->예약확인
						<ul>
							<li><a href="/ProjectWepJosun/memberReservation.jsp">객실 · 예약 내역</a></li>
						</ul>
					</li>
					<li>
						<!-- 개인정보관리 -->개인정보관리
						<ul>
							<li><a href="/ProjectWepJosun/memberReservation.jsp"> <!-- 회원 정보 수정 -->회원 정보 수정</a></li>
							<li><a href="/ProjectWepJosun/memberPwChange.jsp"> <!-- 비밀번호 변경 -->비밀번호 변경</a></li>
							<li><a href="/ProjectWepJosun/memberDelete1.jsp"> <!-- 회원 탈퇴 -->회원 탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</div>

			<!-- myContents -->
			<div class="myContents">
				<form action="Controller" id="delInfoForm2" name="delInfoForm2" method="post">
					<input type="hidden" name="command" value="delInfo2Action"/>
					<h3 class="titDep2">회원 탈퇴</h3>
					<p class="pageGuide tleft">탈퇴를 신청하시기 전에 아래의 유의사항을 한 번 더 확인해 주시기 바랍나다.</p>
	
					<div class="cautionBox">
						<span class="tit">유의 사항</span>
						<ul class="listDep1">
							<li>탈퇴를 신청하시면 번복이 불가능하며 보유하신 모든 포인트는 소멸됩니다.</li>
							<li>개인정보보호법에 따라 고객님의 호텔 이용기록, 개인정보 및 문의내역 기록도 모두 삭제됩니다.</li>
							<li>탈회 신청이 완료되면 즉시 홈페이지 로그인이 제한됩니다.</li>
						</ul>
					</div>
					<div class="chkNotice" style="float: right;">
						<input type="checkbox" name="notice" id="notice" />
						<label for="notice">유의사항에 동의합니다.</label>
					</div>
					<div class="btnArea">
						<button type="button" class="btnSC btnL active" onclick="withdrawalApi();">신청</button>
					</div>
				</form>
			</div>
		</div>
		<!-- End. my contents -->
	</div>	
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
</body>
</html>