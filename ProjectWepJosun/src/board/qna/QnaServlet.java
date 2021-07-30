package board.qna;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import conn.DBConn;

@WebServlet("/QnaServlet")
public class QnaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("QnaServlet 연결");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	    String path=request.getServletContext().getRealPath("") + "upload"; // 파일이 업로드가 되면 어디에 저장 폴더 
	    String enctype="UTF-8"; //한글파일명을 사용 여부 
	    int size=1024*1024*100;//파일의 최대크기 
	    System.out.println(path);
	    
	    File fileSaveDir = new File(path);
	    // 파일 경로 없으면 생성
	    if (!fileSaveDir.exists()) {
	    	fileSaveDir.mkdirs();
	 	}
	    
	    // 사용자가 보내준 데이터를 받는다 (request=>파일을 받을 수 없다 , 일반데이터만 받는다)
	    MultipartRequest mr=new MultipartRequest(request,path,size,enctype,new DefaultFileRenamePolicy());
		
		int category = Integer.parseInt(mr.getParameter("category"));
		String content = mr.getParameter("content");
		String name = mr.getParameter("name");
		String phone = mr.getParameter("phone");
		String email = mr.getParameter("email");
		String reply = mr.getParameter("reply");
		
		// filename,filesize => 없는 경우 (파일을 올리지 않을 경우,파일 올릴 경우)
	    String filename=mr.getOriginalFileName("uploadFile");
	    String fileReName = mr.getFilesystemName("uploadFile");
	    
	    BoardDTO dto = new BoardDTO();
	    dto.setCategory(category);
	    dto.setContent(content);
	    dto.setName(name);
	    dto.setPhone(phone);
	    dto.setEmail(email);
	    dto.setReply(reply);
		
		System.out.println(category + " " + name + " " + phone + " " + email + " " + reply + " " + filename);
		System.out.println("systemName : " + fileReName);
		
		if(filename==null){//파일을 올리지 않을 경우
	         dto.setFileName("");
	    } else{//파일 올릴 경우
	         File file=new File(path+fileReName);
	         // 업로드된 파일의 정보를 얻어온다 (파일 크기를 확인) => 다운로드 (프로그래바)
	         dto.setFileName(fileReName);
	    }
		
		Connection conn = DBConn.getConnection();
		BoardDAO dao = new BoardDAO(conn);
		int result = dao.insertData(dto);
		System.out.println("result : " + result);
		
		PrintWriter out = response.getWriter();
		if(result >= 1) {
			out.println("<script>");
			out.println("alert('정상적으로 접수되었습니다. 담당자가 확인 후 연락드리겠습니다.')");
			out.println("location.href='qna.jsp'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('오류가 발생되었습니다. 잠시 후 다시 접수해주세요.')");
			out.println("location.href='qna.jsp'");
			out.println("</script>");
		}
	}
}
