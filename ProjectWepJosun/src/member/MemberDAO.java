package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
	private Connection conn;

	public MemberDAO(Connection conn) {
		this.conn = conn;
	}
	
	//회원 리스트 보기
	public List<MemberDTO> getMemberList(int start, int end, String searchKey, String searchValue){
		List<MemberDTO> lists = new ArrayList<MemberDTO>();
		searchValue = "%"+searchValue+"%";
		String sql = "select * from (select rownum rnum, m.* from(select name, id, phone, email, address from member where "+searchKey+" like ? )m) where rnum >= ? and rnum <= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress(rs.getString("address"));
				lists.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lists;
	}
	
	//전체 갯수 카운팅(검색했을때 포함)
	public int getDataCount(String searchKey, String searchValue) {
		int totalDataCount = 0;
		searchValue = "%" + searchValue + "%";
		String sql = "select count(*) as totalCount from member where "+searchKey+" like ?";
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
	
	//ID 중복체크
	public int idCheck(String id) {
		int result = 0;
		String sql = "select * from member where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 0;
			}else {
				result = 1;
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//회원가입
	public int join(MemberDTO dto) {
		int result = 0;
		String sql = "insert into member values(?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPw());
			pstmt.setInt(4, dto.getPwHintQ());
			pstmt.setString(5, dto.getPwHintA());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getPhone());
			pstmt.setString(8, dto.getEmail());
			
			result = pstmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	//로그인을 위한 데이터 탐색
	//DTO 객체 - 참조값 넣기
	public MemberDTO login(String id, String pw) {
		MemberDTO dto = new MemberDTO();
		//String str="";
		String sql = "select id, name, address, phone, email from member where id = ? and pw = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				//str = rs.getString("name");
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	//아이디 찾기
	public String findId(String name, String phone, String email) {
		String result = "";
		String sql = "select id from member where name = ? and phone = ? and email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, email);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("id");
			}else {
				result = null;
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//비밀번호 찾기
	public String findPw(String name, String id, int pwHintQ, String pwHintA) {
		String result = "";
		String sql = "select pw from member where name = ? and id = ? and pw_hint_q = ? and pw_hint_a = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setInt(3, pwHintQ);
			pstmt.setString(4, pwHintA);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("pw");
			}else {
				result = null;
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//회원정보수정
	public int updateMember(String name, String phone, String address, String email, String id) {
		int n = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE member SET name=?, address=?, phone=?, email=? WHERE id=?");
			pstmt.setString(1, name);
			pstmt.setString(2, address);
			pstmt.setString(3, phone);
			pstmt.setString(4, email);
			pstmt.setString(5, id);
			n = pstmt.executeUpdate();
			return n;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	//로그인한 아이디의 비밀번호 확인
	public String curPwcheck(String id) {
		MemberDTO dto = new MemberDTO();

		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT pw FROM member WHERE id=?");
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()) {
				dto.setPw(rs.getString(1));
			}

			return dto.getPw();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto.getPw();
	}

	//비밀번호 업데이트
	public int updatePw(String pw, String id) { 
		String result = "";
		int n = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE member SET pw=? WHERE id=?");
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			n = pstmt.executeUpdate();
			return n;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	//회원정보삭제
	public int delMember(String id) {
		int n = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE member WHERE id=?");
			pstmt.setString(1, id);
			n = pstmt.executeUpdate();
			return n;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
}
