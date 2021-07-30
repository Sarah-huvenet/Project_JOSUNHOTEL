package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.DBConn;

public class updatePwAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection conn = DBConn.getConnection();
		PrintWriter out = response.getWriter();
		MemberDAO dao = new MemberDAO(conn);
		
		String id = (String)(session.getAttribute("idKey"));
		String newPw = request.getParameter("newPw");
		String pw = request.getParameter("curPw");			//비밀번호 변경 페이지에서 입력한 패스워드
		String curPw = dao.curPwcheck(id);					//접속한 ID의 패스워드
		int n = dao.updatePw(newPw, id);
		
		System.out.println(id + " " + pw + " " + curPw + " " + newPw + " ");
		if(!(pw.equals(curPw))) {
			out.println("<script>");
			out.println("alert('로그인 된 계정의 비밀번호와 입력한 현재 비밀번호가 일치하지 않습니다. 다시 입력해주세요.')");
			out.println("</script>");
			if(newPw.equals(curPw)) {
				out.println("<script>");
				out.println("alert('기존 비밀번호와 같은 번호를 사용할 수 없습니다.')");
				out.println("location.href='memberPwChange.jsp'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("location.href='memberPwChange.jsp'");
				out.println("</script>");
			}
		} else if(newPw.equals(curPw)) {
			out.println("<script>");
			out.println("alert('기존 비밀번호와 같은 번호를 사용할 수 없습니다.')");
			out.println("location.href='memberPwChange.jsp'");
			out.println("</script>");
		} else if(n == 1){
			out.println("<script>");
			out.println("alert('비밀번호가 변경되었습니다.')");
			out.println("location.href='Login'");
			out.println("</script>");
			session.invalidate();
		} else if(n != 1) {
			out.println("<script>");
			out.println("alert('비밀번호 변경에 실패하였습니다.')");
			out.println("location.href='memberPwChange.jsp'");
			out.println("</script>");
			
		}
	}
}
