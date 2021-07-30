<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="room.CheckInOutDay"%>
<%@page import="conn.DBConn" %>
<%@page import="room.RoomDAO" %>
<%@page import="room.RoomDTO" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; UTF-8");

	String id = (String) session.getAttribute("idKey");
	String startDate = (String)request.getAttribute("startDate");
	String endDate = (String)request.getAttribute("endDate");
	String adltCntArr = (String)request.getAttribute("adltCnt");
	String chldCntArr = (String)request.getAttribute("chldCnt");
	String ckinDate = (String)request.getAttribute("ckinDay");
	String ckoutDate = (String)request.getAttribute("ckoutDay");
	String dateDays = (String)request.getAttribute("dateDays");
	HashMap<String, Object> map  = (HashMap)request.getAttribute("room");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션 선택 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/selectOption.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
</head>
<body>
<!-- 바디 수정 210622 -->
	<div class="wrapper ">
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
						<%
						if(id == null || id == ""){
						%>
						<li><a href="/ProjectWepJosun/Controller?command=RoomLoginAction&startDate=<%=startDate%>&endDate=<%=endDate%>&adltCntArr=<%=adltCntArr%>&chldCntArr=<%=chldCntArr%>">로그인</a></li>
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
	
		<form action="" name="step2Form" id="step2Form" method="post">
		<input type="hidden" name="startDate" id="startDate" value="${startDate}">
		<input type="hidden" name="endDate" id="endDate" value="${endDate }">
		<input type="hidden" name="adltCntArr" id="adltCntArr" value="${adltCnt}">
		<input type="hidden" name="chldCntArr" id="chldCntArr" value="${chldCnt}">
		<input type="hidden" name="ckinDay" id="ckinDay" value="${ckinDay}">
		<input type="hidden" name="ckoutDay" id="ckoutDay" value="${ckoutDay }">
		<input type="hidden" name="dateDays" id="dateDays" value="${dateDays }">
		<input type="hidden" name="roomPrice" id="roomPrice" value="<%=map.get("price")%> "/>
		<input type="hidden" name="roomNum" id="roomNum" value="${roomNum}">
		<input type="hidden" name="command" id="command" value=""/>
			<div id="container" class="container">
				<h1 class="hidden">예약</h1>
				<div class="topArea">
					<div class="topInner">
						<h2 class="titDep1">Booking</h2>
						<div class="stepWrap">
							<ol>
								<li class="prev">
								<em>객실, 요금 선택</em>
								</li>
								<li class="on">
								<span class="hidden">현재단계</span>
								<em>옵션 선택</em>
								</li>
								<li>
								<em>예약자 정보 입력</em>
								</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- //topArea -->
				<div class="selResult">
					<div class="inner">
						<div class="infoArea">
							<dl class="dlType01">
								<dt>HOTEL</dt>
								<dd>그랜드 조선 제주</dd>
							</dl>
							<dl class="dlType02">
								<dt>DATE</dt>
								<dd id="dateText"><%=startDate %>&nbsp;<%=ckinDate %>&nbsp;-&nbsp;<%=endDate %>&nbsp;<%=ckoutDate %><span><%=dateDays %>&nbsp;박</span></dd>
							</dl>
							<dl class="dlType03">
								<dt>ROOMS</dt>
								<dd>1</dd>
							</dl>
							<dl class="dlType03">
								<dt>ADULTS</dt>
								<dd id="adultsNum"><%=adltCntArr %></dd>
							</dl>
							<dl class="dlType03">
								<dt>CHILDREN</dt>
								<dd id="childrenNum"><%=chldCntArr %></dd>
							</dl>
						</div>
					</div>
				</div>
				<!-- //selResult -->
				<div class="inner">
					<!-- rsvRoomWrap -->
					<div class="rsvRoomWrap">
						<div class="lCont">
							<h2 class="titDep2"><%=map.get("name") %></h2>
							<p class="categoryTxt">
								 <%=map.get("view") %> / Size : <%=map.get("size") %> ㎡
							</p>
							<ul class="toggleList rsvList roomRsv" id="optInfo">
								<li class="toggleOn" data-roomidx="0">
								<!-- 기본으로 펼쳐진 경우 toggleOn  추가 -->
								<strong class="listTit">객실</strong>
								<button type="button" class="btnToggle">
								<span class="hidden">상세내용 닫기</span>
								</button>
								<div class="toggleCont" style="display: block;">
									<div class="toggleInner">
										<h3 class="opTit">BREAKFAST</h3>
										<div class="addOption" data-type="optA">
											<span class="txt">성인 조식 추가</span>
											<span class="price">KRW <%=map.get("audlts_price") %></span>
											<div class="numPeople type02">
												<input type="hidden" name="optAAmount" id="optAAmount0" value="<%=map.get("audlts_price") %>">
												<input type="hidden" name="adult_breakfast" id="adult_breakfast" value="0"/>
												<button type="button" class="btnDown blank" data-btntype="down" disabled="disabled">인원 수 감소</button>
												<span>0</span>
												<button type="button" class="btnUp" data-btntype="up">인원 수 증가</button>
											</div>
										</div>
										<div class="addOption" data-type="optC">
											<span class="txt">어린이 조식 추가</span>
											<span class="price">KRW <%=map.get("children_price") %></span>
											<div class="numPeople type02">
												<input type="hidden" name="optCAmount" id="optCAmount0" value="<%=map.get("children_price") %>">
												<input type="hidden" name="children_breakfast" id="children_breakfast" value="0"/>
												<button type="button" class="btnDown blank" data-btntype="down" disabled="disabled">인원 수 감소</button>
												<span>0</span>
												<button type="button" class="btnUp" data-btntype="up" disabled="disabled">인원 수 증가</button>
											</div>
										</div>
										<ul class="txtGuide">
											<li>투숙 일수와 동일한 횟수의 조식이 제공됩니다.</li>
											<li>인원 추가 금액에는 조식이 포함되어 있지 않습니다. 조식 추가 기능을 통해 별도로 추가가 가능합니다.</li>
											<li>어린이 조식 추가 비용 적용 대상은 37개월 이상 만 12세 이하입니다.</li>
											<li>사전 추가된 조식의 경우 특별요금이 적용된 혜택으로, 체크인 후 미사용 시 환불이 불가합니다.
											<!-- 사전 추가된 조식의 경우 특별요금이 적용된 혜택으로, 체크인 후 미사용 시 환불이 불가합니다. -->
											</li>
											<li>코로나19에 따른 사회적 거리두기 정부 시책이 진행될 경우, 뷔페 조식은 다른 장소 및 단품 메뉴로 대체 제공될 수 있습니다.
											<!-- 코로나19에 따른 사회적 거리두기 정부 시책이 진행될 경우, 뷔페 조식은 다른 장소 및 단품 메뉴로 대체 제공될 수 있습니다. -->
											</li>
										</ul>
										<h3 class="opTit">
										REQUESTS
										</h3>
										<textarea name="contArr" placeholder="호텔 이용 시 문의하실 사항이 있으시면 입력해 주세요." maxlength="200"></textarea>
										<p class="txtGuide">
											전달해주신 요청사항을 최대한 반영하도록 최선을 다하겠습니다.<br>
											다만, 부득이하게 반영되지 않을 수 있는 점, 양해 부탁드립니다.
										</p>
									</div>
								</div>
								</li>
							</ul>
						</div>
						<div class="rCont floating" style="transition: margin-top 0.3s ease-out 0s;">
							<ul class="toggleList rsvList" id="roomInfo">
								<li class="toggleOn">
								<!-- 기본으로 펼쳐진 경우 toggleOn  추가 -->
								<strong class="listTit">
								객실 <span class="price" id="roomAmount0"><em></em>KRW</span>
								</strong>
								<button type="button" class="btnToggle"><span class="hidden">상세내용 닫기</span></button>
								<div class="toggleCont" style="display: block;">
									<div class="toggleInner">
										<div class="designScroll">
											<div class="optionTotal scrollWrap" style="">
												<div class="customScrollBox">
													<input type="hidden" id="roomAmount" value="">	<!-- 사용 -->
													<input type="hidden" id="breakfastAmount" value=""> <!-- 사용 -->
													<ul class="infoData" id="dateInfo">
												
													</ul>
													<ul class="infoData" id="roomOptInfo0" style="display:none;">
														<li style="display:none;">
															<span class="lfData">성인 조식</span>
															<span class="rtData">0</span>
														</li>
													</ul>
													<ul class="infoData">
														<li><span class="lfData">세금</span><span class="rtData" id="roomTax0">91,000</span></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								</li>
							</ul>
							<div class="totalCont">
								<div class="totalPrice">
									<span class="txt">총 예약금액</span>
									<span class="subTxt">+ 세금(10%)</span>
									<span class="price"><em id="resvTotalAmount"></em>KRW</span>
									<input type="hidden" name="totalpay" id="totalpay" value="">
								</div>
								<div class="btnArea">
									<div>
										<a href="#none" class="btnSC btnL active" onclick="writeInfo()">
										예약하기 </a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- //rsvRoomWrap -->
				</div>
				<!-- //inner -->
				<!-- 컨텐츠 E -->
			</div>
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
<script>

//콤마찍기
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
// 콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

function addDate(num) {
	let start = document.getElementById("startDate").value;
	var tDate = new Date(start);
	tDate.setDate(tDate.getDate()+num)
	tDate = tDate.toISOString();
	//alert(tDate);
	startDate = tDate.toString().substring(0,10);
	startDate = startDate.replaceAll("-",".");
	
	return startDate;
}

function writeInfo(){
	var form = document.step2Form;
	form.command.value = "goWriteInfo";
	form.action = "Controller";
	form.submit();
	
}

/*		버전업 
 * 	추후 업그레이드 숙박일수에 따라 가격표에 숙박일수 가격 +++
 * 	박수 계산해서 가격에 곱해야함..... 추후   
 
 *  -- 버전업 완료 (21.07.05)
 *  - 숙박일에 따른 가격
 */ 
 
$(document).ready(function(){
	
	// 가격표에 날짜별 가격 표시
	let sucbacDay =(Number)($("#dateDays").val());
	price = $("#roomPrice").val();
	for(let i=1; i<=sucbacDay; i++) {
		date = addDate(i);
		$("#dateInfo").append("<li>	<span class='lfData'>"+date+"</span><span class='rtData'>"+price+"</span></li>")
		
	}
	
	
// 날짜별 가격 총합
let roomPriceArray = new Array();	// 방가격 배열
let roomAmount=0;				

$("#dateInfo li .rtData").each(function(){
	let s = uncomma($(this).text());
	roomPriceArray.push(s);
});	
for(let i=0; i<roomPriceArray.length; i++) {
	roomAmount += Number(roomPriceArray[i]);
}
$("#roomAmount").val(roomAmount);


// 조식가격 총합
function josic(){	
	let breakfastArray = new Array();	// 조식 배열
	let breakfastAmount = 0;
	$("#roomOptInfo0 li .rtData").each(function(){
		let s = uncomma($(this).text());
		breakfastArray.push(s);
	})
	for(let i=0; i<breakfastArray.length; i++) {
		breakfastAmount += Number(breakfastArray[i]);
	}
	$("#breakfastAmount").val(breakfastAmount);
	return breakfastAmount;
}

// 아이예약 확인 하고 버튼 disable 풀기
let childrenNum = Number($("#childrenNum").text());
if(childrenNum != 0){
	$(".btnUp").removeAttr('disabled')
	$("#roomOptInfo0").append("<li style=\"display: none;\"><span class=\"lfData\">어린이 조식</span><span class=\"rtData\">0</span></li>")
	/*<li><span class="lfData">어린이 조식</span><span class="rtData">27,000</span></li>*/
}

//토글 슬라이드
$(".floating .btnToggle").click(function() {
	$(".floating .toggleInner").slideToggle();
	$(".floating .rsvList > li .btnToggle").parent().toggleClass("toggleOn");
});
$(".lCont .btnToggle").click(function() {
	$(".lCont .toggleInner").slideToggle();
	$(".lCont .rsvList > li .btnToggle").parent().toggleClass("toggleOn");
});

// 스크롤 이벤트
$(window).scroll(function(){
	var scroll_top=$(this).scrollTop();
	//console.log(scroll_top);
	if(scroll_top<=550){
		scroll_top=0;
	}else{
		scroll_top -=550;
		if(scroll_top>=171) {
			scroll_top = 171;
		}
	}
	
	$(".rCont.floating").animate({
		top : scroll_top
	},30,'swing');
});

// 세금 기본값 셋팅
$("#roomTax0").text(comma($("#roomAmount").val()*0.1));
// 합계 기본값 셋팅
$("#roomAmount0 em").html(comma(roomAmount+($("#roomAmount").val()*0.1)));
$("#resvTotalAmount").html(comma(roomAmount+($("#roomAmount").val()*0.1)));
$("#totalpay").val(roomAmount+$("#roomAmount").val()*0.1);
/*
 * 		 ' + ' 버튼 이벤트
 * */
$(".btnUp").click(function(){
	let s = $(this).parent().prev().prev().text().substring(0,2); //어린인지 어른인지 확인
	// *************s의 선택자는 추후에 수정 어차피 값을 넘겨 받아오는 숫자이기때문에 그걸로 활용할거임  * 그냥 이대로 쓸게요
	let max ;	// 최대값	
	if(s=="성인"){
		max = Number($("#adultsNum").text());
	} else if(s=="어린"){
		max = Number($("#childrenNum").text());
	}
	
	let $changeSpan = $(this).prev();	//변경할 위치
	let changeNum = Number($changeSpan.text());	// 1 2 3
	
	if(changeNum < max){
		changeNum ++;
		$changeSpan.text(changeNum);
		if(changeNum == max){$changeSpan.next().attr('disabled','true')}	
	}
	
	if(changeNum >= 1){
		$changeSpan.prev().attr('class','btnDown');	// 색상
		$changeSpan.prev().removeAttr('disabled');	// 버튼 클릭 풀기
	
	 
		let i = 0;
		let sucbacDay =(Number)($("#dateDays").val()); //숙박일
		if(s=="성인"){
			$("#roomOptInfo0 >li:first-child").css('display','');
			i=(Number)(uncomma($("#optAAmount0").val()));		// 조식 가격
			let price = changeNum*i*sucbacDay;	//추후 숙박일 곱해야함  *완료
			
			$("#roomOptInfo0 > li:first-child .rtData").html(comma(price));
			$("#adult_breakfast").val(changeNum);
		} 
		else if(s=="어린"){
			$("#roomOptInfo0 > li:nth-child(2)").css('display','');
			i=(Number)(uncomma($("#optCAmount0").val()));		// 조식 가격
			let price = changeNum*i*sucbacDay;
			$("#roomOptInfo0  li:nth-child(2) .rtData").html(comma(price));
			$("#children_breakfast").val(changeNum);
		}
	}
	if(Number($(".type02>span").text()) !=0 ){
		$("#roomOptInfo0").css('display','')
	}
	
	let tax = (josic() + roomAmount)*0.1;
	$("#roomTax0").text(comma(tax));
	
	let total = Number($("#roomAmount").val()) + Number($("#breakfastAmount").val()) + tax;
	$("#roomAmount0 em").html(comma(total));
	$("#resvTotalAmount").html(comma(total));
	$("#totalpay").val(total);
});

/*
 *		' - '버튼 이벤트 	
 * */
$(".btnDown").click(function(){
	let s = $(this).parent().prev().prev().text().substring(0,2); //어린인지 어른인지 확인
	//************s의 선택자는 추후에 수정 어차피 값을 넘겨 받아오는 숫자이기때문에 그걸로 활용할거임 * 그냥 이대로 쓸게요
	let max ;	// 최대값	
	if(s=="성인"){
		max = Number($("#adultsNum").text());
	} else if(s=="어린"){
		max = Number($("#childrenNum").text());
	}
	let $changeSpan = $(this).parent().find("span");	//변경할 위치
	let changeNum = Number($changeSpan.text()) - 1;	//변경할 숫자
	
	if(changeNum != max){		// 변경할 숫자가 예약인원수가 되면
		$changeSpan.next().removeAttr('disabled')	// +버튼 막은거 풀기
		
		let i = 0;
		let sucbacDay =(Number)($("#dateDays").val()); //숙박일
		if(s=="성인"){
			i=(Number)(uncomma($("#optAAmount0").val()));		// 조식가격
			let price = changeNum*i*sucbacDay;
			$("#roomOptInfo0 > li:first-child .rtData").html(comma(price));
			$("#adult_breakfast").val(changeNum);
		} 
		else if(s=="어린"){
			i=(Number)(uncomma($("#optCAmount0").val()));	// 조식가격
			let price = changeNum*i*sucbacDay;
			$("#roomOptInfo0  li:nth-child(2) .rtData").html(comma(price));
			$("#children_breakfast").val(changeNum);
		}
	}
	if(changeNum === 0){		//변경할 숫자가 0이 되면
		$changeSpan.prev().attr('class','btnDown blank')	// 클래스 명 변경 색상이 변함
		$changeSpan.prev().attr('disabled','true')	// 버튼 클릭 막기
//		$("#roomOptInfo0").css('display','none')	// 가격 표 항목 없애기
		if(s=="성인"){
			$("#roomOptInfo0 >li:first-child").css('display','none');
		} 
		else if(s=="어린"){
			$("#roomOptInfo0 > li:nth-child(2)").css('display','none');
		}
	}
	
	$changeSpan.html(changeNum); // 세터 (값변경)
	$changeSpan.change();
	
	if(Number($(".type02>span").text()) === 0 ){
		$("#roomOptInfo0").css('display','none');
	}
	
	let tax = (josic() + roomAmount)*0.1;
	$("#roomTax0").text(comma(tax));
	
	let total = Number($("#roomAmount").val()) + Number($("#breakfastAmount").val()) + tax;
	$("#roomAmount0 em").html(comma(total));
	$("#resvTotalAmount").html(comma(total));
	$("#totalpay").val(total);
});

/*
 * 		합계계산
 * */	

//resvTotalAmount
/*$("#roomAmount").val();
$("#breakfastAmount").val();
$("#roomTax0").val();*/
//let total = $("#roomAmount").val() + $("#breakfastAmount").val() + $("#roomTax0").();
//alert(total);


});
</script>
	
</body>
</html>