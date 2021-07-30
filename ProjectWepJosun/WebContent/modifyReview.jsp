<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import="room.RoomDTO, board.review.ReviewVO"%>
<%
	String id = (String) session.getAttribute("idKey"); 
	List<RoomDTO> list = (List<RoomDTO>)request.getAttribute("list");	
	ReviewVO vo = (ReviewVO)request.getAttribute("vo");
	//System.out.println("size : "+list.size());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CUSTOMER SERVICE - 리뷰 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/writeReview.css">
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script type="text/javascript" src="js/event_noticeWrite.js"></script>
<script>
	
	function cancle(){
		location.href="reviewboard?command=reviewmain";
	}

	function updateReview(){
		let form = document.getElementById("review_WriteForm");
		
		if($("#reservedRoom").val().length==0 || $("#reservedRoom").val()==null ){
			alert("예약했던 객실을 선택해주시기 바랍니다.");
			return false;
		}
		if($("#title").val().length==0 || $("#title").val() == null	){
			alert("제목을 필수 항목입니다.");
			$("#title").focus();
			return false;
		}
		if($("#dsCont").val().length==0 || $("#dsCont").val() == null	){
			alert("내용을 작성 해주시기 바랍니다.");
			$("#dsCont").focus();
			return false;
		}
		form.action = "ModifyReviewServlet";
		form.submit();
	}
	
	$(document).ready(function(){
		$(".roomlist li").click(function(){
			//alert("!");
			$(".roomlist li").children().css({"border" : ""})
			$(this).children().css({"border" : "5px solid black"})
			let a = $(this).attr("id");
			a = a.substr(4)
			$("#reservedRoom").val(a);
		});
		$(".roomlist li").each(function(){
			if($(this).attr("id").substr(4,2) == $("#reservedRoom").val() ){
				$(this).children().css({"border" : "5px solid black"})	
			}
		});
	});
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
							<li><a href="Login%>">로그인</a></li>
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
		<form id="review_WriteForm" name="review_WriteForm" method="post" action="reviewServlet" enctype="multipart/form-data">
		<input type="hidden" id="reservedRoom" name="reservedRoom" value="<%=vo.getRoomNumber() %>" />
		<input type="hidden" id="idx" name="idx" value="<%=vo.getIdx()%>"/>
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
					<!-- writeReview -->
					<h3 class="titDep2" style="margin-left: 400px;">REVIEW</h3>
					<div class="writeReView">
						<ul class="roomlist">
						<%for(RoomDTO dto: list) { %>
							<li id="room<%=dto.getNum() %>" >
								<dl class="roomIntro">
									<dt class="roomName">
										<%=dto.getName() %>
									</dt>
									<dd class="roomBenefit">NUMBER |  <%=dto.getNum() %>호</dd>
									<dd class="roomBenefit">BEDS |  <%=dto.getBeds() %></dd>
									<dd class="roomBenefit"><%=dto.getDetailView() %> |  Size: <%=dto.getrSize() %>㎡</dd>
									<dd class="roomBenefit">ROOM FEATURES |  <%=dto.getFeatures() %></dd>
									<dd class="thum">
										<img src="<%=dto.getImg() %>">										
									</dd>
								</dl>
							</li>
							<%} %>
						</ul>
						<ul class="intList">
							<li>
								<div class="intWrap">
									<span class="tit"> 
										<label for="title">TITLE</label> <span class="essential">*</span>
									</span>
								</div>
								<div class="intInner">
									<span class="intArea"> 
										<input type="text" id="title" name="title" style="width: 100%" aria-required="true" placeholder="제목을 입력해주세요." value="<%=vo.getTitle()%>"> 
									</span>
								</div>
							</li>
							<li>
								<div class="intWrap">
									<span class="tit"><label for="content">CONTENT</label><span class="essential">*</span></span>
								</div>
								<div class="intInner">
									<span class="intArea">
										<textarea id="dsCont" name="content" class="noLine" style="min-height:300px; width:100%;" placeholder="내용을 입력해주세요." ><%=vo.getContent()%></textarea></span>
								</div>
							</li>
							<li>
								<div class="intWrap">
									<span class="tit"><label for="uploadBtn">ATTACHED FILE</label></span>
								</div>
								<div class="intInner">
									<!-- 스크립트 위임 적용 commonJs.setFileUpload('.fileUpload'); -->
									<div class="fileUpload">
										<div class="intDel">
											<input type="text" id="nmFile1" class="fileName" name="fileName" style="width: 554px" readonly="" value="<%=vo.getFileName() %>">
											<input type="hidden" id="nmFile2" name="orginFileName" value="<%=vo.getFileName() %>"/>
											<!-- btnDel -->
											<button type="button" class="btnDel">삭제</button>
											<!-- //btnDel -->
										</div>
										<label for="uploadFile" class="btnSC btnM">파일선택</label> 
										<input type="file" id="uploadFile" name="uploadFile" class="uploadBtn" accept=".jpg, .jpeg, .png" >
									</div>
								</div>
								<p class="txtGuide">* 첨부가능 파일종류 : jpg, png, jpeg (용량 5MB)</p>
							</li>
						</ul>
					<div class="btnArea">
								<a href="#none" onclick="cancle()" class="btnSC btnL cancel">취소</a> 
								<a href="#none" onclick="updateReview()" class="btnSC btnL active">저장</a>
								<div style="clear:both;"></div> 
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