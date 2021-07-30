<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.qna.BoardDAO" %> <!-- BoardDAO의 클래스 가져옴 --> 
<%@ page import="conn.DBConn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 --> 
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 정보를 담는 user클래스를 javabeans 사용--> 
<jsp:useBean id="dto" class="board.qna.BoardDTO" scope="page" /> 
<jsp:setProperty name="dto" property="*" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	int result = dao.insertData(dto);
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('정상적으로 접수되었습니다. 담당자가 확인 후 답변드리겠습니다.')");
	script.println("location.href = 'qna.jsp'");
	script.println("</script>");
%>
</body>
</html>