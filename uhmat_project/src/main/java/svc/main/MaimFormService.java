package svc.main;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.RestaurantDAO;
import dao.ReviewCategoryDAO;
import vo.RestaurantInfoDTO;
import vo.ReviewBoardDTO;

public class MaimFormService {

	public ArrayList<ReviewBoardDTO> getBestLikeBoardList(int pageNum, int listLimit) {
	System.out.println("getBestLikeBoardList");
		
		// 리턴할 데이터를 저장할 변수 선언
		ArrayList<ReviewBoardDTO> reviewList = null;
		
		// Connectino 객체 가져오기
		Connection con = getConnection();
		
		// ReviewCategoryDAO 객체 가져오기
		ReviewCategoryDAO dao = ReviewCategoryDAO.getInstance();
		
		// dao에 Connection 객체 전달하기
		dao.setConnection(con);
		reviewList = dao.selectReviewBestLikeBoardList(pageNum,listLimit); 
	
		// Connection 객체 반환
		close(con);
		
		return reviewList;
	}

	public ArrayList<RestaurantInfoDTO> getBestResBoardList(int pageNum, int listLimit) {
		System.out.println("getBestResBoardList");
		
		// 리턴할 데이터를 저장할 변수 선언
		ArrayList<RestaurantInfoDTO> bestResList = null;
		
		// Connectino 객체 가져오기
		Connection con = getConnection();
		
		// RestaurantDAO 객체 가져오기
		RestaurantDAO dao = RestaurantDAO.getInstance();
		
		// dao에 Connection 객체 전달하기
		dao.setConnection(con);
		bestResList = dao.selectResBoardList(pageNum,listLimit);
	
		// Connection 객체 반환
		close(con);
		
		return bestResList;
	}
	
}
