package board.review;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.Action;
import conn.DBConn;

public class ReviewMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		ReviewDAO dao = new ReviewDAO(DBConn.getConnection());	// review 기능 오브젝트
		int currentPage = 1;
		if(request.getParameter("page")!=null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		int pagecnt = dao.reviewPageCnt();	// 총 페이지 수
		
		int startPage = currentPage%5 == 0 ? currentPage - 4 : currentPage-currentPage%5 + 1;	//for문을 돌리기 위한 시작 페이지
		if(startPage<0) {startPage = 0;}
		int endPage = startPage+4;																//for문을 돌리기 위한 앤드 페이지
		if(endPage>pagecnt) {endPage = pagecnt;}
		
		ArrayList<ReviewVO> list = dao.showWriting(currentPage);
		for(ReviewVO vo:list) {
			if(vo.getFileName()=="" || vo.getFileName() == null) {
				vo.setFileName(vo.getRoomNumber()+".jpg");
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("reviewMain.jsp");
		request.setAttribute("currnetpage", currentPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pagecnt", pagecnt);
		request.setAttribute("list", list);
		
		rd.forward(request, response);
	}

}
