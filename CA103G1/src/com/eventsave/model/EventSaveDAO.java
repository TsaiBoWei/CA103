package com.eventsave.model;

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

import com.eventlist.model.EventListVO;

public class EventSaveDAO implements EventSaveDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT = "INSERT INTO EVENTSAVE (MEM_ID,EVE_ID,ES_STATUS) VALUES (?,?,?)";
	private static final String UPDATE = "UPDATE EVENTSAVE SET ES_STATUS = ? WHERE MEM_ID = ? AND EVE_ID = ?";
	private static final String DELETE = "DELETE FROM EVENTSAVE WHERE MEM_ID = ? AND EVE_ID = ?";
	private static final String GET_ONE_STMT = "SELECT MEM_ID, EVE_ID, ES_STATUS FROM EVENTSAVE WHERE MEM_ID = ? AND EVE_ID = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM EVENTSAVE";
	private static final String GET_MEM_EVENTSAVE_STMT = "SELECT * FROM EVENTSAVE WHERE MEM_ID=? AND ES_STATUS='ESS1'";

	@Override
	public void insert(EventSaveVO eventsaveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, eventsaveVO.getMem_id());
			pstmt.setString(2, eventsaveVO.getEve_id());
			pstmt.setString(3, eventsaveVO.getEs_status());

			pstmt.executeUpdate();

		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(EventSaveVO eventsaveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, eventsaveVO.getEs_status());

			pstmt.setString(2, eventsaveVO.getMem_id());
			pstmt.setString(3, eventsaveVO.getEve_id());

			pstmt.executeUpdate();

		}catch(SQLException se) {
			throw new RuntimeException("A database error occoured. " + se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String mem_id, String eve_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mem_id);
			pstmt.setString(2, eve_id);

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public EventSaveVO findByPrimaryKey(String mem_id, String eve_id) {
		EventSaveVO eventsaveVO = null;
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
				eventsaveVO = new EventSaveVO();
				eventsaveVO.setMem_id(rs.getString("mem_id"));
				eventsaveVO.setEve_id(rs.getString("eve_id"));
				eventsaveVO.setEs_status(rs.getString("es_status"));
			}

		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {	
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return eventsaveVO;
	}

	
	
	@Override
	public List<EventSaveVO> getAll() {
		List<EventSaveVO> list = new ArrayList<EventSaveVO>();
		EventSaveVO eventsaveVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				eventsaveVO = new EventSaveVO();
				eventsaveVO.setMem_id(rs.getString("mem_id"));
				eventsaveVO.setEve_id(rs.getString("eve_id"));
				eventsaveVO.setEs_status(rs.getString("es_status"));
				list.add(eventsaveVO);	
			}

		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	//某個會員的活動收藏
	@Override
	public List<EventSaveVO> findByMemId(String mem_id) {
		List<EventSaveVO> list = new ArrayList<EventSaveVO>();
		EventSaveVO eventsaveVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_EVENTSAVE_STMT);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				eventsaveVO = new EventSaveVO();
				eventsaveVO.setMem_id(rs.getString("mem_id"));
				eventsaveVO.setEve_id(rs.getString("eve_id"));
				eventsaveVO.setEs_status(rs.getString("es_status"));
				list.add(eventsaveVO);	
			}
			
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
}
