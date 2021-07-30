package room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReservationDAO {
	public void insertReservation(Connection conn, ReservationVO vo) {		// DB저장 메소드
		String startDate = vo.getStartDate();
		String endDate = vo.getEndDate();
		CheckInOutDay time = new CheckInOutDay(startDate, endDate);
		
		try {
			String sql = "INSERT INTO reservation(num,name,start_date,end_date,adult,children,adult_breakfast,chil_breakfast,request,phone_number,email,card_type,card_number,card_expiration_date,birthdate,total_pay,room_number,card_password,member_id)"
					+ "VALUES(CHECKING.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getStartDate());
			pstmt.setString(3, vo.getEndDate());
			pstmt.setInt(4, vo.getAdultCnt());
			pstmt.setInt(5, vo.getChildrenCnt());
			pstmt.setInt(6, vo.getAdult_breakfast());
			pstmt.setInt(7, vo.getChil_breakfast());
			pstmt.setString(8, vo.getRequest());
			pstmt.setString(9, vo.getPhoneNum());
			pstmt.setString(10, vo.getEmail());
			pstmt.setString(11, vo.getCard_type());
			pstmt.setString(12, vo.getCard_num());
			pstmt.setString(13, vo.getCard_expiration());
			pstmt.setString(14, vo.getBirth());
			pstmt.setInt(15, vo.getTotal_pay());
			pstmt.setInt(16, vo.getRoom_number()); 
			pstmt.setString(17, vo.getCard_pw());
			pstmt.setString(18, vo.getMemeberId());
			pstmt.executeUpdate();
//			int result = pstmt.executeUpdate();
			/*
			String sql = "INSERT INTO table1 VALUES ('"+name+"',"+num+")";
			Statement stmt = conn.createStatement();
			int result = stmt.executeUpdate(sql);
			*/
//			System.out.println("INSERT 결과 영향 받은 행의 개수 : " + result + "개.");
			pstmt.close();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
		
			String sql ="INSERT INTO reserved_room(num, reserved_date) VALUES(?,?)"; 
			PreparedStatement pstmt = conn.prepareStatement(sql);
			for(int i = 0; i<time.seDay(startDate, endDate); i++) {
				pstmt.setInt(1, vo.getRoom_number());
				pstmt.setString(2,time.addDay(startDate, i));
				pstmt.executeUpdate();
			}
			pstmt.close();
			conn.commit();
		}catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//예약내역 조회(기간선택 시, 나오게끔)
	public ArrayList<HashMap<String, String>> getReserveList(Connection conn, String id, String searchStartDate, String searchEndDate){
		ArrayList<HashMap<String, String>> lists = new ArrayList<HashMap<String, String>>();
		String sql = "select r.num, r.name, r.start_date, r.end_date, r.adult, r.children, r.total_pay, r2.name, r2.img, r2.r_size, r2.detail_view, r.room_number "
				+ "from reservation r, room r2 where r.room_number = r2.num and "
				+ "r.member_id = ? and (r.start_date BETWEEN to_date(?) and to_date(?) or r.end_date BETWEEN to_date(?) and to_date(?))";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, searchStartDate);
			pstmt.setString(3, searchEndDate);
			pstmt.setString(4, searchStartDate);
			pstmt.setString(5, searchEndDate);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("num", rs.getString(1));
				map.put("username", rs.getString(2));
				map.put("startDate", rs.getString(3));
				map.put("endDate", rs.getString(4));
				map.put("adult", rs.getInt(5)+"");
				map.put("children", rs.getInt(6)+"");
				map.put("totalPay", rs.getInt(7)+"");
				map.put("name", rs.getString(8));
				map.put("img", rs.getString(9));
				map.put("rSize", rs.getString(10));
				map.put("detailView", rs.getString(11));
				map.put("roomNumber", rs.getString(12)+"");
				lists.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lists;
	}
	
	//예약취소(예약이 취소되면 무조건 예약자명을 #으로 변경 / reserved_room 예약된 날짜 삭제)
	public int reserveCancle(Connection conn, int reserveNum, int roomNumber, String startDate, String endDate) {
		int result = 0;
		CheckInOutDay time = new CheckInOutDay(startDate, endDate);
		try {
			String sql = "update reservation set name = '#' where num = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reserveNum);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			String sql = "delete from reserved_room where reserved_date = ? and num = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			for(int i = 0; i<time.seDay(startDate, endDate); i++) {
				pstmt.setString(1,time.addDay(startDate, i));
				pstmt.setInt(2, roomNumber);
				pstmt.executeUpdate();
				result++; //2
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//예약내역 조회 (관리자페이지)
	public List<ReservationVO> getAdminReserveList(Connection conn, int start, int end, String searchKey, String searchValue){
		List<ReservationVO> lists = new ArrayList<ReservationVO>();
		searchValue = "%"+searchValue+"%";
		String sql = "select * from(select rownum rnum, r.* from "
				+ "(select name, room_number, start_date, end_date, adult, children, adult_breakfast, chil_breakfast, request, total_pay, phone_number from reservation where "+searchKey+" like ? order by start_date)r)"
				+ " where rnum >=? and rnum<=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ReservationVO vo = new ReservationVO();
				vo.setRnum(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setRoom_number(rs.getInt(3));
				vo.setStartDate(rs.getString(4).substring(0, 10));
				vo.setEndDate(rs.getString(5).substring(0, 10));
				vo.setAdultCnt(rs.getInt(6));
				vo.setChildrenCnt(rs.getInt(7));
				vo.setAdult_breakfast(rs.getInt(8));
				vo.setChil_breakfast(rs.getInt(9));
				if(rs.getString(10) == null) {vo.setRequest("-");}
				else {vo.setRequest(rs.getString(10));}
				
				int priceInt = rs.getInt(11);
				double price = priceInt;
				DecimalFormat dc = new DecimalFormat("###,###,###,###");
				vo.setPay(dc.format(price));
				vo.setPhoneNum(rs.getString(12));
				lists.add(vo);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lists;
	}
	
//	//예약내역 전체 카운트 (관리자페이지)
//	public int countReserveList(Connection conn) {
//		int result = 0;
//		String sql = "select count(*) from reservation";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(sql);
//			ResultSet rs = pstmt.executeQuery();
//			if(rs.next()) result = rs.getInt(1);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
	
	//전체 갯수 카운팅(검색했을때 포함)
	public int getDataCount(Connection conn, String searchKey, String searchValue) {
		int totalDataCount = 0;
		searchValue = "%" + searchValue + "%";
		String sql = "select count(*) as totalCount from reservation where "+searchKey+" like ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) totalDataCount = rs.getInt("totalCount");
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return totalDataCount;
	}
	
	//페이지 카운트 메서드
	public int getPageCount(int pageSize, int dataCount) {
		int pageCount = 0;
		pageCount = dataCount / pageSize;
		if(dataCount%pageSize != 0) {
			pageCount++;
		}
		return pageCount;
	}
}
