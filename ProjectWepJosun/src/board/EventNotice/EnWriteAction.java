package board.EventNotice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

import member.Action;
import conn.DBConn;

public class EnWriteAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = DBConn.getConnection();	
		PrintWriter out = response.getWriter();
		EventNoticeDAO edao = new EventNoticeDAO();
		
		
		String title = request.getParameter("tit");
		String content = request.getParameter("con");
		String file_name = request.getParameter("fileN");
		int category = Integer.parseInt(request.getParameter("cate"));
		
		int n = edao.writePost(category, title, content, file_name);
		boolean fileSaveCheck = false;
		
		if(n==1) {
			fileSaveCheck = true;
		} else if (n!=1) {
			fileSaveCheck = false;
		}
		
		response.setContentType("application/json");
		JSONObject obj = new JSONObject();
		obj.put("fileSaveCheck", fileSaveCheck);
		out.print(obj);
	}
}
