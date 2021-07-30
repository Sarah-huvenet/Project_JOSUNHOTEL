<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="board.qna.BoardDAO" %>
<%@page import="board.qna.BoardDTO" %>
<%@page import="conn.DBConn" %>
<%@page import="board.qna.MyUtil" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.List" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	String id = (String) session.getAttribute("idKey");
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	MyUtil myutil = new MyUtil();
	//넘어온 페이지 번호
	String pageNum = request.getParameter("pageNum");
	//첫 시작시 현재페이지 1
	int currentPage = 1;
	//넘어온 페이지 번호가 존재할 경우, 현재 페이지 값에 넣어주기
	if(pageNum != null){
		currentPage = Integer.parseInt(pageNum);
	}
	//검색키와 키값
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	//검색어가 없을 경우
	if(searchValue==null){
		searchKey = "content";
		searchValue = "";
	}
	//전체 데이터 갯수 구하기
	int dataCount = dao.getDataCount(searchKey, searchValue);
	//한 페이지에 표시할 데이터의 갯수
	int numPerPage = 10;
	//전체 페이지 수 구하기
	int totalPage = myutil.getPageCount(numPerPage, dataCount);
	//전체 페이지 수가 표시할 페이지 수 보다 큰 경우(삭제로 인해)
	if(currentPage > totalPage){
		currentPage = totalPage;
	}
	//데이터베이스에서 가져올 rownum의 시작과 끝
	int start = (currentPage-1)*numPerPage+1;
	int end = currentPage*numPerPage;
	//데이터베이스에서 해당 페이지를 가져온다
	List<BoardDTO> lists = dao.getLists(start, end, searchKey, searchValue);
	String param = "";
	if(!searchValue.equals("")){
		param = "searchKey="+searchKey;
		//param += "&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		param += "&searchValue="+searchValue;
	}
	//페이징 처리
	String listUrl = "adminQnaList.jsp?"+param;
	String pageIndexList = myutil.pageIndexList(currentPage, totalPage, listUrl);
	//글 내용 보기 주소 정리
	String readUrl = cp + "/adminQnaRead.jsp";
	if(param.equals("")){
		readUrl += "?pageNum="+currentPage;
	}else{
		readUrl += param + "&pageNum=" + currentPage;
	}
	DBConn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN | 그랜드 조선 호텔</title>
<link rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/adminQnaList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="js/adminQnaList.js"></script>
<script type="text/javascript">
	function sendIt(){
		f = document.searchfrm;
		f.action = "<%=cp %>/adminQnaList.jsp";
		f.submit();
	}
</script>
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
				<li><a href="/ProjectWepJosun/Controller?command=adminReservationList"><i class="fas fa-calendar-alt"></i> 예약관리</a></li>
				<li class="on"><a href="/ProjectWepJosun/adminQnaList.jsp"><i class="fas fa-question-circle"></i> 문의글 관리</a></li>
			</ul>
		</div>
		<div class="right">
			<form name="searchfrm" method="post" action="">
				<div class="search">
					<div class="selectWrap">
						<select name="searchKey" id="searchType" class="form-control">
							<option value='name'>이름</option>
							<option value='content'>내용</option>
						</select>
					</div>
					<div class="searchtxt">
					    <input type="text" name="searchValue" value="" placeholder="검색어를 입력해주세요.">
					</div>
					<div class="button">
					    <button type="button" onclick="sendIt()">검색</button>
					</div>
				</div>
			</form>
			<div class="contents">
				<table class="qnaList">
					<thead>
						<tr>
							<th style="width:5%;">번호</th>
							<th style="width:10%;">카테고리</th>
							<th style="width:50%;">내용</th>
							<th style="width:10%;">이름</th>
							<th style="width:10%;">답변받을 방식</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
					<% for(BoardDTO dto : lists) { %>
						<tr>
							<td><%=dto.getNum() %></td>
							<td><%=dto.getCategoryT() %></td>
							<td class="content"><a href="<%=readUrl%>&num=<%=dto.getIdx()%>"><%=dto.getContent() %></a></td>
							<td class="date"><%=dto.getName() %></td>
							<td><%=dto.getReply() %></td>
							<td><%=dto.getWriteDate() %></td>
						</tr>
					<%} %>
					</tbody>
				</table>
			</div>
			<div class="page">
				<%=pageIndexList %>
			</div>
		</div>
	</div>
	<!-- End. container -->
</div>
<!-- 전체 감싸는 .wrapper -->
</body>
</html>