package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.DBConn;

public class DelInfo1Action implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection conn = DBConn.getConnection();
		PrintWriter out = response.getWriter();
		MemberDAO dao = new MemberDAO(conn);
		
		String inputPw = request.getParameter("password");
		String id = (String)session.getAttribute("idKey");
		String curPw = dao.curPwcheck(id);
		
		System.out.println(inputPw + " " + id + " " + curPw);
		
		if(!(inputPw.equals(curPw))) {
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 기존의 비밀번호와 일치하지 않습니다.')");
			out.println("location.href='memberDelete1.jsp'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('유의사항 숙지 후 탈퇴를 진행해주시기 바랍니다.')");
			out.println("location.href='memberDelete2.jsp'");
			out.println("</script>");
		}
		
	}
}
