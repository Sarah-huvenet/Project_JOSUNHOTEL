<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.EventNotice.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import = "conn.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EVENT &amp; NOTICE | 그랜드 조선 호텔</title>
</head>
<body>
	<!-- 게시글 삭제 -->
	<%
		DBConn dbconn = new DBConn();
		Connection conn = DBConn.getConnection();
		
		int curPage = Integer.parseInt(request.getParameter("idx"));
		
		EventNoticeDAO edao = new EventNoticeDAO();
		
		int delPost = edao.delPost(curPage);
		
		if(delPost == 1) {
			out.println("<script>");
			out.println("alert('게시글이 삭제되었습니다!')");
			out.println("location.href='event_noticeList.jsp';");
			out.println("</script>");
		}
	%>
</body>
</html>