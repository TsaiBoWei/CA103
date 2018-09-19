package com.evechat.model;

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

public class EveChatDAO implements EveChatDAO_interface{
	
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
		"Insert into EVENTCHAT(ECHAT_ID ,MEM_ID,EVE_ID,ECHAT_CONTENT,ECHAT_TIME,ECHAT_STATUS ) values(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(eventchat_seq.NEXTVAL), 6, '0'),?,?,?,CURRENT_TIMESTAMP,'ECHAT1')" ;
			
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

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
				
			pstmt.setString(1,eveChatVO.getMem_id());
			pstmt.setString(2, eveChatVO.getEve_id());			
			pstmt.setString(3, eveChatVO.getEchat_content());

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
	public EveChatVO findByPrimaryKey(String echat_id) {
		EveChatVO eveChatVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
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

			con = ds.getConnection();
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

			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
//				throw new RuntimeException("A database error occured. "
//						+ se.getMessage());
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

			con = ds.getConnection();
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

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_ECHAT_CONTENT);
						
			pstmt.setString(1, eveChatVO.getEchat_content());
			pstmt.setString(2, eveChatVO.getEchat_id());

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
	public void updateEchatStatus(String echat_id, String echat_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_ECHAT_STATUS);
						
			pstmt.setString(1, echat_status);
			pstmt.setString(2, echat_id);
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
