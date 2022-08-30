package dao;


import static db.JdbcUtil.*;


import java.sql.*;

import vo.*;
import static db.JdbcUtil.*;

import static db.JdbcUtil.close;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import com.mysql.cj.protocol.Resultset;

import db.*;

/*

 * 
 * 1. 메이트
 * 2. tmi
 * 3. 레시피
 * 4. 메이트 댓글
 * 5. tmi 댓글
 * 6. 레시피 댓글
 */
public class CommunityDAO {
	// 1. 멤버변수 선언 및 인스턴스 생성
	private static CommunityDAO instance = new CommunityDAO();

	// 2. 생성자 정의
	private CommunityDAO() {
	}

	public static CommunityDAO getInstance() {
		return instance;
	}

	// --------------------------------------------------------------------
	// 외부(Service Clas)로 부터 Connection 객체를 전달받아 관리하기 위해
	// Conneciton 타입 멤버변수와 Setter 메서드를 정의합니다.
	private Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}

	// ----------------------------------------------------------------------------------

	// 메이트 댓글
	public int insertReplyMate(CommentDTO mateComment) {

		int insertCount = 0;

		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;

		int num = 1;

		// 새 글 번호로 사용될 번호를 생성하기 위해 기존 게시물의 가장 큰 번호 조회
		// => 조회 결과가 있을 경우 해당 번호 + 1 값을 새 글 번호로 저장
		try {
			String sql = "SELECT MAX(idx) FROM community_mate";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1); // 조회된 가장 큰 번호 + 1 값을 새 글 번호로 저장
			}

			// 기존 답글들에 대한 순서번호(re_seq) 증가 작업 처리
			// => 원본글의 참조글번호(re_ref) 와 같고(같은 레코드들 중에서)
			// 원본글의 순서번호(re_seq)보다 큰 레코드들의 순서번호를 1씩 증가시키기
			sql = "UPDATE mate_reply SET re_seq=re_seq+1 WHERE re_ref=? AND re_seq>?";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, mateComment.getRe_ref());
			pstmt2.setInt(2, mateComment.getRe_seq());
			pstmt2.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return insertCount;
	}

	// -----------------------------------------------------------------------------------------

	// 글 갯수 조회
	// 전체 게시물 수를 조회할 mateCount() 메서드 정의
	// => 파라미터 : 없음 리턴타입 : int(listCount)
	public int selectMateCount() {

		int listCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 3단계
			String sql = "SELECT COUNT(*) FROM community_mate";
			pstmt = con.prepareStatement(sql);

			// 4단계
			rs = pstmt.executeQuery();

			if (rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}

		return listCount;
	}

	public ArrayList<MateDTO> selectMateList(int pageNum, int listLimit) {

		ArrayList<MateDTO> mateList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 현재 페이지 번호를 활용하여 조회 시 시작행 번호 계산
		int startRow = (pageNum - 1) * listLimit;

		try {
			// 답글에 대한 처리 과정 추가
			String sql = "SELECT * FROM community_mate ORDER BY idx desc LIMIT ?,?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);

			rs = pstmt.executeQuery();

			// 전체 게시물을 저장할 ArrayList<MateDTO> 객체 생성
			mateList = new ArrayList<MateDTO>();

			// while 문을 사용하여 조회 결과에 대한 반복 작업 수행
			while (rs.next()) {
				// 1개 게시물 정보를 저장할 MateDTO 객체 생성
				MateDTO mate = new MateDTO();
				// 게시물 정보 저장
				mate.setIdx(rs.getInt("idx"));
				mate.setNickname(rs.getString("nickname"));
				mate.setSubject(rs.getString("subject"));
				mate.setContent(rs.getString("content"));
				mate.setReadcount(rs.getInt("readcount"));
				mate.setDatetime(rs.getTimestamp("datetime"));
				System.out.println(mate);

				// 전체 게시물 정보를 저장하는 ArrayList 객체에 1개 게시물 정보 MateDTO 객체 추가
				mateList.add(mate);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectMateList()");
		} finally {
			close(rs);
			close(pstmt);
		}

		return mateList;
	}

	// -----------------------------------------------------------------------------------------
	// 글쓰기 작업 수행
	public int mateInsertCount(MateDTO mate) {

		int insertCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = 1; // 새 글 번호를 저장할 변수

		try {
			// 새 글 번호로 사용될 번호를 생성하기 위해 기존 게시물의 가장 큰 번호 조회
			// => 조회 결과가 있을 경우 해당 번호 + 1 값을 새 글 번호로 저장
			String sql = "SELECT MAX(idx) FROM community_mate";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1) + 1; // 조회된 가장 큰 번호 + 1 값을 새 글 번호로 저장

			}

			// 사용 완료된 PreparedStatement 객체를 먼저 반환
			close(pstmt);

			// 전달받은 데이터를 board 테이블에 INSERT
			sql = "INSERT INTO community_mate VALUES(?,?,?,?,0,CURRENT_TIMESTAMP)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, mate.getNickname());
			pstmt.setString(3, mate.getSubject());
			pstmt.setString(4, mate.getContent());

			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - mateInsertCount() - " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;
	}

	// -------------------------------------------------------------------------------
	// 조회수 증가 작업을 처리하는 increaseReadcount() 메서드
	public void increaseReadcount(int idx) {

		PreparedStatement pstmt = null;

		try {
			String sql = "UPDATE community_mate SET readcount=readcount+1 WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - increaseReadcount() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

	}

	// 1개 게시물의 상세 정보 조회 작업 수행하는 getMate() 메서드
	public MateDTO getMate(int idx) {


		MateDTO mate = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM community_mate WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mate = new MateDTO();
				mate.setIdx(rs.getInt("idx"));
				mate.setNickname(rs.getString("nickname"));
				mate.setSubject(rs.getString("subject"));
				mate.setContent(rs.getString("content"));
				mate.setReadcount(rs.getInt("readcount"));
				mate.setDatetime(rs.getTimestamp("datetime"));
				System.out.println(mate);

			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - getMate() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return mate;
	}

	// ---------------------------------------------------------------------
	// 글 수정
	public int updateMate(MateDTO mate) {

		int updateCount = 0;

		PreparedStatement pstmt = null;

		try {
			String sql = "UPDATE community_mate SET subject=?, content=? WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mate.getSubject());
			pstmt.setString(2, mate.getContent());
			pstmt.setInt(3, mate.getIdx());

			updateCount = pstmt.executeUpdate();
			System.out.println(updateCount);

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateMate() : " + e.getMessage());
		} finally {
			close(pstmt);
		}

		return updateCount;
	}

	// --------------------------------------------------
	public int deleteMate(int idx) {

		int deleteCount = 0;

		PreparedStatement pstmt = null;

		try {
			String sql = "DELETE FROM community_mate WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);

			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteMate() : " + e.getMessage());
		} finally {
			close(pstmt);
		}

		return deleteCount;
	}
	
	// 게시글 삭제하면 댓글도 삭제하는 로직
	public int deleteMateReply(int idx) {
		
		int deleteMateReply = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM mate_reply WHERE board_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			deleteMateReply = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("sql구문 오류 - deleteMateReply" + e.getMessage());
		}
		
		return deleteMateReply;
	}
	

	// Mate 댓글 작성
	public int insertReplyMate(MateReplyDTO mateReply) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		
		int num = 1;
		
		try {
			// 새 글 번호로 사용될 번호를 생성하기 위해 기존 게시물의 가장 큰 번호 조회
			// => 조회 결과가 있을 경우 해당 번호 + 1 값을 새 글 번호로 저장
			String sql = "SELECT MAX(idx) FROM mate_reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1; // 조회된 가장 큰 번호 + 1 값을 새 글 번호로 저장
			}
			
			// 기존 답글들에 대한 순서번호(re_seq) 증가 작업 처리
			// => 원본글의 참조글번호(re_ref) 와 같고(같은 레코드들 중에서)
			//    원본글의 순서번호(re_seq)보다 큰 레코드들의 순서번호를 1씩 증가시키기
