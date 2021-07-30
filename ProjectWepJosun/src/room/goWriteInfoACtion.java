package room;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.DBConn;
import room.RoomDAO;
import member.*;

public class goWriteInfoACtion implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; utf-8");
		
		String startDate = request.getParameter("startDate");
		System.out.println("체크인 날짜 : " + startDate);
		String endDate = request.getParameter("endDate");
		System.out.println("체크아웃 날짜 : " + endDate);
		String adltCnt =request.getParameter("adltCntArr");
		System.out.println("어른 수 : "+adltCnt);
		String chldCnt = request.getParameter("chldCntArr");
		System.out.println("아이 수 : "+chldCnt);
		String ckinDay = request.getParameter("ckinDay");
		System.out.println("체크인 요일 : " + ckinDay);
		String ckoutDay = request.getParameter("ckoutDay");
		System.out.println("체크아웃 요일 : " + ckoutDay);
		int dateDays = Integer.parseInt(request.getParameter("dateDays"));
		System.out.println("숙박일 : " + dateDays);
		int roomNum =Integer.parseInt(request.getParameter("roomNum"));
		System.out.println("방번호 : "+ roomNum);
		String roomPrice = request.getParameter("roomPrice");
		System.out.println("방가격 : " + roomPrice);
		String adultBreakfast = request.getParameter("adult_breakfast");
		System.out.println("어른 조식 수 : " + adultBreakfast );
		String childrenBreakfast = request.getParameter("children_breakfast");
		System.out.println("아이 조식 수 : " + childrenBreakfast);
		String totalPay = request.getParameter("totalpay");
		System.out.println("총 가격 : " + totalPay);
		String txtRequest = request.getParameter("contArr");
		System.out.println("요청사항 : " + txtRequest);
		RoomDAO dao = new RoomDAO(DBConn.getConnection());
		HashMap<String, Object> map = dao.roomOptionInfo(roomNum);
		
		RequestDispatcher rd = request.getRequestDispatcher("reservationInformation.jsp");
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("adltCntArr", adltCnt);
		request.setAttribute("chldCntArr", chldCnt);
		request.setAttribute("ckinDay",ckinDay);
		request.setAttribute("ckoutDay",ckoutDay);
		request.setAttribute("dateDays", dateDays);
		request.setAttribute("roomPrice", roomPrice);
		request.setAttribute("adult_breakfast", adultBreakfast);
		request.setAttribute("children_breakfast", childrenBreakfast);
		request.setAttribute("totalpay", totalPay);
		request.setAttribute("txtRequest", txtRequest);
		request.setAttribute("roomMap", map);
		rd.forward(request, response);
	}
}
