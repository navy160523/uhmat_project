package svc;

import java.sql.*;
import static db.JdbcUtil.*;
import java.util.*;

import dao.*;
import vo.*;

public class RestaurantListService {
	public int getListCount() { //전체 목록의 개수를 가져오는 메서드
		System.out.println("RestaurantListService - getListCount");
		Connection con = getConnection();
		int listCount = 0;
		RestaurantDAO dao = RestaurantDAO.getInstance();
		dao.setConnection(con);
		
		listCount = dao.selectListCount();
		close(con);
		return listCount;
	}
	
	
	public List<RestaurantInfoDTO> selelctRestaurantList(int pageNum, int listLimit) {	//글목록을 정해진 개수만큼 불러오는 메서드
		System.out.println("RestaurantListService-selelctRestaurantList");
		List<RestaurantInfoDTO> list = null;
		Connection con = getConnection();
		RestaurantDAO dao = RestaurantDAO.getInstance();
		dao.setConnection(con);
		list = dao.selectRestaurantList(pageNum, listLimit);
		
		return list;
	}

	

}
