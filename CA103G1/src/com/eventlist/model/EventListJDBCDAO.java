package com.eventlist.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class EventListJDBCDAO implements EventListDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
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
	
	private static final String GET_EVE_INCOME ="SELECT EVE_ID,SUM(EVEPAY_AMOUNT) FROM EVENTLIST WHERE (EVE_ID =?) AND (EVELIST_STATUS='EL3') GROUP BY EVE_ID" ;
	
	private static final String GET_NUM_OF_MEM_BY_EVE ="SELECT EVE_ID,COUNT(*) FROM EVENTLIST WHERE (EVE_ID =?) AND (EVELIST_STATUS='EL0' OR EVELIST_STATUS='EL3') GROUP BY EVE_ID";
	
	
//	private static final String DELETE = 
//	"DELETE FROM EVENTLIST where EVE_ID = ?";

	@Override
	public void insert(EventListVO eventListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
		
			pstmt.setString(1,eventListVO.getMem_id());
			pstmt.setString(2, eventListVO.getEve_id());
			pstmt.setInt(3, eventListVO.getEve_rating());
			pstmt.setString(4, eventListVO.getEvelist_status());
			pstmt.setInt(5, eventListVO.getEvepay_amount());
			pstmt.setDate(6, eventListVO.getEvepay_deadline());
			pstmt.setString(7, eventListVO.getEve_share());

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
	public void update(EventListVO eventListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, eventListVO.getEve_rating());
			pstmt.setString(2, eventListVO.getEvelist_status());
			pstmt.setInt(3, eventListVO.getEvepay_amount());
			pstmt.setDate(4, eventListVO.getEvepay_deadline());
			pstmt.setString(5, eventListVO.getEve_share());
			pstmt.setString(6, eventListVO.getEve_id());		
			pstmt.setString(7,eventListVO.getMem_id());

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
	public EventListVO findByPrimaryKey(String mem_id, String eve_id) {
		EventListVO eventListVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
	
	@Override
	public int getEveIncome(String eve_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int income=0;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_EVE_INCOME);

			pstmt.setString(1, eve_id);			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				income=rs.getInt(2);
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
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return income;
	}
	
	@Override
	public int getNumOfMemByEve(String eve_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int numOfMem=0;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_NUM_OF_MEM_BY_EVE);

			pstmt.setString(1, eve_id);			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				numOfMem=rs.getInt(2);
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
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return numOfMem;
	}
	@Override
	public List<EventListVO> findByEveId(String eve_id) {
		List<EventListVO> list = new ArrayList<EventListVO>();
		EventListVO eventListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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


	
	@Override
	public List<EventListVO> getAll() {
		List<EventListVO> list = new ArrayList<EventListVO>();
		EventListVO eventListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
	
	@Override
	public void updateListStatus(String mem_id, String eve_id,String evelist_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_EVELIST_STATUS);
			
			pstmt.setString(1, evelist_status);
//			pstmt.setString(1, eve_share);
			pstmt.setString(2, eve_id);		
			pstmt.setString(3,mem_id);
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
	public void updateShareStatus(String mem_id, String eve_id,String eve_share) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_SHARE_STATUS);
			
			pstmt.setString(1, eve_share);
			pstmt.setString(2, eve_id);		
			pstmt.setString(3,mem_id);
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
	

	public static void main(String args[]) {
		EventListJDBCDAO dao = new EventListJDBCDAO();
		
		// 新增
//		EventListVO eventListVO1=new EventListVO();
//		eventListVO1.setMem_id("M000005");
//		eventListVO1.setEve_id("E000001");
//		eventListVO1.setEve_rating(4);
//		eventListVO1.setEvelist_status("EL2");
//		eventListVO1.setEvepay_amount(200);
//		eventListVO1.setEvepay_deadline(java.sql.Date.valueOf("2018-09-10"));
// //		eventListVO1.setEvepay_deadline(null);
//		eventListVO1.setEve_share("ES0");
//		dao.insert(eventListVO1);
		
		
		//修改
//		EventListVO eventListVO2=new EventListVO();
//		eventListVO2.setMem_id("M000001");
//		eventListVO2.setEve_id("E000002");
//		eventListVO2.setEve_rating(5);
//		eventListVO2.setEvelist_status("EL0");
//		eventListVO2.setEvepay_amount(300);
//		eventListVO2.setEvepay_deadline(java.sql.Date.valueOf("2018-09-11"));
//		eventListVO2.setEve_share("ES1");	
//		dao.update(eventListVO2);
		
		//查詢一
//		EventListVO eventListVO3=dao.findByPrimaryKey("M000001", "E000001");
//		System.out.println(eventListVO3.getMem_id());
//		System.out.println(eventListVO3.getEve_id());
//		System.out.println(eventListVO3.getEve_rating());
//		System.out.println(eventListVO3.getEvelist_status());
//		System.out.println(eventListVO3.getEvepay_amount());
//		System.out.println(eventListVO3.getEvepay_deadline());
//		System.out.println(eventListVO3.getEve_share());
//		System.out.println("==================================");
		//查全部
//		List<EventListVO> listAll=dao.getAll();
//		for(EventListVO eventListVO4:listAll) {
//			System.out.println(eventListVO4.getMem_id());
//			System.out.println(eventListVO4.getEve_id());
//			System.out.println(eventListVO4.getEve_rating());
//			System.out.println(eventListVO4.getEvelist_status());
//			System.out.println(eventListVO4.getEvepay_amount());
//			System.out.println(eventListVO4.getEvepay_deadline());
//			System.out.println(eventListVO4.getEve_share());
//			System.out.println("==================================");			
//		}
		
		//以MEM_ID查
//		List<EventListVO> listMemId=dao.findByMemId("M000001");
//		for(EventListVO eventListVO5:listMemId) {
//			System.out.println(eventListVO5.getMem_id());
//			System.out.println(eventListVO5.getEve_id());
//			System.out.println(eventListVO5.getEve_rating());
//			System.out.println(eventListVO5.getEvelist_status());
//			System.out.println(eventListVO5.getEvepay_amount());
//			System.out.println(eventListVO5.getEvepay_deadline());
//			System.out.println(eventListVO5.getEve_share());
//			System.out.println("==================================");	
//		}
		
		//以EVE_ID查
//		List<EventListVO> listEveId=dao.findByEveId("E000001");
//		for(EventListVO eventListVO6:listEveId) {
//			System.out.println(eventListVO6.getMem_id());
//			System.out.println(eventListVO6.getEve_id());
//			System.out.println(eventListVO6.getEve_rating());
//			System.out.println(eventListVO6.getEvelist_status());
//			System.out.println(eventListVO6.getEvepay_amount());
//			System.out.println(eventListVO6.getEvepay_deadline());
//			System.out.println(eventListVO6.getEve_share());
//			System.out.println("==================================");	
//			
//		}
		
//		dao.updateListStatus("M000001","E000001", "EL9");
//		dao.updateShareStatus("M000001","E000001", "ES1");
		
		System.out.println(dao.getNumOfMemByEve("E000003"));
		System.out.println(dao.getEveIncome("E000003"));
		
	}

	

}
