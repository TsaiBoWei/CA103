package com.courboar.model;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.Date;

public class CourBoarDAO implements CourBoarDAO_interface {
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
	private static final String INSERT_STMT = "INSERT INTO COURBOAR(CRPOST_ID, CRPOS_TIT,CRPOS_TIME, COUR_ID, MEM_ID,CRPOS_TEXT,CRPOS_STA)"
			+ "VALUES('CP'||LPAD(to_char(courboar_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, 'CP1')";
	private static final String UPDATE_STMT = "UPDATE COURBOAR SET CRPOS_TIT = ?, CRPOS_TEXT = ? WHERE CRPOST_ID = ?";
	private static final String UPDATE_HIDE_STMT = "UPDATE COURBOAR SET CRPOS_STA ='CP2' WHERE CRPOST_ID = ?";
	private static final String FIND_BY_COUR_ID = "SELECT CRPOST_ID, CRPOS_TIT,CRPOS_TIME,COUR_ID,MEM_ID, CRPOS_TEXT,CRPOS_STA FROM COURBOAR WHERE COUR_ID=? AND CRPOS_STA='CP1'ORDER BY CRPOST_ID DESC";
	private static final String FIND_BY_KEYWORD = "SELECT * FROM COURBOAR WHERE COUR_ID= ? AND CRPOS_STA='CP1'AND (regexp_like (CRPOS_TEXT , ? )or regexp_like(CRPOS_TIT , ? )) ORDER BY CRPOST_ID";// orderby未測
	private static final String FIND_BY_PK = "SELECT * FROM COURBOAR WHERE CRPOST_ID= ?";

	private static final String UPDATE_HIDE_BY_CRPOSTID_STMT = "UPDATE BOARDRES SET CRRES_STA ='CPR2' WHERE CRPOST_ID=? ";
	@Override
	public void add(CourBoarVO courboar_vo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, courboar_vo.getCrpos_tit());
			pstmt.setTimestamp(2, courboar_vo.getCrpos_time());
			pstmt.setString(3, courboar_vo.getCour_id());
			pstmt.setString(4, courboar_vo.getMem_id());
			pstmt.setString(5, courboar_vo.getCrpos_text());
//			pstmt.setString(6, courboar_vo.getCrpos_sta());// 預設CP1顯示

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
	public void update(CourBoarVO courboarVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, courboarVO.getCrpos_tit());
			pstmt.setString(2, courboarVO.getCrpos_text());
			pstmt.setString(3, courboarVO.getCrpost_id());
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
	public void hide( String crpost_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			
			con.setAutoCommit(false);
		
			pstmt = con.prepareStatement(UPDATE_HIDE_BY_CRPOSTID_STMT);
			
			pstmt.setString(1, crpost_id);
			pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(UPDATE_HIDE_STMT);

			pstmt.setString(1, crpost_id);
			pstmt.executeUpdate();
			
			con.commit();
			con.setAutoCommit(true);
			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public List<CourBoarVO> findByCour_id(String cour_id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CourBoarVO courboarVO = null;
		List<CourBoarVO> CourBoar_List = new ArrayList<>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_COUR_ID);
			pstmt.setString(1, cour_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				courboarVO = new CourBoarVO();
				courboarVO.setCrpost_id(rs.getString("CRPOST_ID"));
				courboarVO.setCrpos_tit(rs.getString("CRPOS_TIT"));
				courboarVO.setCrpos_time(rs.getTimestamp("CRPOS_TIME"));
				courboarVO.setCour_id(cour_id);
				courboarVO.setMem_id(rs.getString("MEM_ID"));
				courboarVO.setCrpos_text(rs.getString("CRPOS_TEXT"));
				courboarVO.setCrpos_sta(rs.getString("CRPOS_STA"));
				CourBoar_List.add(courboarVO);
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

		return CourBoar_List;

	}

	@Override
	public List<CourBoarVO> findByKeyWord(String keyWord, String cour_id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CourBoarVO courboarVO = null;
		List<CourBoarVO> CourBoar_List = new ArrayList<>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_KEYWORD);
			pstmt.setString(1, cour_id);
			pstmt.setString(2, "[" + keyWord + "]");
			pstmt.setString(3, "[" + keyWord + "]");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				courboarVO = new CourBoarVO();
				courboarVO.setCrpost_id(rs.getString("CRPOST_ID"));
				courboarVO.setCrpos_tit(rs.getString("CRPOS_TIT"));
				courboarVO.setCrpos_time(rs.getTimestamp("CRPOS_TIME"));
				courboarVO.setCour_id(cour_id);
				courboarVO.setMem_id(rs.getString("MEM_ID"));
				courboarVO.setCrpos_text(rs.getString("CRPOS_TEXT"));
				courboarVO.setCrpos_sta(rs.getString("CRPOS_STA"));
				CourBoar_List.add(courboarVO);
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

		return CourBoar_List;

	}

	@Override
	public CourBoarVO findByPK(String crpost_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CourBoarVO courboarVO = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, crpost_id);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				courboarVO = new CourBoarVO();
				courboarVO.setCrpost_id(crpost_id);
				courboarVO.setCrpos_tit(rs.getString("CRPOS_TIT"));
				courboarVO.setCrpos_time(rs.getTimestamp("CRPOS_TIME"));
				courboarVO.setCour_id(rs.getString("COUR_ID"));
				courboarVO.setMem_id(rs.getString("MEM_ID"));
				courboarVO.setCrpos_text(rs.getString("CRPOS_TEXT"));
				courboarVO.setCrpos_sta(rs.getString("CRPOS_STA"));
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

		return courboarVO;

	}

}