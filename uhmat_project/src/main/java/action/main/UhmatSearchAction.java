package action.main;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import svc.*;
import svc.main.*;
import vo.*;

public class UhmatSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		// restaurantBoard pageNum을 처리하기 위하여
		//페이징 처리를 위한 변수 선언
		int pageNum = 1;
		int listLimit = 6;
		int pageLimit = 10;
		
		UhmatSearchService service = new  UhmatSearchService();
		
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		String targetTag = "";
		
		if(request.getParameter("targetTag") != null) {
			
			targetTag = request.getParameter("targetTag");
		}	
		//페이징 처리에 필요한 전체 게시물 갯수 조회 작업
		
		int listCount = service.getListCount(search);
		
		System.out.println("전체 게시물 수 : " + listCount);
		
		//페이징 처리를 위한 계산 작업
		// 1.현재 페이지에서 표시할 전체 페이지 수 계산
		int maxPage = (int)Math.ceil((double)listCount/ listLimit);
		
		// 2. 현재 펭지에서 보여줄 시작 페이지 번호
		int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
		
		// 3. 현재 페이지에서 보여줄 끝 페이지 번호
		int endPage = startPage + pageLimit - 1;
		
		// 4. 끝페이지를 총 페이지 수로 대체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이징 처리 정보를 pageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(pageNum, maxPage, startPage, endPage, listCount);
		
		ArrayList<ReviewBoardDTO> reviewBoard= service.getSearhReviewBoard(search); 
		ArrayList<RestaurantInfoDTO> restaurantBoard = service.getSearchRestaurantInfo(search);
		System.out.println("reviewBoard : " + reviewBoard + "restaurantBoard : " + restaurantBoard );
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("reviewBoard", reviewBoard);
		request.setAttribute("restaurantBoard", restaurantBoard);
		
		forward = new ActionForward();
		forward.setPath("searchResult.jsp");
		forward.setRedirect(false);
				
		return forward;
	}

}
