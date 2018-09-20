package com.chatlogs.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


public class ChatLogsJDBCDAO implements ChatLogsDAO_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String USERID = "CA103G1";
	private static final String PASSWORD = "123456";
	
	private static final String INSERT = 
			"INSERT INTO CHATLOGS (CHAT_ID,CHAT_MEMA_ID,CHAT_MEMB_ID,CHAT_DATE,CHAT_CONTENT,CHAT_IMAGE) VALUES ('CHAT'||LPAD(to_char(chatlogs_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?)";
	private static final String UPDATE = 
			"UPDATE CHATLOGS SET CHAT_MEMA_ID = ?, CHAT_MEMB_ID = ?, CHAT_DATE = ?, CHAT_CONTENT = ?, CHAT_IMAGE = ? WHERE CHAT_ID = ?";
	private static final String DELETE = 
			"DELETE FROM CHATLOGS WHERE CHAT_ID = ?";
	private static final String GET_ONE_STMT = 
			"SELECT CHAT_ID,CHAT_MEMA_ID,CHAT_MEMB_ID,CHAT_DATE,CHAT_CONTENT,CHAT_IMAGE FROM CHATLOGS WHERE CHAT_ID = ?";
	private static final String GET_ALL_STMT = 
			"SELECT CHAT_ID,CHAT_MEMA_ID,CHAT_MEMB_ID,CHAT_DATE,CHAT_CONTENT,CHAT_IMAGE FROM CHATLOGS ORDER BY CHAT_ID";


	@Override
	public void insert(ChatLogsVO chatlogsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(INSERT);
				
			pstmt.setString(1, chatlogsVO.getChat_memA_id());
			pstmt.setString(2, chatlogsVO.getChat_memB_id());
			pstmt.setTimestamp(3, chatlogsVO.getChat_date());
			pstmt.setString(4, chatlogsVO.getChat_content());
			pstmt.setBytes(5, chatlogsVO.getChat_image());
			
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public void update(ChatLogsVO chatlogsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, chatlogsVO.getChat_memA_id());
			pstmt.setString(2, chatlogsVO.getChat_memB_id());
			pstmt.setTimestamp(3, chatlogsVO.getChat_date());
			pstmt.setString(4, chatlogsVO.getChat_content());
			pstmt.setBytes(5, chatlogsVO.getChat_image());
			pstmt.setString(6, chatlogsVO.getChat_id());
		
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public void delete(String chat_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, chat_id);
			
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public ChatLogsVO findByPrimaryKey(String chat_id) {
		
		ChatLogsVO chatlogsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);

			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, chat_id);

			rs = pstmt.executeQuery();

			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd hh:mm");

			while (rs.next()) {
				chatlogsVO = new ChatLogsVO();
				
				chatlogsVO.setChat_id(rs.getString("chat_id"));
				chatlogsVO.setChat_memA_id(rs.getString("chat_memA_id"));
				chatlogsVO.setChat_memB_id(rs.getString("chat_memB_id"));
				chatlogsVO.setChat_date(rs.getTimestamp("chat_date"));
				chatlogsVO.setChat_content(rs.getString("chat_content"));
				chatlogsVO.setChat_image(rs.getBytes("chat_image"));
				
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (NullPointerException e){
			e.getMessage();
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
		return chatlogsVO;
	}
	@Override
	public List<ChatLogsVO> getAll() {
		List<ChatLogsVO> list = new ArrayList<ChatLogsVO>();
		ChatLogsVO chatlogsVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// chatlogsVO 也稱為 Domain objects	
				chatlogsVO = new ChatLogsVO();
				chatlogsVO.setChat_id(rs.getString("chat_id"));
				chatlogsVO.setChat_memA_id(rs.getString("chat_memA_id"));
				chatlogsVO.setChat_memB_id(rs.getString("chat_memB_id"));
				chatlogsVO.setChat_date(rs.getTimestamp("chat_date"));
				chatlogsVO.setChat_content(rs.getString("chat_content"));
				chatlogsVO.setChat_image(rs.getBytes("chat_image"));;					
				list.add(chatlogsVO);
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

	public static void main(String[] args) {
		ChatLogsJDBCDAO dao = new ChatLogsJDBCDAO();
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm");
		Timestamp now =new Timestamp(System.currentTimeMillis());

		//新增
	
//		ChatLogsVO chatlogsVO1 = new ChatLogsVO();
//		chatlogsVO1.setChat_memA_id("M000003");
//		chatlogsVO1.setChat_memB_id("M000002");
//		chatlogsVO1.setChat_date(now);
//		chatlogsVO1.setChat_image(null);
//		dao.insert(chatlogsVO1);
		
		//修改		
//		ChatLogsVO chatlogsVO2 = new ChatLogsVO();
//		chatlogsVO2.setChat_id("CHAT000006");
//		chatlogsVO2.setChat_memA_id("M000003");
//		chatlogsVO2.setChat_memB_id("M000002");
//		chatlogsVO2.setChat_date(now);
//		chatlogsVO2.setChat_content(null);
//		chatlogsVO2.setChat_image(null);
//		dao.update(chatlogsVO2);
		
		
		//刪除
//		dao.delete("CHAT000008");
		
		
		//查詢	
//		ChatLogsVO chatlogsVO3 = dao.findByPrimaryKey("CHAT000001");
//		System.out.print(chatlogsVO3.getChat_id() + ",");
//		System.out.print(chatlogsVO3.getChat_memA_id() + ",");
//		System.out.print(chatlogsVO3.getChat_memB_id() + ",");
//		System.out.print(sdf.format(chatlogsVO3.getChat_date()) + ",");	 //聊天紀錄要的時間格式
////	System.out.print(chatlogsVO3.getChat_date()); 					 //取出timestamp完整格式
//		System.out.print(chatlogsVO3.getChat_content() + ",");
//		System.out.println(chatlogsVO3.getChat_image());
//		System.out.println("---------------------");

		//查詢
		List<ChatLogsVO> list = dao.getAll();
		for(ChatLogsVO chatlogsVO4:list) {
			System.out.print(chatlogsVO4.getChat_id() + ",");
			System.out.print(chatlogsVO4.getChat_memA_id() + ",");
			System.out.print(chatlogsVO4.getChat_memB_id() + ",");
			System.out.print(sdf.format(chatlogsVO4.getChat_date()) + ","); //聊天紀錄要的時間格式
//			System.out.print(chatlogsVO4.getChat_date() + ",");  		//取出timestamp完整格式
			System.out.print(chatlogsVO4.getChat_content() + ",");
			System.out.println(chatlogsVO4.getChat_image());
		}
		
	}
}
