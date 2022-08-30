package action.mainsrh;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import svc.mainsch.*;
import vo.*;

public class UhmatSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		UhmatSearchService service = new  UhmatSearchService();
		
		ArrayList<CommunityTmiDTO> tmiBoard = service.getSearchTmiBoard(search); 
		ArrayList<MateDTO> mateBoard = service.getSearchMateBoard(search); 
		ArrayList<ReviewBoardDTO> reviewBoard= service.getSearhReviewBoard(search); 
		ArrayList<RestaurantInfoDTO> restaurantBoard = service.getSearchRestaurantInfo(search);
		ArrayList<FAQDTO> FAQ = service.getSearchFAQboard(search);
		ArrayList<NoticeDTO> notice = service.getSearchNoticeboard(search);
		System.out.println("tmiBoard: " + tmiBoard + ", mateBoard : " + mateBoard + ", reviewBoard : " + reviewBoard + ", restaurantBoard : " + restaurantBoard + ", FAQBoard : " + FAQ +", noitce : " + notice);
		
		request.setAttribute("tmiBoard", tmiBoard);
		request.setAttribute("mateBoard", mateBoard);
		request.setAttribute("reviewBoard", reviewBoard);
		request.setAttribute("restaurantBoard", restaurantBoard);
		request.setAttribute("FAQ", FAQ);
		request.setAttribute("notice", notice);
		
		forward = new ActionForward();
		forward.setPath("searchResult.jsp");
		forward.setRedirect(false);
				
		return forward;
	}

}
