package room;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CheckInOutDay {
	private String startDate;
	private String endDate;
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public CheckInOutDay(String startDate, String endDate){
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	//시작날짜 요일 구하기
	public String startDayCheck(String startDate) {
		DateFormat dateFormat = new SimpleDateFormat ("yyyy.MM.dd");
		String startDay = "";
		try {
			Date ckinDate = dateFormat.parse(startDate);
			Calendar cal = Calendar.getInstance();
			cal.setTime(ckinDate);
			int dateNum = cal.get(Calendar.DAY_OF_WEEK);
			
			switch(dateNum){
			case 1:
				startDay = "일";
				break;
			case 2:
				startDay = "월";
				break;
			case 3:
				startDay = "화";
				break;
			case 4:
				startDay = "수";
				break;
			case 5:
				startDay = "목";
				break;
			case 6:
				startDay = "금";
				break;
			case 7:
				startDay = "토";
				break;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return startDay;
	}
	
	//끝 날짜 요일 구하기
	public String endDayCheck(String endDate) {
		DateFormat dateFormat = new SimpleDateFormat ("yyyy.MM.dd");
		String endDay = "";
		try {
			Date ckoutDate = dateFormat.parse(endDate);
			Calendar cal = Calendar.getInstance();
			cal.setTime(ckoutDate);
			int dateNum = cal.get(Calendar.DAY_OF_WEEK);
			switch(dateNum){
			case 1:
				endDay = "일";
				break;
			case 2:
				endDay = "월";
				break;
			case 3:
				endDay = "화";
				break;
			case 4:
				endDay = "수";
				break;
			case 5:
				endDay = "목";
				break;
			case 6:
				endDay = "금";
				break;
			case 7:
				endDay = "토";
				break;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return endDay;
	}
	
	//시작-끝 날짜 차이 일수 구하기
	public int seDay(String startDate, String endDate) {
		DateFormat dateFormat = new SimpleDateFormat ("yyyy.MM.dd");
		int dateDays = 0;
		try {
			Date ckinDate = dateFormat.parse(startDate);
			Date ckoutDate = dateFormat.parse(endDate);
			long calDate = ckinDate.getTime() - ckoutDate.getTime();
			long calDateDays = calDate / (24*60*60*1000);
			calDateDays = Math.abs(calDateDays);
			dateDays = (int)calDateDays;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dateDays;
	}
	
	public String returnReserveDate(String startDate, String endDate ) throws Exception {  // 날짜 나열 메소드
		StringBuilder sb = new StringBuilder("'"+startDate+"'");
		for(int i = 1; i< seDay(startDate,endDate); i++) {
			sb.append(", '"+addDay(startDate, i)+"'");
		}
		String date = sb.toString();	//"1994.03.07","yyyy.MM.dd" ,"끝날짜"
		System.out.println("returnReserveDate() : "+date);
		return date;
	}
	
	public String addDay(String strDate,int day ) throws Exception {	// 날짜에 숫자를 더하는 메소드 
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
		Calendar cal = Calendar.getInstance();
		Date dt = format.parse(strDate);
		cal.setTime(dt);
		cal.add(Calendar.DATE, day);
		return format.format(cal.getTime());
	}
}
