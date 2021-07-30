<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String id = (String) session.getAttribute("idKey");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>아이디 / 비밀번호 찾기  | 그랜드 조선 호텔 </title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/findId.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script type="text/javascript" src="js/findId.js"></script>
</head>
<body>
	<div class="wrapper">
		<!-- Start. header -->
		<div class="header">
			<!-- 메뉴 열리면 gnbOn 클래스 추가 -->
			<div class="headArea">
				<strong class="logo"><a href="/ProjectWepJosun/main.jsp">JOSUN HOTELS &amp; RESORTS</a></strong>
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
		<!-- Start. container -->
		<div id="container" class="container findingBox">
			<div class="topArea">
				<h2 class="titDep2">아이디 / 비밀번호 찾기</h2>
			</div>
			<!-- Start. inner -->
			<div class="inner">
				<ul class="tabType01 tabType02">
					<li id="tabId" class="off on"><a href="javascript:tabChange('id');">아이디 찾기</a></li>
					<li id="tabPw" class="off"><a href="javascript:tabChange('pw');">비밀번호 찾기</a></li>
				</ul>
				<!-- tabCont(아이디찾기) -->
				<script>
					function findID(){
						var name = jQuery.trim(jQuery("#nameId").val());
						
						var phone1 = jQuery.trim(jQuery("#idPhone1").val());
						var phone2 = jQuery.trim(jQuery("#idPhone2").val());
						var phone3 = jQuery.trim(jQuery("#idPhone3").val());
						var phone = phone1 + "-" + phone2 + "-" + phone3;
						
						var emailId = jQuery.trim(jQuery("#emailId").val());
						var eDomain = jQuery.trim(jQuery("#eDomain").val());
						var email = emailId + "@" + eDomain;
						
						jQuery("#phone").val(phone);
						jQuery("#email").val(email);
						
						/*
						사용자 입력정보 VALIDATION 체크
						해당 열  input, select 박스가 하나라도 미기재 된 경우 validation false
						최초 미입력 된 element로 focus 이동됨
						 */
						var frstIdx = "";
						jQuery("#tab01 .intList li").each(function(){
							var $this = jQuery(this);
							var validYn = true;
							$this.find("input[type='text'],input[type='password']").each(function(idx){
								var value = jQuery(this).val();
								var id = jQuery(this).attr("id");
								if(value == "" && id != "emailType"){
									validYn = false;
									if(frstIdx == ""){
										frstIdx = jQuery(this);
									}
								}
							});
	
							if(!validYn){
								$this.addClass("error");
							}else{
								$this.removeClass("error");
							}
						});
						
						//전체 값들이 들어갈때까지
						if(frstIdx != ""){
							frstIdx.focus();
							return false;
						}else{
							$.ajax({
								type : 'POST',
								url : './findIdServlet',
								data : {name : name, phone : phone, email : email},
								success : function(data){
									if(data == 'null' || data == ""){
										//팝업창 띄우기
										$('#findIdBox').fadeIn("fast").children('.boxContainer2').show();
									}else{
										//팝업창 띄우기
										$('#findIdBox').fadeIn("fast").children('.boxContainer').show();
										$('#findIdBox .findId').text(data);
									}
								} 
							});
						}
					}
				</script>
				<div id="tab01" class="tabCont" style="">
					<div class="txtBox">
						<p class="txtBoxTitle"><strong style="font-size:30px; display: inline-block; margin-bottom:5px;">아이디를 잊으셨나요?</strong><br>아래사항 인증을 통해<br>아이디를 확인하실 수 있습니다.</p>
						<p class="txtBoxDescription">회원님의 개인정보와 일치하지 않는 소유자의 휴대폰일 경우,<br>확인이 이루어지지 않습니다.</p>
						<p class="txtBoxDescription">회원가입 시, 기입한 내용으로 검색해주세요.</p>
						<div class="frmBox">
							<ul class="intList">
								<li>
									<div class="intWrap">
										<span class="tit">
											<label for="name">이름</label> <span class="essential">*</span> 
										</span>
									</div>
									<div class="intInner">
										<span class="intArea"> 
											<input type="text" id="nameId" name="name" placeholder="국문 이름을 입력해주세요." aria-required="true" value="">
										</span>
									</div>
								</li>
								<li>
									<input type="hidden" id="phone" name="phone">
									<div class="intWrap">
										<span class="tit">
											<label for="idPhone1">휴대폰 번호</label> <span class="essential">*</span>
										</span>
									</div>
									<div class="intInner phoneInp">
										<span class="intArea"> 
											<input type="text" id="idPhone1" title="first phone number" style="width:92px;" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="" maxlength="3">
										</span> 
										<span class="dash"></span> 
										<span class="intArea"> 
											<input type="text" id="idPhone2" title="second phone number" aria-required="true"  style="width:92px;" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="" maxlength="4">
										</span> 
											<span class="dash"></span> 
											<span class="intArea"> 
												<input type="text" id="idPhone3" title="last phone number" role="last" aria-required="true"  style="width:92px;" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="" maxlength="4">
											</span>
									</div>
								</li>
								<li>
									<input type="hidden" id="email" name="email">
									<div class="intWrap">
										<span class="tit">
											<label for="emailId">이메일 주소</label> <span class="essential">*</span>
										</span>
									</div>
									<div class="intInner emailInp">
										<span class="intArea">
											<input type="text" id="emailId" style="width: 100px" aria-required="true" value="">
										</span> 
										<span class="dash">@</span> 
										<span class="intArea">
											<input type="text" id="eDomain" style="width: 100px; margin-right:9px;" aria-required="true" title="이메일주소직접입력" value="">
										</span>
										<div class="intArea selectWrap" style="width: 116px; display:inline-block;">
											<select name="emailType" id="emailType" class="form-control">
												<option value="">직접입력</option>
												<option value="naver.com">naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="gmail.com">gmail.com</option>
											</select>
										</div>
									</div>
								</li>
							</ul>
						</div>
						<div class="btnArea">
							<button type="button" class="btnSC btnL active" onclick="findID()">아이디 찾기</button>
						</div>
					</div>
				</div>
				<!-- tabCont(비밀번호찾기) -->
				<script>
					function findPw(){
						var name = jQuery.trim(jQuery("#namePw").val());
						var id = jQuery.trim(jQuery("#id").val());
						
						var userPwHintQ = jQuery.trim(jQuery("#pwHintType").val());
						jQuery("#pwHintQ").val(userPwHintQ);
						
						var pwHintQ = jQuery("#pwHintQ").val();
						var pwHintA = jQuery.trim(jQuery("#pwHintA").val());
						/*
						사용자 입력정보 VALIDATION 체크
						해당 열  input, select 박스가 하나라도 미기재 된 경우 validation false
						최초 미입력 된 element로 focus 이동됨
						 */
						var frstIdx = "";
						jQuery("#tab02 .intList li").each(function(){
							var $this = jQuery(this);
							var validYn = true;
							$this.find("input[type='text'],input[type='password'],input[type='hidden']").each(function(idx){
								var value = jQuery(this).val();
								var id = jQuery(this).attr("id");
								if(value == "" && id != "pwHintType"){
									validYn = false;
									if(frstIdx == ""){
										frstIdx = jQuery(this);
									}
								}
							});
							if(!validYn){
								$this.addClass("error");
							}else{
								$this.removeClass("error");
							}
						});
						//전체 값들이 들어갈때까지
						if(frstIdx != ""){
							frstIdx.focus();
							return false;
						}else{
							$.ajax({
								type : 'POST',
								url : './findPwServlet',
								data : {name : name, id : id, pwHintQ : pwHintQ, pwHintA : pwHintA},
								success : function(data){
									if(data == 'null' || data == ""){
										//팝업창 띄우기
										$('#findPwBox').fadeIn("fast").children('.boxContainer2').show();
									}else{
										//팝업창 띄우기
										$('#findPwBox').fadeIn("fast").children('.boxContainer').show();
										$('#findPwBox .findPw').text(data);
									}
								} 
							});
						}
					}
				</script>
				<div id="tab02" class="tabCont" style="display: none">
					<div class="txtBox">
						<p class="txtBoxTitle"><strong style="font-size:30px; display: inline-block; margin-bottom:5px;">비밀번호를 잊으셨나요?</strong><br>아래사항 인증을 통해 고객님의 비밀번호를 안전하게 이메일 보내드립니다.</p>
						<p class="txtBoxDescription">회원님의 개인정보와 일치하지 않는 소유자의 휴대폰일 경우,<br>확인이 이루어지지 않습니다.</p>
						<p class="txtBoxDescription">회원가입 시, 기입한 내용으로 검색해주세요.</p>
						<div class="frmBox">
							<ul class="intList">
								<li>
									<div class="intWrap">
										<span class="tit">
											<label for="name">이름</label> 
										</span>
									</div>
									<div class="intInner">
										<span class="intArea"> 
											<input type="text" id="namePw" name="name" placeholder="국문 이름을 입력해주세요." aria-required="true" value="">
										</span>
									</div>
								</li>
								<li>
									<div class="intWrap">
										<span class="tit">
											<label for="id">아이디</label> 
										</span>
									</div>
									<div class="intInner">
										<span class="intArea"> 
											<input type="text" id="id" name="id" placeholder="아이디를 입력해주세요." aria-required="true" value="">
										</span>
									</div>
								</li>
								<li>
									<input type="hidden" id="pwHintQ" name="pwHintQ">
	                            	<div class="intWrap"><span class="tit"><label for="userPwHintQ">힌트 질문</label></span></div>
	                            	<div class="intInner">
		                            	<div class="intArea selectWrap">
											<select name="userPwHintQ" id="pwHintType" class="form-control">
												<option value=''>질문을 선택하세요</option>
												<option value="1">태어난 곳의 이름은?</option>
												<option value="2">기억하고 싶은 날짜는?</option>
												<option value="3">부모님의 성함은?</option>
												<option value="4">꼭 가장 가보고 싶은 나라는?</option>
												<option value="5">가장 좋아했던 선생님의 성함은?</option>
											</select>
										</div>
									</div>
                           		</li>
                           		<li>
	                            	<div class="intWrap"><span class="tit"><label for="pwHintA">힌트 답</label></span></div>
									<div class="intInner">
	                                    <span class="intArea">
		                                    <input type="text" id="pwHintA" name="pwHintA" placeholder="답변을 입력해주세요." aria-required="true">
	                                    </span>
	                                </div>
                          		</li>								
							</ul>
						</div>
						<div class="btnArea">
							<button type="button" class="btnSC btnL active" onclick="findPw()">비밀번호 찾기</button>
						</div>
					</div>
				</div>
			</div>
			<!-- End. inner -->
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
		<!-- End. container -->
		<!-- 아이디 찾기 결과창 -->
		<div id="findIdBox">
			<div class="boxContainer">
				<div class="boxCont">
					<p>입력하신 정보로 조회된 아이디</p>
					<p class="findId">TEST</p>
				</div>
				<div class="boxBtn">
					<a href="/ProjectWepJosun/login.jsp" class="btnSC btnL active">로그인</a>
				</div>
				<a href="#" class="close">닫기</a>
			</div>
			<div class="boxContainer2">
				<div class="boxCont">
					<img src="img/btn_icon/ico_nodata.gif">
					<p>등록된 회원정보가 없습니다.<br>다시 입력해주세요.</p>
				</div>
				<a href="#" class="close">닫기</a>
			</div>
		</div>
		<!-- End. 아이디 찾기 결과창 -->
		<!-- 비밀번호 찾기 결과창 -->
		<div id="findPwBox">
			<div class="boxContainer">
				<div class="boxCont">
					<p>입력하신 정보로 조회된 비밀번호</p>
					<p class="findPw">TEST</p>
				</div>
				<div class="boxBtn">
					<a href="/ProjectWepJosun/login.jsp" class="btnSC btnL active">로그인</a>
				</div>
				<a href="#" class="close">닫기</a>
			</div>
			<div class="boxContainer2">
				<div class="boxCont">
					<img src="img/btn_icon/ico_nodata.gif">
					<p>등록된 회원정보가 없습니다.<br>다시 입력해주세요.</p>
				</div>
				<a href="#" class="close">닫기</a>
			</div>
		</div>
		<!-- End. 비밀번호 찾기 결과창 -->
	</div>
	<!-- 전체감싸는 .wrapper -->
</body>
</html>