//			sql = "UPDATE mate_reply SET re_seq=re_seq+1 WHERE re_ref=? AND re_seq>?";
//			pstmt2 = con.prepareStatement(sql);
//			pstmt2.setInt(1, mateReply.getRe_ref());
//			pstmt2.setInt(2, mateReply.getRe_seq());
//			pstmt2.executeUpdate();
			
			// 답글을 mate_reply 테이블에 INSERT 작업
			sql = "INSERT INTO mate_reply VALUES(?,?,?,?,?,?,now(),?)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, mateReply.getNickname());
			pstmt2.setString(3, mateReply.getContent());
			pstmt2.setInt(4, num);
			pstmt2.setInt(5, 0);
			pstmt2.setInt(6, 0);
			pstmt2.setInt(7, mateReply.getBoard_idx());
//			System.out.println(mateReply);
			
			insertCount = pstmt2.executeUpdate();
			
			// 22-08-09 미완성임
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertReplyMate() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt2);
			close(pstmt);
			close(rs);
		}
		
		
		
		return insertCount;
	}
	
	public ArrayList<MateReplyDTO> selectMateReply(int idx) {
        System.out.println("CommunityDAO - selectMateReply");
        System.out.println("MateReplyDAO - idx : " + idx);
        ArrayList<MateReplyDTO> mateReplyList = null;
        
        PreparedStatement pstmt  = null;
        ResultSet rs = null;
        
        try {
//           String sql = "SELECT * FROM mate_reply WHERE board_idx=?";
       	 String sql = "SELECT * FROM mate_reply WHERE board_idx=? ORDER BY re_ref DESC, re_seq ASC";
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, idx);
           
           rs = pstmt.executeQuery();
           
           mateReplyList = new ArrayList<MateReplyDTO>();
           
           while(rs.next()) {
              
              MateReplyDTO mateReply = new MateReplyDTO();
              mateReply.setBoard_idx(rs.getInt("board_idx"));
              mateReply.setContent(rs.getString("content"));
              mateReply.setDate(rs.getTimestamp("date"));
              mateReply.setIdx(rs.getInt("idx"));
              mateReply.setNickname(rs.getString("nickname"));
              mateReply.setRe_lev(rs.getInt("re_lev"));
              mateReply.setRe_ref(rs.getInt("re_ref"));
              mateReply.setRe_seq(rs.getInt("re_seq"));
//              mateReply.setBoard_idx(rs.getInt("board_idx"));
//              mateReply.setContent(rs.getString("content"));
//              mateReply.setIdx(rs.getInt(idx));
//              mateReply.setRe_lev(rs.getInt("re_lev"));
//              mateReply.setRe_ref(rs.getInt("re_ref"));
//              mateReply.setRe_seq(rs.getInt("re_seq"));
//              mateReply.setDate(rs.getTimestamp("date"));
//              mateReply.setNickname(rs.getString("nickname"));
//              
              mateReplyList.add(mateReply);
           }
           System.out.println("mateReplyList :" +mateReplyList );
           
        } catch (SQLException e) {
           System.out.println("SQL 구문 오류 - selectMateReply() : " + e.getMessage());
           e.printStackTrace();
        } finally {
           close(rs);
           close(pstmt);
        }
        return mateReplyList;
     }
	// ------------------------------------------------------------------------------
	// 댓글 삭제
	public int deleteReplyMate(int reply_idx, String nickname) {

		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM mate_reply WHERE idx=? AND nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reply_idx);
			pstmt.setString(2, nickname);
			
			deleteCount = pstmt.executeUpdate();
			
			System.out.println("deleteReplyMate - " + deleteCount);
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - deleteReplyMate() : " + e.getMessage());
			e.printStackTrace();
		}
		
		return deleteCount;
	}
	// ----------------------------------------------------------
	// 대댓글
	
	public int insertMateRereply(MateReplyDTO mateReply) {
		System.out.println("CommunityDAO - insertMateRereply");
		
		int mateRereplyInsertCount = 0;
		
		PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null;
		ResultSet rs = null;
		
		int num = 1;
		
		try {
			// 새 글 번호로 사용될 번호를 생성하기 위해 기존 게시물의 가장 큰 번호 조회
			// => 조회 결과가 있을 경우 해당 번호 + 1 값을 새 글 번호로 저장
			String sql = "SELECT MAX(idx) FROM mate_reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1; // 조회된 가장 큰 번호 + 1 값을 새 글 번호로 저장
			}
			
//			 기존 답글들에 대한 순서번호(re_seq) 증가 작업 처리
//			 => 원본글의 참조글번호(re_ref) 와 같고(같은 레코드들 중에서)
//			    원본글의 순서번호(re_seq)보다 큰 레코드들의 순서번호를 1씩 증가시키기
			sql = "UPDATE mate_reply SET re_seq=re_seq+1 WHERE re_seq>?";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, mateReply.getRe_seq());
			mateRereplyInsertCount = pstmt2.executeUpdate();
			
			// 답글을 mate_reply 테이블에 INSERT 작업
			sql = "INSERT INTO mate_reply VALUES(?,?,?,?,?,?,now(),?)";
			pstmt3 = con.prepareStatement(sql);
			pstmt3.setInt(1, num);
			pstmt3.setString(2, mateReply.getNickname());
			pstmt3.setString(3, mateReply.getContent());
			pstmt3.setInt(4, mateReply.getIdx());
			pstmt3.setInt(5, mateReply.getRe_ref() + 1);
			pstmt3.setInt(6, mateReply.getRe_seq() + 1);
			pstmt3.setInt(7, mateReply.getBoard_idx());
