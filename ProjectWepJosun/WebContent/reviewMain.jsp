<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="room.RoomDTO, board.review.*" %>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	String id = (String) session.getAttribute("idKey");
	int currentPage = 0;
	int startPage = 0;
	int endPage=0;
	ArrayList<ReviewVO> list = null;
	//if(request.getParameter("currentpage") != null){
	currentPage = (Integer)request.getAttribute("currnetpage");
	startPage = (Integer)request.getAttribute("startPage"); 
	endPage = (Integer)request.getAttribute("endPage");
	list = (ArrayList)(request.getAttribute("list"));
	int pagecnt = (Integer)request.getAttribute("pagecnt");
	/* } */
	/* if(currentPage==0) {
		ReviewDAO dao = new ReviewDAO();	// review 기능 오브젝트
		currentPage = 1;
		if(request.getParameter("page")!=null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		int pagecnt = dao.reviewPageCnt();	// 총 페이지 수
		
		startPage = currentPage%5 == 0 ? currentPage - 4 : currentPage-currentPage%5 + 1;	//for문을 돌리기 위한 시작 페이지
		if(startPage<0) {startPage = 0;}
		
		endPage = startPage+4;																//for문을 돌리기 위한 앤드 페이지
		if(endPage>pagecnt) {endPage = pagecnt;}
		list = dao.showWriting(currentPage);
	} */
	
	
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CUSTOMER SERVICE - 리뷰 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/reviewMain.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
</head>
<body>
<script>
	function fncPage(param){
		let form = document.getElementById("reviewForm")
		form.page.value = param;
		form.command.value = "reviewmain";
		form.action="reviewboard"
		form.submit();
	}
	function loginGo(){
		let form = document.getElementById("loginForm");
		form.method="get";
		form.action='Login';
		form.submit();
	}
	
	function writeReview(){
		let form = document.getElementById("reviewForm");
		form.command.value = "writeReview"
		form.action="reviewboard"
		form.submit();
	}
	
	function noWrite(){
		alert("로그인 후 사용해주시기 바랍니다.");
	}
	
    function minusFive(){
    	let page = (Number)(document.getElementById("page").value);
    	//alert(page);
		if(page > 1 || page == null || page==""){
			page = page-5
			if(page<1 || page == null || page==""){
				page = 1
			}
		let form = document.getElementById("reviewForm")
		form.page.value = page;
		form.command.value = "reviewmain";
		form.action="reviewboard"
		form.submit();
		}
    }
	function minusOne(){
		let page = (Number)(document.getElementById("page").value);
		if(page > 1 || page == null || page==""){
			page = page-1;
			if(page<1 || page == null || page==""){
				page = 1;
			}
		let form = document.getElementById("reviewForm")
		form.page.value = page;
		form.command.value = "reviewmain";
		form.action="reviewboard"
		form.submit();
		}
	}
    
	function plusOne(){
		let page = (Number)(document.getElementById("page").value);
		if(page<<%=pagecnt%>){
			page = page+1;
			if(page><%=pagecnt%>){
				page = <%=pagecnt%>;
			}
			let form = document.getElementById("reviewForm")
			form.page.value = page;
			form.command.value = "reviewmain";
			form.action="reviewboard"
			form.submit();
		}
	}
	
	function plusFive(){
		let page = (Number)(document.getElementById("page").value);
		if(page<<%=pagecnt%>){
			page = page+5;
			if(page><%=pagecnt%>){
				page = <%=pagecnt%>;
			}
			let form = document.getElementById("reviewForm")
			form.page.value = page;
			form.command.value = "reviewmain";
			form.action="reviewboard"
			form.submit();
		}
	}
    
	$(document).ready(function() {
		
		
       $(".myContents tr").click(function(){
    	  let bno = $(this).children(":first").attr("class");
    	  bno = bno.substr(7);
    	  //alert(bno); 
    	  $("#bno").val(bno);
    	  $("#command").val("detailReview");
    	  $("#reviewForm").attr("action", "reviewboard");
    	  $("#reviewForm").submit();
       });
       
       
       
    });
</script>
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
						<%if(id == null || id == ""){%>
					<li><a href="#none" onclick="loginGo()">로그인</a></li>
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
	<form name="loginForm" id="loginForm" method="post" action="">
		<input type="hidden" name="url" id="nextURL" value="<%=request.getServletPath()%>">
	</form>
	<form id="reviewForm" name="reviewForm" method="post">
	<input type="hidden" id="page" name="page" value="<%=currentPage%>">
	<input type="hidden" id="bno" name="bno" value=""/>
	<input type="hidden" id="command" name='command' value=""/>
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
				<!-- myContents -->
				<h3 class="titDep2" style="margin-left: 400px;">REVIEW</h3>
				<div class="myContents">
					<table>
						<tbody>
				<%for(ReviewVO vo : list) {	%>
							<tr>
								<td class="writing<%=vo.getIdx()%>"><div style="background-image:url(img/review/<%=vo.getFileName()%>);"></div></td>
								<td>
									<p>
										제목&nbsp;&nbsp;&nbsp; | <%=vo.getTitle() %>  <br>
										내용&nbsp;&nbsp;&nbsp; | <%=vo.getContent() %> <br>
										작성일 | <%=vo.getWriteDate().substring(0, 10) %><br>
										작성자 | <%=vo.getMemberID() %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 조회수 | <%=vo.getHitCount()%> 
									</p>
								</td>
							</tr>
				<%}	%>			
						</tbody>
					</table>
				</div>
				<div class="pagination">
					<a class="first" onclick="minusFive()"><span class="hidden">first</span></a>
					<a class="prev" onclick="minusOne()"><span class="hidden">prev</span></a>
				<%for(int i=startPage; i<=endPage; i++) {
					if(i==currentPage) {%>										
					<span class="current"><span class="hidden">현재페이지</span><%=i %></span>
					<%} else { %>
					<a href="javascript:fncPage(<%=i%>);"><%=i %></a> 
					<%} %>
				<%} %>
					<a class="next" onclick="plusOne()"><span class="hidden">next</span></a> 
					<a class="last" onclick="plusFive()"><span class="hidden">last</span></a> 
					<%if(id==null) { %>
					<a id="write" onclick="noWrite()" >글쓰기</a>	
					<%	} else{
					%>
					<a id="write" onclick="writeReview()" >글쓰기</a>
					<%
											
					}%>
					
				</div>
				<!-- //myContents -->
			</div>
			<!-- //inner -->
			<!-- 컨텐츠 E -->
		</div>
		<!-- //container -->
	</form>
		<!-- //container -->
	<div style="background:#000;"><!-- Start. footer -->
		<div id="footer">
			<div class="foot-logo">
				<img src="img/01.main/bg_logo_footer.png" alt="그랜드 조선 제주">
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
</body>
</html>