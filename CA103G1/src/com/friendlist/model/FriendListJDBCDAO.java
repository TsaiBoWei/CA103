package com.friendlist.model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
 


public class FriendListJDBCDAO implements FriendListDAO_interface {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USERID = "CA103G1";
	private static final String PASSWORD = "123456";
	
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
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1,friendlistVO.getFl_memA_id());
			pstmt.setString(2,friendlistVO.getFl_memB_id());
			pstmt.setString(3,friendlistVO.getFl_friend_name());
			pstmt.setString(4,friendlistVO.getFl_status());
			pstmt.setString(5,friendlistVO.getFl_block());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}		
		catch (SQLException se) {
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
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(UPDATE); 
		
			pstmt.setString(1,friendlistVO.getFl_friend_name());
			pstmt.setString(2,friendlistVO.getFl_status());
			pstmt.setString(3,friendlistVO.getFl_block());
			
			pstmt.setString(4,friendlistVO.getFl_memA_id());
			pstmt.setString(5,friendlistVO.getFl_memB_id());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}
		
		catch (SQLException se) {
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
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,fl_memA_id);	
			pstmt.setString(2,fl_memB_id);
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}
		
		catch (SQLException se) {
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

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
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

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
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

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
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

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
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
	
	@Override
	public List<FriendListVO> findFriendListByMem(String fl_memA_id) {
		List<FriendListVO> list = new ArrayList<FriendListVO>();
		FriendListVO friendlistVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
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
	
	@Override
	public List<FriendListVO> findFriendListUncomfirmedByMem(String fl_memA_id) {
		List<FriendListVO> list = new ArrayList<FriendListVO>();
		FriendListVO friendlistVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USERID, PASSWORD);
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
	

	public static void main(String[] args) throws IOException{
		
		FriendListJDBCDAO dao = new FriendListJDBCDAO();
			
		// 新增
//	    FriendListVO friendlistVO1 = new FriendListVO();
//		friendlistVO1.setFl_memA_id("M000002");
//		friendlistVO1.setFl_memB_id("M000004");
//		friendlistVO1.setFl_friend_name("JAVA班7號");
//		friendlistVO1.setFl_status("FLB0");
//		friendlistVO1.setFl_block("FLS0");;
//		dao.insert(friendlistVO1);
	
		//修改
//		FriendListVO friendlistVO2 = new FriendListVO();
//		friendlistVO2.setFl_memA_id("M000002");
//		friendlistVO2.setFl_memB_id("M000004");
//		friendlistVO2.setFl_friend_name("JAVA班8號");
//		friendlistVO2.setFl_status("FLB1");
//		friendlistVO2.setFl_block("FLS1");;
//		dao.update(friendlistVO2);
			
		//刪除
//		dao.delete("M000004","M000003");
			
//		查詢
//		FriendListVO friendlistVO4= dao.findByPrimaryKey("M000001","M000002");
//		System.out.print(friendlistVO4.getFl_memA_id() + ",");
//		System.out.print(friendlistVO4.getFl_memB_id() + ",");
//		System.out.print(friendlistVO4.getFl_friend_name() + ",");
//		System.out.print(friendlistVO4.getFl_status() + ",");
//		System.out.println(friendlistVO4.getFl_block() + ",");
//		System.out.println("---------------------");
			
		// 查詢
//		List<FriendListVO> list = dao.getAll();
//		for (FriendListVO friendlistVO5 : list) {
//			System.out.print(friendlistVO5.getFl_memA_id() + ",");
//			System.out.print(friendlistVO5.getFl_memB_id() + ",");
//			System.out.print(friendlistVO5.getFl_friend_name() + ",");
//			System.out.print(friendlistVO5.getFl_status() + ",");
//			System.out.print(friendlistVO5.getFl_block() + ",");
//			System.out.println();
//		}
	
		//查詢某會員的好友清單
//		List<FriendListVO> list = dao.findFriendListByMem("M000001");
//		for(FriendListVO friendlistVO7:list) {
//			System.out.print(friendlistVO7.getFl_memA_id() + ",");
//			System.out.print(friendlistVO7.getFl_memB_id() + ",");
//			System.out.print(friendlistVO7.getFl_friend_name() + ",");
//			System.out.print(friendlistVO7.getFl_status() + ",");
//			System.out.println(friendlistVO7.getFl_block() + ",");
//		}
		
		//查詢某會員的待確認好友清單
		List<FriendListVO> list = dao.findFriendListUncomfirmedByMem("M000001");
		for(FriendListVO friendlistVO7:list) {
			System.out.print(friendlistVO7.getFl_memA_id() + ",");
			System.out.print(friendlistVO7.getFl_memB_id() + ",");
			System.out.print(friendlistVO7.getFl_friend_name() + ",");
			System.out.print(friendlistVO7.getFl_status() + ",");
			System.out.println(friendlistVO7.getFl_block() + ",");
		}
	}		
}
