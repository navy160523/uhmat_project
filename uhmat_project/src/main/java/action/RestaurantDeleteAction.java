package action;

import java.io.PrintWriter;

import javax.servlet.http.*;

import svc.RestaurantDeleteService;
import vo.*;

public class RestaurantDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("RestaurantDeleteAction");
		RestaurantDeleteService service = new RestaurantDeleteService();
		String resName = request.getParameter("resName");
		String photo = service.bringPhoto(resName);
		String filePath =  request.getServletContext().getRealPath("/upload");
		boolean isDeleteSuccess = service.deleteRestaurantInfo(resName,filePath, photo);
		
		if(isDeleteSuccess) {
			//성공시 지도 정보도 같이 삭제
			service.deleteMapInfo(resName);
			forward = new ActionForward();
			forward.setPath("restaurantList.re");
			forward.setRedirect(true);
		}else {
			PrintWriter out = response.getWriter();
			response.setContentType("text/html; charset=Utf-8");
			out.print("<script>alert('식당 삭제 실패');history.back();</script>");
		}
		return forward;
	}

}
