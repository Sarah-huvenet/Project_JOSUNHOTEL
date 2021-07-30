package board.qna;

public class MyUtil {
	//전체 페이지 수 구하기
	//numPerPage : 한화면에 표시할 데이터 개수
	//dataCount : 전체 데이터 갯수
	public int getPageCount(int numPerPage, int dataCount) {
		int pageCount = 0;
		pageCount = dataCount / numPerPage;
		if(dataCount%numPerPage != 0) {
			pageCount++;
		}
		return pageCount;
	}
	
	//페이징 처리 메소드
	//currentPage : 현재 표시할 페이지
	//totalPage : 전체 페이지 수
	//listUrl : 링크를 설정할 URL (adminQnaList.jsp)
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {
		int numPerBlock = 5; //리스트 밑에 나오는 페이지번호 출력 갯수
		int currentPageSetup; //표시할 첫 페이지의 -1 해준 값
		int page; //하이퍼링크가 될 page index 숫자
		
		StringBuffer sb = new StringBuffer();
		if(currentPage==0 || totalPage ==0) { //데이터가 없을경우
			return "";
		}
		
		System.out.println(listUrl);
		System.out.println(listUrl.indexOf("?"));
		if(listUrl.indexOf("?")!=-1) { //물음표가 있으면
			listUrl = listUrl + "&";
		}else {
			listUrl = listUrl + "?";
		}
		
		
		//표시할 첫 페이지의 -1 해준 값
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;
		
		//currentPage가 numPerBlock로 나누어 떨어지는 경우
		if(currentPage % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}

		//바로가기 페이지
		page = currentPageSetup + 1; //currentPageSetup에 +1값부터 페이지 번호가 시작됨
		
		//바로가기 페이지는 전체페이지 수 보다 커질수 없음
		while(page <= totalPage && page <= (currentPageSetup+numPerBlock)) {
			if(page == currentPage) {
				sb.append("<a class=\"active\" href=\""+listUrl+"pageNum="+page+"\">"+page+"</a>&nbsp;");
			}else {
				sb.append("<a href=\""+listUrl+"pageNum="+page+"\">"+page+"</a>&nbsp;");
			}
			page++;
		}
		
		return sb.toString();
		//https://wiper2019.tistory.com/85?category=781008
	}
}
