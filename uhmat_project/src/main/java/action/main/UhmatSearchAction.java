package action.main;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.main.UhmatSearchService;
import vo.ActionForward;
import vo.CommunityTmiDTO;
import vo.FAQDTO;
import vo.MateDTO;
import vo.NoticeDTO;
import vo.RestaurantInfoDTO;
import vo.ReviewBoardDTO;

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
