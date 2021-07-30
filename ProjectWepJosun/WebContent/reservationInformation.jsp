<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; UTF-8");
	
	String id = (String) session.getAttribute("idKey");
	String name = (String) session.getAttribute("nameKey");
	String email = (String) session.getAttribute("emailKey");
	String[] emailArr = null;
	if(email != null){emailArr = email.split("@",2);}		/* 일단 오류를 위해 막아둔거임  */
	String phone = (String) session.getAttribute("phoneKey");
	String[] phoneArr = null;
	if(phone != null){phoneArr = phone.split("-", 3);} 	/* 일단 오류를 위해 막아둔거임  */
	String startDate = (String)request.getAttribute("startDate");
	String endDate = (String)request.getAttribute("endDate");
	String ckinDate = (String)request.getAttribute("ckinDay");
	String ckoutDate = (String)request.getAttribute("ckoutDay");
	int dateDays =(Integer)(request.getAttribute("dateDays"));
	String adltCntArr =(String)request.getAttribute("adltCntArr");
	String chldCntArr = (String)request.getAttribute("chldCntArr");
	String adult_breakfast = (String)request.getAttribute("adult_breakfast");
	String children_breakfast = (String)request.getAttribute("children_breakfast");
	String roomPrice = (String)request.getAttribute("roomPrice");
	String totalPay = (String)request.getAttribute("totalpay");
	String txtRequest = (String)request.getAttribute("txtRequest");
	HashMap<String, Object> map  = (HashMap)request.getAttribute("roomMap");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약자 정보 입력 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/reservationImformation.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/default.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
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

	jQuery(document).ready(function(){
		
		if($("#adult_breakfast").val() != 0){
			let sucbacDay =(Number)($("#dateDays").val()); //숙박일
			let adult_breakfast = (Number)($("#adult_breakfast").val());
			let adult_price = uncomma('<%=map.get("audlts_price")%>');
			let price = sucbacDay*adult_breakfast*adult_price;
			
			$("#roomOptInfo0").css('display','');
			$("#roomOptInfo0 >li:first-child").css('display','');
			$("#roomOptInfo0 > li:first-child .rtData").html(comma(price));
		}
		
		if($("#children_breakfast").val() != 0){
			let sucbacDay =(Number)($("#dateDays").val()); //숙박일
			let chil_breakfast = (Number)($("#adult_breakfast").val());
			let chli_price = uncomma('<%=map.get("children_price")%>');
			let price = sucbacDay*chil_breakfast*chli_price;
			
			$("#roomOptInfo0").append("<li><span class=\"lfData\">어린이 조식</span><span class=\"rtData\">"+comma(price)+"</span></li>")
			/*<li><span class="lfData">어린이 조식</span><span class="rtData">27,000</span></li>*/
		}
		
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
		
		let tax = (josic() + roomAmount)*0.1;
		$("#roomTax0").text(comma(tax));
		let total = Number($("#roomAmount").val()) + Number($("#breakfastAmount").val()) + tax;
		// 합계 기본값 셋팅
		$("#roomAmount0 em").html(comma(total));
		$("#resvTotalAmount").html(comma(total));
		
		if("" != ""){
			alert("");
		}
		
		//카드번호, 생년월일  maxlength만큼 입력 시 다음 input 으로 이동
		jQuery("input[id^='cardNo'], input[type='text'][id^='birth']").keyup(function(idx){
	        var charLimit = jQuery(this).attr("maxlength");
	        if(jQuery(this).attr("role") != "last"){
		        if(this.value.length >= charLimit) {
		        	jQuery(this).parent().next().find("input").focus();
		            return false;
		        }
	        }
	    });
		
		//카드번호, 생년월일  maxlength만큼 입력 시 다음 input 으로 이동
		jQuery("input[id^='moblphonTelno']").keyup(function(idx){
	        var charLimit;
	        var id = jQuery(this).attr("id");
	        if(id == "moblphonTelno"){
	        	charLimit = 3;
	        }else{
	        	charLimit = 4;
	        }
	        if(jQuery(this).attr("role") != "last"){
		        if(this.value.length >= charLimit) {
		        	jQuery(this).parent().next().next().find("input").focus();
		            return false;
		        }
	        }
	    });
		
		/*
			이메일 도메인 정보 수정 시
			직접입력인 경우 email2 input disabled 제거
			도메인 선택 시 도메인 email2 input에 주입 후 disabled
		*/
		jQuery("[name='emailType']").on("change", function(){
			var value = jQuery(this).val();
			if(value == ""){
				jQuery("#email2").val("");
				jQuery("#email2").prop("readonly", false);
			}else{
				jQuery("#email2").val(value);
				jQuery("#email2").prop("readonly", true);
			}
		});
		
		jQuery("input[type='text'],input[type='password'], select").on("keyup change", function(){
			var validFlag = true;
			jQuery(this).closest("li").find("input[type='text'],input[type='password'], select").each(function(idx){
				if(jQuery(this).val() == "" && jQuery(this).attr("id") != "emailType"){
					validFlag = false;
				}	
			});
		
			if(validFlag && jQuery(this).closest("li").hasClass("error")){
				jQuery(this).closest("li").removeClass("error");
				jQuery(this).closest("li").find(".alertMessage").hide();
			}
		});
		
		// 스크롤 이벤트
		$(window).scroll(function(){
			var scroll_top=$(this).scrollTop();
			//console.log(scroll_top);
			if(scroll_top<=550){
				scroll_top=0;
			}else{
				scroll_top -=550;
				console.log(scroll_top);
				if(scroll_top>=971) {
					scroll_top = 971;
				}
			}
			
			$(".rCont.floating").animate({
				top : scroll_top
			},30,'swing');
		});
	});

