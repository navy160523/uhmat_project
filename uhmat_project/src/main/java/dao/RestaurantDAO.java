package dao;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;

import vo.*;
public class RestaurantDAO {
	// 싱글톤 DAO 생성
	private RestaurantDAO() {}
	private static RestaurantDAO instance = new RestaurantDAO();
	public static  RestaurantDAO getInstance() {
		return instance;
	}
	
	//커넥션 객체를 전달받기 위한 지역변수 선언 + 넘겨받는 메서드
	private Connection con;
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	//전체 목록의 개수 조회
	public int selectListCount() {
		System.out.println("RestaurantDAO-selectListCount");
		int listCount=0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM restaurant_info";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("selectListCount - SQL 구문 오류!");
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	//전체 목록을 페이징 처리하여 조회
	public List<RestaurantInfoDTO> selectRestaurantList(int pageNum, int listLimit) {
		System.out.println("RestaurantDAO-selectRestaurantList");
		List<RestaurantInfoDTO> list = null;
		int startPage = (pageNum-1)*listLimit;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM restaurant_info ORDER BY res_name LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startPage);
			pstmt.setInt(2, listLimit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RestaurantInfoDTO dto = new RestaurantInfoDTO();
				dto.setResName(rs.getString("res_name"));
				dto.setrPostcode(rs.getString("r_postcode"));
				dto.setResName(rs.getString("address"));
				dto.setResName(rs.getString("phone_number"));
				dto.setResName(rs.getString("opentime"));
				dto.setResName(rs.getString("res_link"));
				dto.setResName(rs.getString("photo"));
				dto.setReviewCount(rs.getInt("reviewCount"));
				dto.setRating(rs.getFloat("rating"));
									
				list.add(dto);				
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("selectRestaurantList - SQL 구문 오류!");
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int insertResInfo(RestaurantInfoDTO dto) {
		int insertCount = 0 ;
		System.out.println("RestaurantDAO - insertResInfo()");
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO restaurant_info VALUES(?,?,?,0,?,?,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getResName());
			pstmt.setString(2, dto.getrPostcode());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getPhoneNumber());
			pstmt.setString(5, dto.getOpentime());
			pstmt.setString(6, dto.getResLink());
			pstmt.setString(7, dto.getPhoto());
			pstmt.setString(8, dto.getResInfo());
			
			insertCount=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("RestaurantDAO - insertResInfo() - SQL 구문 오류!");
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}
}
