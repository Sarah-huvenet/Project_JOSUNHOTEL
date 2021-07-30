package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.DBConn;

public class LoginAction implements Action{
	@SuppressWarnings("unused")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		String nextUrl = "null";
		if(request.getParameter("nextUrl")!=null) {
			nextUrl = request.getParameter("nextUrl");
		}
		
		MemberDTO dto = dao.login(id, pw);
		String name = dto.getName();
		String addr = dto.getAddress();
		String phone = dto.getPhone();
		String email = dto.getEmail();
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		
		String startDate = request.getParameter("startDate");	// startDate
		String endDate = request.getParameter("endDate");		// endDate
		String adltCntArr = request.getParameter("adltCntArr");	// adltCntArr
		String chldCntArr = request.getParameter("chldCntArr");	// chldCntArr; 
		
		String referer = request.getHeader("Referer");
		
		if(name == null || name.equals("")) {
			out.println("<script>");
			out.println("alert('조회된 회원 정보가 없습니다.')");
			out.println("location.href = '"+referer+"'");
			out.println("</script>");
		}else {
			session.setAttribute("idKey", id);
			session.setAttribute("nameKey", name);
			session.setAttribute("addrKey", addr);
			session.setAttribute("phoneKey", phone);
			session.setAttribute("emailKey", email);
			
			request.setAttribute("startDate", startDate);
			request.setAttribute("endDate", endDate);
			request.setAttribute("adltCntArr", adltCntArr);
			request.setAttribute("chldCntArr", chldCntArr);
			
			if(nextUrl.equals("/findIdPw.jsp") || nextUrl.equals("/join.jsp")) {
				response.sendRedirect(request.getContextPath() + "/main.jsp");
			}else if(nextUrl.equals("Room")) {
				request.getRequestDispatcher("Controller?command=searchRoom").forward(request, response);
			}else if(nextUrl.equals("null")) {
				request.getRequestDispatcher("main.jsp").forward(request, response);
			}else if(nextUrl.equals("/reviewMain.jsp")) {
	            request.getRequestDispatcher("reviewboard?command=reviewmain").forward(request, response);
	        }else if(nextUrl != null){
				response.sendRedirect(request.getContextPath() + nextUrl);
			}
		}
	}
}
