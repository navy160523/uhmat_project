package svc.main;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;
import java.util.*;

import dao.*;
import db.*;
import vo.*;

public class UhmatSearchService {



	public ArrayList<ReviewBoardDTO> getSearhReviewBoard(String search) {
		ArrayList<ReviewBoardDTO> reviewList = null;
		
		// Connectino 객체 가져오기
		Connection con = getConnection();
		
		// ReviewCategoryDAO 객체 가져오기
		ReviewCategoryDAO dao = ReviewCategoryDAO.getInstance();
		
		// dao에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// 게시물 목록 조회 호출
		reviewList = dao.selectMainReviewBoardList(search); 
		
		// Connection 객체 반환
		close(con);
		
		return reviewList;
		
		
	}

	public ArrayList<RestaurantInfoDTO> getSearchRestaurantInfo(String search) {
		ArrayList<RestaurantInfoDTO> list = null;
		
		Connection con = getConnection();
		
		RestaurantDAO dao = RestaurantDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.selectMainRestaurantList(search);
		
		return list;
	}



}
