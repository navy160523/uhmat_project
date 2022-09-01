package action;

import java.util.*;

import javax.servlet.http.*;

import svc.*;
import vo.*;

public class ReviewReplyListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("ReviewReplyListAction.re");
		
		ActionForward forward = null;
		
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String nickname = request.getParameter("nickname");
		
		System.out.println(idx + " " + nickname);
		
		ArrayList<ReviewReplyDTO> replyList = ReviewReplyListService.getReplyList(idx);
		
		request.setAttribute("replyList", replyList);
		
		forward = new ActionForward();
		forward.setPath("food/review/reviewReplyList.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
