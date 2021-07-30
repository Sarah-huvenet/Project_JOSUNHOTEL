package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('로그아웃되었습니다. 이용해주셔서 감사합니다.')");
		out.println("location.href = 'main.jsp'");
		out.println("</script>");
	}

}
