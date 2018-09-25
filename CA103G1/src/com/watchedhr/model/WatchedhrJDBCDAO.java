package com.watchedhr.model;

import java.util.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;

public class WatchedhrJDBCDAO implements WatchedhrDAO_interface {
	
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA103G1";
	private static final String PASSWORD = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO WATCHEDHR(COUR_UNIT_ID, CRORDER_ID, WATCHED_HR) VALUES(?, ?, ?)";
	private static final String UPDATE_STMT = "UPDATE WATCHEDHR SET WATCHED_HR = ? WHERE COUR_UNIT_ID = ? AND CRORDER_ID = ?";

	@Override
	public void insert(WatchedhrVO watchedhrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, watchedhrVO.getCour_unit_id());
			pstmt.setString(2, watchedhrVO.getCrorder_id());
			pstmt.setDouble(3, watchedhrVO.getWatched_hr());
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
	public void update(WatchedhrVO watchedhrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setDouble(1, watchedhrVO.getWatched_hr());
			pstmt.setString(2, watchedhrVO.getCour_unit_id());
			pstmt.setString(3, watchedhrVO.getCrorder_id());
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

}
