package svc.mainsch;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.*;
import java.util.*;

import dao.*;
import db.*;
import vo.*;

public class UhmatSearchService {

	public ArrayList<CommunityTmiDTO> getSearchTmiBoard(String search) {
		ArrayList<CommunityTmiDTO> tmiBoardList = null;
		
		// 1. Connection 객체 가져오기 - 공통
		Connection con = getConnection();
				
		// 2. CommunityDAO 객체 가져오기 - 공통
		CommunityDAO dao = CommunityDAO.getInstance();
		
		// 3. BoardDAO 객체에 Connetion 객체 전달하기 - 공통
		dao.setConnection(con);
		
		// 4. BoardDAO 객체의 selectTmiBoardList() 메서드를 호출하여 게시물 목록 조회
		// => 파라미터 : 현재페이지번호(pageNum), 페이지 당 게시물 수(listLimit)
		// 	  리턴타입 : ArrayList<CommunityDTO> getTmiboardList

		tmiBoardList = dao.selectMainTmiBoardList(search);

		System.out.println(tmiBoardList);
		
		// 5. Connection 객체 반환 - 공통
		close(con);
		
		return tmiBoardList;
	}

	public ArrayList<MateDTO> getSearchMateBoard(String search) {
		ArrayList<MateDTO> mateBoardList =null;
		
		Connection con = JdbcUtil.getConnection();
		
		CommunityDAO dao = CommunityDAO.getInstance();
		
		dao.setConnection(con);
		
		mateBoardList = dao.selectMainMateBoardList(search);
		
		return mateBoardList;
	}

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

	public ArrayList<FAQDTO> getSearchFAQboard(String search) {
		ArrayList<FAQDTO> list = null;
		
		Connection con = JdbcUtil.getConnection();
		
		FAQDAO dao = FAQDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.selectMainAnythingList(search);
		
		JdbcUtil.close(con);
		
		return list;
	}

	public ArrayList<NoticeDTO> getSearchNoticeboard(String search) {
		ArrayList<NoticeDTO> list = null;
		
		Connection con = JdbcUtil.getConnection();
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
		dao.setConnection(con);
		
		list = dao.selectMainAnythingList(search);
		
		JdbcUtil.close(con);
		
		return list;
	}

}
