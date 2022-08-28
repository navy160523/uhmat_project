package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.member.MemberDetailService;
import vo.ActionForward;
import vo.MemberDTO;

public class MemberDetailFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberDetailFormAction");

		ActionForward forward = null;

		String nickName = request.getParameter("nickName");

		MemberDetailService service = new MemberDetailService();

		MemberDTO member = service.getMember(nickName);

		request.setAttribute("member", member);

		forward = new ActionForward();
		forward.setPath("member/detail.jsp");
		forward.setRedirect(false);

		return forward;
	}

}
