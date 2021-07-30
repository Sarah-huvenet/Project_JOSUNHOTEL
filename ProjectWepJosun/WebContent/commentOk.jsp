<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.qna.BoardCommentDAO" %> <!-- userdao의 클래스 가져옴 --> 
<%@ page import="board.qna.BoardDAO" %> <!-- userdao의 클래스 가져옴 --> 
<%@ page import="conn.DBConn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 --> 
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 정보를 담는 user클래스를 javabeans 사용--> 
<jsp:useBean id="dtoC" class="board.qna.BoardCommentDTO" scope="page" /> 
<jsp:setProperty name="dtoC" property="*" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(dtoC.getContent() == null){
		PrintWriter script = response.getWriter(); 
		script.println("<script>"); 
		script.println("alert('댓글 내용을 입력해주세요.')"); 
		script.println("history.back()"); 
		script.println("</script>");
	}else{
		
		Connection conn = DBConn.getConnection();
		BoardCommentDAO daoC = new BoardCommentDAO(conn);
		int result = daoC.insertCommentData(dtoC);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('완료')");
		script.println("location.href = 'adminQnaRead.jsp?num="+request.getParameter("num")+"&pageNum="+request.getParameter("pageNum")+"'");
		script.println("</script>");
	}
%>
</body>
</html>