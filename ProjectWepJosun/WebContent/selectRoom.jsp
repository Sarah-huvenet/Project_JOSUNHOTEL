<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="room.CheckInOutDay"%>
<%@page import="conn.DBConn" %>
<%@page import="room.RoomDAO" %>
<%@page import="room.RoomDTO" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.List" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; UTF-8");
	
	String id = (String) session.getAttribute("idKey");
	String startDate = (String)request.getAttribute("startDate");
	String endDate = (String)request.getAttribute("endDate");
	String adltCntArr = (String)request.getAttribute("adltCntArr");
	String chldCntArr = (String)request.getAttribute("chldCntArr");
	String ckinDate = (String)request.getAttribute("ckinDay");
	String ckoutDate = (String)request.getAttribute("ckoutDay");
	int dateDays = (Integer)request.getAttribute("dateDays");
	List<RoomDTO> lists = (List<RoomDTO>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실 선택 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/selectRoom.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script type="text/javascript" src="js/selectRoom.js"></script>
<script>
//list 없을때
$(document).ready(function(){
   let list = <%=lists.size()%>;
      //alert(list.length);
      if(list == 0) {
         $(".noData").css("display", "");
      } 
});

function fncOpenRoomInfo(num){
	var num = num;
	$.ajax({
		type : 'POST',
		url : './RoomInfoServlet',
		data : {num : num},
		dataType : "json",
		success : function(data){
			$('#layerPopup .title').text(data.name);
			$('.contBox1 img').attr('src',data.img);
			$('.contBox2 li:nth-child(1) dd').text(data.location);
			$('.contBox2 li:nth-child(2) dd').text(data.beds);
			$('.contBox2 li:nth-child(3) dd').text(data.size);
			$('.contBox2 li:nth-child(4) dd').text(data.features);
			$('.contBox2 li:nth-child(5) dd').text(data.view);
			
			var bath = (data.bath).split('//');
			for(var i=0; i<bath.length; i++){
				$('#tab01 ul').append("<li>" + bath[i] + "</li>");
			}
			var bed = (data.bed).split('//');
			for(var i=0; i<bed.length; i++){
				$('#tab02 ul').append("<li>" + bed[i] + "</li>");
			}
			var minibar = (data.minibar).split('//');
			for(var i=0; i<minibar.length; i++){
				$('#tab03 ul').append("<li>" + minibar[i] + "</li>");
			}
			var closet = (data.closet).split('//');
			for(var i=0; i<closet.length; i++){
				$('#tab04 ul').append("<li>" + closet[i] + "</li>");
			}
			
			$('#layerPopup').fadeIn("fast");
		}
	});
}

//비교함 빼기
function fncSubCompareProduct(roomNum){
	var removeTarget = jQuery(".compList li[role="+roomNum+"]");
	var removeTargetDetail = jQuery(".compList02 li[role="+roomNum+"]");
	var renameTarget = jQuery("#room_"+roomNum);
	var newFloatingStr = ""; //새로 그려줄 영역 STR
	var compareCnt = 0; //비교함 갯수
	
	//비교함, 팝업창 지우기
	removeTarget.remove();
	removeTargetDetail.remove();
	
	//str에 넣을거 적고
	newFloatingStr += "<li>";
	newFloatingStr += "<div class=\'compWrap noCont'\>";
	newFloatingStr += "<p class=\'txt'\>비교할 상품을 추가하실 수 있습니다.</p>";
	newFloatingStr += "<span class=\'thum'\></span>";
	newFloatingStr += "</div>";
	newFloatingStr += "</li>";
	
	//str 추가
	jQuery(".compList").append(newFloatingStr);
	
	//버튼 글자 및 onclick 변경
	renameTarget.find("button.btnRsv2").text("COMPARE");
	renameTarget.find("button.btnRsv2").attr("onclick", "fncAddCompareProduct("+roomNum+")");
	
	//li에  인덱스값 다시 부여하기
	jQuery(".compList li").each(function(idx){
		jQuery(this).attr("data-index",idx);
	});
	
	//비교하기 갯수 구하기
	jQuery(".compList li").find(".compWrap").each(function(){
		if(!jQuery(this).hasClass("noCont")){
			compareCnt++;
		}
	});
	
	//비교하기 갯수 반영
	jQuery(".comparison .btnArea button").text(compareCnt+"개 비교하기");
	
	//비교하기가 2개 이하일 때는 안되야함 - 알럿창
	if(compareCnt < 2){
		jQuery(".comparison .btnWrap button").attr("onclick", "alert('비교할 상품을 2개 이상 담아주세요.'); return false;");
	}
	
	//비교함 갯수가 0일때는 비교함전체화면 숨기기
	if(compareCnt == 0){
		jQuery(".comparison").hide();
	}
}

//비교함 추가
function fncAddCompareProduct(roomNum){
	var targetIdx = -1; 
	var listRoom = jQuery("#room_"+roomNum);
	var compareCnt = 0; //비교함 개수
	var compareStr = ""; //플로팅 str
	var compareDetailStr = ""; //팝업 str
	var duplicateYn = false;
	
	//비교함 html
	compareStr += "<div class=\'compWrap'\>";
	compareStr += "<p class=\'txt'\ style=\'color:#fff'\>" + listRoom.find(".roomName").text() + "</p>";
	compareStr += "<span class=\'thum'\><img src=\'" + listRoom.find(".thum img").attr("src") + "'\></span>";
	compareStr += "</div>";
	compareStr += "<button type=\'button'\ class=\'btnDel'\ onclick=\'fncSubCompareProduct("+roomNum+")'\>비교함 삭제</button>";
	
	//팝업창 html
	compareDetailStr += "<li role=\'" + roomNum + "'\>";
	compareDetailStr += "<dl>";
	compareDetailStr += "<dt class=\'tit'\>" + listRoom.find(".roomName").text() + "</dt>";
	compareDetailStr += "<dd class=\'thum'\><img src=\'" + listRoom.find(".thum img").attr("src") + "'\></dd>";
	compareDetailStr += "<dd class=\'txt'\>" + listRoom.find(".roomIntro .roomBenefit").text() + "</dd>";
	compareDetailStr += "<dd class=\'price'\>" + listRoom.find(".priceWrap .price").text().replace("~"," ") + "</dd>";
	compareDetailStr += "<dd><button type=\'button'\ class=\'btnToggle btnSC btnRsv'\ onclick=\'roomReserveBtn("+roomNum+")'\>예약하기</button></dd>";
	compareDetailStr += "</dl>";
	compareDetailStr += "</li>";
	
	//비교함에 동일한 상품이 있는지 체크
	jQuery(".compList").find("li").each(function(){
		if(jQuery(this).attr("role") == roomNum){
			duplicateYn = true;
			return false;
		}
	});
	
	//동일한 상품이 있다면 이미 등록되어 있다고 알림
	if(duplicateYn){
		alert("이미 동일한 상품이 들어있습니다.");
		return false;
	}
	
	//동일한 상품이 없다면 등록하기
	//추가할 영역 index 찾기
	jQuery(".compList").find(".compWrap").each(function(){
		compareCnt++;
		if(jQuery(this).hasClass("noCont")){
			targetIdx = jQuery(this).closest("li").data("index");
			return false;
		}
	});
	
	//console.log(compareCnt);
	//최대 3개까지 --> 이건 방이 더 있을 경우에 발생함
	if(targetIdx == -1){
		alert("상품은 최대 3개까지 추가 가능합니다.");
		return false;
	}
	
	//버튼 글자 및 onclick 변경
	listRoom.find("button.btnRsv2").text("UNCOMPARE");
	listRoom.find("button.btnRsv2").attr("onclick", "fncSubCompareProduct("+roomNum+")");
	
	//비교하기 갯수 추가
	jQuery(".comparison .btnArea button").text(compareCnt+"개 비교하기"); 
	
	if(compareCnt > 1){
		jQuery(".comparison .btnWrap button").attr("onclick", "popShow('#layerPop1');");
	}
	
	//그 index에 role 값과 str 넣기
	jQuery(".compList").find("li[data-index='"+targetIdx+"']").attr("role",roomNum);
	jQuery(".compList").find("li[data-index='"+targetIdx+"']").html(compareStr);
	jQuery("#layerPop1").find(".compList02").append(compareDetailStr);
}

//비교함 팝업창 보이기
function popShow(){
	var layerCont = jQuery("#layerPop1").find(".layerCont");
	jQuery("#layerPop1").fadeIn("fase");
	layerCont.css({
		'top':'50%',
		'left':'50%',
		'margin-top':-(layerCont.outerHeight() / 2),
		'margin-left':-(layerCont.outerWidth() / 2)
	});
}

//비교함 팝업창 숨기기
function popClose(){
	jQuery("#layerPop1").fadeOut("fase");
}

function roomReserveBtn(roomNum){
	var form = document.step1Form;
	document.getElementById("roomNum").value = roomNum; 
	document.getElementById("command").value = "optionSelect";
	var loginCheck = "<%=session.getAttribute("idKey")%>";
	console.log(loginCheck);
	
	if(loginCheck == "null"){
		alert('회원가입 또는 로그인 후 예약 가능합니다.');
		location.href="/ProjectWepJosun/Controller?command=RoomLoginAction&startDate=<%=startDate%>&endDate=<%=endDate%>&adltCntArr=<%=adltCntArr%>&chldCntArr=<%=chldCntArr%>";
	}else{
		form.action= "Controller";
		form.submit();
	}
}
</script>
</head>
<body>
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
		<form action="" name="step1Form" id="step1Form" method="post">
			<input type="hidden" name="startDate" id="startDate" value="${startDate}">
			<input type="hidden" name="endDate" id="endDate" value="${endDate }">
			<input type="hidden" name="adltCntArr" id="adltCntArr" value="${adltCntArr}">
			<input type="hidden" name="chldCntArr" id="chldCntArr" value="${chldCntArr }">
			<input type="hidden" name="ckinDay" id="ckinDay" value="${ckinDay}">
			<input type="hidden" name="ckoutDay" id="ckoutDay" value="${ckoutDay }">
			<input type="hidden" name="dateDays" id="dateDays" value="${dateDays }">
			<input type="hidden" name="roomNum" id="roomNum" value="">
			<input type="hidden" name="command" id="command" value=""/>
			<div id="container" class="container" style="margin-top: 0px;">
				<!-- 컨텐츠 S -->
				<div class="topArea">
					<div class="topInner">
						<h2 class="titDep1">Booking</h2>
						<div class="stepWrap">
							<ol>
								<li class="on">
								<span class="hidden">현재단계</span>
								<em>객실, 요금 선택</em>
								</li>
								<li>
								<em>옵션 선택</em>
								</li>
								<li>
								<em>예약자 정보 입력</em>
								</li>
							</ol>
						</div>
					</div>
				</div>
				<div class="selResult">
					<div class="inner">
						<div class="infoArea">
							<dl class="dlType01">
								<dt>HOTEL</dt>
								<dd>그랜드 조선 제주</dd>
							</dl>
							<dl class="dlType02">
								<dt>DATE</dt>
								<dd id="dateText"><%=startDate %>&nbsp;<%=ckinDate %>&nbsp;-&nbsp;<%=endDate %>&nbsp;<%=ckoutDate %><span><%=dateDays %> 박</span></dd>
							</dl>
							<dl class="dlType03">
								<dt>ROOMS</dt>
								<dd>1</dd>
							</dl>
							<dl class="dlType03">
								<dt>ADULTS</dt>
								<dd><%=adltCntArr %></dd>
							</dl>
							<dl class="dlType03">
								<dt>CHILDREN</dt>
								<dd><%=chldCntArr %></dd>
							</dl>
						</div>
					</div>
				</div>			
				<div class="inner">
					<div class="roomContainer" style="display: none;">
						<h3 class="hidden">상품으로 보기</h3>
					</div>
					<!-- //roomContainer -->
					<div class="roomContainer" style="">
						<h3 class="hidden">객실로 보기</h3>
						<ul class="toggleList roomList" id="roomList">
							<li class="noData" style="display:none;">
								<p class="txt">
									예약 가능한 객실이 없습니다.<br>
									다시 검색해주세요.
								</p>
								<!-- 객실 내 상품이 없을 경우 -->
							</li>
							<% for(RoomDTO dto : lists){ %>
							<li id="room_<%=dto.getNum() %>">
								<dl class="roomIntro">
									<dt class="roomName"><%=dto.getName() %></dt>
									<dd class="roomBenefit"><%=dto.getDetailView() %> | Size : <%=dto.getrSize() %>㎡</dd>
									<dd class="btnView">
										<a href="#none" class="btnS icoArr" onclick="fncOpenRoomInfo(<%=dto.getNum()%>);">객실 상세보기 </a>
									</dd>
									<dd class="priceWrap">
										<span class="price">
											<%=dto.getPrice() %><em>KRW ~</em>
										</span>
										<span class="day">1박 / 세금 별도</span>
									</dd>
									<dd class="thum">
										<img src="<%=dto.getImg() %>" alt="<%=dto.getName() %>">
									</dd>
									<dd>
										<button type=button class="btnToggle btnSC btnRsv" onclick="roomReserveBtn(<%=dto.getNum() %>)">RESERVE</button>
										<button type=button class="btnToggle btnSC btnRsv2" onclick="fncAddCompareProduct(<%=dto.getNum()%>)">COMPARE</button>
									</dd>
								</dl>
							</li>
							<% } %>
						</ul>
						<!-- //roomList -->
					</div>
				</div>
				<!-- //inner -->
				<!-- 비교함 -->
				<div class="comparison" style="display:none;">
					<div class="btnArea">
						<button type="button" class="btnComp">0개 비교하기</button> <!-- 열렸을 때 on 클래스 추가 -->
					</div>
					<div class="compCont" style="display:none;">
						<div class="compInner">
							<ul class="compList">
								<li data-index="0">	
									<div class="compWrap noCont">
										<p class="txt">비교할 상품을 추가하실 수 있습니다.</p>	
										<span class="thum"></span>									
									</div>
								</li>
								<li data-index="1">	
									<div class="compWrap noCont">
										<p class="txt">비교할 상품을 추가하실 수 있습니다.</p>	
										<span class="thum"></span>									
									</div>
								</li>
								<li data-index="2">	
									<div class="compWrap noCont">
										<p class="txt">비교할 상품을 추가하실 수 있습니다.</p>	
										<span class="thum"></span>									
									</div>
								</li>
							</ul>
							<div class="btnWrap">
								<button type="button" class="btnSC btnM active" onclick="alert('비교할 상품을 2개 이상 담아주세요.'); return false;">비교하기</button>
								<p class="txtGuide">최대 3개 비교 가능</p>
							</div>
						</div>
					</div>
				</div>
				<!-- //비교함 -->
			</div>
			<!-- //container -->
			<div id="layerPopup" class="popup">
				<div class="layerContainer">
					<div class="layerContents">
						<h2 class="title">Prestige Hill Suite</h2>
						<div class="scrollWrap">
							<div class="designScroll">
								<div class="contBox contBox1">
									<img src="img/Room/1.jpg">
									<p class="txtGuide">* 상기 이미지는 이해를 돕기 위한 이미지 컷으로 실제와 다를 수 있습니다.</p>
								</div>
								<div class="contBox contBox2">
									<ul>
										<li>
											<dl>
												<dt>LOCATION</dt>
												<dd>1층 - 6층</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>BEDS</dt>
												<dd>수퍼킹1, 퀸2 또는 퀸4</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>SIZE</dt>
												<dd>193.1</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>ROOM FEATURES</dt>
												<dd>거실 1, 응접실 1, 침실 2, 화장실 2, 펜트리 1, 발코니 1, 프라이빗 풀</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>VIEW</dt>
												<dd>파노라마뷰, 오션뷰</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>CHECK-IN/CHECK-OUT</dt>
												<dd>15:00 / 12:00</dd>
											</dl>
										</li>
									</ul>
								</div>
								<div class="contBox contBox3">
									<h2 class="titDep2">객실 어메니티</h2>
									<ul class="tabType01 tabToggle">
										<li class="on"><a href="#tab01" role="button">Bath Room</a></li>
										<li><a href="#tab02" role="button">Bed Room</a></li>
										<li><a href="#tab03" role="button">Mini Bar</a></li>
										<li><a href="#tab04" role="button">Closet</a></li>
									</ul>
									<div id="tab01" class="tabCont" style="display:block;">
										<ul class="tabRoomInfo">
										</ul>
									</div>
									<div id="tab02" class="tabCont">
										<ul class="tabRoomInfo">
										</ul>
										<p class="txtGuide">* 침구 브랜드 : 150년 역사의 이태리 럭셔리 브랜드 FRETTE (프레떼)</p>
									</div>
									<div id="tab03" class="tabCont">
										<ul class="tabRoomInfo">
										</ul>
									</div>
									<div id="tab04" class="tabCont">
										<ul class="tabRoomInfo">
										</ul>
									</div>
								</div>
								<div class="contBox contBox4">
									<h2 class="titDep2">특별 서비스</h2>
									<ul class="packageCont22">
										<li>
											<dl>
												<dt>GRAN J</dt>
												<dd class="txtArea">
													<p class="txt" style="margin-bottom: 61px;">그랜드 조선 힐 스위트 투숙 고객만을 위한 프라이빗 라운지 그랑 제이, 제주 식재료를 활용한 미식의 향연은<br>여러분의 시간을 더욱 품격있게 만들어 드립니다.</p>
													<div class="sInfo">
														<ul>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">위치</span>
																<span class="txt">그랜드 조선 힐 스위트 1층</span>
															</li>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">시간</span>
																<span class="txt">
																	BREAKFAST 07:30 - 11:00 (서양식 또는 한식 한상차림 제공)
																	<br>COFFEE &amp; TEA SERVICE 12:00 – 17:00
																	<br>GRAN CHOICE 18:00 - 23:00
																</span>
					                                        </li>
														</ul>
													</div>
													<ul class="txtGuide" style="margin-top: 8px;">
					                                    <li style="margin-top: 3px;">* 그랑초이스 : 웰컴 샴페인 1잔 + A LA CARTE 1가지 + 와인/위스키/맥주/칵테일 중 1인당 2잔 선택</li>
					                                    <li style="margin-top: 3px;">* 조식과 그랑초이스는 유료로 제공됩니다.</li>
													</ul>
												</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>HEAVENLY POOL</dt>
												<dd class="txtArea">
													<p class="txt" style="margin-bottom: 61px;">그랜드 조선 힐 스위트 투숙고객만을 위한 헤븐리 풀&라운지, 사계절 따뜻한 온수풀에서<br>마치 하늘 위에 있는듯한 기분을 만끽해보세요.</p>
													<div class="sInfo">
														<ul>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">위치</span>
																<span class="txt">그랜드 조선 힐 스위트 6층</span>
															</li>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">시간</span>
																<span class="txt">
																	09:00 - 22:00
																</span>
					                                        </li>
														</ul>
													</div>
												</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>GX ROOM & SAUNA</dt>
												<dd class="txtArea">
													<p class="txt" style="margin-bottom: 61px;">그랜드 조선 힐 스위트 투숙 고객만을 위한 GX ROOM과 사우나에서 일상에 지친 몸과 마음을<br>시원하게 풀어드립니다.</p>
													<div class="sInfo">
														<ul>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">위치</span>
																<span class="txt">그랜드 조선 힐 스위트 3층</span>
															</li>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">시간</span>
																<span class="txt">
																	07:00 - 22:00
																</span>
					                                        </li>
														</ul>
													</div>
													<ul class="txtGuide" style="margin-top: 8px;">
					                                    <li style="margin-top: 3px;">* 코로나 19 확산방지를 위해 신관 힐 스위트 사우나는 한시적으로 미운영됩니다.</li>
													</ul>
												</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>GARDEN POOL</dt>
												<dd class="txtArea">
													<p class="txt" style="margin-bottom: 61px;">사계절 온수풀로 운영되는 가든 풀은 아이부터 어른까지 모두가 즐길 수 있는 공간입니다.<br>이국적인 정취를 느끼며 완벽한 힐링타임을 경험해보세요.</p>
													<div class="sInfo">
														<ul>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">위치</span>
																<span class="txt">그랜드 조선 제주 1층</span>
															</li>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">시간</span>
																<span class="txt">
																	09:00 - 23:00
																</span>
					                                        </li>
														</ul>
													</div>
													<ul class="txtGuide" style="margin-top: 8px;">
					                                    <li style="margin-top: 3px;">* 코로나 확산방지를 위해 시설운영이 22시까지로 조정됩니다.<br>&nbsp;&nbsp; 본 이용 지침은 추후 정부 지침에 따라 변경 될 수 있습니다.</li>
													</ul>
												</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>PEAK. POOL</dt>
												<dd class="txtArea">
													<p class="txt" style="margin-bottom: 61px;">제주 중문의 아름다운 바다를 보며 스위밍을 즐길 수 있는 성인 전용 온수풀에서 매일 밤 펼쳐지는<br>라이브 디제잉과 함께 특별한 제주의 밤을 만나보세요.</p>
													<div class="sInfo">
														<ul>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">위치</span>
																<span class="txt">그랜드 조선 제주 R층 (루프탑)</span>
															</li>
															<li>
																<span class="tit" style="padding: 5px 15px 5px 0;">시간</span>
																<span class="txt">
																	09:00 - 24:00
																</span>
					                                        </li>
														</ul>
													</div>
													<ul class="txtGuide" style="margin-top: 8px;">
					                                    <li style="margin-top: 3px;">* 코로나 확산방지를 위해 시설운영이 22시까지로 조정됩니다.<br>&nbsp;&nbsp; 본 이용 지침은 추후 정부 지침에 따라 변경 될 수 있습니다.</li>
													</ul>
												</dd>
											</dl>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<button type="button" class="btnClose">닫기</button>
				</div>
			</div>
			<div id="layerPop1" class="layerPop">
				<div class="layerCont">
					<div class="compLayer">
						<h2 class="compTit">패키지 비교하기</h2>
						<ul class="compList02"></ul>
					</div>
					<button type="button" class="btnClose" onclick="popClose('#layerPop1');">닫기</button>
				</div>
			</div>
			<!-- // layerpopup -->
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
</body>
</html>