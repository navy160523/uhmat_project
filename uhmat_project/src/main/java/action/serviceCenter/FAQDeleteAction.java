package action.serviceCenter;

import java.io.*;

import javax.servlet.http.*;

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
