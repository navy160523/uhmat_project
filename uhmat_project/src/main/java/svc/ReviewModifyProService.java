package svc;

import vo.ReviewBoardDTO;
import static db.JdbcUtil.*;

import java.io.File;
import java.sql.Connection;

import dao.ReviewCategoryDAO;

public class ReviewModifyProService {

	public boolean modifyReview(ReviewBoardDTO dto, String originPath) {
		
		System.out.println("ReviewModifyProService - modifyReview()");
		boolean isModifySuccess = false;
		
		// 1. Connection pool
		Connection con = getConnection();
		
		// 2. DAO 객체 가져오기
		ReviewCategoryDAO dao = ReviewCategoryDAO.getInstance();
		
		// 3. DAO 객체에 Connection 전달
		dao.setConnection(con);
		
		/*
		 * 4. 파일 삭제 . dto.getPhoto를 통해서 Update전 Origin 이름을 변수에 저장 
		 * 5. update 진행
		 * 6. updataeCount가 0 보다 클 경우 
		 * 	-> 기존에 저장한 이름을 경로에서 삭제, 
		 *  -> 커밋
		 *  -> isModifySuccess= true;
		 */
		File f = new File(originPath);		
		System.out.println(f.getAbsolutePath());
		
//		int updateCount = dao.updateReview(dto);
		
		

//		if(updateCount > 0) {

			
//		} else {
//			rollback(con);
//		}		
//		close(con);
		return isModifySuccess;
	}


}
