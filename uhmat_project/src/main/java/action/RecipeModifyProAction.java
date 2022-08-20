package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.RecipeModifyProService;
import vo.ActionForward;
import vo.RecipeDTO;

public class RecipeModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("레시피글 수정 작업 요청 액션 - RecipeModifyProAction");
		
		ActionForward forward = null;
		
		
		
		
		
		RecipeDTO recipe = new RecipeDTO();
		recipe.setIdx(Integer.parseInt(request.getParameter("idx")));
		recipe.setNickname(request.getParameter("nickname"));
		recipe.setSubject(request.getParameter("subject"));
		recipe.setContent(request.getParameter("content"));
		System.out.println("레시피프로액션 - " + recipe);
		
		RecipeModifyProService service = new RecipeModifyProService();
		boolean isModifySuccess = service.modifyRecipe(recipe);
		
		if(!isModifySuccess) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 수정 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setPath("RecipeDetail.co?idx=" + Integer.parseInt(request.getParameter("idx")) + "&pageNum=" + request.getParameter("pageNum"));
			forward.setRedirect(true);
		}
		
		return forward;
	}

}
