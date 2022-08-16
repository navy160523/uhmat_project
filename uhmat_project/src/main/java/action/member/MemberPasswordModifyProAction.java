package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.member.MemberPasswordModifyProService;
import vo.ActionForward;

public class MemberPasswordModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String email = request.getParameter("email");
		String passwd= request.getParameter("passwd");

		MemberPasswordModifyProService service = new MemberPasswordModifyProService();
		boolean isModifyPasswordSuccess = service.modifyPassword(email, passwd);
		
		if(!isModifyPasswordSuccess) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('새로운 패스워드 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('새로운 패스워드 등록 성공!')");
			out.println("</script>");
			forward = new ActionForward();
			forward.setPath("MemberLoginForm.me");
			forward.setRedirect(true);
		}
	

		return forward;
	}

}
