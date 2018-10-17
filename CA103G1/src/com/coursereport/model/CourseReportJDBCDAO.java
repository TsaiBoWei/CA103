package com.coursereport.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class CourseReportJDBCDAO implements CourseReportDAO_interface {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA103";
	private static final String PASSWORD = "123456";

	// SQL
	private static final String INSERT_STMT = "INSERT INTO COURSEREPORT(COURREPO_ID,COURRE_TIME,COURREP_ITEM,COUR_ID,MEM_ID,COURREP_TEXT,COURREP_STATUS,REPLY_MGR_ID)"
			+ "VALUES('CR'||LPAD(to_char(coursereport_seq.NEXTVAL), 6, '0'),?, ?, ?, ?, ?,'CR1',?)";
	private static final String UPDATE_COURREP_STATUS_STMT = "UPDATE COURSEREPORT SET COURREP_STATUS = ? WHERE COURREPO_ID= ?";
	private static final String GET_REPORT_BY_COURID_STATUS = "SELECT * FROM COURSEREPORT WHERE COUR_ID= ? AND COURREP_STATUS=? ORDER BY COURRE_TIME DESC";
	private static final String FIND_BY_PK = "SELECT * FROM COURSEREPORT WHERE COURREPO_ID= ? ";
	private static final String GET_ALL = "SELECT * FROM COURSEREPORT";

	private static final String GET_REPORT_BY_STATUS = 
			"SELECT * FROM COURSEREPORT WHERE COURREP_STATUS=? ORDER BY COURRE_TIME DESC";
	
	private static final String GET_REPORT_BY_SOLVED_STATUS = 
			"SELECT * FROM COURSEREPORT WHERE COURREP_STATUS='CR3' OR COURREP_STATUS='CR2' ORDER BY COURRE_TIME DESC";
	
	@Override
	public void add(CourseReportVO courseReportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setTimestamp(1, courseReportVO.getCourre_time());
			pstmt.setString(2, courseReportVO.getCourrep_item());
			pstmt.setString(3, courseReportVO.getCour_id());
			pstmt.setString(4, courseReportVO.getMem_id());
			pstmt.setString(5, courseReportVO.getCourrep_text());
			pstmt.setString(6, courseReportVO.getReply_mgr_id());

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
	public void updateCourrep_Status(String courrep_status, String courrepo_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_COURREP_STATUS_STMT);

			pstmt.setString(1, courrep_status);
			pstmt.setString(2, courrepo_id);

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
	public CourseReportVO findByPK(String courrepo_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		CourseReportVO courseReportVO = null;

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, courrepo_id);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				courseReportVO = new CourseReportVO();
				courseReportVO.setCourrepo_id(courrepo_id);
				courseReportVO.setCourre_time(rs.getTimestamp("COURRE_TIME"));
				courseReportVO.setCourrep_item(rs.getString("COURREP_ITEM"));
				courseReportVO.setCour_id(rs.getString("COUR_ID"));
				courseReportVO.setMem_id(rs.getString("MEM_ID"));
				courseReportVO.setCourrep_text(rs.getString("COURREP_TEXT"));
				courseReportVO.setCourrep_status(rs.getString("COURREP_STATUS"));
				courseReportVO.setReply_mgr_id(rs.getString("REPLY_MGR_ID"));

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

		return courseReportVO;
	}

	@Override
	public List<CourseReportVO> findByCourIdplusStatus(String cour_id, String courrep_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		CourseReportVO courseReportVO = null;
		List<CourseReportVO> courseReport_List = new ArrayList<>();

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_REPORT_BY_COURID_STATUS);
			pstmt.setString(1, cour_id);
			pstmt.setString(2, courrep_status);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				courseReportVO = new CourseReportVO();
				courseReportVO.setCourrepo_id(rs.getString("COURREPO_ID"));
				courseReportVO.setCourre_time(rs.getTimestamp("COURRE_TIME"));
				courseReportVO.setCourrep_item(rs.getString("COURREP_ITEM"));
				courseReportVO.setCour_id(cour_id);
				courseReportVO.setMem_id(rs.getString("MEM_ID"));
				courseReportVO.setCourrep_text(rs.getString("COURREP_TEXT"));
				courseReportVO.setCourrep_status(courrep_status);
				courseReportVO.setReply_mgr_id(rs.getString("REPLY_MGR_ID"));
				courseReport_List.add(courseReportVO);
			}

		} catch (SQLException e) {
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

		return courseReport_List;

	}

	@Override
	public List<CourseReportVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CourseReportVO courseReportVO = null;
		List<CourseReportVO> courseReport_List = new ArrayList<>();

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				courseReportVO = new CourseReportVO();
				courseReportVO.setCourrepo_id(rs.getString("COURREPO_ID"));
				courseReportVO.setCourre_time(rs.getTimestamp("COURRE_TIME"));
				courseReportVO.setCourrep_item(rs.getString("COURREP_ITEM"));
				courseReportVO.setCour_id(rs.getString("COUR_ID"));
				courseReportVO.setMem_id(rs.getString("MEM_ID"));
				courseReportVO.setCourrep_text(rs.getString("COURREP_TEXT"));
				courseReportVO.setCourrep_status(rs.getString("COURREP_STATUS"));
				courseReportVO.setReply_mgr_id(rs.getString("REPLY_MGR_ID"));
				courseReport_List.add(courseReportVO);

			}

		} catch (SQLException se) {
			se.printStackTrace();

		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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

		return courseReport_List;
	}
	
	@Override
	public List<CourseReportVO> findByCourStatus(String courrep_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		CourseReportVO courseReportVO = null;
		List<CourseReportVO> courseReport_List = new ArrayList<>();

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_REPORT_BY_STATUS);
			pstmt.setString(1, courrep_status);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				courseReportVO = new CourseReportVO();
				courseReportVO.setCourrepo_id(rs.getString("COURREPO_ID"));
				courseReportVO.setCourre_time(rs.getTimestamp("COURRE_TIME"));
				courseReportVO.setCourrep_item(rs.getString("COURREP_ITEM"));
				courseReportVO.setCour_id(rs.getString("COUR_ID"));
				courseReportVO.setMem_id(rs.getString("MEM_ID"));
				courseReportVO.setCourrep_text(rs.getString("COURREP_TEXT"));
				courseReportVO.setCourrep_status(courrep_status);
				courseReportVO.setReply_mgr_id(rs.getString("REPLY_MGR_ID"));
				courseReport_List.add(courseReportVO);
			}

		} catch (SQLException e) {
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

		return courseReport_List;

	}
	
	@Override
	public List<CourseReportVO> findSolvedCours() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CourseReportVO courseReportVO = null;
		List<CourseReportVO> courseReport_List = new ArrayList<>();

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_REPORT_BY_SOLVED_STATUS);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				courseReportVO = new CourseReportVO();
				courseReportVO.setCourrepo_id(rs.getString("COURREPO_ID"));
				courseReportVO.setCourre_time(rs.getTimestamp("COURRE_TIME"));
				courseReportVO.setCourrep_item(rs.getString("COURREP_ITEM"));
				courseReportVO.setCour_id(rs.getString("COUR_ID"));
				courseReportVO.setMem_id(rs.getString("MEM_ID"));
				courseReportVO.setCourrep_text(rs.getString("COURREP_TEXT"));
				courseReportVO.setCourrep_status(rs.getString("COURREP_STATUS"));
				courseReportVO.setReply_mgr_id(rs.getString("REPLY_MGR_ID"));
				courseReport_List.add(courseReportVO);

			}

		} catch (SQLException se) {
			se.printStackTrace();

		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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

		return courseReport_List;
	}
	
	public static void main(String[] args) {

		// add
		CourseReportVO courseReportVO = new CourseReportVO();
//
//		courseReportVO.setCourre_time(new Timestamp(System.currentTimeMillis()));
//		courseReportVO.setCourrep_item("CRN1");
//		courseReportVO.setCour_id("COUR000002");
//		courseReportVO.setMem_id("M000001");
//		courseReportVO.setCourrep_text("老師行為不當2");
//		courseReportVO.setReply_mgr_id("MGR000001");
//		CourseReportJDBCDAO courseReportDAO = new CourseReportJDBCDAO();
//		courseReportDAO.add(courseReportVO);
//
//		System.out.println("create successful");
		// update status
//		CourseReportJDBCDAO courseReportDAO1 = new CourseReportJDBCDAO();
//		courseReportDAO1.updateCourrep_Status("CR2", "CR000002");
//
//		// select by course_id and status
		CourseReportJDBCDAO courseReportDAO2 = new CourseReportJDBCDAO();
//
//		List<CourseReportVO> courseReport_list = courseReportDAO2.findByCourIdplusStatus("COUR000001", "CR1");
//		
		List<CourseReportVO> courseReport_list1 = courseReportDAO2.getAll();

		for (CourseReportVO courseReportVO1 : courseReport_list1) {
			System.out.print(courseReportVO1.getCourrepo_id() + ",");
			SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy HH:mm:ss", Locale.US);
			System.out.print(sdf.format(courseReportVO.getCourre_time()) + ",");
			System.out.print("COUR000001" + ",");
			System.out.print(courseReportVO.getMem_id() + ",");
			System.out.print(courseReportVO.getCourrep_text() + ",");
			System.out.print("CR1" + ",");
			System.out.print("CP000001" + ",");
			System.out.print(courseReportVO.getReply_mgr_id() + ",");
			System.out.println("");
		}
//
//		// findbyPK
//		CourseReportVO courseReportVO3 = courseReportDAO2.findByPK("CR000002");
//		SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy HH:mm:ss", Locale.US);
//		System.out.print(sdf.format(courseReportVO.getCourre_time()) + ",");
//		System.out.print(courseReportVO3.getCourrep_item() + ",");
//		System.out.print(courseReportVO3.getMem_id() + ",");
//		System.out.print(courseReportVO3.getCourrep_text() + ",");
//		System.out.print(courseReportVO3.getCourrep_status() + ",");
//		System.out.print(courseReportVO3.getReply_mgr_id() + ",");

	

	}



}
