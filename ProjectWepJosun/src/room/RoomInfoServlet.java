package room;

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

@WebServlet("/RoomInfoServlet")
public class RoomInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoomInfoServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 설정 위한
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		Connection conn = DBConn.getConnection();
		RoomDAO dao = new RoomDAO(conn);
		
		String roomNum = request.getParameter("num");
		int num = Integer.parseInt(roomNum);
		
		JSONObject data = new JSONObject(dao.roomInfo(num));
		
		PrintWriter out = response.getWriter();
		out.print(data);
	}

}
