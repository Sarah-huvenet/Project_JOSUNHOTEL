package board.review;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.Action;
import conn.DBConn;
import room.RoomDAO;
import room.RoomDTO;

public class WriteReviewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		RequestDispatcher rd = request.getRequestDispatcher("writeReview.jsp");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("idKey");
		System.out.println(id);
		RoomDAO dao = new RoomDAO(DBConn.getConnection());
		List<RoomDTO> list= dao.writeReview(id);
		if(list == null) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('예약정보가 없습니다.')");
			out.println("location.href = 'reviewboard?command=reviewmain'");
			out.println("</script>");
		} else {
			request.setAttribute("list", list); 
			rd.forward(request, response);
		}
	}
}
