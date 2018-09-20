package com.boardres.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardresDAO implements BoardresDAO_interface {
//	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
//	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
//	private static final String USER = "PROJECTTEST";
//	private static final String PASSWORD = "123456";
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// SQL
	private static final String INSERT_STMT = "INSERT INTO BOARDRES(CRRES_ID,CRRES_TIME,CRPOST_ID,MEM_ID,CRRES_TEXT,CRRES_STA)"
			+ "VALUES('CPR'||LPAD(to_char(boardres_seq.NEXTVAL), 6, '0'),?, ?, ?, ?,'CPR1')";
	private static final String UPDATE_REPLYTEXT_STMT = "UPDATE BOARDRES SET CRRES_TEXT = ? WHERE CRRES_ID= ?";
	private static final String UPDATE_HIDE_STMT = "UPDATE BOARDRES SET CRRES_STA = ? WHERE CRRES_ID= ? ";
	private static final String UPDATE_HIDE_BY_CROSTID_STMT = "UPDATE BOARDRES SET CRRES_STA ='CPR2' WHERE CRPOST_ID=? ";
	private static final String FIND_BY_PK = "SELECT * FROM BOARDRES WHERE CRRES_ID= ? "; 
	private static final String FIND_BY_CRPOST_ID = "SELECT * FROM BOARDRES WHERE CRPOST_ID=? AND CRRES_STA='CPR1'ORDER BY CRRES_ID DESC ";// 展示清單用

	//

	@Override
	public void add(BoardresVO boardresVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setTimestamp(1, boardresVO.getCrres_time());
			pstmt.setString(2, boardresVO.getCrpost_id());
			pstmt.setString(3, boardresVO.getMem_id());
			pstmt.setString(4, boardresVO.getCrres_text());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(BoardresVO boardresVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_REPLYTEXT_STMT);

			pstmt.setString(1, boardresVO.getCrres_text());
			pstmt.setString(2, boardresVO.getCrres_id());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void hide(String crres_sta, String crres_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_HIDE_STMT);

			pstmt.setString(1, crres_sta);
			pstmt.setString(2, crres_id);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	@Override
	public void hideByCrostId(String crpost_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_HIDE_BY_CROSTID_STMT);

			pstmt.setString(1, crpost_id);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public List<BoardresVO> findByCrpostId(String crpost_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		BoardresVO boardresVO = null;
		List<BoardresVO> boardres_List = new ArrayList<>();

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_CRPOST_ID);
			pstmt.setString(1, crpost_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardresVO = new BoardresVO();
				boardresVO.setCrres_id(rs.getString("CRRES_ID"));
				boardresVO.setCrres_time(rs.getTimestamp("CRRES_TIME"));
				boardresVO.setMem_id(rs.getString("MEM_ID"));
				boardresVO.setCrpost_id(crpost_id);
				boardresVO.setCrres_text(rs.getString("CRRES_TEXT"));
				boardres_List.add(boardresVO);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return boardres_List;

	}

	@Override
	public BoardresVO findByPK(String crres_id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		BoardresVO boardresVO = null;

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, crres_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				boardresVO = new BoardresVO();
				boardresVO.setCrres_id(crres_id);
				boardresVO.setCrres_time(rs.getTimestamp("CRRES_TIME"));
				boardresVO.setMem_id(rs.getString("MEM_ID"));
				boardresVO.setCrpost_id(rs.getString("CRPOST_ID"));
				boardresVO.setCrres_text(rs.getString("CRRES_TEXT"));
				boardresVO.setCrres_sta(rs.getString("CRRES_STA"));
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return boardresVO;

	}

}
