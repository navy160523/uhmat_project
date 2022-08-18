package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReviewDetailService;
import vo.ActionForward;
import vo.ReviewBoardDTO;

public class ReviewModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("ReviewModifyFormAction");
		ActionForward forward = null;
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		ReviewDetailService service = new ReviewDetailService();
		ReviewBoardDTO dto = service.getReviewBoard(idx);
		
		request.setAttribute("dto", dto);
		request.setAttribute("originPath", dto.getPhoto());

		forward = new ActionForward();
		forward.setPath("food/review/reviewModifyForm.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
