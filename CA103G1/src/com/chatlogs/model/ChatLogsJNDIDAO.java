package com.chatlogs.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ChatLogsJNDIDAO implements ChatLogsDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

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
			ds.getConnection();
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, chatlogsVO.getChat_memA_id());
			pstmt.setString(2, chatlogsVO.getChat_memB_id());
			pstmt.setTimestamp(3, chatlogsVO.getChat_date());
			pstmt.setString(4, chatlogsVO.getChat_content());
			pstmt.setBytes(5, chatlogsVO.getChat_image());

			pstmt.executeUpdate();

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
			ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, chatlogsVO.getChat_memA_id());
			pstmt.setString(2, chatlogsVO.getChat_memB_id());
			pstmt.setTimestamp(3, chatlogsVO.getChat_date());
			pstmt.setString(4, chatlogsVO.getChat_content());
			pstmt.setBytes(5, chatlogsVO.getChat_image());
			pstmt.setString(6, chatlogsVO.getChat_id());

			pstmt.executeUpdate();

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
			ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, chat_id);

			pstmt.executeUpdate();

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

			ds.getConnection();
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
		List<ChatLogsVO> chatlogs_List = new ArrayList<ChatLogsVO>();
		ChatLogsVO chatlogsVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// chatlogsVO ¤]ºÙ¬° Domain objects	
				chatlogsVO = new ChatLogsVO();
				chatlogsVO.setChat_id(rs.getString("chat_id"));
				chatlogsVO.setChat_memA_id(rs.getString("chat_memA_id"));
				chatlogsVO.setChat_memB_id(rs.getString("chat_memB_id"));
				chatlogsVO.setChat_date(rs.getTimestamp("chat_date"));
				chatlogsVO.setChat_content(rs.getString("chat_content"));
				chatlogsVO.setChat_image(rs.getBytes("chat_image"));;					
				chatlogs_List.add(chatlogsVO);
			}

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
		return chatlogs_List;
	}
}
