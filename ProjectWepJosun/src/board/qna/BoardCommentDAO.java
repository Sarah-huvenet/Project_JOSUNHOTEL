package board.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class BoardCommentDAO {
	private Connection conn;
	public BoardCommentDAO(Connection conn) {
		this.conn = conn;
	}
	
	//메일 보내기
	public void mailSend(String email, String content) {
		//발신자
		String host = "smtp.gmail.com"; // Gmail SMTP 서버 주소
		String user = "himedia.sora@gmail.com"; // 발신자 메일 주소
		String password = "thfk-461834"; // 발신자 패스워드
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		try { 
			System.out.println("메일 전송 중...");
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); // 받는 사람 메일 주소
			message.setSubject("[그랜드 제주 호텔] 문의주신 내용의 답변입니다."); // 메일 제목
			message.setText(content); // 메일 내용
			Transport.send(message);
			System.out.println("메일 전송 성공!");
		} catch (MessagingException e) { 
			e.printStackTrace(); 
		}
	}
	
	//댓글 작성
	public int insertCommentData(BoardCommentDTO dtoC) {
		int result = 0;
		ResultSet rs = null;
		String email = null;
		
		String sql = "insert into qna_comment values(COMMENT_SEQ.nextval, ?, ?)";
		String boardSql = "select email from board_qna where idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dtoC.getNumQna());
			pstmt.setString(2, dtoC.getContent());
			

			PreparedStatement pstmtB = conn.prepareStatement(boardSql);
			pstmtB.setInt(1, dtoC.getNumQna());
			rs = pstmtB.executeQuery();
			if(rs.next()) {
				email = rs.getString(1);
			}
			mailSend(email, dtoC.getContent());
			
			result = pstmt.executeUpdate();
			return result;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1; //오류
	}
	
	//게시글의 num(idx)으로 조회한 데이터
	public List<BoardCommentDTO> getCommentData(int num) {
		List<BoardCommentDTO> lists = new ArrayList<BoardCommentDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		sql = "select rownum, c.* from (select idx, content from qna_comment where num_qna=? order by idx)c";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardCommentDTO dtoC = new BoardCommentDTO();
				dtoC.setRnum(rs.getInt(1));
				dtoC.setIdx(rs.getInt("idx"));
				dtoC.setContent(rs.getString("content"));
				
				lists.add(dtoC);
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lists;
	}
}
