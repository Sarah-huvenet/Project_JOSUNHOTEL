package member;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.DBConn;
import room.ReservationDAO;
import room.ReservationVO;

public class AdminReservationList implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = DBConn.getConnection();
		ReservationDAO dao = new ReservationDAO();
		
		int pageNo = 1;
		if(request.getParameter("page")!=null){
			pageNo = Integer.parseInt(request.getParameter("page"));
		}
		
		int pageSize = 10;
		int start = pageNo * pageSize - (pageSize - 1);
		int end = pageNo * pageSize;
		
		String searchKey = "";
		String searchValue = "";
		if(request.getParameter("searchKey")!=null) {
			searchKey = request.getParameter("searchKey");
			searchValue = request.getParameter("searchValue");
		}else {
			searchKey = "name";
		}
		
		List<ReservationVO> lists = dao.getAdminReserveList(conn, start, end, searchKey, searchValue);
		//int totalPage = dao.countReserveList(conn);
		int dataCount = dao.getDataCount(conn, searchKey, searchValue);
		int totalPage = dao.getPageCount(pageSize, dataCount);
		
		System.out.println("dataCount :" + dataCount);
		System.out.println("totalPage : " + totalPage);
		
		String param = "";
		if(!searchValue.equals("")){
			param = "searchKey="+searchKey;
			param += "&searchValue="+searchValue+"&";
		}
		
		String url = "Controller?command=adminReservationList&"+param;
		StringBuffer page = new StringBuffer();
		
		for(int i=1; i<=totalPage; i++){
			if(pageNo == i){
				page.append("<a class=\"active\" href=\""+url+"page="+i+"\">"+i+"</a>&nbsp;");
			}else {
				page.append("<a href=\""+url+"page="+i+"\">"+i+"</a>&nbsp;");
			}
		}
		
		request.setAttribute("lists", lists);
		request.setAttribute("page", page.toString());
		request.getRequestDispatcher("adminReservation.jsp").forward(request, response);
	}

}
