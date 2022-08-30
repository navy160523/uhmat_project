package dao;

import static db.JdbcUtil.close;

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
			

			list = new ArrayList<RestaurantInfoDTO>();

			while(rs.next()) {
				RestaurantInfoDTO dto = new RestaurantInfoDTO();
				dto.setResName(rs.getString("res_name"));
				dto.setrPostcode(rs.getString("r_postcode"));

				dto.setAddress(rs.getString("address"));
				dto.setPhoneNumber(rs.getString("phone_number"));
				dto.setOpentime(rs.getString("opentime"));
				dto.setResLink(rs.getString("res_link"));
				dto.setPhoto(rs.getString("photo"));
				dto.setReviewCount(rs.getInt("reviewCount"));
				dto.setRating(rs.getFloat("rating"));
				
				System.out.println(dto);

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


	//식당 정보 입력

	public int insertResInfo(RestaurantInfoDTO dto) {
		int insertCount = 0 ;
		System.out.println("RestaurantDAO - insertResInfo()");
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO restaurant_info VALUES(?,?,?,0,?,?,?,?,?,0,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getResName());
			pstmt.setString(2, dto.getrPostcode());
			pstmt.setString(3, dto.getAddress());
			pstmt.setString(4, dto.getPhoneNumber());
			pstmt.setString(5, dto.getOpentime());
			pstmt.setString(6, dto.getResLink());
			pstmt.setString(7, dto.getPhoto());
			pstmt.setString(8, dto.getResInfo());
			pstmt.setDouble(9, dto.getLatitude());
			pstmt.setDouble(10, dto.getLongitude());
			

			System.out.println(dto);

			insertCount=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("RestaurantDAO - insertResInfo() - SQL 구문 오류!");
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}


	//식당 상세정보 가져오기
	public RestaurantInfoDTO getRestaurantInfo(String resName) {
		System.out.println("RestaurantInfoDTO-getRestaurantInfo");
		RestaurantInfoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT*FROM restaurant_info WHERE res_name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, resName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new RestaurantInfoDTO();
				dto.setResName(rs.getString("res_name"));
				dto.setrPostcode(rs.getString("r_postcode"));
				dto.setAddress(rs.getString("address"));
				dto.setPhoneNumber(rs.getString("phone_number"));
				dto.setOpentime(rs.getString("opentime"));
				dto.setResLink(rs.getString("res_link"));
				dto.setPhoto(rs.getString("photo"));
				dto.setReviewCount(rs.getInt("reviewCount"));
				dto.setRating(rs.getFloat("rating"));
				dto.setResInfo(rs.getString("res_info"));
				dto.setLatitude(rs.getDouble("latitude"));
				dto.setLongitude(rs.getDouble("longitude"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getRestaurantInfo() - SQL 구문 오류!");
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return dto;
	}

	//식당 정보 삭제
		public int deleteRestaurantInfo(String resName) {		
			System.out.println("restaurantInfoDAO - deleteRestaurantInfo()");
			int deleteCount = 0;
			PreparedStatement pstmt = null;
			try {
				String sql = "DELETE FROM restaurant_info WHERE res_name=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, resName);
				deleteCount = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("deleteRestaurantInfo() - SQL 구문 오류!");
			}finally {
				close(pstmt);
			}
			
			return deleteCount;
		}
	//식당 정보 삭제 전 사진의 이름을 가져오는 메서드
		public String selectPhoto(String resName) {
			System.out.println("restaurantDAO - selectPhoto()");
			String photo="";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "SELECT photo FROM restaurant_info WHERE res_name=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, resName);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					photo = rs.getString("photo");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("selectPhoto() - SQL 구문 오류!");
			}finally {
				close(rs);
				close(pstmt);
			}
			
			return photo;
		}
	//식당 위치의 지도 정보 1개 들고 오기

		//식당이 삭제 될 시 위치 정보도 같이 삭제
		public void deleteMapInfo(String resName) {
			System.out.println("restaurantDAO - deleteMapInfo()");
			PreparedStatement pstmt = null;
			try {
				String sql = "DELETE FROM map WHERE res_name =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, resName);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("deleteMapInfo() - SQL 구문 오류!");
			}finally {
				close(pstmt);
			}

		}

		public ArrayList<RestaurantInfoDTO> selectMapList(String keyword) {
			System.out.println("RestaurantDAO - selectMapList");
			ArrayList<RestaurantInfoDTO> list =null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM restaurant_info WHERE res_name LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				
				rs = pstmt.executeQuery();
				
				list = new ArrayList<RestaurantInfoDTO>();
				
				while(rs.next()) {
					RestaurantInfoDTO dto = new RestaurantInfoDTO();
					dto.setResName(rs.getString("res_name"));
					dto.setrPostcode(rs.getString("r_postcode"));
					dto.setAddress(rs.getString("address"));
					dto.setRating(rs.getFloat("rating"));
					dto.setPhoneNumber(rs.getString("phone_number"));
					dto.setOpentime(rs.getString("opentime"));
					dto.setResLink(rs.getString("res_link"));
					dto.setPhoto(rs.getString("photo"));
					dto.setResInfo(rs.getString("res_info"));
					dto.setReviewCount(rs.getInt("reviewCount"));
					dto.setLatitude(rs.getDouble("latitude"));
					dto.setLongitude(rs.getDouble("longitude"));
					list.add(dto);
				}
				System.out.println("selectMapList - list : " + list);
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("selectMapList() - SQL 구문 오류!");
			}finally {
				close(pstmt);
				close(rs);
			}
			
			return list;
		}

		//전체 목록을 페이징 처리하여 조회
		public ArrayList<RestaurantInfoDTO> selectMainRestaurantList(String search) {
			ArrayList<RestaurantInfoDTO> list = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM restaurant_info WHERE res_name=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, search);
				rs = pstmt.executeQuery();
				

				list = new ArrayList<RestaurantInfoDTO>();

				while(rs.next()) {
					RestaurantInfoDTO dto = new RestaurantInfoDTO();
					dto.setResName(rs.getString("res_name"));
					dto.setrPostcode(rs.getString("r_postcode"));
					dto.setAddress(rs.getString("address"));
					dto.setPhoneNumber(rs.getString("phone_number"));
					dto.setOpentime(rs.getString("opentime"));
					dto.setResLink(rs.getString("res_link"));
					dto.setPhoto(rs.getString("photo"));
					dto.setReviewCount(rs.getInt("reviewCount"));
					dto.setRating(rs.getFloat("rating"));
					
					System.out.println(dto);

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

		

}