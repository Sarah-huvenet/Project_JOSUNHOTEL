<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 --> 
<%
	String referer = request.getHeader("Referer");
	String startDate = request.getParameter("startDate");	// startDate
	String endDate = request.getParameter("endDate");		// endDate
	String adltCntArr = request.getParameter("adltCntArr");	// adltCntArr
	String chldCntArr = request.getParameter("chldCntArr");	// chldCntArr
	String id = (String) session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script type="text/javascript" src="js/login.js"></script>
</head>
<body>
<%
	if(session.getAttribute("idKey")!=null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인됨')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
%>
	<div class="wrapper">
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
						<li><a href="Login">로그인</a></li>
						<li><a href="Join">회원가입</a></li>
					</ul>
				</div>
				<!-- //gnbUtil -->
			</div>
		</div>
		<!-- End. header -->
		<script>
			function fncLogin(){
				
				/*
				사용자 입력정보 VALIDATION 체크
				해당 열  input, select 박스가 하나라도 미기재 된 경우 validation false
				최초 미입력 된 element로 focus 이동됨
				*/
				var frstIdx = "";
				$(".membersLogin p").each(function(){
					var $this = $(this);
					$this.find("input[type='text'],input[type='password']").each(function(idx){
						var validYn = true;
						var value = jQuery(this).val();
						var id = jQuery(this).attr("id");
						if(value == "" && id != "emailType"){
							validYn = false;
							if(frstIdx == ""){
								frstIdx = jQuery(this);
							}
						}
						if(!validYn){
							$this.addClass("error");
							$this.find(".alertMessage").show();
						}else{
							$this.removeClass("error");
							$this.find(".alertMessage").hide();
						}
					});
					
				});
				if(frstIdx != ""){
	  				bResult = false;
					frstIdx.focus();
					return false;
				}
				
				$('#loginform').submit();
			}
		</script>
		<!--(페이지 URL)-->
		<form id="loginform" name="loginform" action="Controller" method="post">
			<input type="hidden" name="command" value="loginAction">
			<input type="hidden" id="nextUrl" name="nextUrl" value="<%=request.getParameter("url")%>">
			<!-- 룸보기에서 로그인할 경우 -->
			<input type="hidden" name="startDate" value="<%=startDate%>">
			<input type="hidden" name="endDate" value="<%=endDate%>">
			<input type="hidden" name="adltCntArr" value="<%=adltCntArr%>">
			<input type="hidden" name="chldCntArr" value="<%=chldCntArr%>">
			<div id="container" class="container login">
				<!-- 컨텐츠 S -->
				<div class="topArea">
					<div class="topInner">
						<h2 class="titDep1">Sign In</h2>
						<p class="pageGuide">
							 머무는 모든 순간이 특별해집니다.
						</p>
					</div>
				</div>
				<div class="inner">
					<!-- tabCont(아이디 로그인) -->
					<div id="tab01" class="tabCont" style="display: block">
						<div class="loginBox">
							<div class="membersLogin">
								<p class="loginFrm">
									<!-- 필수입력서식에 미입력 발생 시, error 클래스 추가 alertMessage 노출, 포커스가 가면 error 클래스 제거 -->
									<span class="alertMessage">
									아이디를 입력해주세요.
									<!-- 아이디를 입력해주세요. -->
									</span>
									<label class="hidden" for="id">아이디</label>
									<input type="text" id="id" name="id" placeholder="아이디" aria-required="true">
									<!-- 아이디 -->
								</p>
								<p class="loginFrm">
									<span class="alertMessage">비밀번호를 입력해주세요.
									<!-- 비밀번호를 입력해주세요. -->
									</span>
									<label class="hidden" for="pw">비밀번호</label>
									<!-- 비밀번호 -->
									<input type="password" id="pw" name="pw" placeholder="비밀번호" aria-required="true" onkeydown="javascript:if(event.keyCode==13){PageScript.fncLogin('ID');}">
									<!-- 비밀번호 -->
								</p>
								<span class="frm">
								<input type="checkbox" id="idSaveCheck">
								<label for="idSaveCheck">아이디 저장</label>
								</span>
								<button type="button" class="btnSC btnL active btnFull" onclick="fncLogin(); return false;">로그인</button>
								<p class="loginGuide">
									CLUB JOSUN 회원이 되시면 더 많은 혜택이 있습니다.
									<!-- Josun Hotels & Resorts 회원이 되시면 더 많은 혜택이 있습니다. -->
								</p>
								<div class="loginLink">
									<a href="Join" class="btnS icoArr">회원가입</a>
									<a href="/ProjectWepJosun/findIdPw.jsp" class="btnS icoArr">아이디 / 비밀번호 찾기</a>
								</div>
							</div>
						</div>
					</div>
					<ul class="txtGuide">
						<li>이용자 비밀번호 5회 연속 오류시 계정이 잠기게 됩니다.</li>
						<li>오프라인 회원의 경우 온라인 회원가입 후 계정연동 가능합니다.</li>
						<li>메리어트 호텔에서 예약하신 경우, 메리어트 사이트에서만 예약 확인이 가능합니다.</li>
					</ul>
				</div>
				<!-- //inner -->
				<!-- 컨텐츠 E -->
			</div>
			<!-- //container -->
		</form>
		<!-- //container -->
		<div style="background:#000;"><!-- Start. footer -->
			<div id="footer">
				<div class="foot-logo"><img src="img/01.main/bg_logo_footer.png" alt="그랜드 조선 제주">
				</div>
				<div class="foot-txt">
					서울시 중구 소공로 106 대표이사 한채양 T. 02-771-0500<br>
					사업자등록번호 104-81-27386 통신판매신고번호 중구 0623호<br>
					2020 JOSUN HOTELS &amp; RESORTS Co. All rights reserved.
				</div>
			</div>
		</div>
		<!-- End. footer -->
	</div>
	<!-- //wrapper -->
</body>
</html>