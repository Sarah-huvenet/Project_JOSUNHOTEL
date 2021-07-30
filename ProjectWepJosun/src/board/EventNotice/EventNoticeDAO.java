package board.EventNotice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.*;

public class EventNoticeDAO {//Data Access Object 약자. Database의 data에 access하는 트랜잭션 객체
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public EventNoticeDAO() {
			this.conn = DBConn.getConnection();
	}
	
	//전체목록
	public ArrayList <EventNoticeDTO> getList(int selectCate, String keyword, int startRow, int endRow) {
		ArrayList <EventNoticeDTO> listenvo = new ArrayList<EventNoticeDTO>();
		
		//검색어 검색하면 나올 수 있도록.
		String sql = "SELECT t2.* FROM(SELECT ROWNUM rnum, t.* FROM (SELECT c.catename , e.* FROM event_notice e, en_cate c WHERE e.category=c.num and e.content like ? ORDER BY e.write_date DESC) t) t2 WHERE ? <=rnum AND rnum <= ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventNoticeDTO envo = new EventNoticeDTO();
				
				envo.setIdx(rs.getInt("IDX"));
				envo.setCateName(rs.getString("CATENAME"));
				envo.setTitle(rs.getString("TITLE"));
				envo.setFileName(rs.getString("FILE_NAME"));
				envo.setWriteDate(rs.getString("WRITE_DATE").substring(0, 11));
				
				listenvo.add(envo);
			}
			
			return listenvo;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return listenvo;
		
	}
	
	//키워드 & 검색어 검색
	public ArrayList <EventNoticeDTO> findList(int selectCate, String keyword, int startRow, int endRow) {
		ArrayList <EventNoticeDTO> listenvo =  new ArrayList<EventNoticeDTO>();
		
		//카테고리 & 컨텐츠 내역 검색
		String sql = "SELECT t2.* FROM(SELECT ROWNUM rnum, t.* FROM (SELECT c.catename , e.* FROM event_notice e, en_cate c WHERE e.category=c.num AND e.category Like ? AND e.content Like ? ORDER BY e.write_date DESC) t) t2 WHERE ? <=rnum AND rnum <= ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+selectCate+"%");
			pstmt.setString(2, "%"+keyword+"%");
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventNoticeDTO envo = new EventNoticeDTO();
				
				envo.setIdx(rs.getInt("IDX"));
				envo.setCateName(rs.getString("CATENAME"));
				envo.setTitle(rs.getString("TITLE"));
				envo.setFileName(rs.getString("FILE_NAME"));
				envo.setWriteDate(rs.getString("WRITE_DATE").substring(0, 11));
				
				listenvo.add(envo);
			}
			
			
			return listenvo;
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return listenvo;
		
	}
	
	//키워드만 검색
	public ArrayList <EventNoticeDTO> keywordList(String keyword, int startRow, int endRow) {
		ArrayList <EventNoticeDTO> listenvo =  new ArrayList<EventNoticeDTO>();
		String sql = "SELECT t2.* FROM(SELECT ROWNUM rnum, t.* FROM (SELECT c.catename , e.* FROM event_notice e, en_cate c WHERE e.category=c.num AND e.content Like ? ORDER BY e.write_date DESC) t) t2 WHERE ? <=rnum AND rnum <= ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventNoticeDTO envo = new EventNoticeDTO();
				
				envo.setIdx(rs.getInt("IDX"));
				envo.setCateName(rs.getString("CATENAME"));
				envo.setTitle(rs.getString("TITLE"));
				envo.setFileName(rs.getString("FILE_NAME"));
				envo.setWriteDate(rs.getString("WRITE_DATE").substring(0, 11));
				
				listenvo.add(envo);
			}
			
			return listenvo;
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return listenvo;
	}
	
	//DB에 있는 총 게시물 수 파악하기
	public int getCount (Connection conn) {
		int totalPostDb = 0;

		String sql = "SELECT COUNT(*) FROM event_notice";		//totalPost, pageSize 구하기
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalPostDb = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("dbPost SQL ERR.");
		}
		
		return totalPostDb;
	}
	
	//상세보기 & 수정하기 - DB에서 불러오기
	public ArrayList <EventNoticeDTO> selectList(int curPage) {
		ArrayList <EventNoticeDTO> listenvo =  new ArrayList<EventNoticeDTO>();
		
		String sql = "SELECT * FROM event_notice WHERE idx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, curPage);
			ResultSet rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				EventNoticeDTO envo = new EventNoticeDTO();
				
				envo.setIdx(rs.getInt("idx"));
				envo.setCategory(rs.getInt("CATEGORY"));
				envo.setTitle(rs.getString("TITLE"));
				envo.setContent(rs.getString("CONTENT"));
				envo.setFileName(rs.getString("FILE_NAME"));
				envo.setWriteDate(rs.getString("WRITE_DATE"));
				updateViewCnt(curPage);
				listenvo.add(envo);
			}
			
			return listenvo;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return listenvo;
		
	}
	
	//게시글 수정
	public int updatePost(int category, String title, String content, String file_name, int idx) {

		String sql = "UPDATE event_notice SET category = ?, title = ?, content=?, file_name=? WHERE idx=?";
		
		int n = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, file_name);
			pstmt.setInt(5, idx);
			n = pstmt.executeUpdate();
			conn.commit();
			
			return n;
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	//게시글  쓰기
	public int writePost(int category, String title, String content, String file_name) {
		String sql = "INSERT INTO event_notice VALUES (EN_SEQ.nextval, ?, ?, ?, sysdate, 0, ?)";
		
		int n = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, category);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, file_name);
			n = pstmt.executeUpdate();
			conn.commit();
			
			return n;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return n;
	}
	
	//게시글 삭제
	public int delPost(int curPage) {
		String sql = "DELETE FROM event_notice WHERE idx=?";
		
		int n = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, curPage);
			n = pstmt.executeUpdate();
			
			return n;
		
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return n;
	}
	
	//이전글
	public int getPrevPageNum(int curPage) {
		String sql = "SELECT max(idx) FROM event_notice WHERE idx<?";
		
		int prevIdx = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, curPage);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				prevIdx = rs.getInt(1);
			}	
			return prevIdx;
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return prevIdx;
	}
	
	//다음글
	public int getNextPageNum(int curPage) {
		String sql = "SELECT min(idx) FROM event_notice WHERE idx>?";
		
		int nextIdx = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, curPage);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				nextIdx = rs.getInt(1);
			}
			
			return nextIdx;
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return nextIdx;
	}
	
	//이전 타이틀
	public String getPrevTitle(int prevIdx) {
		String sql = "SELECT title FROM event_notice WHERE idx = ?";
		
		String prevTit = "";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prevIdx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				prevTit = rs.getString(1);
			}
			
			return prevTit;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return prevTit;
		
	}
	
	//다음 타이틀
	public String getNextTitle(int nextIdx) {
		String sql = "SELECT title FROM event_notice WHERE idx = ?";
		
		String nextTit = "";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nextIdx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				nextTit = rs.getString(1);
			}
			
			return nextTit;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return nextTit;
	}
	
	//조회수
	public void updateViewCnt(int curPage) {
		String sql = "UPDATE event_notice SET hitcount=hitcount + 1 WHERE idx = ?";
		int n = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, curPage);
			n = pstmt.executeUpdate();
			if(n == 1) {
				System.out.println("조회수 올라감");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}//end.Class
