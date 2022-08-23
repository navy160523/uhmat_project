package svc;

import java.sql.*;
import java.util.*;

import dao.*;
import db.*;
import vo.*;

public class MapService {

	public ArrayList<RestaurantInfoDTO> selectMapList() {
		ArrayList<RestaurantInfoDTO> list =null;
		
		Connection con = JdbcUtil.getConnection();
		
		RestaurantDAO dao = RestaurantDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.selectMapList();
		
		JdbcUtil.close(con);
		
		return list;
		
		
	}

	public ArrayList<MapDTO> selectMapList2() {
		ArrayList<MapDTO> list2 =null;
		
		Connection con = JdbcUtil.getConnection();
		
		RestaurantDAO dao = RestaurantDAO.getInstance();
		
		dao.setConnection(con);
		
		list2 = dao.selectMapList2();
		
		JdbcUtil.close(con);
		
		return list2;
	}

}
