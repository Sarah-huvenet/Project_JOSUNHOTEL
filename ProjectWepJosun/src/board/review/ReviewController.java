package board.review;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.Action;
import member.ActionFactory;

@WebServlet("/reviewboard")
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String command = request.getParameter("command");
		System.out.println(command);
		
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		if(action != null) action.execute(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String command = request.getParameter("command");
		System.out.println(command);
		
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		if(action != null) action.execute(request, response);
	}

}
