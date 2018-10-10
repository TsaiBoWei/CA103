package com.sptype.model;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sptype.model.SptypeDAO_interface;
import com.sptype.model.SptypeVO;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;

public class SptypeDAO implements SptypeDAO_interface {
	
//	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
//	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
//	private static final String USER = "CA103G1";
//	private static final String PASSWORD = "123456";
	
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
			private static DataSource ds = null;
			static {
				try {
					Context ctx = new InitialContext();
					ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
				} catch (NamingException e) {
					e.printStackTrace();
				}
			}

	private static final String INSERT_STMT = 
			"INSERT INTO SPTYPE(SPTYPE_ID, SPORT, SPORT_LOGO) VALUES('SP'||LPAD(to_char(COUR_ID_seq.NEXTVAL), 6, '0'), ?, ?)";
	private static final String UPDATE_STMT = "UPDATE SPTYPE SET SPORT = ?, SPORT_LOGO = ? WHERE SPTYPE_ID = ?";
	private static final String DELETE_STMT = "DELETE FROM  SPTYPE WHERE SPTYPE_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM  SPTYPE WHERE SPTYPE_ID = ?";
	private static final String GET_ALL = "SELECT * FROM  SPTYPE";

	@Override
	public void insert(SptypeVO sptypeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, sptypeVO.getSport());
			//先用照片測
			byte[] pic = getPictureByteArray("item/test01.jpg");
			pstmt.setBytes(2, pic);
			pstmt.executeUpdate();

			// Handle any driver errors
//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (IOException ie) {
			throw new RuntimeException("A IOException. " + ie.getMessage());
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
	public void update(SptypeVO sptypeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, sptypeVO.getSport());
			//先用照片測
			byte[] pic = getPictureByteArray("item/test01.jpg");
			pstmt.setBytes(2, pic);
			pstmt.setString(3, sptypeVO.getSptype_id());
			pstmt.executeUpdate();			

			// Handle any driver errors
//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (IOException ie) {
			throw new RuntimeException("A IOException. " + ie.getMessage());
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
	public void delete(String sptype_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, sptype_id);
			
			pstmt.executeUpdate();

			// Handle any driver errors
//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
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
	public SptypeVO findByPK(String sptype_id) {
		SptypeVO sptypeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, sptype_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				sptypeVO = new SptypeVO();
				sptypeVO.setSptype_id(rs.getString("SPTYPE_ID"));
				sptypeVO.setSport(rs.getString("SPORT"));
//				byte[] pic = rs.getBytes("SPORT_LOGO");
//				readPicture(pic);
			}

//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
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

		return sptypeVO;
	}

	@Override
	public List<SptypeVO> getAll() {
		List<SptypeVO> list = new ArrayList<>();
		SptypeVO sptypeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				sptypeVO = new SptypeVO();
				sptypeVO.setSptype_id(rs.getString("SPTYPE_ID"));
				sptypeVO.setSport(rs.getString("SPORT"));
				// byte[] pic = rs.getBytes("SPORT_LOGO");
				// readPicture(pic);
				list.add(sptypeVO);
			}

//		} catch (ClassNotFoundException ce) {
//			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
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
	
	// 使用byte[]方式
		public static byte[] getPictureByteArray(String path) throws IOException {
			File file = new File(path);
			FileInputStream fis = new FileInputStream(file);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte[] buffer = new byte[8192];
			int i;
			while ((i = fis.read(buffer)) != -1) {
				baos.write(buffer, 0, i);
			}
			baos.close();
			fis.close();

			return baos.toByteArray();
		}
		
	// Handle with byte array data
		public static void readPicture(byte[] bytes) throws IOException {
			FileOutputStream fos = new FileOutputStream("output/test_output.jpg");
			fos.write(bytes);
			fos.flush();
			fos.close();
		}

}
