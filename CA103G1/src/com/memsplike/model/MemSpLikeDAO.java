package com.memsplike.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemSpLikeDAO implements MemSpLikeDAO_interface {
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";

	//INSERT INTO "MEMSPLIKE" (MEM_ID,SPTYPE_ID,LIKE_STATUS) VALUES ('M000001','SP000001','LS0');
	private static String INSERT_STMT 
	="INSERT INTO MEMSPLIKE (MEM_ID,SPTYPE_ID,LIKE_STATUS) VALUES (?,?,?)";
	
	private static String DELETE_STMT
	="DELETE FROM MEMSPLIKE where MEM_ID=? AND SPTYPE_ID=?";
	
	private static String UPDATE_STMT 
	="UPDATE MEMSPLIKE SET LIKE_STATUS=? WHERE MEM_ID=? AND SPTYPE_ID=?";
	
	private static String GET_ONE_BY_MEM_ID_AND_SPTYPE_ID=
	"SELECT MEM_ID, SPTYPE_ID, LIKE_STATUS FROM MEMSPLIKE WHERE MEM_ID=? AND SPTYPE_ID=?";
	
	private static String GET_LIST_BY_MEM_ID
	="SELECT MEM_ID, SPTYPE_ID, LIKE_STATUS FROM MEMSPLIKE WHERE MEM_ID=?";
	
	private static String GET_LIST_BY_SPTYPE_ID
	="SELECT MEM_ID, SPTYPE_ID, LIKE_STATUS FROM MEMSPLIKE WHERE SPTYPE_ID=?";
	
	private static String GET_ALL_STMT
	="SELECT MEM_ID, SPTYPE_ID, LIKE_STATUS FROM MEMSPLIKE ORDER BY MEM_ID, SPTYPE_ID";
	

 
	@Override
	public void insert(MemSpLikeVO memSpLikeVO) {
		// �ŧi�s�u
		Connection con = null;
		PreparedStatement pstmt = null;		
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);			
			// ���ƨϥ�
			pstmt.setString( 1, memSpLikeVO.getMem_id());
			pstmt.setString( 2, memSpLikeVO.getSptype_id());
			pstmt.setString( 3, memSpLikeVO.getLike_status());			
			pstmt.executeUpdate();			
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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

	public void delete(String mem_id, String sptype_id) {
		Connection con = null;
		PreparedStatement pstmt = null;		
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_STMT);			
			// ���ƨϥ�
			pstmt.setString( 1, mem_id);
			pstmt.setString( 2, sptype_id);		
			pstmt.executeUpdate();			
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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
	public void update(MemSpLikeVO memSpLikeVO) {
		// �ŧi�s�u
		// Like_Status�u�ݭn�窱�A, ��L���key�ҬOfk, ���o�s�W
		// ���Ǭ� status > id > sptype
		Connection con = null;
		PreparedStatement pstmt = null;		
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);			
			// ���ƨϥ�
			pstmt.setString( 1, memSpLikeVO.getLike_status());
			pstmt.setString( 2, memSpLikeVO.getMem_id());
			pstmt.setString( 3, memSpLikeVO.getSptype_id());						
			pstmt.executeUpdate();			
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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

	public MemSpLikeVO findByMemIdAndSpTypeId(String memid, String sptype_id) {
		MemSpLikeVO vo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_BY_MEM_ID_AND_SPTYPE_ID);
			pstmt.setString(1, memid);
			pstmt.setString(2, sptype_id);
			rs = pstmt.executeQuery();
			
			// ���ƨϥ�
			while ( rs.next() ) {
				vo = new MemSpLikeVO();
				vo.setMem_id(rs.getString("MEM_ID"));
				vo.setSptype_id(rs.getString("SPTYPE_ID"));
				vo.setLike_status(rs.getString("LIKE_STATUS"));
			}
	
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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
		return vo;
	}
	
	@Override
	public List<MemSpLikeVO> findByMemId(String memId) {
		List<MemSpLikeVO> list = new ArrayList<MemSpLikeVO>();
		// �ŧi�s�u
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemSpLikeVO vo = null;
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_LIST_BY_MEM_ID);
			pstmt.setString(1, memId);
			rs = pstmt.executeQuery();
			
			// ���ƨϥ�
			while ( rs.next() ) {
				vo = new MemSpLikeVO();
				vo.setMem_id(rs.getString("MEM_ID"));
				vo.setSptype_id(rs.getString("SPTYPE_ID"));
				vo.setLike_status(rs.getString("LIKE_STATUS"));
				list.add(vo);
			}
	
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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
	public List<MemSpLikeVO> findBySpTypeId(String sptype_id) {
		List<MemSpLikeVO> list = new ArrayList<MemSpLikeVO>();
		// �ŧi�s�u
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemSpLikeVO vo = null;
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_LIST_BY_SPTYPE_ID);
			pstmt.setString(1, sptype_id);
			rs = pstmt.executeQuery();
			
			// ���ƨϥ�
			while ( rs.next() ) {
				vo = new MemSpLikeVO();
				vo.setMem_id(rs.getString("MEM_ID"));
				vo.setSptype_id(rs.getString("SPTYPE_ID"));
				vo.setLike_status(rs.getString("LIKE_STATUS"));
				list.add(vo);
			}
	
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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
	public List<MemSpLikeVO> getAll() {
		List<MemSpLikeVO> list = new ArrayList<MemSpLikeVO>();
		// �ŧi�s�u
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemSpLikeVO vo = null;
		try {
			// JDBC���I4��
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			// ���ƨϥ�
			while ( rs.next() ) {
				vo = new MemSpLikeVO();
				vo.setMem_id(rs.getString("MEM_ID"));
				vo.setSptype_id(rs.getString("SPTYPE_ID"));
				vo.setLike_status(rs.getString("LIKE_STATUS"));
				list.add(vo);
			}
	
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
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
	
//	public static void main(String[] args) {
//		MemSpLikeJDBCDAO dao = new MemSpLikeJDBCDAO();
//		MemSpLikeVO mem = new MemSpLikeVO();
//		mem.setMem_id("M000001");
//		mem.setSptype_id("SP000001");
//		mem.setLike_status("LS1");
//		dao.update(mem);
//		
//		List<MemSpLikeVO> list = new ArrayList<MemSpLikeVO>();
//		list = dao.findByMemId("M000001");
//		for( MemSpLikeVO vo : list ) {
//			System.out.println(vo.getMem_id());
//		}
//		
//		List<MemSpLikeVO> list2 = new ArrayList<MemSpLikeVO>();
//		list2 = dao.findBySpTypeId("SP000001");
//		for( MemSpLikeVO vo : list2 ) {
//			System.out.println(vo.getMem_id());
//		}
//		
//		List<MemSpLikeVO> list3 = new ArrayList<MemSpLikeVO>();
//		list3 = dao.getAll();
//		for( MemSpLikeVO vo : list3 ) {
//			System.out.println(vo.getMem_id());
//		}
//	}

}
