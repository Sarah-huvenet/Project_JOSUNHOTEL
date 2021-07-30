package board.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.DBConn;
import room.ReservationVO;
import room.RoomDTO;

public class ReviewDAO {
	Connection conn;
	private final static int pageSize = 5;		// 한 페이지에 표시될 글의 갯수 페이지에 5개씩 표현할것.
	
	public ReviewDAO(Connection conn) {
		this.conn = conn;
	}

	public static int getPagesize() {
		return pageSize;
	}
	
	public int reviewWritingCnt() {		// 총 리뷰를 쓴 글의 개수
		int totalCnt = 0;
		try {
			String sql = "SELECT COUNT(*) FROM board_review";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCnt = rs.getInt(1);
			}
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return totalCnt;
	}
	
	public int reviewPageCnt() {		// 총 페이지 개수 5개씩 묶었을때 페이지의 수
		int totalCnt = reviewWritingCnt();
		int pageSize = getPagesize();
		int totalPage = totalCnt/pageSize;
		if(totalCnt > pageSize * totalPage) { totalPage++;	}
		
		if(totalPage==0) {totalPage=1;}
		return totalPage;
	}
	public ArrayList<ReviewVO> showWriting(int page) {	//페이지 셋팅
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		String sql = "select b3.* from (select rownum rnum, b2.* from (select br.* from board_review br order by write_date desc) b2) b3 where rnum>=? and rnum<=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (page-1)*pageSize + 1 );
			pstmt.setInt(2, page*pageSize);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String content = rs.getString("content");
				if(content.length()>15) {
					content = content.substring(0, 15);
					content += "...";
				}
				String writeDate = rs.getString("write_date");
				int hitCount = rs.getInt("hitcount");
				String memberID = rs.getString("member_id");
				int roomNum = rs.getInt("room_number");
				String fileName = rs.getString("file_name");
				list.add(new ReviewVO(idx, title, content, writeDate, hitCount, memberID,roomNum,fileName));
			}
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<RoomDTO> showRoom(String id) {		// 로그인한 아이디의 예약 했던 방 정보를 보여주는 메소드  
		ArrayList<RoomDTO> list = new ArrayList<RoomDTO>();
		String sql = "select re.num reservation_num, ro.* from room ro, reservation re where ro.num = re.room_number and re.member_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				RoomDTO dto = new RoomDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setImg(rs.getString("img"));
				dto.setBeds(rs.getString("beds"));
				dto.setrSize(rs.getString("r_size"));
				dto.setFeatures(rs.getString("features"));
				dto.setDetailView(rs.getString("detail_view"));
				list.add(dto);
			}
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public void insertWrite(ReviewVO review) { 		// 글쓰기
		try {
			String sql = "insert into board_review(idx,title,content,member_id,room_number,file_name ) VALUES(REVIEW.nextval,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review.getTitle());
			pstmt.setString(2, review.getContent());
			pstmt.setString(3, review.getMemberID());
			pstmt.setInt(4, review.getRoomNumber());
			pstmt.setString(5, review.getFileName());
			pstmt.executeUpdate();
			pstmt.close();
			conn.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void modifyWritea(ReviewVO vo) {
		String sql ="update board_review SET title=?,content=?,room_number=?,file_name=? where idx= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getRoomNumber());
			pstmt.setString(4, vo.getFileName());
			pstmt.setInt(5, vo.getIdx());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public int plusHitcount(int idx) {		// hitcount ++ 해서 디비 업데이트
		int result = 0;
		String sql = "update board_review set hitcount = hitcount + 1 where idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}     
		return result;
	}
	
	public ReviewVO detailReview(int idx) {
		ReviewVO vo = null; 
		String sql ="select * from board_review where idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int bno = rs.getInt(1);
				String title = rs.getString(2);
				String content = rs.getString(3);
				String writeDate = rs.getString(4);
				int hitCount = rs.getInt(5);
				String memberId = rs.getString(6);
				int roomNum = rs.getInt(7);
				String fileName = rs.getString(8);
				
				vo = new ReviewVO(bno, title, content, writeDate, hitCount, memberId, roomNum, fileName);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public String retFilename(int idx) {
		String fileName = "";
		String sql = "select file_name from board_review where idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				fileName = rs.getString(1);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return fileName;
	}
	
	public int deleteReview(int idx) {
		int result = 0;
		String sql = "DELETE FROM  board_review WHERE idx = ? ";
				
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
