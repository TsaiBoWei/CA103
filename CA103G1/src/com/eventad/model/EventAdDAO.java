package com.eventad.model;

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

public class EventAdDAO implements EventAdDAO_interface{
	
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
		"Insert into EVENTAD(EAD_ID ,MEM_ID,EAD_PIC,EAD_PTYPE, EAD_STATUS )values ('EAD'||LPAD(to_char(eventad_seq.NEXTVAL), 6, '0'),?,?,?,'EAD0')";
	
	private static final String GET_ALL_STMT = 
		"SELECT EAD_ID ,MEM_ID,EAD_PIC,EAD_PTYPE, EAD_STATUS FROM EVENTAD order by EAD_ID";
	
	private static final String GET_ONE_STMT ="SELECT EAD_ID ,MEM_ID,EAD_PIC,EAD_PTYPE, EAD_STATUS FROM EVENTAD WHERE EAD_ID=?" ;
		
	private static final String UPDATE = 
		"UPDATE EVENTAD set MEM_ID=?,EAD_PIC=?,EAD_PTYPE=? where EAD_ID = ? ";
	
	private static final String UPDATE_STATUS = 
		"UPDATE EVENTAD set EAD_STATUS=?  where EAD_ID = ? ";

	@Override
	public void insert(EventAdVO eventAdVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,eventAdVO.getMem_id());
			pstmt.setBytes(2, eventAdVO.getEad_pic());
			pstmt.setString(3, eventAdVO.getEad_ptype());

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
	public void update(EventAdVO eventAdVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,eventAdVO.getMem_id());
			pstmt.setBytes(2, eventAdVO.getEad_pic());
			pstmt.setString(3, eventAdVO.getEad_ptype());
			pstmt.setString(4, eventAdVO.getEad_id());

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
	public void updateStatus(String ead_id, String ead_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1,ead_status);
			pstmt.setString(2,ead_id);
			
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
	public EventAdVO findByPrimaryKey(String ead_id) {
		EventAdVO eventAdVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, ead_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventAdVO = new EventAdVO();
				eventAdVO.setEad_id(rs.getString("EAD_ID"));
				eventAdVO.setMem_id(rs.getString("MEM_ID"));
				eventAdVO.setEad_pic(rs.getBytes("EAD_PIC"));
				eventAdVO.setEad_ptype(rs.getString("EAD_PTYPE"));
				eventAdVO.setEad_status(rs.getString("EAD_STATUS"));
				
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
		return eventAdVO;
	}

	@Override
	public List<EventAdVO> getAll() {
		List<EventAdVO> list=new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {				
				EventAdVO eventAdVO = new EventAdVO();
				eventAdVO.setEad_id(rs.getString("EAD_ID"));
				eventAdVO.setMem_id(rs.getString("MEM_ID"));
				eventAdVO.setEad_pic(rs.getBytes("EAD_PIC"));
				eventAdVO.setEad_ptype(rs.getString("EAD_PTYPE"));
				eventAdVO.setEad_status(rs.getString("EAD_STATUS"));
				list.add(eventAdVO);
				
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
