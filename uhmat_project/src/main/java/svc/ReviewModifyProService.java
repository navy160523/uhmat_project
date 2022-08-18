package svc;

import vo.ReviewBoardDTO;
import static db.JdbcUtil.*;


import java.io.*;
import java.nio.file.*;
import java.sql.Connection;

import javax.servlet.*;
import javax.servlet.http.*;


import dao.ReviewCategoryDAO;

public class ReviewModifyProService {


	public boolean modifyReview(ReviewBoardDTO dto, String originPath, String realPath) {
		
		System.out.println("ReviewModifyProService - modifyReview()");
		System.out.println("절대경로 : " + realPath + " 파일이름 : " + originPath);
		

		boolean isModifySuccess = false;
		
		// 1. Connection pool
		Connection con = getConnection();
		
		// 2. DAO 객체 가져오기
		ReviewCategoryDAO dao = ReviewCategoryDAO.getInstance();
		
		// 3. DAO 객체에 Connection 전달
		dao.setConnection(con);
		
		/*

		 * 4. dao의 updateReview를 통해 update 진행
		 * 5. updateCount에 따라 update
		 * -> 성공 시 파일삭제, 커밋, isModifySuccess = true 로 변환
		 * -> 실패 시 rollback 진행
		 */
		
		
		int updateCount = dao.updateReview(dto);

		if(updateCount > 0) {
			Path path = Paths.get(realPath + "/"+ originPath);
			try {
				Files.deleteIfExists(path);
				System.out.println("Delete is success");
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("Delete is failed");
				e.printStackTrace();
			}
			
			commit(con);
			isModifySuccess = true;
		
		} else {
			rollback(con);
		}		
		close(con);

		return isModifySuccess;
	}


}
