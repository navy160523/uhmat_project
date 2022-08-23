package action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import svc.*;
import vo.*;

public class MapAction  {


	public ArrayList<RestaurantInfoDTO> execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		MapService service = new MapService();
		ArrayList<RestaurantInfoDTO> list = service.selectMapList();
		
		request.setAttribute("list", list);
		
		System.out.println("list : " + list);
		
		return list;
	}
	public ArrayList<MapDTO> execute2(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		MapService service = new MapService();
		
		ArrayList<MapDTO> list2 = service.selectMapList2();
		
		request.setAttribute("list2", list2);
		
		System.out.println("list : " + list2);
		
		
		return list2;
	}

}
