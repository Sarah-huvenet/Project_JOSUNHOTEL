package board.review;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.Action;
import conn.DBConn;
import room.ReservationDAO;
import room.ReservationVO;
import room.RoomDAO;
import room.RoomDTO;

public class GoReviewModify implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		RequestDispatcher rd = request.getRequestDispatcher("modifyReview.jsp");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("idKey");
		System.out.println(id);
		RoomDAO dao = new RoomDAO(DBConn.getConnection());
		List<RoomDTO> list= dao.writeReview(id);
		ReviewDAO reDAO = new ReviewDAO(DBConn.getConnection());
		ReviewVO vo = reDAO.detailReview(idx);
		if(vo.getFileName() == null) {
			vo.setFileName("");
		}
		
		request.setAttribute("vo", vo);
		request.setAttribute("list", list); 
		request.setAttribute("idx", idx);
		rd.forward(request, response);
		
	}
}