//			System.out.println(mateReply);
			mateRereplyInsertCount = pstmt3.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertReplyMate() : " + e.getMessage());
			e.printStackTrace();
		} finally {
			close(pstmt3);
			close(pstmt2);
			close(pstmt);
			close(rs);
		}
		
		return mateRereplyInsertCount;
		
	}
	
	// ==============================================================================
	


	// tmi게시판 전체 게시물 수를 조회할 selcetTmiListCount() 메서드 정의
	// => 파라미터 : 없음, 리턴타입 : int(tmilistCount)
	public int selectTmiListCount() {
		System.out.println("CommunityDAO - selectTmiListCount() 호출!");
		int tmiListCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT COUNT(*) FROM community_tmi";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				tmiListCount = rs.getInt(1);

			}
		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectTmiListCount() " + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}

		return tmiListCount;
	}

	// tmi게시판 목록을 조회하는 selectTmiBoardList() 메서드 정의
	// => 파라미터 : 현재페이지번호(pageNum), 페이지 당 게시물 수 (listLimit)
	// 리턴타입 : ArrayList<CommunityDTO> tmiBoardList
	public ArrayList<CommunityTmiDTO> selectTmiBoardList(int pageNum, int listLimit) {
		System.out.println("CommunityDAO - selectTmiBoardList() 호출!");
		ArrayList<CommunityTmiDTO> tmiBoardList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 현재 페이지 번호를 활용하여 조회 시 시작행 번호를 계산
		int startRow = (pageNum - 1) * listLimit;

		try {
			String sql = "SELECT * FROM community_tmi ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);

			rs = pstmt.executeQuery();

			tmiBoardList = new ArrayList<CommunityTmiDTO>();

			// while문을 사용하여 조회 결과에 대한 반복 작업을 수행.
			while (rs.next()) {
				// tmi게시판 1개 게시물 정보를 저장할 CommunityTmiDTO 의 객체를 생성.
				CommunityTmiDTO tmiBoard = new CommunityTmiDTO();
				tmiBoard.setIdx(rs.getInt("idx"));
				tmiBoard.setNickname(rs.getString("nickname"));
				tmiBoard.setSubject(rs.getString("subject"));
				tmiBoard.setContent(rs.getString("content"));
				tmiBoard.setDatetime(rs.getTimestamp("datetime"));
				tmiBoard.setReadcount(rs.getInt("readcount"));

				tmiBoardList.add(tmiBoard);
			}

		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL구문 오류 발생! - selectTmiBoardList" + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}

		return tmiBoardList;
	}

	// CommunityDAO 객체(인스턴스)의 insertTmiBoard() 메서드를 호출하여 글쓰기 작업을 수행 한 후 결과를 리턴받습니다.
	// => 파라미터 : CommunityDAO 객체(board) 리턴타입 : int(insertCount)
	public int insertTmiBoard(CommunityTmiDTO tmiBoard) {
		System.out.println("CommunityDAO - insertTmiBoard() 호출!");

		int tmiInsertCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = 1;

		try {
			String sql = "SELECT MAX(idx) FROM community_tmi";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}

			close(pstmt);

			sql = "INSERT INTO community_tmi VALUES(?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, tmiBoard.getNickname());
			pstmt.setString(3, tmiBoard.getSubject());
			pstmt.setString(4, tmiBoard.getContent());
			pstmt.setInt(5, tmiBoard.getReadcount());
			pstmt.setTimestamp(6, tmiBoard.getDatetime());

			tmiInsertCount = pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL 구문 작성 오류! - insertTmiBoard() " + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}

		return tmiInsertCount;
	}

	// tmi 글 상세정보를 조회하여 요청하는 selectTmiBoard() 메서드 정의
	// => 파라미터 : 글번호(tmiIdx) 리턴타입 : CommunityDTO(idx)
	public CommunityTmiDTO selectTmiBoard(int idx) {
		System.out.println("CommunityDAO - selectTmiBoard() 호출!");
		CommunityTmiDTO tmiBoard = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM community_tmi WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				tmiBoard = new CommunityTmiDTO();
				tmiBoard.setIdx(rs.getInt("idx"));
				tmiBoard.setNickname(rs.getString("nickname"));
				tmiBoard.setSubject(rs.getString("subject"));
				tmiBoard.setContent(rs.getString("content"));
				tmiBoard.setDatetime(rs.getTimestamp("datetime"));
				tmiBoard.setReadcount(rs.getInt("readcount"));
				System.out.println(tmiBoard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectTmiBoard()" + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}

		return tmiBoard;
	}

	// tmi 글의 조회수 증가 작업을 처리하는 updateTmiReadCount() 메서드 정의
	// => 파라미터 : idx(CommunityTmiDTO)
	public void updateTmiReadCount(int idx) {
		System.out.println("CommunityDAO - updateTmiReadCount() 호출!");
		PreparedStatement pstmt = null;

		try {
			String sql = "UPDATE community_tmi SET readcount=readcount+1 WHERE idx=?";
			// 조회수 증가 작업 update 구문 재 확인 필수!
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - updateReadcount()" + e.getMessage());

		} finally {
			close(pstmt);
		}
	}

	// 글 수정, 삭제 권한 판별을 수행하는 isTmiWriter() 메서드 정의
	public boolean isTmiWriter(int idx, String nickname) {

		System.out.println("CommunityDAO - isTmiWriter() 호출!");

		boolean isTmiWriter = false;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM community_tmi WHERE idx=? AND nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, nickname);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 조회 결과 있을 시 번호에 해당하는 닉네임이 일치
				isTmiWriter = true;
			}

		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - isTmiWriter()" + e.getMessage());

		} finally {
			close(pstmt);
			close(rs);
		}

		return isTmiWriter;
	}

	// 글 수정 작업을 수행하는 updateTmiBoard() 메서드 정의
	public int updateTmiBoard(CommunityTmiDTO tmiBoard) {

		System.out.println("CommunityDAO - updateTmiBoard() 호출!");

		int updateTmiCount = 0;

		PreparedStatement pstmt = null;

		try {
			String sql = "UPDATE community_tmi SET nickname=?,subject=?,content=? WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tmiBoard.getNickname());
			pstmt.setString(2, tmiBoard.getSubject());
			pstmt.setString(3, tmiBoard.getContent());
			pstmt.setInt(4, tmiBoard.getIdx());

			updateTmiCount = pstmt.executeUpdate();
			System.out.println(updateTmiCount);

		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - updateTmiBoard()" + e.getMessage());

		} finally {
			close(pstmt);
		}

		return updateTmiCount;
	}


	// 게시글 삭제 메서드 정의
	public int deleteTmiBoard(int idx) {
		System.out.println("CommunityDAO - deleteTmiBoard() 호출!");
		int deleteTmiCount = 0;

		PreparedStatement pstmt = null;

		try {
			String sql = "DELETE FROM tmi_reply WHERE board_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);

			deleteTmiCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteTmiBoard() : " + e.getMessage());
		}

		return deleteTmiCount;
	}
	// -----------------------------------------------------------------------------------------
	// TMI 댓글 메서드 시작

	// TMI 댓글 작성 메서드
	public int insertTmiReply(TmiReplyDTO tmiReply) {
		System.out.println("CommunityDAO - insertTmiReply() 호출!");
		System.out.println(tmiReply.getContent());
		int tmiReplyInsertCount = 0;
		
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		
		int idx = 1;
		
		try {
			String sql = "SELECT MAX(idx) FROM tmi_reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			
			sql = "INSERT INTO tmi_reply VALUES(?,?,?,?,?,?,?,now())";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, idx);
			pstmt2.setInt(2, tmiReply.getBoard_idx());
			pstmt2.setString(3, tmiReply.getNickname());
			pstmt2.setString(4, tmiReply.getContent());
			pstmt2.setInt(5, tmiReply.getIdx());
			pstmt2.setInt(6, 0);
			pstmt2.setInt(7, 0);
			
			System.out.println("댓글작성 - " + pstmt2);
			
			tmiReplyInsertCount = pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertTmiReply() " + e.getMessage());
		} finally {
			close(pstmt2);
			close(pstmt);
			close(rs);
		}
		
		return tmiReplyInsertCount;
	}

	// 댓글 리스트 조회 작업
	public ArrayList<TmiReplyDTO> selectTmiReplyList(int idx) {
		System.out.println("CommunityDAO - selectTmiReplyList() 호출!");
		
		TmiReplyDTO tmiReply = null;
		ArrayList<TmiReplyDTO> tmiReplyList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM tmi_reply WHERE board_idx=? ORDER BY re_ref DESC, re_seq ASC;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			rs = pstmt.executeQuery();
			
			tmiReplyList = new ArrayList<TmiReplyDTO>();
			while(rs.next()) {
				tmiReply = new TmiReplyDTO();
				tmiReply.setIdx(rs.getInt("idx"));
				tmiReply.setBoard_idx(rs.getInt("board_idx"));
				tmiReply.setNickname(rs.getString("nickname"));
				tmiReply.setContent(rs.getString("content"));
				tmiReply.setRe_ref(rs.getInt("re_ref"));
				tmiReply.setRe_seq(rs.getInt("re_seq"));
				tmiReply.setRe_lev(rs.getInt("re_lev"));
				tmiReply.setDate(rs.getTimestamp("date"));
				
				tmiReplyList.add(tmiReply);
			}
				System.out.println(tmiReply);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 selectTmiReplyList() " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return tmiReplyList;
	}
	
	// 댓글 1개의 상세 정보 조회 작업을 수행하는 selectTmiReply() 메서드
	public TmiReplyDTO selectTmiReply(int idx) {
		TmiReplyDTO tmiReply = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM tmi_reply WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				tmiReply = new TmiReplyDTO();
				tmiReply.setIdx(rs.getInt("idx"));
				tmiReply.setBoard_idx(rs.getInt("board_idx"));
				tmiReply.setNickname(rs.getString("nickname"));
				tmiReply.setContent(rs.getString("content"));
				tmiReply.setRe_ref(rs.getInt("re_ref"));
				tmiReply.setRe_lev(rs.getInt("re_lev"));
				tmiReply.setRe_seq(rs.getInt("re_seq"));
				tmiReply.setDate(rs.getTimestamp("date"));
				
				System.out.println("selectTmiReply - "+ tmiReply);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectTmiReply() " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return tmiReply;
	}

	// 댓글 수정 작업
	public boolean isTmiReplyWriter(int idx, String nickname) {
		System.out.println("CommunityDAO - isTmiReplyWriter");
		boolean isTmiReplyWriter = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM tmi_reply WHERE idx=? AND nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, nickname);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				isTmiReplyWriter = true;
			}
			System.out.println(isTmiReplyWriter);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - isTmiReplyWriter " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return isTmiReplyWriter;
	}

	// 댓글 수정 작업 요청 
	public int updateTmiReply(TmiReplyDTO tmiReply) {
		System.out.println("CommunityDAO - updateTmiReply() 호출!");
		
		int tmiReplyUpdateCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE tmi_reply SET nickname=?,content=? WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tmiReply.getNickname());
			pstmt.setString(2, tmiReply.getContent());
			pstmt.setInt(3, tmiReply.getIdx());
			
			tmiReplyUpdateCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 tmiReplyUpdateReply() " + e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return tmiReplyUpdateCount;
	}

	// 답글(대댓글) 입력 작업 메서드
	public int insertTmiRereply(TmiReplyDTO tmiRereply) {
		System.out.println("CommunityDAO - insertTmiRereply() 호출!");
		int tmiRereplyInsertCount = 0;
		
		PreparedStatement pstmt = null, pstmt2 = null, pstmt3 = null;
		ResultSet rs = null;
		
		int idx = 1;
		
		try {
			String sql = "SELECT MAX(idx) FROM tmi_reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			sql = "UPDATE tmi_reply SET re_seq=re_seq+1 WHERE re_seq>?";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, tmiRereply.getRe_seq());
			
			tmiRereplyInsertCount = pstmt2.executeUpdate();
			
			sql = "INSERT INTO tmi_reply VALUES(?,?,?,?,?,?,?,now())";
			pstmt3 = con.prepareStatement(sql);
			pstmt3.setInt(1, idx);
			pstmt3.setInt(2, tmiRereply.getBoard_idx());
			pstmt3.setString(3, tmiRereply.getNickname());
			pstmt3.setString(4, tmiRereply.getContent());
			pstmt3.setInt(5, tmiRereply.getIdx());
			pstmt3.setInt(6, tmiRereply.getRe_lev() + 1);
			pstmt3.setInt(7, tmiRereply.getRe_seq() + 1);
			
			System.out.println("댓글작성 - " + pstmt3);
			
			tmiRereplyInsertCount = pstmt3.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertTmiRereply() " + e.getMessage());
		} finally {
			close(pstmt3);
			close(pstmt2);
			close(pstmt);
			close(rs);
		}
		
		return tmiRereplyInsertCount;
	}
	
	// 댓글 삭제 작업
	public int deleteTmiReply(int idx, String nickname) {
		System.out.println("Tmi 댓글 삭제 - deleteTmiReply()");
		
		int deleteTmiReplyCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "DELETE FROM tmi_reply WHERE idx=? AND nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, nickname);
			
			deleteTmiReplyCount = pstmt.executeUpdate();
			
			System.out.println("deleteTmiReply - " + deleteTmiReplyCount);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteTmiReply() " + e.getMessage());
		}
		
		return deleteTmiReplyCount;
	}

	public ArrayList<CommunityTmiDTO> selectMainTmiBoardList(String search) {
		System.out.println("CommunityDAO - selectTmiBoardList() 호출!");
		ArrayList<CommunityTmiDTO> tmiBoardList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 현재 페이지 번호를 활용하여 조회 시 시작행 번호를 계산

		try {
			String sql = "SELECT * FROM community_tmi WHERE subject=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();

			tmiBoardList = new ArrayList<CommunityTmiDTO>();

			// while문을 사용하여 조회 결과에 대한 반복 작업을 수행.
			while (rs.next()) {
				// tmi게시판 1개 게시물 정보를 저장할 CommunityTmiDTO 의 객체를 생성.
				CommunityTmiDTO tmiBoard = new CommunityTmiDTO();
				tmiBoard.setIdx(rs.getInt("idx"));
				tmiBoard.setNickname(rs.getString("nickname"));
				tmiBoard.setSubject(rs.getString("subject"));
				tmiBoard.setContent(rs.getString("content"));
				tmiBoard.setDatetime(rs.getTimestamp("datetime"));
				tmiBoard.setReadcount(rs.getInt("readcount"));

				tmiBoardList.add(tmiBoard);
			}

		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL구문 오류 발생! - selectTmiBoardList" + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}

		return tmiBoardList;
	}

	public ArrayList<MateDTO> selectMainMateBoardList(String search) {
		System.out.println("selectMateBoardList");
		ArrayList<MateDTO> mateBoardList = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 현재 페이지 번호를 활용하여 조회 시 시작행 번호를 계산

		try {
			String sql = "SELECT * FROM community_mate WHERE subject=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();

			mateBoardList = new ArrayList<MateDTO>();

			// while문을 사용하여 조회 결과에 대한 반복 작업을 수행.
			while (rs.next()) {
				// tmi게시판 1개 게시물 정보를 저장할 CommunityTmiDTO 의 객체를 생성.
				MateDTO mateBoard = new MateDTO();
				mateBoard.setContent(rs.getString("content"));
				mateBoard.setDatetime(rs.getTimestamp("datetime"));
				mateBoard.setIdx(rs.getInt("idx"));
				mateBoard.setNickname(rs.getString("nickname"));
				mateBoard.setReadcount(rs.getInt("readcount"));
				mateBoard.setSubject(rs.getString("subject"));

				mateBoardList.add(mateBoard);
			}

		} catch (SQLException e) {

			e.printStackTrace();
			System.out.println("SQL구문 오류 발생! - selectTmiBoardList" + e.getMessage());

		} finally {
			close(rs);
			close(pstmt);
		}
		return mateBoardList;
	}

	

	// -----------------------------------------------------------------------------------------


}
