package com.courlist.model;
import java.util.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;

public class CourlistJDBCDAO implements CourlistDAO_interface {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA103G1";
	private static final String PASSWORD = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO COURLIST(COUR_ID, SPTYPE_ID, COA_ID, CNAME, COUR_TEXT, COUR_COST, COUR_PHO, COUR_LAU, COUR_ANN, COUR_VIEW)"
			+ "VALUES('COUR'||LPAD(to_char(COUR_ID_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_STMT = "UPDATE COURLIST SET SPTYPE_ID = ?, COA_ID = ?, CNAME = ?, "
			+ "COUR_TEXT = ?, COUR_COST = ?, COUR_PHO = ?, COUR_LAU = ?, COUR_ANN = ?, COUR_VIEW = ? WHERE COUR_ID = ?";
	private static final String DELETE_STMT = "DELETE FROM COURLIST WHERE COUR_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM COURLIST WHERE COUR_ID = ?";
	private static final String GET_ALL = "SELECT * FROM COURLIST";

	@Override
	public void insert(CourlistVO courlistVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, courlistVO.getSptype_id());
			pstmt.setString(2, courlistVO.getCoa_id());
			pstmt.setString(3, courlistVO.getCname());
			pstmt.setString(4, courlistVO.getCour_text());
			pstmt.setInt(5, courlistVO.getCour_cost());	
			byte[] pic = getPictureByteArray("item/test01.jpg");
			pstmt.setBytes(6, pic);
			pstmt.setString(7, courlistVO.getCour_lau());
			pstmt.setString(8, courlistVO.getCour_ann());
			pstmt.setInt(9, courlistVO.getCour_view());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
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
	public void update(CourlistVO courlistVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, courlistVO.getSptype_id());
			pstmt.setString(2, courlistVO.getCoa_id());
			pstmt.setString(3, courlistVO.getCname());
			pstmt.setString(4, courlistVO.getCour_text());
			pstmt.setInt(5, courlistVO.getCour_cost());	
			byte[] pic2 = getPictureByteArray("item/test01.jpg");
			pstmt.setBytes(6, pic2);
			pstmt.setString(7, courlistVO.getCour_lau());
			pstmt.setString(8, courlistVO.getCour_ann());
			pstmt.setInt(9, courlistVO.getCour_view());
			pstmt.setString(10, courlistVO.getCour_id());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
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
	public void delete(String cour_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setString(1, cour_id);
			
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
	public CourlistVO findByPK(String cour_id) {
		CourlistVO courlistVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, cour_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				courlistVO = new CourlistVO();
				courlistVO.setCour_id(rs.getString("COUR_ID"));
				courlistVO.setSptype_id(rs.getString("SPTYPE_ID"));
				courlistVO.setCoa_id(rs.getString("COA_ID"));
				courlistVO.setCname(rs.getString("CNAME"));
				courlistVO.setCour_text(rs.getString("COUR_TEXT"));
				courlistVO.setCour_cost(rs.getInt("COUR_COST"));
				byte[] pic = rs.getBytes("COUR_PHO");
				readPicture(pic);		
				courlistVO.setCour_lau(rs.getString("COUR_LAU"));
				courlistVO.setCour_ann(rs.getString("COUR_ANN"));
				courlistVO.setCour_view(rs.getInt("COUR_VIEW"));
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

		return courlistVO;
	}

	@Override
	public List<CourlistVO> getAll() {
		List<CourlistVO> list = new ArrayList<>();
		CourlistVO courlistVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				courlistVO = new CourlistVO();
				courlistVO.setCour_id(rs.getString("COUR_ID"));
				courlistVO.setSptype_id(rs.getString("SPTYPE_ID"));
				courlistVO.setCoa_id(rs.getString("COA_ID"));
				courlistVO.setCname(rs.getString("CNAME"));
				courlistVO.setCour_text(rs.getString("COUR_TEXT"));
				courlistVO.setCour_cost(rs.getInt("COUR_COST"));
				byte[] pic2 = rs.getBytes("COUR_PHO");
				readPicture(pic2);
				courlistVO.setCour_lau(rs.getString("COUR_LAU"));
				courlistVO.setCour_ann(rs.getString("COUR_ANN"));
				courlistVO.setCour_view(rs.getInt("COUR_VIEW"));
				list.add(courlistVO);
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
		public static void readPicture(byte[] bytes){
			FileOutputStream fos = null;
			try {
				if( bytes != null) {
					fos = new FileOutputStream("output/test_output.jpg");
					fos.write(bytes);
				}
			}catch(IOException ie){
				throw new RuntimeException("A IOException. " + ie.getMessage());
			}finally {
				if (fos != null) {
					try {
						fos.flush();
						fos.close();
					} catch (IOException ie) {
						ie.printStackTrace(System.err);
					}
				}
			}	
		}
}
