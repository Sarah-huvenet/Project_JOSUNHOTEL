<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.EventNotice.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import = "conn.*" %>
<% String id = (String) session.getAttribute("idKey"); %>
<% 
	Connection conn = DBConn.getConnection();
	EventNoticeDAO edao = new EventNoticeDAO();
	ArrayList <EventNoticeDTO> listEn = new ArrayList <EventNoticeDTO>();
	
	int curPage = 0;
	curPage = Integer.parseInt(request.getParameter("idx"));
	
	listEn = edao.selectList(curPage);
	
	int prevIdx = edao.getPrevPageNum(curPage);		//이전글번호
	int nextIdx = edao.getNextPageNum(curPage);		//다음글번호
	
	String prevTit = edao.getPrevTitle(prevIdx);	//이전글 타이틀
	String nextTit = edao.getNextTitle(nextIdx);	//다음글 타이틀
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EVENT &amp; NOTICE | 그랜드 조선 호텔</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/event_noticeView.css">
<script type="text/javascript" src="js/header.js"></script>
<script>
	function fncGoList() {	//목록가기
		var a = $(".btnSC btnL").val();
		location.href='event_noticeList.jsp';
	}
	
	function writeModify(currentPageNum) {	//수정하기
		var a = currentPageNum;
		location.href='event_noticeModify.jsp?idx='+a;
	}
	
	function writeDel(currentPageNum) {//삭제
		var a = currentPageNum;
		location.href='event_noticeViewAction.jsp?idx='+a;
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
	<div id="container" class="container">
		<div class="inner">
			<div class="mbsDetailCont">
				<div class="detailView">
				<%for(int i = 0; i <= listEn.size()-1; i++) {%>
					<h2 class="tit"><%=listEn.get(i).getTitle()%></h2>
					<ul class="infoData">
						<li>조선호텔앤리조트</li>
						<li><%=listEn.get(i).getWriteDate()%></li>
					</ul>
					<p class="txtBox"><%=listEn.get(i).getContent()%></p>
				<%} %>
					<ul class="shortList">
						<% 
						if(prevIdx == 0){ %>
							<li class="prev"><span>이전 글</span>
								<a class="ellipsis" href="event_noticeList.jsp">이전 글이 없습니다.</a>
							</li>
							<li class="next"><span>다음 글</span>
								<a class="ellipsis" href="event_noticeView.jsp?idx=<%=nextIdx%>"><%=nextTit%></a>
							</li>
						<%} else if(nextIdx == 0) {%>
							<li class="prev"><span>이전 글</span>
								<a class="ellipsis" href="event_noticeView.jsp?idx=<%=prevIdx%>"><%=prevTit%></a>
							</li>
							<li class="next"><span>다음 글</span>
								<a class="ellipsis" href="event_noticeList.jsp">다음 글이 없습니다.</a>
							</li>
						<%}else{ %>
							<li class="prev"><span>이전 글</span>
								<a class="ellipsis" href="event_noticeView.jsp?idx=<%=prevIdx%>"><%=prevTit%></a>
							</li>
							<li class="next"><span>다음 글</span>
								<a class="ellipsis" href="event_noticeView.jsp?idx=<%=nextIdx%>"><%=nextTit%></a>
							</li>
						<%} %>
					</ul>
					<div class="btnArea">
						<a href="#none" onclick="fncGoList();" class="btnSC btnL">목록</a> 
						<%if(id == null) {%>
							<div></div>
						<%} else if(id.equals("admin")) {%>
							<a href="#none" onclick="writeModify(<%=curPage %>);" class="btnSC writeL">수정</a> 
							<a href="#none" onclick="writeDel(<%=curPage %>);" class="btnSC writeD">삭제</a>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	</div>
		<!-- End. contents -->
	
		<!-- Start. footer -->
		<div style="background: #000;">
			<div id="footer">
				<div class="foot-logo">
					<img src="img/01.main/bg_logo_footer.png" alt="그랜드 조선 제주">
				</div>
				<div class="foot-txt">
					서울시 중구 소공로 106 대표이사 한채양 T. 02-771-0500<br>
					사업자등록번호 104-81-27386 통신판매신고번호 중구 0623호<br> 
					020 JOSUN HOTELS &amp; RESORTS Co. All rights reserved.
				</div>
			</div>
		</div>
		<!-- End. footer -->
	</div>
</body>
</html>