package action.serviceCenter;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;

import action.Action;
import svc.*;
import svc.serviceCenter.FAQDeleteService;
import vo.*;

public class FAQDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("FAQDeleteAction - execute");
		ActionForward forward = null;
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		String uploadPath = "upload"; // 가상의 폴더명
		
		// 2. 업로드 파일 크기를 제한하기 위한 정수 형태의 값 지정(10MB 제한)
		int fileSize = 1024 * 1024 * 10; // byte(1) -> KB(1024Byte) -> MB(1024KB) -> 10MB 단위 변환
		
		// 3. 현재 프로젝트(서블릿)를 처리하는 객체인 서블릿 컨텍스트 객체 얻어오기
		ServletContext context = request.getServletContext();
		
		// 4. 업로드 파일이 저장되는 실제 경로를 얻어오기
		// => ServletContext 객체의 getRealPath() 메서드 호출
		String realPath = context.getRealPath(uploadPath); // 가상의 업로드 폴더명을 파라미터로 전달
//						System.out.println(realPath);
		// D:\Shared\JSP\workspace_jsp2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MVC_Board\ upload
		// => 실제 업로드 될 폴더 위치(주의! 워크스페이스 내의 프로젝트 폴더에 있는 upload 폴더는 가상의 폴더)
		
		// 5. MultipartRequest 객체 생성
		// => 생성자 파라미터로 파일 업로드에 필요한 각종 파라미터를 전달
		MultipartRequest multi = new MultipartRequest(
			request, // 1) 실제 요청 정보가 포함된 request 객체
			realPath, // 2) 실제 업로드 폴더 경로
			fileSize, // 3) 업로드 파일 크기
			"UTF-8", // 4) 파일명에 대한 인코딩 방식(한글 처리 등이 필요하므로 UTF-8 지정)
			new DefaultFileRenamePolicy() // 5) 중복 파일명에 대한 처리를 담당하는 객체(파일명 뒤에 숫자 1 부터 차례대로 부여)
		);
		// => 객체 생성되는 시점에 이미 업로드 파일은 실제 폴더에 업로드 처리 완료됨
		
		FAQDeleteService service = new FAQDeleteService();
		boolean deleteSuccess = service.removeFAQ(idx);
//		System.out.println("deleteSuccess : " + deleteSuccess);
		boolean deleteReplySuccess = false;

		
		if(!deleteSuccess) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");

		} else {
			File f = new File(realPath, multi.getParameter("real_File"));
			if(f.exists()) {
				f.delete();
			}	
			boolean checkReply = service.checkReply(idx);
			
			if(!checkReply) { // 댓글이 없을 경우
				deleteReplySuccess = true;
			} else { // 댓글이 있을 경우
				deleteReplySuccess = service.removeReplyFAQ(idx);
	//			System.out.println("deleteSuccess : " + deleteSuccess);
			}

		}
		if(!deleteReplySuccess) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");

			out.println("alert('글 삭제 실패!')");
			out.println("history.back()");
			out.println("</script>");

			
		} else {
			forward = new ActionForward();
			forward.setPath("FAQList.sc");
			forward.setRedirect(true);
		}
		
		return forward;
	}

}
