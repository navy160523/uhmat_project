package svc;

import java.sql.*;
import java.util.*;

import dao.*;
import db.*;
import vo.*;

public class FAQListService {

	public int getListSelectCount(String ment) {
		int listCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		
		FAQDAO dao = FAQDAO.getInstance();
		
		dao.setConnection(con);
		
		listCount = dao.selectAnythingListcount(ment);
		System.out.println("getList listCount " + listCount);
		JdbcUtil.close(con);
		
		return listCount;
	}
	
	public ArrayList<FAQDTO> getFAQList(int pageNum, int listLimit, String ment) {
		ArrayList<FAQDTO> list = null;
		
		Connection con = JdbcUtil.getConnection();
		
		FAQDAO dao = FAQDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.selectAnythingList(pageNum, listLimit, ment);
		
		JdbcUtil.close(con);
		
		return list;
	}

	

}
