<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="room.*" %>
<%
	String id = (String) session.getAttribute("idKey");
	List<ReservationVO> lists = (List<ReservationVO>)request.getAttribute("lists");
	String pageNav = (String)request.getAttribute("page");
	System.out.println(pageNav);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/adminReservation.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="wrapper">
	<!-- Start. headerbar -->
	<div class="headerbar">
		<div class="maintit">
			<p>administrator</p>
		</div>
		<div class="hbmnu">
			<ul>
				<li>
					<a href="/ProjectWepJosun/main.jsp">홈페이지</a> <!-- 클릭하면 홈페이지 메인으로 이동 -->
				</li>
				<li>
					<a href="Logout">로그아웃</a> <!-- 클릭하면 로그아웃되면서, 홈페이지 로그인화면으로 이동 -->
				</li>
			</ul>
		</div>
	</div>
	<!-- End. headerbar -->
	<!-- Start. container -->
	<div class="container">
		<div class="left">
			<ul>
				<li><a href="/ProjectWepJosun/Controller?command=adminMemberList"><i class="fas fa-users-cog"></i> 회원관리</a></li>
				<li class="on"><a href="/ProjectWepJosun/Controller?command=adminReservationList"><i class="fas fa-calendar-alt"></i> 예약관리</a></li>
				<li><a href="/ProjectWepJosun/adminQnaList.jsp"><i class="fas fa-question-circle"></i> 문의글 관리</a></li>
			</ul>
		</div>
		<div class="right">
			<form name="searchfrm" method="post" action="Controller">
				<input type="hidden" name="command" value="adminReservationList">
				<div class="search">
					<div class="selectWrap">
						<select name="searchKey" id="searchType" class="form-control">
							<option value='name'>예약자</option>
							<option value='phone_number'>핸드폰번호</option>
						</select>
					</div>
					<div class="searchtxt">
					    <input type="text" name="searchValue" value="" placeholder="검색어를 입력해주세요.">
					</div>
					<div class="button">
					    <button type="submit">검색</button>
					</div>
				</div>
			</form>
			<div class="contents">
				<table class="memberList">
					<thead>
						<tr>
							<th rowspan="2">번호</th>
							<th rowspan="2">예약자</th>
							<th rowspan="2">예약룸</th>
							<th rowspan="2" style="width:17%;">예약일자</th>
							<th colspan="2" style="border-bottom:none;">예약인원수</th>
							<th colspan="2" style="border-bottom:none;">조식</th>
							<th rowspan="2" style="width:25%;">문의사항</th>
							<th rowspan="2">결제금액</th>
							<th rowspan="2">핸드폰번호</th>
						</tr>
						<tr>
							<th style="width:6%;">성인</th>
							<th style="width:6%;">어린이</th>
							<th style="width:6%;">성인</th>
							<th style="width:6%; border-right:none;">어린이</th>
						</tr>
					</thead>
					<tbody>
						<%for(ReservationVO vo : lists){%>
						<tr>
							<td><%=vo.getRnum()%></td>
							<td><%=vo.getName()%></td>
							<td><%=vo.getRoom_number()%></td>
							<td><%=vo.getStartDate()%> ~ <%=vo.getEndDate()%></td>
							<td><%=vo.getAdultCnt()%></td>
							<td><%=vo.getChildrenCnt()%></td>
							<td><%=vo.getAdult_breakfast()%></td>
							<td><%=vo.getChil_breakfast()%></td>
							<td><%=vo.getRequest()%></td>
							<td><%=vo.getPay()%></td>
							<td><%=vo.getPhoneNum()%></td>
						</tr>
						<%}%>
					</tbody>
				</table>
				<div class="page">
					<%=pageNav %>
				</div>
			</div>
		</div>
	</div>
	<!-- End. container -->
</div>
<!-- 전체 감싸는 .wrapper -->
</body>
</html>