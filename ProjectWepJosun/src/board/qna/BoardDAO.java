package board.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
	private Connection conn;
	
	public BoardDAO(Connection conn) {
		this.conn = conn;
	}
	
	//게시판 글쓰기
	public int insertData(BoardDTO dto) {
		int result = 0;

//		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd"); // 형식 설정
//		Date time = new Date(); // date 현재시간
//		String time1 = format1.format(time);
		
		String sql = "insert into board_qna(idx, category, content, name, phone, email, reply_by, write_date, file_name) values(QNA_SEQ.nextval,?,?,?,?,?,?,sysdate,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCategory());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPhone());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getReply());
			pstmt.setString(7, dto.getFileName());
			
			result = pstmt.executeUpdate();
			return result;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1; // 오류
	}
	
	//게시판 목록
	public List<BoardDTO> getLists(int start, int end, String searchKey, String searchValue){
		List<BoardDTO> lists = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		searchValue = "%"+searchValue+"%";
		//System.out.println(searchKey + " | "+ searchValue);
		
		sql = "select * from (select rownum rnum, b2.* from (select b.idx, q.name 카테고리, b.content, b.name, b.reply_by, b.write_date from board_qna b, qna_category q where b.category = q.num and b."+searchKey+" like ? order by write_date desc) b2) where rnum >= ? and rnum <=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setIdx(rs.getInt(2));
				dto.setCategoryT(rs.getString("카테고리"));
				dto.setContent(rs.getString(4));
				dto.setName(rs.getString(5));
				dto.setReply(rs.getString(6));
				
				String time = rs.getString(7);
				dto.setWriteDate(time.substring(0, 10));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lists;
	}
	
	//전체 갯수 카운팅
	public int getDataCount(String searchKey, String searchValue) {
		int totalDataCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		//검색어를 포함하여 내용을 다 출력하게 하기 위해 %붙임
		searchValue = "%" + searchValue + "%";
		sql = "select count(*) as totalCount from board_qna where "+searchKey+" like ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalDataCount = rs.getInt("totalCount");
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return totalDataCount;
	}
	
	//num(idx) 로 조회한 데이터
	public BoardDTO getReadData(int num) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		sql = "select q.name 카테고리, b.* from board_qna b, qna_category q where b.category = q.num and idx = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setIdx(rs.getInt("idx"));
				dto.setCategoryT(rs.getString("카테고리"));
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setReply(rs.getString("reply_by"));
				dto.setWriteDate(rs.getString("write_date"));
				dto.setFileName(rs.getString("file_name"));
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
}
