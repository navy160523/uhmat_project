package svc;

import java.sql.*;
import java.util.*;

import dao.*;
import db.*;
import vo.*;

public class MapService {

	public ArrayList<RestaurantInfoDTO> selectMapList(String keyword) {
		System.out.println("MapService - selectMapList");
		ArrayList<RestaurantInfoDTO> list =null;
		
		Connection con = JdbcUtil.getConnection();
		
		RestaurantDAO dao = RestaurantDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.selectMapList(keyword);
		System.out.println("list : " + list);
		JdbcUtil.close(con);
		
		return list;
		
		
	}


}
