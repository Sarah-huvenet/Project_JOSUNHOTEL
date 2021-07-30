package board.review;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.Action;
import conn.DBConn;
import room.RoomDAO;
import room.RoomDTO;

public class DetailReviewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		ReviewDAO dao = new ReviewDAO(DBConn.getConnection());
		RoomDAO roomdao = new RoomDAO(DBConn.getConnection());
		int idx = Integer.parseInt(request.getParameter("bno"));
		int result = dao.plusHitcount(idx);
		if(result==0) {
			System.out.println("조회수 실패");
		}
		ReviewVO vo = dao.detailReview(idx);
		RoomDTO dto = roomdao.detailReviewRoom(vo.getRoomNumber());
		RequestDispatcher rd = request.getRequestDispatcher("detailViewReview.jsp");
		request.setAttribute("review", vo);
		request.setAttribute("room", dto);
		rd.forward(request, response);
		

	}

}
