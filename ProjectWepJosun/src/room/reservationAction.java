package room;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;
import member.*;

public class reservationAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; utf-8");
		
		String name = request.getParameter("reservationName");
		System.out.println("예약자 명 : " + name);
		String startDate = request.getParameter("startDate");
		System.out.println("체크인 날짜 : " + startDate);
		String endDate = request.getParameter("endDate");
		System.out.println("체크아웃 날짜 : " + endDate);
		int adltCnt =Integer.parseInt(request.getParameter("adltCntArr"));
		System.out.println("어른 수 : " + adltCnt);
		int chldCnt = Integer.parseInt(request.getParameter("chldCntArr"));
		System.out.println("아이 수 : " + chldCnt);
		int adultBreakfast = Integer.parseInt(request.getParameter("adult_breakfast"));
		System.out.println("어른 조식 수 : " + adultBreakfast );
		int childrenBreakfast = Integer.parseInt(request.getParameter("children_breakfast"));
		System.out.println("아이 조식 수 : " + childrenBreakfast);
		String txtRequest = request.getParameter("txtRequest");
		System.out.println("요청사항 : " + txtRequest);
		String phoneNum  = request.getParameter("mobPhoneTelNo");
		System.out.println("전화번호 : " + phoneNum);
		String email = request.getParameter("email");
		System.out.println("이메일 주소 : "+email);
		String cardtype = request.getParameter("cardCode");
		System.out.println("카드사NO : " + cardtype);
		String cardNo = request.getParameter("cardNo");
		System.out.println("카드번호 : " + cardNo);
		String cardExe = request.getParameter("exepiration");
		System.out.println("카드 유효기간 : " + cardExe);
		String birth = request.getParameter("birth");
		System.out.println("생일 : "+birth);
		int totalPay = Integer.parseInt(request.getParameter("totalpay"));
		System.out.println("총 금액 : " + totalPay);
		int roomNum = Integer.parseInt(request.getParameter("roomNum"));
		System.out.println("방번호 : " + roomNum);
		String cardPw = request.getParameter("cardPw");
		System.out.println("카드비밀번호 : " + cardPw);
		String id = request.getParameter("id");
		System.out.println("아이디 : " + id);
		
		ReservationDAO dao = new ReservationDAO();
		dao.insertReservation(DBConn.getConnection(), new ReservationVO(name, startDate, endDate, adltCnt, chldCnt, adultBreakfast, childrenBreakfast, txtRequest, phoneNum, email, cardtype, cardNo, cardExe, birth, totalPay, roomNum, cardPw, id));
		
		DBConn.close();
		
//		PrintWriter out = response.getWriter();
//		out.println("<script>");
//		out.println("alert('예약이 완료되었습니다! \n문의주신 내용이 있으시다면 담당자가 연락드릴 예정입니다. \n감사합니다.^^')");
//		out.println("location.href = 'main.jsp'");
//		out.println("</script>");
		request.getRequestDispatcher("main.jsp").forward(request, response);
	}
}
