package room;

import java.io.IOException;

import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;
import member.Action;

public class SearchRoomAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String startDate = "";
		String endDate = "";
		String adltCntArr = "";
		String chldCntArr = "";
		
		if(request.getAttribute("startDate")==null) {
			startDate = request.getParameter("ckinDate");	// startDate
			endDate = request.getParameter("ckoutDate");		// endDate
			adltCntArr = request.getParameter("adltCntArr");	// adltCntArr
			chldCntArr = request.getParameter("chldCntArr");	// chldCntArr
			System.out.println("룸보기에서 로그인 한 후"+startDate);
		}else {
			startDate = (String)request.getAttribute("startDate");
			endDate = (String)request.getAttribute("endDate");
			adltCntArr = (String)request.getAttribute("adltCntArr");
			chldCntArr = (String)request.getAttribute("chldCntArr");
			System.out.println("메인에서 날짜 선택한 경우"+startDate);
		}
		
		if(chldCntArr == null) {chldCntArr = "0";}	
		//System.out.println(chldCntArr);
		CheckInOutDay checkDay = new CheckInOutDay(startDate, endDate);
		
		String ckinDay = checkDay.startDayCheck(startDate);	// 요일		
		String ckoutDay = checkDay.endDayCheck(endDate);	// 요일
		
		int dateDays = checkDay.seDay(startDate, endDate);	//날짜 차이

		Connection conn = DBConn.getConnection();
		RoomDAO dao = new RoomDAO(conn);
		List<RoomDTO> list = dao.getRoomLists(startDate,endDate); //시작-끝 날짜 받아야함
		
		DBConn.close();
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=showRoom");
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("adltCntArr", adltCntArr);
		request.setAttribute("chldCntArr", chldCntArr);
		request.setAttribute("ckinDay",ckinDay);
		request.setAttribute("ckoutDay",ckoutDay);
		request.setAttribute("dateDays", dateDays);
		request.setAttribute("list", list);
		rd.forward(request, response);
	}

}
