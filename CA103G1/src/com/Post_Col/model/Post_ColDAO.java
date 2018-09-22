package com.Post_Col.model;

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

public class Post_ColDAO implements Post_ColDAO_interface{
	
	 private static DataSource ds = null;
	 static {
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}

	private static final String INSERT_STMT = "INSERT INTO POST_COL(POST_ID,MEM_ID,POST_COLSTATUS)values(?,?,?)";
	private static final String UPDATE_STMT = "UPDATE POST_COL SET POST_COLSTATUS = ? WHERE POST_ID = ? AND MEM_ID=?";
	private static final String DELETE_STMT = "DELETE FROM POST_COL WHERE POST_ID = ? AND MEM_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM POST_COL WHERE POST_ID = ? AND MEM_ID = ?";
	private static final String GET_ALL = "SELECT * FROM POST_COL";
	
	
	@Override
	public void add(Post_ColVO post_colVO) {
		Connection con = null;
		PreparedStatement pstmt = null; 
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,post_colVO.getPost_id());
			pstmt.setString(2,post_colVO.getMem_id());
			pstmt.setString(3,post_colVO.getPost_colStatus());
			
			pstmt.executeUpdate();
			
	
		}
//		catch (IOException ie) {
//			System.out.println(ie);} 
		
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
	public void update(Post_ColVO post_colVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1,post_colVO.getPost_colStatus());
			pstmt.setString(2,post_colVO.getPost_id());
			pstmt.setString(3,post_colVO.getMem_id());
			 
			 
			
			pstmt.executeUpdate();
		
		}
//		catch (IOException ie) {
//			System.out.println(ie);} 
		
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
	public void delete(String post_id,String mem_id) { 
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1,post_id);	
			pstmt.setString(2,mem_id);
			pstmt.executeUpdate();
	
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
	public Post_ColVO findByPK(String post_id,String mem_id) {
		Post_ColVO post_colVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, post_id);
			pstmt.setString(2, mem_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				post_colVO = new Post_ColVO();
				post_colVO.setPost_id(rs.getString("POST_ID"));
				post_colVO.setMem_id(rs.getString("MEM_ID"));
				post_colVO.setPost_colStatus(rs.getString("POST_COLSTATUS"));
			
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

		return post_colVO;
}

	@Override
	public List<Post_ColVO> getAll() {
		List<Post_ColVO> post_colList = new ArrayList<>();
		Post_ColVO post_colVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				post_colVO = new Post_ColVO();
				post_colVO.setPost_id(rs.getString("POST_ID"));
				post_colVO.setMem_id(rs.getString("MEM_ID"));
				post_colVO.setPost_colStatus(rs.getString("POST_COLSTATUS"));
				post_colList.add(post_colVO);
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
		return post_colList;
		
	}

	
		
}

