package action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import svc.*;
import vo.*;

public class MapAction  {


	public ArrayList<RestaurantInfoDTO> execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MapAction - execute ");
		ActionForward forward = null;
		
		String keyword= "";
		
		if(request.getParameter("keyword")!=null) {
			keyword = request.getParameter("keyword");
		}
		System.out.println("keyword : " + keyword);
		
		MapService service = new MapService();
		
		ArrayList<RestaurantInfoDTO> list = service.selectMapList(keyword);
		
		request.setAttribute("list", list);
		
		System.out.println("list : " + list);
		
		return list;
	}

}
