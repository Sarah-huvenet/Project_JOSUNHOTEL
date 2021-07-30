package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import conn.DBConn;

public class ModifyInfoAction implements Action {
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		Connection conn = DBConn.getConnection();
		MemberDAO edao = new MemberDAO(conn);
		
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String id = (String)session.getAttribute("idKey");
		
		System.out.println(name +" "+ phone + " " + address +" "+email+" "+ id);
		
		int n = edao.updateMember(name, phone, address, email, id);
		//System.out.println("n : " + n);
		
		boolean fileSaveCheck = false;
		
		if(n==1) {
			fileSaveCheck = true;
			session.setAttribute("nameKey", name);
			session.setAttribute("addrKey", address);
			session.setAttribute("phoneKey", phone);
			session.setAttribute("emailKey", email);
		} else if (n!=1) {
			fileSaveCheck = false;
		}
		
		response.setContentType("application/json");
		JSONObject obj = new JSONObject();
		obj.put("fileSaveCheck", fileSaveCheck);
		out.print(obj);
	}
}
