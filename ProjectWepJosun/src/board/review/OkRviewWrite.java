package board.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class OkRviewWrite {
	
	public boolean passTime(String date) {
		SimpleDateFormat dateForm = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		Date currentTime = new Date();
		
		String date1 = dateForm.format(currentTime);
		String date2 = date + "12:00:00";	//체크아웃 기간  ex)date = 2021.07.08 
		long calDateDays = 0; 
		try{ // String Type을 Date Type으로 캐스팅하면서 생기는 예외로 인해 여기서 예외처리 해주지 않으면 컴파일러에서 에러가 발생해서 컴파일을 할 수 없다.
			// date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
			Date todate = dateForm.parse(date1);
			Date SecondDate = dateForm.parse(date2);
			// Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
			// 연산결과 -950400000. long type 으로 return 된다.
			long calDate = todate.getTime() - SecondDate.getTime(); 
			// Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다. 
			// 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
			calDateDays = calDate / 1000; 
			System.out.println("현재 : " + todate);
			System.out.println("예약했던 체크아웃날짜 : "+SecondDate);
//			System.out.println(calDate);
			
//			calDateDays = Math.abs(calDateDays);
			
//			System.out.println("두 날짜의 날짜 차이: "+calDateDays);
		}
		catch(ParseException e)
		{
			e.printStackTrace();
			// 예외 처리
		}
		if(calDateDays>=0) {
			return true;
		}else {
			return false;
		}
	}
	// 1. 예약 가능   0.체크아웃을 안한상태  -1. 예약 id 정보 자체가 없음 
	public int doWriteReview(Connection conn,String id) {		// 로그인한 아이디가 리뷰를 쓸수 있는지 없는지를 리턴하는 메소드
		int doWrite = -2 ;
		try {
			String sql = "select end_date from  reservation where member_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String checkOutDate = rs.getString(1);			// date=  현재 시간 - 체크아웃시간  if(date>0) 예약가능(ture)  else 불가능
				checkOutDate += " 12:00:00";					// chechout 이후에 글작성 가능
				doWrite = passTime(checkOutDate)? 1 : 0 ;
			} else {
				doWrite = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return doWrite;
	}
	
}
