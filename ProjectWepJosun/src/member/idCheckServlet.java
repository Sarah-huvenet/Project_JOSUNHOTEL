package member;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;

@WebServlet("/idCheckServlet")
public class idCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public idCheckServlet() {
		super();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 한글 설정 위한
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);
		
		String id = request.getParameter("id");
		
		// 해당 체크함수는 숫자 결과값 나오기 때매 공백 추가해서 문자열 추가 ""
		// 해당 결과가 0, 1 나온 것을 보내니 ajax에서 결과값으로 받아서 처리
		response.getWriter().write(dao.idCheck(id) + ""); 
	}
}
