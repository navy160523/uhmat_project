package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import action.Action;
import action.member.MemberAuthAction;
import action.member.MemberChechDuplicateEmailAction;
import action.member.MemberChechDuplicateNickNameAction;
import action.member.MemberJoinProAction;
import action.member.MemberLoginProAction;
import action.member.MemberLogoutAction;
import action.member.MemberNaverLoginAction;
import action.member.MemberSendAuthMailAction;
import vo.ActionForward;


@WebServlet("/MemberNaverLogin")
public class MemberNaverLogin extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	
		String command = request.getServletPath();
		System.out.println(command);
		ActionForward forward = null; 
		Action action = null;
		
		try {
			action=new MemberNaverLoginAction();
			forward=action.execute(request, response);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
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
