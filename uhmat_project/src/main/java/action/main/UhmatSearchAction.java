package action.main;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import svc.main.*;
import vo.*;

public class UhmatSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		UhmatSearchService service = new  UhmatSearchService();
		
		ArrayList<ReviewBoardDTO> reviewBoard= service.getSearhReviewBoard(search); 
		ArrayList<RestaurantInfoDTO> restaurantBoard = service.getSearchRestaurantInfo(search);
		System.out.println("reviewBoard : " + reviewBoard + "restaurantBoard : " + restaurantBoard );
		
		request.setAttribute("reviewBoard", reviewBoard);
		request.setAttribute("restaurantBoard", restaurantBoard);
		
		forward = new ActionForward();
		forward.setPath("searchResult.jsp");
		forward.setRedirect(false);
				
		return forward;
	}

}
