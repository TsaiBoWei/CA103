package com.eventlist.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EventListDAO implements EventListDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
		"Insert into EVENTLIST(MEM_ID,EVE_ID,EVE_RATING,EVELIST_STATUS,EVEPAY_AMOUNT,EVEPAY_DEADLINE,EVE_SHARE)values(?,?,?,?,?,?,?)";
		
	private static final String GET_ALL_STMT = 
		"SELECT MEM_ID,EVE_ID,EVE_RATING,EVELIST_STATUS,EVEPAY_AMOUNT,EVEPAY_DEADLINE,EVE_SHARE FROM EVENTLIST order by MEM_ID,EVE_ID";
	
	private static final String GET_ONE_STMT ="SELECT MEM_ID,EVE_ID,EVE_RATING,EVELIST_STATUS,EVEPAY_AMOUNT,EVEPAY_DEADLINE,EVE_SHARE FROM EVENTLIST WHERE MEM_ID=? AND EVE_ID=?" ;
	
	private static final String GET_MEM_EVELIST_STMT = 
		"SELECT MEM_ID,EVE_ID,EVE_RATING,EVELIST_STATUS,EVEPAY_AMOUNT,EVEPAY_DEADLINE,EVE_SHARE FROM EVENTLIST  WHERE MEM_ID= ? AND EVELIST_STATUS !='EL9'";
	
	private static final String GET_EVE_EVELIST_STMT = 
		"SELECT MEM_ID,EVE_ID,EVE_RATING,EVELIST_STATUS,EVEPAY_AMOUNT,EVEPAY_DEADLINE,EVE_SHARE FROM EVENTLIST  WHERE EVE_ID= ? AND EVELIST_STATUS !='EL9'";
		
	private static final String UPDATE = 
		"UPDATE EVENTLIST set EVE_RATING=?,EVELIST_STATUS=?,EVEPAY_AMOUNT=?,EVEPAY_DEADLINE=?,EVE_SHARE=?  where EVE_ID = ? AND MEM_ID=?";
	
	private static final String UPDATE_EVELIST_STATUS = 
			"UPDATE EVENTLIST set EVELIST_STATUS=?  where EVE_ID = ? AND MEM_ID=?";
	
	private static final String UPDATE_SHARE_STATUS = 
			"UPDATE EVENTLIST set EVE_SHARE=?  where EVE_ID = ? AND MEM_ID=?";
	
	
//		private static final String DELETE = 
//		"DELETE FROM EVENTLIST where EVE_ID = ?";

	@Override
	public void insert(EventListVO eventListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
		
			pstmt.setString(1,eventListVO.getMem_id());
			pstmt.setString(2, eventListVO.getEve_id());
			pstmt.setInt(3, eventListVO.getEve_rating());
			pstmt.setString(4, eventListVO.getEvelist_status());
			pstmt.setInt(5, eventListVO.getEvepay_amount());
			pstmt.setDate(6, eventListVO.getEvepay_deadline());
			pstmt.setString(7, eventListVO.getEve_share());

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
	public void update(EventListVO eventListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, eventListVO.getEve_rating());
			pstmt.setString(2, eventListVO.getEvelist_status());
			pstmt.setInt(3, eventListVO.getEvepay_amount());
			pstmt.setDate(4, eventListVO.getEvepay_deadline());
			pstmt.setString(5, eventListVO.getEve_share());
			pstmt.setString(6, eventListVO.getEve_id());		
			pstmt.setString(7,eventListVO.getMem_id());

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
	public EventListVO findByPrimaryKey(String mem_id, String eve_id) {
		EventListVO eventListVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, mem_id);
			pstmt.setString(2, eve_id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventListVO = new EventListVO();
				eventListVO.setMem_id(mem_id);
				eventListVO.setEve_id(eve_id);			
				eventListVO.setEve_rating(rs.getInt("EVE_RATING"));
				eventListVO.setEvelist_status(rs.getString("EVELIST_STATUS"));
				eventListVO.setEvepay_amount(rs.getInt("EVEPAY_AMOUNT"));
				eventListVO.setEvepay_deadline(rs.getDate("EVEPAY_DEADLINE"));
				eventListVO.setEve_share(rs.getString("EVE_SHARE"));
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
		return eventListVO;
	}

	
	@Override
	public List<EventListVO> findByMemId(String mem_id) {
		List<EventListVO> list = new ArrayList<EventListVO>();
		EventListVO eventListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_EVELIST_STMT);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventListVO = new EventListVO();
				eventListVO.setMem_id(rs.getString("Mem_id"));
				eventListVO.setEve_id(rs.getString("Eve_id"));			
				eventListVO.setEve_rating(rs.getInt("EVE_RATING"));
				eventListVO.setEvelist_status(rs.getString("EVELIST_STATUS"));
				eventListVO.setEvepay_amount(rs.getInt("EVEPAY_AMOUNT"));
				eventListVO.setEvepay_deadline(rs.getDate("EVEPAY_DEADLINE"));
				eventListVO.setEve_share(rs.getString("EVE_SHARE"));
				list.add(eventListVO); // Store the row in the list
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

	@Override
	public List<EventListVO> findByEveId(String eve_id) {
		List<EventListVO> list = new ArrayList<EventListVO>();
		EventListVO eventListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_EVE_EVELIST_STMT);
			pstmt.setString(1, eve_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventListVO = new EventListVO();
				eventListVO.setMem_id(rs.getString("Mem_id"));
				eventListVO.setEve_id(rs.getString("Eve_id"));			
				eventListVO.setEve_rating(rs.getInt("EVE_RATING"));
				eventListVO.setEvelist_status(rs.getString("EVELIST_STATUS"));
				eventListVO.setEvepay_amount(rs.getInt("EVEPAY_AMOUNT"));
				eventListVO.setEvepay_deadline(rs.getDate("EVEPAY_DEADLINE"));
				eventListVO.setEve_share(rs.getString("EVE_SHARE"));
				list.add(eventListVO); // Store the row in the list
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


	
	@Override
	public List<EventListVO> getAll() {
		List<EventListVO> list = new ArrayList<EventListVO>();
		EventListVO eventListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventListVO = new EventListVO();
				eventListVO.setMem_id(rs.getString("Mem_id"));
				eventListVO.setEve_id(rs.getString("Eve_id"));			
				eventListVO.setEve_rating(rs.getInt("EVE_RATING"));
				eventListVO.setEvelist_status(rs.getString("EVELIST_STATUS"));
				eventListVO.setEvepay_amount(rs.getInt("EVEPAY_AMOUNT"));
				eventListVO.setEvepay_deadline(rs.getDate("EVEPAY_DEADLINE"));
				eventListVO.setEve_share(rs.getString("EVE_SHARE"));
				list.add(eventListVO); // Store the row in the list
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
	
	@Override
	public void updateListStatus(String mem_id, String eve_id,String evelist_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_EVELIST_STATUS);
			
			pstmt.setString(1, evelist_status);
//				pstmt.setString(1, eve_share);
			pstmt.setString(2, eve_id);		
			pstmt.setString(3,mem_id);
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
	public void updateShareStatus(String mem_id, String eve_id,String eve_share) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SHARE_STATUS);
			
			pstmt.setString(1, eve_share);
			pstmt.setString(2, eve_id);		
			pstmt.setString(3,mem_id);
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

}
