package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import action.Action;
import action.admin.AdminDeleteMemberAction;
import action.admin.AdminManageMemberDetailAction;
import action.admin.AdminManageMemberListAction;
import action.admin.AllBoardListAction;
import vo.ActionForward;

/**
 * Servlet implementation class admincontroller
 */
@WebServlet("*.ad")
public class admincontroller extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getServletPath();
		System.out.println(command);
		ActionForward forward = null;
		Action action = null;
		if (command.equals("/Admin.ad")) {
			forward = new ActionForward();
			forward.setPath("admin/adminTop.jsp");
			forward.setRedirect(false);
			
		} else if(command.equals("/AdminManageMemberList.ad")) {
			try {
				action = new AdminManageMemberListAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/AdminManageMemberDetail.ad")) {
			try {
				action = new AdminManageMemberDetailAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		} else if(command.equals("/AdminDeleteMember.ad")) {
			try {
				action = new AdminDeleteMemberAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//-------------------------------------------------------------------
		// 회원가입 폼
		else if (command.equals("/AllBoardListForm.ad")) {
			forward = new ActionForward();
			forward.setPath("/admin/AllBoardList.jsp");
			forward.setRedirect(false);
		}
		// 회원가입 폼 (DB)처리
		else if (command.equals("/AllBoardList.ad")) {
			try {
				action = new AllBoardListAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			String gson = new Gson().toJson(request.getAttribute("list"));
			System.out.println(request.getAttribute("list"));
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(gson);
		}
		
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				request.getRequestDispatcher(forward.getPath()).forward(request, response);
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doProcess(request, response);
	}

}
