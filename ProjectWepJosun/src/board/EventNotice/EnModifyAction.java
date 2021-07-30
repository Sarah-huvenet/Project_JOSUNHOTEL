package board.EventNotice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import conn.DBConn;
import member.Action;

public class EnModifyAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = DBConn.getConnection();
		EventNoticeDAO edao = new EventNoticeDAO();
		PrintWriter out = response.getWriter();
		
		String title = request.getParameter("tit");
		String content = request.getParameter("con");
		String file_name = request.getParameter("fileN");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int category = Integer.parseInt(request.getParameter("cate"));
		
		int n = edao.updatePost(category, title, content, file_name, idx);
			
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
