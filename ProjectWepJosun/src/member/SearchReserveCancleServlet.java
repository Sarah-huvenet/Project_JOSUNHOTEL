package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import conn.DBConn;
import room.ReservationDAO;

@WebServlet("/SearchReserveCancleServlet")
public class SearchReserveCancleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int reserveNum = Integer.parseInt(request.getParameter("num"));
		int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		System.out.println(reserveNum);
		System.out.println(roomNumber);
		System.out.println(startDate + ", " + endDate);
		
		Connection conn = DBConn.getConnection();
		ReservationDAO dao = new ReservationDAO();
		
		int result = dao.reserveCancle(conn, reserveNum, roomNumber, startDate, endDate);
		System.out.println(result);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		out.print(obj);
	}

}
