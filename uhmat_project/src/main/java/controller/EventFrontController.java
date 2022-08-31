package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.event.ServiceWriteProAction;
import vo.ActionForward;

@WebServlet("*.ev")
public class EventFrontController extends HttpServlet {
	// GET 방식 or POST 방식에 따른 처리를 별도로 구분하지 않고 공통으로 처리하기 위해
	// doProcess() 메서드를 정의하고 doGet(), doPost() 메서드에서 호출
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("EventFrontController");
		
		// POST 방식 요청에 대한 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		// 서블릿 주소 추출
		String command = request.getServletPath();
		System.out.println("command : " + command);
		
		// Action 클래스 인스턴스들을 공통으로 관리하는 Action 타입 변수 선언
		Action action = null;
		// 포워딩 정보를 관리하는 ActionForward 타입 변수 선언
		ActionForward forward = null;
		
		// =============================================================================
		
		// 추출된 서블릿 주소를 if문을 사용하여 판별하고 각 주소에 따른 액션(작업) 요청
		// 이벤트 페이지의 서비스(어맛이벤트, 쿠폰 등) 서블릿 요청 시작
		
		// 이벤트페이지의 서비스의 이벤트참여하기(글쓰기)
		// => 사용자가 이벤트 참여 사용!
		if(command.equals("/ServiceWriteForm.ev")) {
			System.out.println("이벤트서비스 참여 뷰페이지!");
			forward = new ActionForward();
			forward.setPath("event/service/serviceWrite.jsp");
			forward.setRedirect(false);
			
		} else if(command.equals("/ServiceWritePro.ev")) {
			System.out.println("이벤트서비스 참여 작업 요청");
			try {
				action = new ServiceWriteProAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ServiceWriteProAction 오류 - " + e.getMessage());
			}
		}
		
		// =======================================================================================
		// ActionFoward 객체에 저장된 포워딩 정보에 따른 포워딩 작업을 수행하기 위한 공통코드 작성
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
