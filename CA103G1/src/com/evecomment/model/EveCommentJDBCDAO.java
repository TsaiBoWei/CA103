package com.evecomment.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class EveCommentJDBCDAO implements EveCommentDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"Insert into EVENTCOMMENT(ECOMMENT_ID,MEM_ID,EVE_ID,ECOMMENT,ECOM_TIME,ECOM_STATUS)values('EC'||LPAD(to_char(ecomment_seq.NEXTVAL), 6, '0'),?,?,?,CURRENT_TIMESTAMP,?)";
	
	private static final String GET_ALL_STMT = 
		"SELECT ECOMMENT_ID,MEM_ID,EVE_ID,ECOMMENT,ECOM_TIME,ECOM_STATUS FROM EVENTCOMMENT order by ECOMMENT_ID";
	
	private static final String GET_ONE_STMT ="SELECT ECOMMENT_ID,MEM_ID,EVE_ID,ECOMMENT,ECOM_TIME,ECOM_STATUS FROM EVENTCOMMENT WHERE ECOMMENT_ID=?" ;
		
	private static final String UPDATE = 
		"UPDATE EVENTCOMMENT set ECOMMENT=?,ECOM_TIME=CURRENT_TIMESTAMP,ECOM_STATUS=?  where ECOMMENT_ID=?";

	@Override
	public void insert(EveCommentVO eveCommentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,eveCommentVO.getMem_id());
			pstmt.setString(2, eveCommentVO.getEve_id());
			pstmt.setString(3, eveCommentVO.getEcomment());
			pstmt.setString(4, eveCommentVO.getEcom_status());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public void update(EveCommentVO eveCommentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, eveCommentVO.getEcomment());
			pstmt.setString(2, eveCommentVO.getEcom_status());
			pstmt.setString(3, eveCommentVO.getEcomment_id());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public EveCommentVO findByPrimaryKey(String ecomment_id) {
		EveCommentVO eveCommentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, ecomment_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eveCommentVO = new EveCommentVO();
				eveCommentVO.setEcomment_id(ecomment_id);
				eveCommentVO.setMem_id(rs.getString("MEM_ID"));
				eveCommentVO.setEve_id(rs.getString("EVE_ID"));	
				eveCommentVO.setEcom_status(rs.getString("Ecom_status"));
				eveCommentVO.setEcom_time(rs.getTimestamp("Ecom_time"));
				eveCommentVO.setEcomment(rs.getString("Ecomment"));	
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return eveCommentVO;
	}

	@Override
	public List<EveCommentVO> getAll() {
		List<EveCommentVO> list=new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {		
				EveCommentVO eveCommentVO = new EveCommentVO();
				eveCommentVO.setEcomment_id(rs.getString("ECOMMENT_ID"));
				eveCommentVO.setMem_id(rs.getString("MEM_ID"));
				eveCommentVO.setEve_id(rs.getString("EVE_ID"));	
				eveCommentVO.setEcom_status(rs.getString("Ecom_status"));
				eveCommentVO.setEcom_time(rs.getTimestamp("Ecom_time"));
				eveCommentVO.setEcomment(rs.getString("Ecomment"));	
				list.add(eveCommentVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	
	public static void main(String args[]) {
		EveCommentJDBCDAO dao=new EveCommentJDBCDAO();
//		//新增
//		EveCommentVO eveCommentVO1=new EveCommentVO();
//		eveCommentVO1.setEcomment("請問之後還有活動嗎?");
//		eveCommentVO1.setEve_id("E000001");
//		eveCommentVO1.setMem_id("M000002");
//		eveCommentVO1.setEcom_status("EC1");
//		dao.insert(eveCommentVO1);
		
		//修改
//		EveCommentVO eveCommentVO2=new EveCommentVO();
//		eveCommentVO2.setEcomment("請問還能報名嗎?");
//		eveCommentVO2.setEcomment_id("EC000001");
//		eveCommentVO2.setEcom_status("EC2");
//		dao.update(eveCommentVO2);
//		
		//查一
//		EveCommentVO eveCommentVO3=dao.findByPrimaryKey("EC000001");
//		System.out.println(eveCommentVO3.getEcomment_id());
//		System.out.println(eveCommentVO3.getEve_id());
//		System.out.println(eveCommentVO3.getMem_id());
//		System.out.println(eveCommentVO3.getEcom_time());
//		System.out.println(eveCommentVO3.getEcom_status());
//		System.out.println(eveCommentVO3.getEcomment());
//		System.out.println("================================");
		
		
		//查全部
		List<EveCommentVO> list =dao.getAll();
		for(EveCommentVO eveCommentVO4:list) {
			System.out.println(eveCommentVO4.getEcomment_id());
			System.out.println(eveCommentVO4.getEve_id());
			System.out.println(eveCommentVO4.getMem_id());
			System.out.println(eveCommentVO4.getEcom_time());
			System.out.println(eveCommentVO4.getEcom_status());
			System.out.println(eveCommentVO4.getEcomment());
			System.out.println("================================");	
		}
		
		
	}

}