/**
	예약!		
*/
function fncGoResv(){
	var frstIdx = "";
	/*
		사용자 입력정보 VALIDATION 체크
		해당 열  input, select 박스가 하나라도 미기재 된 경우 validation false
		최초 미입력 된 element로 focus 이동됨
	
	*/
	jQuery(".intList li").each(function(){
		var $this = jQuery(this);
		var validYn = true;
		$this.find("input[type='text'],input[type='password'], select").each(function(idx){
			var value = jQuery(this).val();
			var id = jQuery(this).attr("id");
			if(value == "" && id != "emailType"){
				validYn = false;
				if(frstIdx == ""){
					frstIdx = jQuery(this);
				}
			}
		});		// 공백 검사
		
		if(!validYn){
			$this.addClass("error");	// 공백 일때
			$this.find(".alertMessage").show();
		}else{
			$this.removeClass("error");	// 공백 아닐때
			$this.find(".alertMessage").hide();
		}
	});
	if(frstIdx != ""){
		frstIdx.focus();
		return false;
	}
	
		
	if(!jQuery("#cancelAgree").is(":checked")){
		alert("취소 규정 항목 동의는 필수 입니다."); 
		jQuery("#cancelAgree").focus();
		return false;
	}
		
	jQuery("#policyAgree").prop("checked", true);
	
	var birthExp = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;	// 생년월일 정규식
	var birthMonth = parseInt(jQuery("#birth2").val()) > 9 ? jQuery("#birth2").val() : "0" + parseInt(jQuery("#birth2").val());	// month값
	var birthDay = parseInt(jQuery("#birth3").val()) > 9 ? jQuery("#birth3").val() : "0" + parseInt(jQuery("#birth3").val());	// day값 
	var birth = jQuery("#birth1").val()+birthMonth+birthDay;		// ex)19940307;
	
	if(!birthExp.test(birth)){
		alert("생년월일을 확인해주세요."); 
		return false;
	}
	$("#mobPhoneTelNo").val($("#moblphonTelno").val()+"-"+$("#moblphonTelno1").val()+"-"+$("#moblphonTelno2").val());	//전화번호 더하기
	
	$("#email").val($("#email1").val()+"@"+$("#email2").val());	// 이메일 취합
	
	jQuery("#cardNo").val(jQuery("#cardNo1").val()+"-"+jQuery("#cardNo2").val()+"-"+jQuery("#cardNo3").val()+"-"+jQuery("#cardNo4").val()); //카드번호 취합
	$("#exepiration").val($("#expYear").val()+"/"+$("#expMonth").val());
	/* 
	if(!validateCardNumber(jQuery("#cardNo").val())){
		alert("유효한 카드번호가 아닙니다.\n다시 확인해주세요.");
		jQuery("#cardNo1").focus();
		return false;
	}
	 */
	jQuery("#birth").val(birth);	//생년월일 취합
	
	/*
		예약 유효성 검사
	*/
	var answer;
	answer = confirm("예약 하시겠습니까?");
	if(answer == true){
	   $("#command").val("reservation");
	   $("#step3Form").attr("action", "Controller");
	   $("#step3Form").submit();
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
		<form action="" name="step3Form" id="step3Form" method="post">
		<input type="hidden" name="startDate" id="startDate" value="${startDate}">
		<input type="hidden" name="endDate" id="endDate" value="${endDate }">
		<input type="hidden" name="adltCntArr" id="adltCntArr" value="${adltCntArr}">
		<input type="hidden" name="chldCntArr" id="chldCntArr" value="${chldCntArr}">
		<input type="hidden" name="ckinDay" id="ckinDay" value="${ckinDay}">
		<input type="hidden" name="ckoutDay" id="ckoutDay" value="${ckoutDay }">
		<input type="hidden" name="dateDays" id="dateDays" value="${dateDays }">
		<input type="hidden" name="roomPrice" id="roomPrice" value="${roomPrice}"/>
		<input type="hidden" name="roomNum" id="roomNum" value="<%=map.get("num")%>">
		<input type="hidden" name="adult_breakfast" id="adult_breakfast" value="${adult_breakfast}"/>
		<input type="hidden" name="children_breakfast" id="children_breakfast" value="${children_breakfast }"/>
		<input type="hidden" name="totalpay" id = "totalpay" value="${totalpay}"/>
		<input type="hidden" name="txtRequest" id="txtRequest" value="${txtRequest}"/>
		<input type="hidden" name="id" id="id" value="<%=id %>"/>
		<input type="hidden" name="email" id="email" value=""/>
		<input type="hidden" name="cardNo" id="cardNo" value=""/>
		<input type="hidden" name="command" id="command" value=""/>
		<input type="hidden" name="birth" id="birth" value=""/>
		<input type="hidden" name="exepiration" id="exepiration" value=""/>
			<div id="container" class="container">
				<!-- 컨텐츠 S -->
				<h1 class="hidden">예약</h1>
				<div class="topArea">
					<div class="topInner">
						<h2 class="titDep1">Booking</h2>
						<div class="stepWrap">
							<ol>
								<li class="prev">
								<em>객실, 요금 선택</em>
								</li>
								<li class="prev">
								<em>옵션 선택</em>
								</li>
								<li class="on">
								<span class="hidden">
								현재단계 </span>
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
								<dd><%=adltCntArr %></dd>
							</dl>
							<dl class="dlType03">
								<dt>CHILDREN</dt>
								<dd><%=chldCntArr %></dd>
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
							<ul class="intList">
								<li>
								<!-- 미입력 일 경우 error 클래스 추가 alertMessage 노출 -->
								<div class="intWrap">
									<span class="tit">
									<label for="kName">RESERVATION NAME</label>
									<span class="essential">필수</span>
									</span>
								</div>
								<div class="intInner">
									<span class="intArea">
									<%if(id!=null) { %>
									<input type="text" class="readOn" style="width:440px" name="reservationName" value="<%=name %>" readonly="">
									<%} else { %>
									<input type="text" class="readOn" name="reservationName" style="width:440px" value="">
										<%} %>
									</span>
								</div>
								</li>
								<li>
								<div class="intWrap">
									<span class="tit">
									<label for="phone">PHONE NUMBER</label>
									<span class="essential">필수</span>
									</span>
								</div>
								<div class="intInner phoneInp">
								<input type="hidden" id="mobPhoneTelNo" name="mobPhoneTelNo" value="">
									<%if(id!=null) { %>
									<span class="intArea">
									<input type="text" id="moblphonTelno" name="moblphonTelno" style="width:145px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="<%=phoneArr[0]%>">
									</span>
									<span class="dash"></span>
									<span class="intArea">
									<input type="text" id="moblphonTelno1" name="moblphonTelno1" style="width:145px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="<%=phoneArr[1]%>">
									</span>
									<span class="dash"></span>
									<span class="intArea">
									<input type="text" id="moblphonTelno2" name="moblphonTelno2" style="width:145px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" role="last" value="<%=phoneArr[2]%>">
									</span>
									<span class="alertMessage">휴대폰 번호를 입력해주세요.</span>
									<%} else{ %>
									<span class="intArea">
									<input type="text" id="moblphonTelno" name="moblphonTelno" style="width:145px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="">
									</span>
									<span class="dash"></span>
									<span class="intArea">
									<input type="text" id="moblphonTelno1" name="moblphonTelno1" style="width:145px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="">
									</span>
									<span class="dash"></span>
									<span class="intArea">
									<input type="text" id="moblphonTelno2" name="moblphonTelno2" style="width:145px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" role="last" value="">
									</span>
									<span class="alertMessage">휴대폰 번호를 입력해주세요.</span>
									<%} %>
								</div>
								</li>
								<li>
								<div class="intWrap">
									<span class="tit">
									<label for="eMail">E-MAIL</label>
									<span class="essential">필수</span>
									</span>
								</div>
								<div class="intInner emailInp">
								<%if(id!=null) { %>
									<span class="intArea"><input type="text" id="email1" style="width:273px" aria-required="true" onkeyup="this.value=this.value.replace((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/), '');" value="<%=emailArr[0]%>"></span>
									<span class="dash">@</span>
									<span class="intArea"><input type="text" id="email2" style="width:273px" aria-required="true" onkeyup="this.value=this.value.replace((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/), '');" value="<%=emailArr[1]%>"></span>
								<%} else{ %>
									<span class="intArea"><input type="text" id="email1" style="width:273px" aria-required="true" onkeyup="this.value=this.value.replace((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/), '');" value=""></span>
									<span class="dash">@</span>
									<span class="intArea"><input type="text" id="email2" style="width:273px" aria-required="true" onkeyup="this.value=this.value.replace((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/), '');" value=""/></span>
								<%} %>
									<div class="intArea selectWrap" style="width:273px" first="false">
										<select name="emailType" id="emailType" class="form-control" style="/* display: none; */">
											<option value="">직접 입력</option>
											<option value="naver.com">naver.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="nate.com">nate.com</option>
											<option value="gmail.com">gmail.com</option>
										</select>
									</div>
									<span class="alertMessage">이메일을 입력해주세요.</span>
								</div>
								</li>
								<li>
								<div class="intWrap">
									<div class="titArea">
										<span class="tit">
										<label for="cardType">CREDIT CARD TYPE</label>
										<span class="essential">필수</span>
										</span>
									</div>
								</div>
								<div class="intArea intInner">
									<div class="selectWrap" style="width:900px" first="false">
										<select name="cardCode" id="cardCode" class="form-control" style="/* display: none; */">
											<option value="">카드 선택</option>
											<option value="01">비씨</option>
											<option value="02">국민</option>
											<option value="03">하나(외환)</option>
											<option value="04">삼성</option>
											<option value="06">신한</option>
											<option value="07">현대</option>
											<option value="08">롯데</option>
											<option value="09">한미</option>
											<option value="10">신세계한미</option>
											<option value="11">시티</option>
											<option value="12">농협</option>
											<option value="13">수협</option>
											<option value="14">평화</option>
											<option value="15">우리</option>
											<option value="16">하나</option>
											<option value="17">동남(주택)</option>
											<option value="18">주택</option>
											<option value="19">조흥(강원)</option>
											<option value="20">축협(농협)</option>
											<option value="21">광주</option>
											<option value="22">전북</option>
											<option value="23">제주</option>
											<option value="24">산은</option>
											<option value="25">해외비자</option>
										</select>
									</div>
									<span class="alertMessage">신용카드 종류를 선택해주세요.</span>
								</div>
								</li>
								<li>
								<div class="intWrap">
									<span class="tit">
									<label for="cdNum">CARD NUMBER</label>
									<span class="essential">필수</span>
									</span>
								</div>
								<div class="intInner duobuleInp">
									<span class="intArea"><input type="text" id="cardNo1" style="width:165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" maxlength="4"></span>
									<span class="intArea"><input type="text" id="cardNo2" style="width:165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" maxlength="4"></span>
									<span class="intArea"><input type="text" id="cardNo3" style="width:165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" maxlength="4"></span>
									<span class="intArea"><input type="text" id="cardNo4" role="last" style="width:165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" maxlength="4"></span>
									<span class="alertMessage">신용카드 번호를 입력해주세요.</span>
									<!-- 20200420 수정 -->
								</div>
								</li>
								<li>
								<div class="intWrap">
									<span class="tit">
									<label for="cdMonth">EXPIRY DATE</label>
									<span class="essential">필수</span>
									</span>
								</div>
								<div class="intInner duobuleSelect">
									<div class="intArea selectWrap" style="width:440px" first="false">
										<select name="expMonth" id="expMonth" class="form-control" style="/* display: none; */">
											<option value="">월</option>
											<option value="01">1월</option>
											<option value="02">2월</option>
											<option value="03">3월</option>
											<option value="04">4월</option>
											<option value="05">5월</option>
											<option value="06">6월</option>
											<option value="07">7월</option>
											<option value="08">8월</option>
											<option value="09">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
									</div>
									<div class="intArea selectWrap" style="width:440px" first="false">
										<select id="expYear" name="expYear" style="/* display: none; */">
											<option value="">년</option>
											<option value="2021">2021년</option>
											<option value="2022">2022년</option>
											<option value="2023">2023년</option>
											<option value="2024">2024년</option>
											<option value="2025">2025년</option>
											<option value="2026">2026년</option>
											<option value="2027">2027년</option>
											<option value="2028">2028년</option>
											<option value="2029">2029년</option>
											<option value="2030">2030년</option>
											<option value="2031">2031년</option>
										</select>
									</div>
									<span class="alertMessage">신용카드 유효기간을 선택해주세요.</span>
								</div>
								</li>
								<li>
								<div class="intWrap">
									<span class="tit">
									<label for="cdPassword">CARD PASSWORD</label>
									<span class="essential">필수필수</span>
									</span>
								</div>
								<div class="intInner">
									<span class="intArea">
									<input type="password" id="cardPw" name="cardPw" placeholder="비밀번호 앞 2자리" style="width:165px" aria-required="true" maxlength="2">
									</span>
									<span class="alertMessage">카드 비밀번호를 입력해주세요.(비밀번호 앞 2자리)</span>
									<!-- 20200420 수정 -->
									<!-- 카드 비밀번호를 입력해주세요.(비밀번호 앞 2자리) -->
								</div>
								</li>
								<li>
								<div class="intWrap">
									<span class="tit">
									<label for="dateBirth">DATE OF BIRTH</label>
									<span class="essential">필수필수</span>
									</span>
								</div>
								<div class="intInner duobuleInp">
									<span class="intArea"><input type="text" id="birth1" placeholder="YYYY" style="width:165px" aria-required="true" maxlength="4" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');"></span>
									<span class="intArea"><input type="text" id="birth2" placeholder="MM" style="width:165px" aria-required="true" maxlength="2" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');"></span>
									<span class="intArea"><input type="text" id="birth3" placeholder="DD" style="width:165px" aria-required="true" maxlength="2" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');"></span>
									<span class="alertMessage">생년월일을 입력해주세요.</span>
									<!-- 생년월일을 입력해주세요. -->
								</div>
								</li>
							</ul>
							<p class="txtGuide">
								예약 접수 확인 용도이며, 온라인 예약 시 직접 결제가 이루어지지 않습니다.
							</p>
							<div class="notiContainer">
								<h3 class="titDep3">취소 규정</h3>
								<ul class="toggleList agreeCont">
									<li class="toggleOn">
									<span class="frm type02">
									<input type="checkbox" id="cancelAgree" name="cancelAgree">
									<label for="cancelAgree">
									[필수] 취소 및 노쇼(No-show) 규정에 동의합니다. </label>
									</span>
									<div class="toggleCont" style="display: block;">
										<div class="toggleInner">
											<div class="designScroll">
												<div class="scrollWrap" style="">
													<div class="customScrollBox">
														<ul class="listDep1">
															<li>체크인 7일 전 오후 6시 이전 : 위약금 없이 변경 및 취소 가능</li>
															<li>체크인 7일 전 오후 6시 이후 ~ 1일 전 오후 6시 이전 : 최초 1박 요금의 20% 부과</li>
															<li>체크인 1일 전 오후 6시 이후 : 취소 및 No-show 위약금 발생
															<ul class="listDep2">
																<li>1박 투숙 : 객실료의 80% 위약금 부과</li>
																<li>2박 이상 투숙 : 최초 1박 요금의 100% 부과</li>
															</ul>
															</li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="rCont floating" style="transition: margin-top 0.3s ease-out 0s; top: 0px;">
							<ul class="toggleList rsvList">
								<li class="toggleOn">
								<!-- 기본으로 펼쳐진 경우 toggleOn  추가 -->
								<strong class="listTit">
								객실1 <span class="price" id="roomAmount0"><em>1,001,000</em>KRW</span>
								</strong>
								<button type="button" class="btnToggle"><span class="hidden">상세내용 보기</span></button>
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
														<li style="display: none;"><span class="lfData">봉사료</span><span class="rtData" id="roomService0">0</span></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								</li>
							</ul>
							<div class="totalCont">
								<!-- 20200420 수정 -->
								<div class="totalPrice">
									<!-- saleTxt가 있을땐 type02 -->
									<span class="txt">총 예약금액</span>
									<span class="subTxt">+ 세금(10%)</span>
									<span class="price"><em id="resvTotalAmount">1,001,000</em>KRW</span>
								</div>
								<div class="btnArea">
									<div>
										<a href="#none" class="btnSC btnL active" onclick="fncGoResv();">예약 완료</a>
									</div>
									<!-- 예약완료 -->
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
	<!-- //wrapper -->
</body>
</html>