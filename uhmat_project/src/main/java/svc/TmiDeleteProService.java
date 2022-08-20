package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.CommunityDAO;

import static db.JdbcUtil.*;

public class TmiDeleteProService {

	public boolean isTmiWriter(int idx, String nickname) {
		System.out.println("TmiDeleteProService - isTmiWriter");
		boolean isTmiWriter = false;
		
		// 1. Connection 객체 가져오기 - 공통
		Connection con = getConnection();
				
		// 2. CommunityDAO 객체 가져오기 - 공통
		CommunityDAO dao = CommunityDAO.getInstance();
		
		// 3. BoardDAO 객체에 Connetion 객체 전달하기 - 공통
		dao.setConnection(con);
		
		// CommunityTmiDTO 객체의 isTmiWriter() 메서드를 호출하여 수정 권한 판별 수행
		isTmiWriter = dao.isTmiWriter(idx, nickname);
		
		close(con);
		
		return isTmiWriter;
	}

	public boolean removeTmiBoard(int idx) {
		System.out.println("TmiDeleteProService - removeTmiBoard");
		boolean isTmiDeleteSuccess = false;
		
		// 1. Connection 객체 가져오기 - 공통
		Connection con = getConnection();
				
		// 2. CommunityDAO 객체 가져오기 - 공통
		CommunityDAO dao = CommunityDAO.getInstance();
		
		// 3. BoardDAO 객체에 Connetion 객체 전달하기 - 공통
		dao.setConnection(con);
		
		// CommunityTmiDTO deleteTmiBoard() 메서드를 호출하여 삭제 작업 수행
		// => 파라미터 : 글번호		리턴타입 : int(deleteTmiCount)
		int deleteTmiCount = dao.deleteTmiBoard(idx);
		
		// deleteCount가 0 보다 크면 commit, 아니면 rollback 작업 수행
		if(deleteTmiCount > 0) {
			commit(con);
			isTmiDeleteSuccess = true;
		} else {
			rollback(con);
		}
		
		return isTmiDeleteSuccess;
	}

}
