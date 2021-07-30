package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import conn.DBConn;
import room.ReservationDAO;
import room.ReservationVO;

@WebServlet("/SearchReserveServlet")
public class SearchReserveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		String searchStartDate = request.getParameter("searchStartDate");
		String searchEndDate = request.getParameter("searchEndDate");
		String id = (String)session.getAttribute("idKey");
		
//		System.out.println("넘겨진 정보 : " + searchStartDate + ", " + searchEndDate + ", " + id);
		
		Connection conn = DBConn.getConnection();
		ReservationDAO dao = new ReservationDAO();
		ArrayList<HashMap<String, String>> list = dao.getReserveList(conn, id, searchStartDate, searchEndDate);
		
//		System.out.println("예약내역 리스트 ----------");
		System.out.println(list);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("list", list);
		out.print(obj);
	}

}
