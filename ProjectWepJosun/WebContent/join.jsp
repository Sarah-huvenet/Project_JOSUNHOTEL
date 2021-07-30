<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="conn.DBConn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
String id = (String) session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입  | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/join.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script type="text/javascript" src="js/join.js"></script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<!-- 메뉴 열리면 gnbOn 클래스 추가 -->
			<div class="headArea">
				<strong class="logo">
					<a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp; RESORTS</a>
				</strong>
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
						<li><a href="/ProjectWepJosun/adminMember.jsp">관리자페이지</a></li>
						<%}else{ %>
						<li><a href="Logout">로그아웃</a></li>
						<li><a href="/ProjectWepJosun/memberReservation.jsp">마이페이지</a></li>
						<%} %>
					</ul>
				</div>
				<!-- //gnbUtil -->
			</div>
		</div><!-- End. header -->
		<div id="container" class="container join">
			<div class="topArea">
				<div class="topInner">
					<h2 class="titDep1">Join Now</h2>
				</div>
			</div>
			<div class="inner">
				<h2 class="titDep2">회원가입 약관</h2>
				<p class="pageGuide tleft">조선호텔앤리조트는 체계적인 회원 정보 관리를 위하여 아래와 같이 개인정보를 수집·이용 및 제공하고자 합니다.<br>내용을 자세히 읽으신 후 동의 여부를 결정하여 주시기 바랍니다.</p>
				<!-- 개인정보이용약관 -->
				<div class="agreeBox">
					<ul	class="toggleList agreeCont">
						<li>
							<span class="frm type02">
								<input type="checkbox" id="frmChk02" name="mberAgreChk" value="A0001"><label for="frmChk02">[필수] 개인정보수집 및 이용에 대한 동의</label>
							</span>
							<button type="button" class="btnToggle"><span class="hidden">상세내용 보기</span></button>
							<div class="toggleCont">
                                <div class="toggleInner">
									<p class="notiTxt">조선호텔앤리조트는 클럽조선 회원가입과 관련하여 아래와 같은 개인정보를 수집 및 이용하고 있습니다.<br>개인정보 처리에 대한 상세한 사항은 조선호텔앤리조트 홈페이지의 '개인정보처리방침'을 참조하십시오.</p>
									<p class="notiTxt">본 개인정보 수집 및 이용 동의서의 내용과 상충되는 부분은 본 동의서의 내용이 우선합니다.</p>
									<table class="tblH">
										<colgroup><col style="width:33%"><col style="width:34%"><col style="width:auto"></colgroup>
										<caption>개인정보수집 및 이용에 대한 동의 목록</caption>
										<thead>
											<tr>
												<th scope="col">수집 항목</th>
												<th scope="col">수집 목적</th>
												<th scope="col">보유 기간</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row" class="tcenter">회원 ID, 비밀번호, 이름, 생년월일, 국적, 성별, 휴대폰번호</th>
												<td>서비스 이용자 식별 및 본인, 14세 이상 여부 확인</td>
												<td class="f18" rowspan="3">회원탈퇴 또는 5년간 이용실적 없을 시</td>
											</tr>
											<tr>
												<th scope="row" class="tcenter">휴대폰번호, 이메일주소</th>
												<td>계약 이행을 위한 연락 및 민원업무 처리 등의 의사소통</td>
											</tr>
											<tr>
												<th scope="row" class="tcenter">주소</th>
												<td>멤버십 카드발송</td>
											</tr>
										</tbody>
									</table>
									<p class="txtGuide">* 위의 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으나 동의를 거부하실 경우 회원가입, 멤버십 서비스 이용이 불가합니다.</p>
                                </div>
                            </div>
						</li>
					</ul>
				</div>
				<h2 class="titDep2">필수정보 입력</h2>
				<div class="frmBox">
					<div class="frmInfo">
						<script type="text/javascript">
							//아이디 유효성 검사
							function fncIdDupChk() {
								//아이디 입력여부 확인alert
								var id = jQuery.trim($("#id").val());		
								var num = id.search(/[0-9]/g); //숫자
								var eng = id.search(/[a-z]/ig); //영문
								var spe = id.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
									
								if(id.length < 1 ) { //아이디를 안적었을 경우
									alert("입력된 아이디가 없습니다.");
									return false;
								}else if(id.length < 8 || id.length > 12){ //8글자 아래, 12글자 위
									alert("아이디는 8자리 ~ 12자리 이내로 입력해주세요.");
									return false;
								}else if(id.search(/\s/) != -1){ //공백문자 X
									alert("아이디는 공백 없이 입력해주세요.");
									return false;
								}else if(num < 0 || eng < 0 ){
									alert("아이디는 영문,숫자를 혼합하여 입력해주세요.");
									return false;
								}else{
									var sendData = id;
									$.ajax({
										type : 'POST',
										url : './idCheckServlet',
										data : {id : sendData},
										success : function(result){
											if(result == 1){
												$('#idCheck').val('Y');
												alert("사용가능한 아이디 입니다.");
											}else{
												$('#idCheck').val('N');
												alert("이미 등록되어 있는 아이디입니다.");
											}
										}
									});
								}
							}
						</script>
						<form action="Controller" id="joinform" name="joinform" method="post">
						<input type="hidden" name="command" value="joinAction">
						<ul class="intList">
							<li>
								<div class="intWrap">
									<span class="tit"><label for="name">NAME</label> <span class="essential">*</span>
									</span>
								</div>
								<div class="intInner">
									<span class="intArea"> 
										<input type="text" id="name" name="name" placeholder="국문 이름을 입력하세요." style="width: 550px" aria-required="true" value="">
										<span class="alertMessage">이름을 입력해주세요.</span>
									</span>
								</div>
							</li>
							<li>
                                <div class="intWrap"><span class="tit"><label for="id">ID</label><span class="essential">*</span></span></div>
                                <div class="intInner">
                                    <span class="intArea">
                                    	<input type="hidden" id="idCheck" name="idCheck" value="N">
                                    	<input type="text" id="id" name="id" placeholder="영문/숫자 조합으로 8 ~ 12자리로만 가능합니다." style="width:515px" aria-required="true">
                                    	<span class="alertMessage">아이디를 입력해주세요.</span>
                                    </span>
                                    <button type="button" class="btnSC btnM" onclick="fncIdDupChk()">ID 중복 확인</button>
                                </div>
                            </li>
                            <li>
                                <div class="intWrap"><span class="tit"><label for="pw">PASSWORD</label><span class="essential">*</span></span></div>
                                <div class="intInner">
                                    <span class="intArea">
                                    	<input type="password" id="pw" name="pw" placeholder="영문/숫자/특수문자를 사용하며, 8 ~ 12자리로만 가능합니다." style="width:515px" aria-required="true">
                                    	<span class="alertMessage">비밀번호를 입력해주세요.</span>
                                    </span>
                                </div>
                                <!-- <p class="txtGuide">* 비밀번호 내 ID가 포함되거나, 연속되는 문자 또는 숫자는 3자리 이상 사용할 수 없습니다.</p> -->
                                <p class="txtGuide">* 특수문자(~!@#$%^&amp;*()_+)중 하나를 선택하시면 됩니다.</p><!-- 2021-02-03 추가 -->
                            </li>
                            <li class="intList-repwd" style="margin-top: -137px !important;">
                                <div class="intWrap"><span class="tit"><label for="pwRe">CONFIRM PASSWORD</label><span class="essential">*</span></span></div>
                                <div class="intInner">
                                    <span class="intArea">
                                    	<input type="password" id="pwRe" name="pwRe" placeholder="영문/숫자/특수문자를 사용하며, 8 ~ 12자리로만 가능합니다." style="width:515px" aria-required="true">
                                    	<span class="alertMessage">동일한 비밀번호를 입력해주세요.</span>
                                    </span>
                                </div>
                            </li>
                            <li>
                            	<div class="intWrap"><span class="tit"><label for="pwHintQ">PASSWORD HINT</label><span class="essential">*</span></span></div>
                            	<div class="intInner">
	                            	<div class="intArea selectWrap" style="width: 400px;">
										<select name="pwHintQ" id="pwHintType" class="form-control">
											<option value="none">질문을 선택하세요</option>
											<option value="1">태어난 곳의 이름은?</option>
											<option value="2">기억하고 싶은 날짜는?</option>
											<option value="3">부모님의 성함은?</option>
											<option value="4">꼭 가장 가보고 싶은 나라는?</option>
											<option value="5">가장 좋아했던 선생님의 성함은?</option>
										</select>
									</div>
								</div>
                            </li>
                            <li class="intList-repwhint" style="margin-top: -60px !important;">
								<div class="intInner">
                                    <span class="intArea">
	                                    <input type="text" id="userPwHint" name="pwHintA" placeholder="답변을 입력해주세요." style="width:515px" aria-required="true">	
                               			<span class="alertMessage" style="left:-422px;">비밀번호 힌트를 작성해주세요.</span>
                                    </span>
                                </div>
                            </li>
                            <li class="intList-address">
                            	<input type="hidden" id="address" name="address">
                                <div class="intWrap"><span class="tit"><label for="address">Address</label><span class="essential">*</span></span></div>
                                <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                               	<script>
                               	function execDaumPostcode(){
								    new daum.Postcode({
								        oncomplete: function(data) {
								            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
								            // http://postcode.map.daum.net/guide 에서 예제를 활용하여 커스텀
								
											$('input[name=postcode]').val(data.zonecode);      // 우편번호(5자리)
											$('input[name=addr]').val(data.address);       // 기본주소
											//$('input[name=addr2]').val(data.buildingName);  // 건물명
								        }
								    }).open();                               		
                               	}
								</script>
                                <div class="intInner">
                                    <span class="intArea"><input type="text" id="postcode" name="postcode" style="width:328px" aria-required="true" readonly=""></span>
                                    <button type="button" class="btnSC btnM" onclick="execDaumPostcode();">우편번호 검색</button>
                                </div>
                                <div class="intInner duobuleInp">
                                    <span class="intArea">
                                    	<input type="text" id="addr" name="addr" style="width:513px" title="주소" aria-required="true" readonly="">
                                    </span>
                                    <span class="intArea">
                                    	<input type="text" id="detailAddr" name="detailAddr" style="width:513px" title="상세주소" placeholder="상세주소를 입력해주세요." aria-required="true">
                                    </span>
                                    <span class="alertMessage" style="top:-90px;">주소를 입력해주세요.</span><!-- 20200528 수정 : 경고문구case(추가2) -->
                                    <span class="alertMessage" style="top:-90px;">상세주소를 입력해주세요.</span>
                                </div>
                            </li>
                            <li>
                            	<input type="hidden" id="phone" name="phone">
								<div class="intWrap">
									<span class="tit"><label for="idPhone">PHONE NUMBER</label><span class="essential">*</span></span>
								</div>
								<div class="intInner phoneInp">
									<span class="intArea">
										<input type="text" id="idPhone1" name="idPhone" title="first phone number" style="width: 165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="" maxlength="3">
									</span>
									<span class="dash"></span> 
									<span class="intArea">
										<input type="text" id="idPhone2" name="idPhone" title="second phone number" style="width: 165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="" maxlength="4">
									</span> 
									<span class="dash"></span> 
									<span class="intArea">
										<input type="text" id="idPhone3" name="idPhone" title="last phone number" role="last" style="width: 165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="" maxlength="4">
									</span> 
									<span class="alertMessage">휴대폰 번호를 입력해주세요.</span>
								</div>
							</li>
                            <li>
                            	<input type="hidden" id="email" name="email">
								<div class="intWrap">
									<span class="tit"><label for="eMail">E-MAIL</label><span class="essential">*</span></span>
								</div>
								<div class="intInner emailInp">
									<span class="intArea">
										<input type="text" id="emailId" style="width: 244px" aria-required="true" value="">
									</span> 
									<span class="dash">@</span> 
									<span class="intArea">
										<input type="text" id="eDomain" style="width: 244px" aria-required="true" title="이메일주소직접입력" value="">
									</span>
									<div class="intArea selectWrap" style="width: 244px">
										<select name="emailType" id="emailType" class="form-control">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="nate.com">nate.com</option>
											<option value="gmail.com">gmail.com</option>
										</select>
									</div>
									<span class="alertMessage">이메일 주소를 입력해주세요.</span>
								</div>
							</li>
						</ul>
						</form>
					</div>
				</div>
				<div class="btnArea">
                    <button type="button" class="btnSC btnL" onclick="javascript:document.referrer ? history.back() : location.href='main.jsp';">취소</button>
                    <button type="button" class="btnSC btnL active" onclick="fncRegist(); return false;">회원가입</button>
                </div>
			</div>
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
	</div>

</body>
</html>