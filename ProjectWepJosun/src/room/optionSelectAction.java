package room;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;
import room.RoomDAO;
import member.*;


public class optionSelectAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; utf-8");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String adltCnt = request.getParameter("adltCntArr");
		String chldCnt = request.getParameter("chldCntArr");
		String ckinDay = request.getParameter("ckinDay");
		String ckoutDay = request.getParameter("ckoutDay");
		String dateDays = request.getParameter("dateDays");
		int roomNum = Integer.parseInt(request.getParameter("roomNum"));
		
		RoomDAO dao = new RoomDAO(DBConn.getConnection());
		HashMap<String, Object> map = dao.roomOptionInfo(roomNum);
		
		DBConn.close();
		
		RequestDispatcher rd = request.getRequestDispatcher("selectOption.jsp");
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("adltCnt", adltCnt);
		request.setAttribute("chldCnt", chldCnt);
		request.setAttribute("ckinDay",ckinDay);
		request.setAttribute("ckoutDay",ckoutDay);
		request.setAttribute("dateDays", dateDays);
		request.setAttribute("room", map);
		request.setAttribute("roomNum", roomNum);
		
		rd.forward(request, response);
	}

}
