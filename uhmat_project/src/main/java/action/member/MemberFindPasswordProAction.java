package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import vo.ActionForward;

public class MemberFindPasswordProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String email = request.getParameter("email");
		System.out.println(email);
		// 가입 성공 시 인증 메일 발송을 위한 서블릿 주소 요청(파라미터 : 아이디, 이메일)
		forward = new ActionForward();
		forward.setPath("SendPasswordMail.me?email=" + email);
		forward.setRedirect(true);

		return forward;
	}

}
