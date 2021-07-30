package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.DBConn;

public class DelInfo2Action implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection conn = DBConn.getConnection();
		PrintWriter out = response.getWriter();
		MemberDAO dao = new MemberDAO(conn);
		
		String id = (String)session.getAttribute("idKey");
		
		int result = dao.delMember(id);
		
		System.out.println(id + " " + result);
		
		if(result == 1) {
			out.println("<script>");
			out.println("alert('회원정보 및 개인정보가 삭제되었습니다.')");
			out.println("</script>");
			session.invalidate();
			out.println("<script>");
			out.println("location.href='main.jsp'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('회원정보 삭제 실패. 들어오는건 회원님 마음이지만 나가는건 제 마음입니다.')");
			out.println("location.href='memberDelete2.jsp'");
			out.println("</script>");
		}
		
	}
}
