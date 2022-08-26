package action;

import javax.servlet.http.*;

import svc.RestaurantModifyFormService;
import vo.*;

public class RestaurantModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("RestaurantModifyFormAction");
		RestaurantModifyFormService service = new RestaurantModifyFormService();
		
		//DAO에서 식당 정보와 식당 위치정보를 불러옴
		String resName = request.getParameter("resName");
		RestaurantInfoDTO dto = service.getRestaurantInfo(resName); 
		MapDTO map = service.getMapInfo(resName);
		
		//지도 위치정보와 식당 정보를 request 객체에 저장하여 jsp 파일로 전송
		request.setAttribute("map", map);
		request.setAttribute("resInfo", dto);
		
		forward = new ActionForward();
		forward.setPath("food/restaurant/res_modify.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
