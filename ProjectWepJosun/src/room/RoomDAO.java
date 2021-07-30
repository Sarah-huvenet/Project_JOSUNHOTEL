package room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.json.simple.JSONObject;

public class RoomDAO {
	private Connection conn;
	
	public RoomDAO(Connection conn) {
		this.conn = conn;
	}
	
	//전체 룸 출력
	public List<RoomDTO> getRoomLists(String startDate,String endDate ){
		List<RoomDTO> lists = new ArrayList<RoomDTO>();
		System.out.println("getRoomLists()"+startDate);
		System.out.println("getRoomLists()"+endDate);
		String sql = "SELECT num,name,price,img,r_size,detail_view FROM room  where num in ("+duplicateCheck(startDate,endDate)+")";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				RoomDTO dto = new RoomDTO();
				dto.setNum(rs.getInt(1));
				dto.setName(rs.getString(2));

				int priceInt = Integer.parseInt(rs.getString(3));
				double price = priceInt;
				DecimalFormat dc = new DecimalFormat("###,###,###,###");
				dto.setPrice(dc.format(price));

				//https://mainia.tistory.com/4457
				//dto.setPrice(rs.getString(3)); //price
				dto.setImg(rs.getString(4));
				dto.setrSize(rs.getString(5));
				dto.setDetailView(rs.getString(6));
				System.out.println(dto.getPrice());	// 일로 못넘어감 그전에 에러 발생
				lists.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lists;
	}

	public String duplicateCheck(String startDate, String endDate) {		//중복체크
		String okReserve = "";
		CheckInOutDay time = new CheckInOutDay(startDate, endDate);
		try {
			String sql = "select num from room where num not in(SELECT DISTINCT num FROM reserved_room WHERE reserved_date in("+time.returnReserveDate(startDate, endDate)+"))";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int okReserveRoomNum = rs.getInt(1);
				okReserve += (okReserve.equals("") ? "'" : ", '") + okReserveRoomNum + "'";
				//					System.out.println(okReserveRoomNum);    // '303', '302', '301'
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		catch (Exception e) {
			e.printStackTrace();
		}
		
		if(okReserve.equals("")) {
			okReserve = "''";
		}
		
		return okReserve;
	}

	// roomOption Page
	public HashMap<String,Object> roomOptionInfo(int bno) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		String sql = "select r.num,r.name,r.price,r.r_size,r.detail_view ,h.adults_price,h.children_price from room r, hotel h WHERE r.hotel_number = h.num and r.num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				map.put("num", rs.getString(1));
				map.put("name", rs.getString(2));
				int price = Integer.parseInt(rs.getString(3));
				DecimalFormat dc = new DecimalFormat("###,###,###,###");
				map.put("price",dc.format(price));
				map.put("size", rs.getString(4));
				map.put("view", rs.getString(5));
				price = Integer.parseInt(rs.getString(6));
				map.put("audlts_price",dc.format(price));
				price = Integer.parseInt(rs.getString(7));
				map.put("children_price", dc.format(price));
			} else {
				System.out.println("잘못된 번호가 넘어옴");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	//특정 룸 인포
	public HashMap<String, Object> roomInfo(int num){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String sql="select r.name, r.img, r.location, r.beds, r.r_size, r.features, r.viewpoint, a.bath, a.bed, a.minibar, a.closet " + 
				"from room r, amenity_package a where r.amenity = a.num and r.num = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				map.put("name", rs.getString(1));
				map.put("img", rs.getString(2));
				map.put("location", rs.getString(3));
				map.put("beds", rs.getString(4));
				map.put("size", rs.getString(5));
				map.put("features", rs.getString(6));
				map.put("view", rs.getString(7));
				map.put("bath", rs.getString(8));
				map.put("bed", rs.getString(9));
				map.put("minibar", rs.getString(10));
				map.put("closet", rs.getString(11));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return map;
	}
	
	public List<RoomDTO> writeReview(String id){
		List<RoomDTO> list = new ArrayList<RoomDTO>();
		int cnt = 0;
		String sql = "select DISTINCT ro.num,ro.name,ro.img,ro.beds,ro.r_size,ro.detail_view,ro.features from reservation re, room ro where re.room_number = ro.num and re.member_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				RoomDTO dto = new RoomDTO();
				dto.setNum(rs.getInt(1));
				dto.setName(rs.getString(2));
				dto.setImg(rs.getString(3));
				dto.setBeds(rs.getString(4));
				dto.setrSize(rs.getString(5));
				dto.setDetailView(rs.getString(6));
				dto.setFeatures(rs.getString(7));
//				System.out.println(dto);
				list.add(dto);
				//System.out.println("list : " + list.size());
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//System.out.println("dao에서 size : "+list.size());
		return list;
	}
	
	public RoomDTO detailReviewRoom(int roomNum) {
		RoomDTO dto = null;
		String sql = "select name,img,beds,r_size,detail_view,features from  room  where num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, roomNum);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new RoomDTO();
				dto.setName(rs.getString(1));
				dto.setImg(rs.getString(2));
				dto.setBeds(rs.getString(3));
				dto.setrSize(rs.getString(4));
				dto.setDetailView(rs.getString(5));
				dto.setFeatures(rs.getString(6));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}
}
