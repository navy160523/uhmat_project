package svc.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;
import java.util.*;

import dao.*;
import db.*;
import vo.*;

public class AdminManageMemberListService {

	public int getMemberListSelectCount() {
		int listCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		dao.setConnection(con);
		
		listCount = dao.SelectMemberListCount();
				
		JdbcUtil.close(con);
		
		return listCount;
	}
	
	public ArrayList<MemberDTO> getMember(int pageNum, int listLimit, String ment) {
		ArrayList<MemberDTO> list= null;
		
		Connection con = getConnection();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.AdminSelectMemberList(pageNum, listLimit, ment);
		System.out.println("AdminManageMemberListService의 list :" + list);
		close(con);
		
		return list;
	}


}
