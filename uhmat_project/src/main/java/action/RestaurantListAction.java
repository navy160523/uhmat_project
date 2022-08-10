package action;

import java.util.*;

import javax.servlet.http.*;

import svc.*;
import vo.*;

public class RestaurantListAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("RestaurantListAction");
		
		RestaurantListService service = new RestaurantListService();
		//1. 페이지 계산하는 메서드
		int listCount = service.getListCount();
		int pageNum = 1; // 현재 페이지 번호(기본값 1 페이지로 설정)
		int listLimit = 10; // 한 페이지 당 표시할 게시물 수
		int pageLimit = 10; // 한 페이지 당 표시할 페이지 목록 수
		
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum")); // String -> int 변환
		}
		System.out.println("전체 게시물 수 : " + listCount);
		// -------------------------------------------------------------------------------------
		// 페이징 처리를 위한 계산 작업
		// 1. 현재 페이지에서 표시할 전체 페이지 수 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);

		// 2. 현재 페이지에서 보여줄 시작 페이지 번호(1, 11, 21 등의 시작 번호) 계산
		int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

		// 3. 현재 페이지에서 보여줄 끝 페이지 번호(10, 20, 30 등의 끝 번호) 계산
		int endPage = startPage + pageLimit - 1;

		// 4. 만약, 끝 페이지(endPage)가 현재 페이지에서 표시할 총 페이지 수(maxPage)보다 클 경우
		// 끝 페이지 번호를 총 페이지 수로 대체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		//2.페이지 개수만큼의 글 목록을 가져오기 
		List<RestaurantInfoDTO> list = service.selelctRestaurantList(pageNum,listLimit);
		
		
		PageInfo pageInfo = new PageInfo(pageNum, maxPage, startPage, endPage, listCount);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("restaurantInfo", list);
		forward = new ActionForward();
		forward.setPath("food/restaurant/res_list.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
	

}
