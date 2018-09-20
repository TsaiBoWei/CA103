package com.purchcour.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PurchCourDAO implements PurchCourDAO_interface {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "PROJECTTEST";
	private static final String PASSWORD = "123456";

//  SQL
	private static final String INSERT_STMT = "INSERT INTO PURCHCOUR(CRORDER_ID,CRORDER_TIME,COUR_ID,MEM_ID,REFUND)"
			+ "VALUES('CO'||LPAD(to_char(purchcour_seq.NEXTVAL), 6, '0'),?, ?, ?,'CO1')";
	private static final String UPDATE_SCORE_STMT = "UPDATE PURCHCOUR SET COURSCO = ? WHERE CRORDER_ID= ? AND REFUND='CO1'"; // 預設未退訂
	private static final String UPDATE_REFUND_STMT = "UPDATE PURCHCOUR SET REFUND = ? WHERE CRORDER_ID= ? ";
	private static final String FIND_BY_MEM_ID = "SELECT * FROM PURCHCOUR WHERE MEM_ID=? AND REFUND='CO1'ORDER BY CRORDER_ID";// 展示清單用
	private static final String FIND_BY_PK = "SELECT * FROM PURCHCOUR WHERE CRORDER_ID=? AND REFUND='CO1'";

	private static final String FIND_BY_KEYWORD = "SELECT COURLIST.CNAME,COURLIST.COUR_COST,SPTYPE.SPORT, MEM.MEM_NAME FROM (((COURLIST LEFT JOIN PURCHCOUR ON COURLIST.COUR_ID=PURCHCOUR.COUR_ID)LEFT JOIN SPTYPE ON COURLIST.SPTYPE_ID=SPTYPE.SPTYPE_ID)LEFT JOIN COACH ON COURLIST.COA_ID=COACH.COA_ID)LEFT JOIN MEM ON COACH.MEM_ID =MEM.MEM_ID WHERE COURLIST.CNAME LIKE ? AND PURCHCOUR.MEM_ID=?";

	//

	@Override
	public void add(PurchCourVO purchcourVo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setDate(1, purchcourVo.getCrorder_time());
			pstmt.setString(2, purchcourVo.getCour_id());
			pstmt.setString(3, purchcourVo.getMem_id());

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
	public void updateScore(Integer coursco, String crorder_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_SCORE_STMT);

			pstmt.setInt(1, coursco);
			pstmt.setString(2, crorder_id);

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
	public void updateRefund(String refund, String crorder_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_REFUND_STMT);

			pstmt.setString(1, refund);
			pstmt.setString(2, crorder_id);

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
	public List<PurchCourVO> findByPK(String crorder_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PurchCourVO> findByMem_id(String mem_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		PurchCourVO purchcour_vo = null;
		List<PurchCourVO> purchcour_List = new ArrayList<>();

		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_MEM_ID);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				purchcour_vo = new PurchCourVO();
				purchcour_vo.setCrorder_id(rs.getString("CRORDER_ID"));
				purchcour_vo.setCrorder_time(rs.getDate("CRORDER_TIME"));
				purchcour_vo.setMem_id(rs.getString("MEM_ID"));
				purchcour_vo.setRefund(rs.getString("REFUND"));
				purchcour_vo.setCoursco(rs.getInt("COURSCO"));
				purchcour_List.add(purchcour_vo);
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

		return purchcour_List;

	}

	// join
	@Override
	public List<PurchCourVO> findByKeyWord(String keyWord, String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

}