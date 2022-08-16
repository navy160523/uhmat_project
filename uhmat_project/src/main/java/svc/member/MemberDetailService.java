package svc.member;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.MemberDAO;
import vo.MemberDTO;

public class MemberDetailService {

	public MemberDTO getMember(String email) {
		MemberDTO member = null;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		member = dao.selectMember(email);
		
		close(con);
		
		return member;
	}

}
