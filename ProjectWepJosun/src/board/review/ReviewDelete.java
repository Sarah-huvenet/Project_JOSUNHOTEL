package board.review;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.Action;
import conn.DBConn;

public class ReviewDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		ReviewDAO dao = new ReviewDAO(DBConn.getConnection());
		String filename = dao.retFilename(idx);
		int result = dao.deleteReview(idx);
		if(result==0) {
			System.out.println("ERR.");
		}
//		System.out.println("idx : " + idx);
		if(filename!=null) {
			System.out.println("filename : "+filename);
			File file = new File("C:\\Workspace\\workspace(2)\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\ProjectWepJosun (1)\\img\\review\\" + filename);
			if(file.exists()) {
				if(file.delete()) {
					System.out.println("파일삭제 성공");
				} else {
					System.out.println("파일삭제 실패");
				}
			} else {
				System.out.println("파일이 존재 하지 않습니다.");
			}
		}
		response.sendRedirect("reviewboard?command=reviewmain");
	}

}
