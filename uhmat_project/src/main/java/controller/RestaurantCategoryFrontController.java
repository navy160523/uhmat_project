package controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import org.json.simple.*;

import com.google.gson.*;
import com.mysql.cj.x.protobuf.MysqlxPrepare.*;

import action.*;
import vo.*;

/**
 * Servlet implementation class RestaurantReviewFrontController
 */
@WebServlet("*.re")
public class RestaurantCategoryFrontController extends HttpServlet {
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String command = request.getServletPath();
		System.out.println(command);
		ActionForward forward = null;
		Action action = null;
		// -------------------------------------------------------
		if (command.equals("/ReviewList.re")) {
			try {
				action = new ReviewListAction();
				forward = action.execute(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}

		}
		/*
		 * 여기서부터는 식당 요청!! 글쓰기 수정 삭제 등은 관리자로 로그인 되어있어야함!
		 */
		else if (command.equals("/restaurantList.re")) {
			System.out.println("식당 글 목록 요청!!");
			try {
				action = new RestaurantListAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantWriteForm.re")) {
			System.out.println("식당 글 입력 폼 요청!");
			forward = new ActionForward();

			forward.setPath("food/restaurant/res_write.jsp");

			forward.setRedirect(false);
		} else if (command.equals("/restaurantWritePro.re")) {
			System.out.println("식당 글 입력 요청!");
			try {
				action = new RestaurantWriteProAction();
				forward = action.execute(request, response);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantDetail.re")) {
			System.out.println("식당 상세보기 요청!");
			try {
				action = new RestaurantDetailAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantModifyForm.re")) {
			System.out.println("식당 수정 폼 요청!");
			try {
				action = new RestaurantModifyFormAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantModifyPro.re")) {
			System.out.println("식당 수정 업데이트 요청!");
			try {
				action = new RestaurantModifyProAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantDelete.re")) {
			System.out.println("식당 삭제 요청!");
			try {
				action = new RestaurantDeleteAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 추가로 태그와 카테고리 관련된 작업 요청이 더 필요함!!

		else if (command.equals("/ReviewModifyForm.re")) {
			try {
				action = new ReviewModifyFormAction();
				forward = action.execute(request, response);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (command.equals("/restaurantDetail.re")) {
			System.out.println("식당 상세보기 요청!");
			try {
				action = new RestaurantDetailAction();
				forward = action.execute(request, response);

			} catch (Exception e) {

				e.printStackTrace();
			}
		} else if (command.equals("/ReviewModifyProAction.re")) {
			try {
				action = new ReviewModifyProAction();
				forward = action.execute(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}

		} else if (command.equals("/ReviewDelete.re")) {
			try {
				action = new ReviewDetailAction();
				forward = action.execute(request, response);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantModifyForm.re")) {
			System.out.println("식당 수정 폼 요청!");
			try {
				action = new RestaurantModifyFormAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantModifyPro.re")) {
			System.out.println("식당 수정 업데이트 요청!");
			try {
				action = new RestaurantModifyProAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (command.equals("/restaurantDelete.re")) {
			System.out.println("식당 삭제 요청!");
			try {
				action = new RestaurantDeleteAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		// 추가로 태그와 카테고리 관련된 작업 요청이 더 필요함!!

		// 지도로 보기-------------------------------------------------------------------------
			
			// json 이용하여 다 보여주기 & 검색
			
		}else if (command.equals("/map.re")) {

			MapAction mapGet = new MapAction();

			JSONObject jobj = new JSONObject();
			ArrayList<RestaurantInfoDTO> list = mapGet.execute(request, response);

			String gson = new Gson().toJson(list);
			System.out.println(list);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(gson);
		
		// 지도 보여주기
		} else if (command.equals("/mapForm.re")) {

			forward = new ActionForward();
			forward.setPath("/food/map/map.jsp");
			forward.setRedirect(false);

		}
		//----------------------------------------------------------
		if (forward != null)

		{
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				request.getRequestDispatcher(forward.getPath()).forward(request, response);
			}
		}
	}
	// ---------------------------------------------------------

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
