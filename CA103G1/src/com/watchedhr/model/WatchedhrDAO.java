package com.watchedhr.model;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.purchcour.model.PurchCourVO;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;

public class WatchedhrDAO implements WatchedhrDAO_interface {
	
//	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
//	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
//	private static final String USER = "CA103G1";
//	private static final String PASSWORD = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO WATCHEDHR(COUR_UNIT_ID, CRORDER_ID, WATCHED_HR) VALUES(?, ?, ?)";
	private static final String UPDATE_STMT = "UPDATE WATCHEDHR SET WATCHED_HR = ? WHERE COUR_UNIT_ID = ? AND CRORDER_ID = ?";
	private static final String GET_WATCH_SUM_BY_CRORDER_ID = "SELECT SUM (WATCHED_HR) FROM WATCHEDHR WHERE CRORDER_ID=?" ;
	private static final String GET_COUR_UNIT_BY_CRORDER_ID= "SELECT COUR_UNIT_ID FROM WATCHEDHR WHERE CRORDER_ID=?" ;
	private static final String GET_WATCHEDHR= "SELECT WATCHED_HR FROM WATCHEDHR WHERE CRORDER_ID=? AND COUR_UNIT_ID=? " ;
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	@Override
	public void insert(WatchedhrVO watchedhrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, watchedhrVO.getCour_unit_id());
			pstmt.setString(2, watchedhrVO.getCrorder_id());
			pstmt.setDouble(3, watchedhrVO.getWatched_hr());
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
	public void update(WatchedhrVO watchedhrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setDouble(1, watchedhrVO.getWatched_hr());
			pstmt.setString(2, watchedhrVO.getCour_unit_id());
			pstmt.setString(3, watchedhrVO.getCrorder_id());
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
	public Double getWatchSum(String crorder_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
        Double total_watchhr=0.0;
		

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(FIND_BY_MEM_ID);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_WATCH_SUM_BY_CRORDER_ID);
			pstmt.setString(1, crorder_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				total_watchhr=rs.getDouble(1);
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

		return total_watchhr;

	}

	@Override
	public List<String> getCour_unit_idByCrorder_id(String crorder_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<String> courunitList = new ArrayList<>();
		
		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(GET_COUR_UNIT_BY_CRORDER_ID);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COUR_UNIT_BY_CRORDER_ID);
			pstmt.setString(1, crorder_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String cour_unit_id=rs.getString("COUR_UNIT_ID");
				courunitList.add(cour_unit_id);
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

		return courunitList;

	}

	@Override
	public Double getWatched_hr(String crorder_id, String cour_unit_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Double watched_hr=0.0;
		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			pstmt = con.prepareStatement(GET_COUR_UNIT_BY_CRORDER_ID);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_WATCHEDHR);
			pstmt.setString(1, crorder_id);
			pstmt.setString(2, cour_unit_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				watched_hr=rs.getDouble("WATCHED_HR");
				
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

		return watched_hr;

	}

}
