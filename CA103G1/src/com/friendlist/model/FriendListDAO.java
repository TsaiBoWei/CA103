package com.friendlist.model;

import java.io.IOException;
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

public class FriendListDAO implements FriendListDAO_interface{

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT = "INSERT INTO FRIENDLIST(FL_MEMA_ID,FL_MEMB_ID,FL_FRIEND_NAME,FL_STATUS,FL_BLOCK)values(?,?,?,?,?)";
	private static final String UPDATE = "UPDATE FRIENDLIST SET FL_FRIEND_NAME = ?, FL_STATUS= ?, FL_BLOCK= ? WHERE FL_MEMA_ID = ? AND FL_MEMB_ID = ?";
	private static final String DELETE = "DELETE FROM FRIENDLIST WHERE FL_MEMA_ID = ? AND FL_MEMB_ID = ?";
	private static final String GET_ONE_STMT = "SELECT * FROM FRIENDLIST WHERE FL_MEMA_ID = ? AND FL_MEMB_ID = ?";
	private static final String GET_ALL_STMT = "SELECT * FROM FRIENDLIST";
	//某個會員的好友清單
	private static final String GET_MEM_FRIENDLIST_STMT = "SELECT * FROM FRIENDLIST WHERE FL_MEMA_ID=? AND FL_STATUS='FLS1'";
	//某個會員的待確認好友清單
	private static final String GET_MEM_FRIENDLIST_UNCOMFIRMED_STMT = "SELECT * FROM FRIENDLIST WHERE FL_MEMA_ID=? AND FL_STATUS='FLS0'";

	
	@Override
	public void insert(FriendListVO friendlistVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1,friendlistVO.getFl_memA_id());
			pstmt.setString(2,friendlistVO.getFl_memB_id());
			pstmt.setString(3,friendlistVO.getFl_friend_name());
			pstmt.setString(4,friendlistVO.getFl_status());
			pstmt.setString(5,friendlistVO.getFl_block());
			
			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		}finally {
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
	public void update(FriendListVO friendlistVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE); 
		
			pstmt.setString(1,friendlistVO.getFl_friend_name());
			pstmt.setString(2,friendlistVO.getFl_status());
			pstmt.setString(3,friendlistVO.getFl_block());
			
			pstmt.setString(4,friendlistVO.getFl_memA_id());
			pstmt.setString(5,friendlistVO.getFl_memB_id());
			
			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		}finally {
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
	public void delete(String fl_memA_id, String fl_memB_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,fl_memA_id);	
			pstmt.setString(2,fl_memB_id);
			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		}finally {
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
	public FriendListVO findByPrimaryKey(String fl_memA_id, String fl_memB_id) {
		
		FriendListVO friendlistVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, fl_memA_id);
			pstmt.setString(2, fl_memB_id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				friendlistVO = new FriendListVO();
				friendlistVO.setFl_memA_id(rs.getString("FL_MEMA_ID"));
				friendlistVO.setFl_memB_id(rs.getString("FL_MEMB_ID"));
				friendlistVO.setFl_friend_name(rs.getString("FL_FRIEND_NAME"));
				friendlistVO.setFl_status(rs.getString("FL_STATUS"));
				friendlistVO.setFl_block(rs.getString("FL_BLOCK"));
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

		return friendlistVO;
	}
	
	@Override
	public List<FriendListVO> getAll() {
		List<FriendListVO> list = new ArrayList<>();
		FriendListVO friendlistVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				friendlistVO = new FriendListVO();
				friendlistVO.setFl_memA_id(rs.getString("FL_MEMA_ID"));
				friendlistVO.setFl_memB_id(rs.getString("FL_MEMB_ID"));
				friendlistVO.setFl_friend_name(rs.getString("FL_FRIEND_NAME"));
				friendlistVO.setFl_status(rs.getString("FL_STATUS"));
				friendlistVO.setFl_block(rs.getString("FL_BLOCK"));
				list.add(friendlistVO);
			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	
	//某個會員的好友清單
		public List<FriendListVO> findFriendListByMem(String fl_memA_id) {
			List<FriendListVO> list = new ArrayList<FriendListVO>();
			FriendListVO friendlistVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_MEM_FRIENDLIST_STMT);
				pstmt.setString(1, fl_memA_id);
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
					friendlistVO = new FriendListVO();
					friendlistVO.setFl_memA_id(rs.getString("fl_memA_id"));
					friendlistVO.setFl_memB_id(rs.getString("fl_memB_id"));
					friendlistVO.setFl_friend_name(rs.getString("fl_friend_name"));
					friendlistVO.setFl_status(rs.getString("fl_status"));
					friendlistVO.setFl_friend_name("fl_block");
					list.add(friendlistVO);	
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
		//某個會員待確認好友清單
		public List<FriendListVO> findFriendListUncomfirmedByMem(String fl_memA_id) {
			List<FriendListVO> list = new ArrayList<FriendListVO>();
			FriendListVO friendlistVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_MEM_FRIENDLIST_UNCOMFIRMED_STMT);
				pstmt.setString(1, fl_memA_id);
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
					friendlistVO = new FriendListVO();
					friendlistVO.setFl_memA_id(rs.getString("fl_memA_id"));
					friendlistVO.setFl_memB_id(rs.getString("fl_memB_id"));
					friendlistVO.setFl_friend_name(rs.getString("fl_friend_name"));
					friendlistVO.setFl_status(rs.getString("fl_status"));
					friendlistVO.setFl_friend_name("fl_block");
					list.add(friendlistVO);	
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
