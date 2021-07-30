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

@WebServlet("/findIdServlet")
public class findIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public findIdServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 설정 위한
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);
		
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		String id = dao.findId(name, phone, email);
		PrintWriter out = response.getWriter();
		out.print(id);
		//response.getWriter().write(dao.findId(name, phone, email) + "");
	}

}
