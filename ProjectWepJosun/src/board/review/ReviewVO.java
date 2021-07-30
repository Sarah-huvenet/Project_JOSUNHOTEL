package board.review;

import java.text.SimpleDateFormat;

public class ReviewVO {
	private int idx;
	private String title;
	private String content;
	private String writeDate;
	private int hitCount;
	private String memberID;
	private int roomNumber;
	private String fileName;
	
	public ReviewVO( String title, String content,String memberID,int roomNumber, String fileName) {
		
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		String crrentTime = format.format (System.currentTimeMillis());
		
		this.title = title;
		this.content = content;
		this.writeDate = crrentTime;
		this.hitCount = 0;
		this.memberID = memberID;
		this.roomNumber = roomNumber;
		this.fileName = fileName;
	}
	
	
	
	public ReviewVO(int idx, String title, String content, String writeDate, int hitCount, String memberID,
			int roomNumber, String fileName) {
		this.idx = idx;
		this.title = title;
		this.content = content;
		this.writeDate = writeDate;
		this.hitCount = hitCount;
		this.memberID = memberID;
		this.roomNumber = roomNumber;
		this.fileName = fileName;
	}



	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public int getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
	
	
}
