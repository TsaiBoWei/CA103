package com.courunit.model;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;

public class CourunitDAO implements CourunitDAO_interface{
//	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
//	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
//	private static final String USER = "CA103G1";
//	private static final String PASSWORD = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO COURUNIT(COUR_UNIT_ID, COUR_ID, CU_NAME, COUR_FILM_BLOB, COUR_LENGTH, COUR_VTYPE)"
			+ "VALUES('CU'||LPAD(to_char(COUR_ID_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?)";
	private static final String UPDATE_STMT = "UPDATE COURUNIT SET COUR_ID = ?, CU_NAME = ?, COUR_FILM_BLOB = ?, "
			+ "COUR_FILM_VC = ?, COUR_LENGTH = ?, COUR_VTYPE = ? WHERE COUR_UNIT_ID = ?";
	private static final String DELETE_STMT = "DELETE FROM  COURUNIT WHERE COUR_UNIT_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM  COURUNIT WHERE COUR_UNIT_ID = ?";
	private static final String GET_ALL = "SELECT * FROM  COURUNIT";
	
	//ash
	private static final String GET_COURUNIT_BY_COUR_ID= "SELECT COUR_UNIT_ID, COUR_ID, CU_NAME, COUR_LENGTH, COUR_VTYPE FROM COURUNIT WHERE COUR_ID = ? ORDER BY COUR_UNIT_ID ";
	private static final String GET_UNIT_SUM_BY_COUR_ID = "SELECT SUM (COUR_LENGTH) FROM COURUNIT WHERE COUR_ID=?" ;
	
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
	public void insert(CourunitVO courunitVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
    
		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, courunitVO.getCour_id());
			pstmt.setString(2, courunitVO.getCu_name());
			//先用照片測
//			byte[] pic = getPictureByteArray("item/test01.jpg");
			pstmt.setBytes(3, courunitVO.getCour_film_blob());
//			pstmt.setString(4, courunitVO.getCour_film_vc());
			pstmt.setDouble(4, courunitVO.getCour_length());	
			pstmt.setString(5, courunitVO.getCour_vtype());
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
	public void update(CourunitVO courunitVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, courunitVO.getCour_id());
			pstmt.setString(2, courunitVO.getCu_name());
			//先用照片測
//			byte[] pic2 = getPictureByteArray("item/test01.jpg");
			pstmt.setBytes(3, courunitVO.getCour_film_blob());
//			pstmt.setString(4, courunitVO.getCour_film_vc());
			pstmt.setDouble(4, courunitVO.getCour_length());	
			pstmt.setString(5, courunitVO.getCour_vtype());
			pstmt.setString(6, courunitVO.getCour_unit_id());
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
	public void delete(String cour_unit_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, cour_unit_id);
			
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
	public CourunitVO findByPK(String cour_unit_id) {
		CourunitVO courunitVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, cour_unit_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				courunitVO = new CourunitVO();
				courunitVO.setCour_unit_id(rs.getString("COUR_UNIT_ID"));
				courunitVO.setCour_id(rs.getString("COUR_ID"));
				courunitVO.setCu_name(rs.getString("CU_NAME"));
				courunitVO.setCour_film_blob(rs.getBytes("COUR_FILM_BLOB"));
//				readPicture(pic);
//				courunitVO.setCour_film_vc(rs.getString("COUR_FILM_VC"));
				courunitVO.setCour_length(rs.getDouble("COUR_LENGTH"));
				courunitVO.setCour_vtype(rs.getString("COUR_VTYPE"));
			}

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

		return courunitVO;
	}

	@Override
	public List<CourunitVO> getAll() {
		List<CourunitVO> list = new ArrayList<>();
		CourunitVO courunitVO = null;
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
				courunitVO = new CourunitVO();
				courunitVO.setCour_unit_id(rs.getString("COUR_UNIT_ID"));
				courunitVO.setCour_id(rs.getString("COUR_ID"));
				courunitVO.setCu_name(rs.getString("CU_NAME"));
//				byte[] pic2 = rs.getBytes("COUR_FILM_BLOB");
//				readPicture(pic2);
//				courunitVO.setCour_film_vc(rs.getString("COUR_FILM_VC"));
				courunitVO.setCour_length(rs.getDouble("COUR_LENGTH"));
				courunitVO.setCour_vtype(rs.getString("COUR_VTYPE"));
				list.add(courunitVO);
			}

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
//		public static void readPicture(byte[] bytes) throws IOException {
//			FileOutputStream fos = new FileOutputStream("output/test_output.jpg");
//			fos.write(bytes);
//			fos.flush();
//			fos.close();
//		}
		
		
		
			
		
//ash		
		

		@Override
		public Double getUnitSum(String cour_id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Double total_length=0.0;
			try {

//				Class.forName(DRIVER);
//				con = DriverManager.getConnection(URL, USER, PASSWORD);
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_UNIT_SUM_BY_COUR_ID);
				pstmt.setString(1, cour_id);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					
					total_length=rs.getDouble(1);
				
				}

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

			return total_length;
		}

	@Override
	public List<CourunitVO> getCourUnitwithoutVideo(String cour_id) {
		List<CourunitVO> list = new ArrayList<>();
		CourunitVO courunitVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_COURUNIT_BY_COUR_ID);
			pstmt.setString(1, cour_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				courunitVO = new CourunitVO();
				courunitVO.setCour_unit_id(rs.getString("COUR_UNIT_ID"));
				courunitVO.setCour_id(rs.getString("COUR_ID"));
				courunitVO.setCu_name(rs.getString("CU_NAME"));
//				byte[] pic2 = rs.getBytes("COUR_FILM_BLOB");
//				readPicture(pic2);
//				courunitVO.setCour_film_vc(rs.getString("COUR_FILM_VC"));
				courunitVO.setCour_id(rs.getString("COUR_ID"));
				courunitVO.setCour_length(rs.getDouble("COUR_LENGTH"));
				courunitVO.setCour_vtype(rs.getString("COUR_VTYPE"));
				list.add(courunitVO);
			}

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

}
