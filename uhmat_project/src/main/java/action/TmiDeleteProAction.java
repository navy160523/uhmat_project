package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.TmiDeleteProService;
import vo.ActionForward;

public class TmiDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("TmiDeleteProAction");
		
		ActionForward forward = null;
		
		// request 객체를 통해 전달받은 파라미터(idx, nickname) 가져오기
		int idx = Integer.parseInt(request.getParameter("idx"));
		String nickname = request.getParameter("nickname");
		
		// TmiDeleteProService - isTmiWriter() 메서드를 호출하여 삭제 권한 판별
		// => 파라미터 : 글번호, 닉네임		리턴타입 : boolean(isTmiWriter)
		// => 작업 내용은 TmiModifyService의 isTmiWriter()와 동일합니다.
		TmiDeleteProService service = new TmiDeleteProService();
		boolean isTmiWriter = service.isTmiWriter(idx, nickname);
		
		// 삭제 권한 판별 결과에 따른 작업 수행
		if(!isTmiWriter) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제 불가능!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			// TmiDeleteProService - removeTmiBoard() 메서드를 호출하여 삭제 요청
			// => 파라미터 : 글번호    리턴타입 : boolean(isTmiDeleteSuccess)
			boolean isTmiDeleteSuccess = service.removeTmiBoard(idx);
			
			// 삭제 결과 판별
			if(!isTmiDeleteSuccess) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 실패!')");
				out.println("history.back()");
				out.println("</script>");
			} else {
				// 글목록(TmiList.co) 페이지 요청 => 페이지번호 전달
				forward = new ActionForward();
				forward.setPath("TmiList.co?idx=" + idx + "&pageNum=" + request.getParameter("pageNum"));
				forward.setRedirect(true);
			}
			
		}
		
		return forward;
	}

}
