package board.review;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import conn.DBConn;
@WebServlet("/ModifyReviewServlet")
public class ModifyReivewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");// 한글 디코딩
		response.setContentType("text/html; charset=utf-8");
		String path=getServletConfig().getServletContext().getRealPath("/") + "img/review"; // 파일이 업로드가 되면 어디에 저장 폴더 
	    String enctype="UTF-8"; //한글파일명을 사용 여부 
	    int size=1024*1024*100;//파일의 최대크기 
	    System.out.println(path);
	    
	    File fileSaveDir = new File(path);
	    // 파일 경로 없으면 생성
	    if (!fileSaveDir.exists()) {
	    	fileSaveDir.mkdirs();
	 	}
	    
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("idKey");
	    // 사용자가 보내준 데3이터를 받는다 (request=>파일을 받을 수 없다 , 일반데이터만 받는다)
	    MultipartRequest mr=new MultipartRequest(request,path,size,enctype,new DefaultFileRenamePolicy());
		
	    int idx = Integer.parseInt(mr.getParameter("idx"));
		int roomNum = Integer.parseInt(mr.getParameter("reservedRoom"));
		String content = mr.getParameter("content");
		String title = mr.getParameter("title");
		String originFilename = mr.getParameter("orginFileName");
		
		// filename,filesize => 없는 경우 (파일을 올리지 않을 경우,파일 올릴 경우)
	    String filename=mr.getOriginalFileName("uploadFile");
	    String fileReName = mr.getFilesystemName("uploadFile");
	    
	    ReviewVO vo = new ReviewVO(title, content, id, roomNum, filename);
	    vo.setIdx(idx);
		if(filename==null || filename == ""){//파일을 올리지 않을 경우
	         vo.setFileName(originFilename);	// 원래 이름으로 저장
	         
	    } else{//파일 올릴 경우-----------------------------------------------------------중요  여기서 셋
	         File file=new File(path+fileReName);
	         // 업로드된 파일의 정보를 얻어온다 (파일 크기를 확인) => 다운로드 (프로그래바)
	         vo.setFileName(fileReName);
	         
	         // 파일을 올렸을경우에만 원래 이미지 삭제
	         File originImg = new File(path + "/"+originFilename);	// 저장함
	         
	         if(originImg.exists()) {
	        	 if(originImg.delete()) {
	        		 System.out.println("파일삭제 성공");
	        	 } else {
	        		 System.out.println("파일삭제 실패");
	        	 }
	         } else {
	        	 System.out.println("파일이 존재 하지 않습니다.");
	         }
	    }
		
		ReviewDAO dao = new ReviewDAO(DBConn.getConnection());
		dao.modifyWritea(vo);
	    response.sendRedirect("reviewboard?command=reviewmain");
	}

}
