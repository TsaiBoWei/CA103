package com.coach.model;
import java.util.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;

public class CoachJDBCDAO implements CoachDAO_interface {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA103G1";
	private static final String PASSWORD = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO COACH(COA_ID, MEM_ID, COA_TEXT, COA_STATUS, COA_RECOUNT)"
			+ "VALUES('C'||LPAD(to_char(COUR_ID_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?)";
	private static final String UPDATE_STMT = "UPDATE COACH SET MEM_ID = ?, COA_TEXT = ?, COA_STATUS = ?, "
			+ "COA_RECOUNT = ? WHERE COA_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM COACH WHERE COA_ID= ?";
	private static final String GET_ALL = "SELECT * FROM COACH";
	private static final String HIDE_STMT = "UPDATE COACH SET COA_STATUS = ? WHERE COA_ID = ?";
	private static final String SELECT_STMT = "SELECT * FROM COACH WHERE COA_ID= ? "
			+ "AND COA_STATUS='CS02' AND (regexp_like (±Ð½m¦W¦r , ? )) ORDER BY COA_ID";

	@Override
	public void insert(CoachVO coachVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, coachVO.getMem_id());
			pstmt.setString(2, coachVO.getCoa_text());
			pstmt.setString(3, coachVO.getCoa_status());
			pstmt.setInt(4, coachVO.getCoa_recount());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
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
	public void update(CoachVO coachVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, coachVO.getMem_id());
			pstmt.setString(2, coachVO.getCoa_text());
			pstmt.setString(3, coachVO.getCoa_status());
			pstmt.setInt(4, coachVO.getCoa_recount());
			pstmt.setString(5, coachVO.getCoa_id());	
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
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
	public CoachVO findByPK(String coa_id) {
		CoachVO coachVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, coa_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				coachVO = new CoachVO();
				coachVO.setCoa_id(rs.getString("COA_ID"));
				coachVO.setMem_id(rs.getString("MEM_ID"));
				coachVO.setCoa_text(rs.getString("COA_TEXT"));
				coachVO.setCoa_status(rs.getString("COA_STATUS"));
				coachVO.setCoa_recount(rs.getInt("COA_RECOUNT"));
			}

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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

		return coachVO;
	}

	@Override
	public List<CoachVO> getAll() {
		List<CoachVO> list = new ArrayList<>();
		CoachVO coachVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				coachVO = new CoachVO();
				coachVO.setCoa_id(rs.getString("COA_ID"));
				coachVO.setMem_id(rs.getString("MEM_ID"));
				coachVO.setCoa_text(rs.getString("COA_TEXT"));
				coachVO.setCoa_status(rs.getString("COA_STATUS"));
				coachVO.setCoa_recount(rs.getInt("COA_RECOUNT"));
				list.add(coachVO);
			}

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
//		} catch (IOException ie) {
//			throw new RuntimeException("A IOException. " + ie.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
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
		return list;
	}

//	@Override
//	public void hide(String cour_id) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(DELETE_STMT);
//
//			pstmt.setString(1, cour_id);
//			
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//	}
//
//	@Override
//	public void select(String cour_id) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(DELETE_STMT);
//
//			pstmt.setString(1, cour_id);
//			
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//	}

}
