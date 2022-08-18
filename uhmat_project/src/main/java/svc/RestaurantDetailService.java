package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.RestaurantDAO;
import vo.RestaurantInfoDTO;

public class RestaurantDetailService {

	public RestaurantInfoDTO selectDetail(String resName) {
		RestaurantInfoDTO dto = null;
		System.out.println("RestaurantDetailService-selectDetail");
		Connection con = getConnection();
		RestaurantDAO dao = RestaurantDAO.getInstance(); 
		dao.setConnection(con);
		dto = dao.getRestaurantInfo(resName);
		
		close(con); 
		return dto;
	}

}
