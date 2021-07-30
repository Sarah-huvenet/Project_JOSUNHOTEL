package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;

public class JoinAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		int pwHintQ = Integer.parseInt(request.getParameter("pwHintQ"));
		String pwHintA = request.getParameter("pwHintA");
		
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		System.out.println(name + id + pw + pwHintQ + pwHintA + address + email + phone);
		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);
		MemberDTO dto = new MemberDTO();
		dto.setName(name);
		dto.setId(id);
		dto.setPw(pw);
		dto.setPwHintQ(pwHintQ);
		dto.setPwHintA(pwHintA);
		dto.setAddress(address);
		dto.setPhone(phone);
		dto.setEmail(email);
		int result = dao.join(dto);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('회원가입이 완료되었습니다.')");
		out.println("location.href='Login'");
		out.println("</script>");
	}
}
