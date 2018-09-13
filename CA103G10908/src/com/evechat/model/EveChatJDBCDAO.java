package com.evechat.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;



public class EveChatJDBCDAO implements EveChat_interface{
	
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"Insert into EVENTCHAT(ECHAT_ID ,MEM_ID,EVE_ID,ECHAT_CONTENT,ECHAT_TIME,ECHAT_STATUS ) values(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(eventchat_seq.NEXTVAL), 6, '0'),?,?,?,CURRENT_TIMESTAMP,?)" ;
		
	private static final String GET_ALL_STMT = 
		"SELECT ECHAT_ID ,MEM_ID,EVE_ID,ECHAT_CONTENT,ECHAT_TIME ,ECHAT_STATUS FROM EVENTCHAT order by ECHAT_ID";
	
	private static final String GET_EVE_ECHAT = 
		"SELECT ECHAT_ID,MEM_ID,EVE_ID,ECHAT_CONTENT,ECHAT_TIME,ECHAT_STATUS FROM EVENTCHAT Where EVE_ID=? order by ECHAT_ID";
	
	private static final String GET_ONE_STMT ="SELECT ECHAT_ID ,MEM_ID,EVE_ID,ECHAT_CONTENT,ECHAT_TIME,ECHAT_STATUS FROM EVENTCHAT WHERE ECHAT_ID=?" ;
		
	private static final String UPDATE_ECHAT_CONTENT = 
		"UPDATE EVENTCHAT set ECHAT_CONTENT=?,ECHAT_TIME=CURRENT_TIMESTAMP  where ECHAT_ID=?";
	
	private static final String UPDATE_ECHAT_STATUS = 
		"UPDATE EVENTCHAT set ECHAT_STATUS=?  where ECHAT_ID=?";

	@Override
	public void insert(EveChatVO eveChatVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
				
			pstmt.setString(1,eveChatVO.getMem_id());
			pstmt.setString(2, eveChatVO.getEve_id());			
			pstmt.setString(3, eveChatVO.getEchat_content());
			pstmt.setString(4, eveChatVO.getEchat_status());

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
	public EveChatVO findByPrimaryKey(String echat_id) {
		EveChatVO eveChatVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, echat_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eveChatVO = new EveChatVO();
				eveChatVO.setEchat_id(rs.getString("ECHAT_ID"));
				eveChatVO.setMem_id(rs.getString("MEM_ID"));
				eveChatVO.setEve_id(rs.getString("EVE_ID"));	
				eveChatVO.setEchat_status(rs.getString("ECHAT_STATUS"));
				eveChatVO.setEchat_time(rs.getTimestamp("ECHAT_TIME"));
				eveChatVO.setEchat_content(rs.getString("Echat_content"));	
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
		return eveChatVO;
	}

	@Override
	public List<EveChatVO> getEve_Echat(String eve_id) {
		List<EveChatVO> list=new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_EVE_ECHAT);
			pstmt.setString(1,eve_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {		
				EveChatVO eveChatVO = new EveChatVO();
				eveChatVO.setEchat_id(rs.getString("ECHAT_ID"));
				eveChatVO.setMem_id(rs.getString("MEM_ID"));
				eveChatVO.setEve_id(rs.getString("EVE_ID"));	
				eveChatVO.setEchat_time(rs.getTimestamp("Echat_time"));
				eveChatVO.setEchat_content(rs.getString("Echat_content"));
				eveChatVO.setEchat_status(rs.getString("Echat_status"));
				list.add(eveChatVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
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
	public List<EveChatVO> getAll() {
		List<EveChatVO> list=new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {		
				EveChatVO eveChatVO = new EveChatVO();
				eveChatVO.setEchat_id(rs.getString("ECHAT_ID"));
				eveChatVO.setMem_id(rs.getString("MEM_ID"));
				eveChatVO.setEve_id(rs.getString("EVE_ID"));	
				eveChatVO.setEchat_time(rs.getTimestamp("Echat_time"));
				eveChatVO.setEchat_content(rs.getString("Echat_content"));
				eveChatVO.setEchat_status(rs.getString("ECHAT_STATUS"));
				list.add(eveChatVO);
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
	public void updateEchatCont(EveChatVO eveChatVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_ECHAT_CONTENT);
						
			pstmt.setString(1, eveChatVO.getEchat_content());
			pstmt.setString(2, eveChatVO.getEchat_id());

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
	public void updateEchatStatus(String echat_id, String echat_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_ECHAT_STATUS);
						
			pstmt.setString(1, echat_status);
			pstmt.setString(2, echat_id);
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
		EveChatJDBCDAO dao=new EveChatJDBCDAO();
		
		//新增
		EveChatVO eveChatVO1 =new EveChatVO();
		eveChatVO1.setMem_id("M000002");
		eveChatVO1.setEve_id("E000002");
		eveChatVO1.setEchat_content("have fun");
		eveChatVO1.setEchat_status("ECHAT0");
		dao.insert(eveChatVO1);
//		
		//修改內容
//		EveChatVO eveChatVO2 =new EveChatVO();
//		eveChatVO2.setEchat_id("20180908-000001");
//		eveChatVO2.setEchat_content("yoyo");
//		dao.updateEchatCont(eveChatVO2);
		
		//修改狀態
		
//		dao.updateEchatStatus("20180908-000001", "ECHAT1");
		
		//查一
//		EveChatVO eveChatVO4=dao.findByPrimaryKey("20180908-000001");
//		System.out.println(eveChatVO4.getEchat_id());
//		System.out.println(eveChatVO4.getEve_id());
//		System.out.println(eveChatVO4.getMem_id());
//		Timestamp ts= eveChatVO4.getEchat_time();
//		//--------SimpleDateFormat寫法--------
//		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
//		System.out.println(sdf.format(ts));
//		System.out.println(eveChatVO4.getEchat_status());
//		System.out.println(eveChatVO4.getEchat_content());
//		
//		
//		
//		//用活動查
		List<EveChatVO> list1=dao.getEve_Echat("E000001");
		for(EveChatVO eveChatVO5:list1) {
			System.out.println(eveChatVO5.getEchat_id());
			System.out.println(eveChatVO5.getEve_id());
			System.out.println(eveChatVO5.getMem_id());
			Timestamp ts1= eveChatVO5.getEchat_time();
			//--------SimpleDateFormat寫法--------
			SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
			System.out.println(sdf1.format(ts1));			
			System.out.println(eveChatVO5.getEchat_status());
			System.out.println(eveChatVO5.getEchat_content());
			System.out.println("==============================");
		}
////		
////		//查全部
//		List<EveChatVO> list2=dao.getAll();
//		for(EveChatVO eveChatVO6:list2) {
//			System.out.println(eveChatVO6.getEchat_id());
//			System.out.println(eveChatVO6.getEve_id());
//			System.out.println(eveChatVO6.getMem_id());
//			Timestamp ts2= eveChatVO6.getEchat_time();
//			//--------SimpleDateFormat寫法--------
//			SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
//			System.out.println(sdf2.format(ts2));			
//			System.out.println(eveChatVO6.getEchat_status());
//			System.out.println(eveChatVO6.getEchat_content());
//			System.out.println("==============================");
//		}
		
	}



	

}
