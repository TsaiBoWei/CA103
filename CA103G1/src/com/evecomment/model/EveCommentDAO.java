package com.evecomment.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EveCommentDAO implements EveCommentDAO_interface{
	
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
		"Insert into EVENTCOMMENT(ECOMMENT_ID,MEM_ID,EVE_ID,ECOMMENT,ECOM_TIME,ECOM_STATUS)values('EC'||LPAD(to_char(ecomment_seq.NEXTVAL), 6, '0'),?,?,?,CURRENT_TIMESTAMP,'EC1')";
	
	private static final String GET_ALL_STMT = 
		"SELECT ECOMMENT_ID,MEM_ID,EVE_ID,ECOMMENT,ECOM_TIME,ECOM_STATUS FROM EVENTCOMMENT WHERE ECOM_STATUS !='EC0' order by ECOMMENT_ID";
	
	private static final String GET_ONE_STMT ="SELECT ECOMMENT_ID,MEM_ID,EVE_ID,ECOMMENT,ECOM_TIME,ECOM_STATUS FROM EVENTCOMMENT WHERE ECOMMENT_ID=?" ;
		
	private static final String UPDATE = 
		"UPDATE EVENTCOMMENT set ECOMMENT=?,ECOM_TIME=CURRENT_TIMESTAMP where ECOMMENT_ID=?";
	
	private static final String UPDATE_ECOM_STATUS = "UPDATE EVENTCOMMENT set ECOM_STATUS=?  where ECOMMENT_ID=?";
	
	@Override
	public void insert(EveCommentVO eveCommentVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,eveCommentVO.getMem_id());
			pstmt.setString(2, eveCommentVO.getEve_id());
			pstmt.setString(3, eveCommentVO.getEcomment());

			pstmt.executeUpdate();

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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, eveCommentVO.getEcomment());
			pstmt.setString(2, eveCommentVO.getEcomment_id());
			pstmt.executeUpdate();

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
	public void updateStatus(String ecomment_id, String ecom_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_ECOM_STATUS);
			pstmt.setString(1, ecom_status);
			pstmt.setString(2, ecomment_id);		
			pstmt.executeUpdate();

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

			con = ds.getConnection();
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

			con = ds.getConnection();
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

}
