package action;

import java.io.*;

import javax.servlet.http.*;

import svc.*;
import vo.*;

public class ReviewLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("ReviewLikeAction.re");
		
		ActionForward forward = null;
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String nickname = request.getParameter("nickname");
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		System.out.println(idx + nickname + pageNum);
		
		ReviewLikeService service = new ReviewLikeService();
		boolean isModifySuccess = service.modifyLike(idx, nickname);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(!isModifySuccess) {
			out.println("<script>");
			out.println("alert('좋아요 수정 실패!')");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setPath("ReviewDetail.re?idx=" + idx + "&pageNum=" + pageNum);
			forward.setRedirect(true);
		}
		return forward;
	}

}
