<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>
<%String id = (String) session.getAttribute("idKey");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>CUSTOMER SERVICE - 문의하기 | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/headerfooter.css">
<link rel="stylesheet" href="css/qna.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="js/header.js"></script>
<script type="text/javascript" src="js/qna.js"></script>
</head>
<body>
	<div class="wrapper">
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
		<div id="container" class="container ctmService mypage">
			<div class="topArea">
				<div class="topInner">
					<h2 class="titDep1">Customer Service</h2>
					<p class="pageGuide">조선호텔앤리조트는 언제나 고객의 목소리에 귀기울이고 있습니다.<br> 소중한 충고와 격려, 또는 제안의 말씀을 남겨 주시면 최대한 반영하여 더 나은 서비스로 보답하겠습니다.
					</p>
				</div>
			</div>
			<div class="inner">
				<!-- LNB -->
				<div class="lnbArea">
					<ul class="lnb ctmType">
						<li class="on"><a href="/ProjectWepJosun/qna.jsp">Q&amp;A</a></li>
						<li><a href="reviewboard?command=reviewmain">REVIEW</a></li>
					</ul>
				</div>
				<!-- MY CONTENTS -->
				<script type="text/javascript">
					function checkSize(input) {
						var fileVal = $("#uploadFile").val();
						fileVal = fileVal.slice(fileVal.indexOf(".") + 1)
								.toLowerCase();
						if (fileVal != "jpg" && fileVal != "png"
								&& fileVal != "jpeg") {
							alert("이미지 파일만 가능합니다. 확장자명을 확인해주세요.");
							input.value = null;
						} else if (input.files
								&& input.files[0].size > (5 * 1024 * 1024)) {
							alert("파일 사이즈가 5mb 를 넘습니다.");
							input.value = null;
						}
					}
				
					function fncRegist(){
						/*
						사용자 입력정보 VALIDATION 체크
						해당 열  input이 하나라도 미기재 된 경우 validation false
						최초 미입력 된 element로 focus 이동됨
						*/
						
						var frstIdx = "";
						jQuery(".intList li").each(function(){
							var $this = jQuery(this);
							var validYn = true;
							$this.find("input[type='text'], select, input[type='radio'], textarea").each(function(idx){
								var value = jQuery(this).val();
								var id = jQuery(this).attr("id");
								var type = jQuery(this).prop("type");
								if(type == "radio"){
									if(!$("input:radio[name='category']").is(":checked")){
										value = "";
									}
								}
								
								
								if(value == "" && id != "emailType" && id != "nmFile1"){
									validYn = false;
									if(frstIdx == ""){
										if(id == "cdVocSource" || id == "dsVocSourceDetail1"){
											frstIdx = jQuery("#cdVocSource-button");
										}else{
											frstIdx = jQuery(this);
										}
									}
								}
								
							});
							
							if(!validYn){
								$this.addClass("error");
								$this.find(".alertMessage").show();
							}else{
								$this.removeClass("error");
								$this.find(".alertMessage").hide();
							}
						});
						if(frstIdx != ""){
							frstIdx.focus();
							return false;
						}
						
						var idPhone = $("#idPhone1").val()+"-"+$("#idPhone2").val()+"-"+$("#idPhone3").val();
						var email = $("#emailId").val()+"@"+$("#eDomain").val();
						$("#idPhone").val(idPhone);
						$("#email").val(email);
						
						// 개인정보 수집ㆍ이용 동의
						if(!jQuery("#privacyAgree").is(":checked")){
							alert("개인정보 수집ㆍ이용에 동의해주세요."); 
							jQuery("#privacyAgree").focus();
							return false;
						}
	
						jQuery("#vocForm").submit();
					}
				</script>
				<%
					String name;
					String userPhone;
					String[] phone = new String[3];
					String userEmail;
					String[] email = new String[2];
					if(id == null || id.equals("")){
						name = "";
						for(int i = 0; i < phone.length; i++){
							phone[i] = "";
							if(i <= email.length-1){
								email[i] = "";
							}
 						}
					}else{
						name = (String) session.getAttribute("nameKey");
						userPhone = (String) session.getAttribute("phoneKey");
						phone = userPhone.split("-");
						userEmail = (String) session.getAttribute("emailKey");
						email = userEmail.split("@");
					}
				%>
				<form id="vocForm" name="writeform" method="post" action="QnaServlet" enctype="multipart/form-data">
				<!-- <input type="hidden" name="command" value="qnaAction"> -->
				<input type="hidden" id="idPhone" name="phone" value="">
				<input type="hidden" id="email" name="email" value="">
				<div class="myContents">
					<h3 class="titDep2">Q&amp;A</h3>
					<% if(id==null || id.equals("")){ %>
						<div class="txtBox" style="">
			                <span class="txt">조선호텔앤리조트 회원이신가요?</span>
			                <a href="Login?url=<%= request.getServletPath() %>" class="btnSC btnM icoArr" style="background: transparent;">로그인하기</a>
		            	</div>
					<% } %>
					<div class="frmInfo">
						<ul class="intList">
							<li class="intList-address">
								<div class="intWrap">
									<span class="tit"><label for="address-01-01">CATEGORY</label><span class="essential">*</span></span>
								</div>
								<div class="intBox">
									<span class="frm">
										<input type="radio" id="cdVocPattern-1" name="category" value="1">
										<label for="cdVocPattern-1">칭찬</label>
									</span>
									<span class="frm">
										<input type="radio" id="cdVocPattern-2" name="category" value="2">
										<label for="cdVocPattern-2">불만</label>
									</span> 
									<span class="frm">
										<input type="radio" id="cdVocPattern-3" name="category" value="3">
										<label for="cdVocPattern-3">질문</label>
									</span> 
									<span class="frm">
										<input type="radio" id="cdVocPattern-4" name="category" value="4">
										<label for="cdVocPattern-4">기타</label>
									</span>
								</div>
							</li>
							<li>
								<div class="intWrap">
									<span class="tit"><label for="dsCont">CONTENT</label><span class="essential">*</span></span>
								</div>
								<div class="intInner">
									<span class="intArea"><textarea id="dsCont" name="content" class="noLine" style="width: 910px"
											placeholder="불건전한 내용(예: 개인정보보안, 불충분한 증거/귀책 사유에 대한 개인 음해성/음란성 비방 등) 또는 광고성 게시물은 사전 통보없이 삭제 처리될 수 있으며, 등록된 의견은 수정이 불가하오니 이 점 양지하여 주시기 바랍니다."></textarea></span>
									<span class="alertMessage">내용을 입력해주세요.</span>
								</div>
								<p class="txtGuide">* 문의 내용을 상세히 기재해 주시면 정확한 답변에 도움이 됩니다.</p>
							</li>
							<li>
								<div class="intWrap">
									<span class="tit"> <label for="kName">NAME</label> <span class="essential">*</span>
									</span>
								</div>
								<div class="intInner">
									<span class="intArea">
										<input type="text" id="korNm" name="name" placeholder="국문 이름을 입력하세요." style="width: 440px" aria-required="true" value="<%=name %>"> 
										<span class="test"></span>
										<span class="alertMessage">이름을 입력해주세요.</span>
									</span>
								</div>
							</li>
							<li>
								<div class="intWrap">
									<span class="tit"><label for="phone">MOBILE</label><span class="essential">*</span></span>
								</div>
								<div class="intInner phoneInp">
									<span class="intArea">
										<input type="text" id="idPhone1" title="first phone number" style="width: 165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="<%=phone[0] %>" maxlength="3">
									</span>
									<span class="dash"></span> 
									<span class="intArea">
										<input type="text" id="idPhone2" title="second phone number" style="width: 165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="<%=phone[1] %>" maxlength="4">
									</span> 
									<span class="dash"></span> 
									<span class="intArea">
										<input type="text" id="idPhone3" title="last phone number" role="last" style="width: 165px" aria-required="true" onkeyup="this.value=this.value.replace(/[^\d\ ]/g, '');" value="<%=phone[2] %>" maxlength="4">
									</span> 
									<span class="alertMessage">휴대폰 번호를 입력해주세요.</span>
								</div>
							</li>
							<li>
								<div class="intWrap">
									<span class="tit"><label for="eMail">E-MAIL</label><span class="essential">*</span></span>
								</div>
								<div class="intInner emailInp">
									<span class="intArea">
										<input type="text" id="emailId" style="width: 244px" aria-required="true" value="<%= email[0]%>">
									</span> 
									<span class="dash">@</span> 
									<span class="intArea">
										<input type="text" id="eDomain" style="width: 244px" aria-required="true" title="이메일주소직접입력" value="<%=email[1]%>">
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
							<li class="intList-address">
								<div class="intWrap">
									<span class="tit"><label for="fgReply-01">REPLY BY</label></span>
								</div>
								<div class="intBox">
									<span class="frm">
										<input type="radio" id="fgReply-01" name="reply" value="이메일" checked>
										<label for="fgReply-01">이메일</label>
									</span> 
									<span class="frm">
										<input type="radio" id="fgReply-02" name="reply" value="전화">
										<label for="fgReply-02">전화</label>
									</span> 
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
											<input type="text" id="nmFile1" class="fileName" name="fileName" style="width: 554px" readonly>
											<!-- btnDel -->
											<button type="button" class="btnDel">삭제</button>
											<!-- //btnDel -->
										</div>
										<label for="uploadFile" class="btnSC btnM">파일선택</label> 
										<input type="file" id="uploadFile" name="uploadFile" class="uploadBtn" accept=".jpg, .jpeg, .png" onchange="checkSize(this)">
									</div>
								</div>
								<p class="txtGuide">* 첨부가능 파일종류 : jpg, png, jpeg (용량 5MB)</p>
							</li>
						</ul>
					</div>
					<!-- 개인정보 수집 및 이용에 관한 동의 -->
					<h4 class="titDep3">개인정보 수집 및 이용에 관한 동의</h4>
					<ul class="toggleList rsvList">
						<li class="">
							<span class="frm type02"> 
								<input type="checkbox" id="privacyAgree" value="Y">
								<label for="privacyAgree">[필수]개인정보 수집 · 이용 동의</label>
							</span>
							<button type="button" class="btnToggle">
								<span class="hidden">상세내용 보기</span>
							</button>
							<!-- 버튼 클릭 시 li에 toggleOn 클래스 추가되면서 toggleCont 펼쳐짐 -->
							<div class="toggleCont">
								<div class="toggleInner">
									<div class="nonSrollWrap">
										<table class="tblH">
											<caption>수집 항목, 수집 목적, 보유 기간으로 구성된 개인정보 수집 이용 동의 항목</caption>
											<thead>
												<tr>
													<th scope="col"><span>수집 항목</span></th>
													<th scope="col"><span>수집 목적</span></th>
													<th scope="col"><span>보유 기간</span></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>이름</td>
													<td>서비스 이용자 식별</td>
													<td rowspan="2" class="boldTxt">상담신청 접수 후 3년</td>
												</tr>
												<tr>
													<td>휴대폰번호, 이메일주소</td>
													<td>서비스 이행을 위한 연락 및 안내, 고지사항 전달, 불만처리 등의 의사소통</td>
												</tr>
											</tbody>
										</table>
										<p class="txtGuide">* 위의 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으나 동의를 거부하실 경우 서비스 이용이 불가합니다.</p>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<div class="btnArea">
	                	<button type="button" class="btnSC btnL active" onclick="fncRegist()">저장</button>
	           		</div>
				</div>
				</form>
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
		<!-- End. container -->
	</div>
</body>
</html>