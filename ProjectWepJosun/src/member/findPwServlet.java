package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;

@WebServlet("/findPwServlet")
public class findPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public findPwServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글설정
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);
		
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String hintQ = request.getParameter("pwHintQ");
		int pwHintQ = Integer.parseInt(hintQ);
		String pwHintA = request.getParameter("pwHintA");
		
		String pw = dao.findPw(name, id, pwHintQ, pwHintA);
		PrintWriter out = response.getWriter();
		out.print(pw);
	}

}
