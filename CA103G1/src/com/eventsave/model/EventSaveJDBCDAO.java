package com.eventsave.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventSaveJDBCDAO implements EventSaveDAO_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USERID = "CA103G1";
	private static final String PASSWORD = "123456";
	
	private static final String INSERT = "INSERT INTO EVENTSAVE (MEM_ID,EVE_ID,ES_STATUS) VALUES (?,?,?)";
	private static final String UPDATE = "UPDATE EVENTSAVE SET ES_STATUS = ? WHERE MEM_ID = ? AND EVE_ID = ?";
	private static final String DELETE = "DELETE FROM EVENTSAVE WHERE MEM_ID = ? AND EVE_ID = ?";
	private static final String GET_ONE_STMT = "SELECT MEM_ID, EVE_ID, ES_STATUS FROM EVENTSAVE WHERE MEM_ID = ? AND EVE_ID = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM EVENTSAVE";
	@Override
	public void insert(EventSaveVO eventsaveVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, eventsaveVO.getMem_id());
			pstmt.setString(2, eventsaveVO.getEve_id());
			pstmt.setString(3, eventsaveVO.getEs_status());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." + e.getMessage());
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
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, eventsaveVO.getEs_status());
			
			pstmt.setString(2, eventsaveVO.getMem_id());
			pstmt.setString(3, eventsaveVO.getEve_id());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, mem_id);
			pstmt.setString(2, eve_id);

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
	public EventSaveVO findByPrimaryKey(String mem_id, String eve_id) {
		EventSaveVO eventsaveVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
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
			
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				eventsaveVO = new EventSaveVO();
				eventsaveVO.setMem_id(rs.getString("mem_id"));
				eventsaveVO.setEve_id(rs.getString("eve_id"));
				eventsaveVO.setEs_status(rs.getString("es_status"));
				list.add(eventsaveVO);	
			}
			
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			
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
	
	public static void main(String[] args) {
		EventSaveJDBCDAO dao = new EventSaveJDBCDAO();
		
		//新增
//		EventSaveVO eventsaveVO1 = new EventSaveVO();
//		eventsaveVO1.setMem_id("M000001");
//		eventsaveVO1.setEve_id("E000003");
//		eventsaveVO1.setEs_status("ESS0");
//		dao.insert(eventsaveVO1);
		
		//修改		
//		EventSaveVO eventsaveVO2 = new EventSaveVO();
//		eventsaveVO2.setMem_id("M000001");
//		eventsaveVO2.setEve_id("E000003");
//		eventsaveVO2.setEs_status("ESS0");
//		dao.update(eventsaveVO2);
		
		//刪除
//		dao.delete("M000001", "E000003");
		
		//查詢
//		EventSaveVO eventsaveVO3 = dao.findByPrimaryKey("M000001", "E000001");
//		System.out.print(eventsaveVO3.getMem_id() + ",");
//		System.out.print(eventsaveVO3.getEve_id() + ",");
//		System.out.print(eventsaveVO3.getEs_status());
//		System.out.println("---------------------------------");
		
		//查詢全部
		List<EventSaveVO> list = dao.getAll();
		for(EventSaveVO eventsaveVO4 : list) {
			System.out.print(eventsaveVO4.getMem_id() + ",");
			System.out.print(eventsaveVO4.getEve_id() + ",");
			System.out.print(eventsaveVO4.getEs_status());
			System.out.println();
		}
	}
}
