package action;

import java.io.*;

import javax.servlet.http.*;

import svc.*;
import vo.*;

public class ReviewReplyWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("ReviewReplyWriteAction");
		ActionForward forward = null;
		
		int board_idx = Integer.parseInt(request.getParameter("idx"));
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		ReviewReplyWriteService service = new ReviewReplyWriteService();
		boolean isWriteSuccess = service.registReply(board_idx, nickname, content);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(!isWriteSuccess) {
			out.println("<script>");
			out.println("alert('좋아요 수정 실패!')");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setPath("ReviewDetail.re?idx=" + board_idx + "&pageNum=" + pageNum);
			forward.setRedirect(true);
		}
		return forward;
	}

}
