package com.Post.model;

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

public class PostDAO implements PostDAO_interface{
	
	 private static DataSource ds = null;
	 static {
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
	

	private static final String INSERT_STMT = "INSERT INTO POST(POST_ID,MEM_ID,POST_CON,POST_TIME,POST_VIEW,SPTYPE_ID,POST_STATUS,POST_TITLE,POST_PRIVACY)values(to_char(sysdate,'yyyymmdd')||'-'||'PO'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'),?,?,?,?,?,'POS0',?,?)";
	private static final String UPDATE_STMT = "UPDATE POST SET MEM_ID = ?, POST_CON = ?, POST_TIME = ?,POST_VIEW = ?,SPTYPE_ID = ?,POST_STATUS = ?,POST_TITLE = ?,POST_PRIVACY=? WHERE POST_ID = ?";
	private static final String DELETE_STMT = "DELETE FROM POST WHERE POST_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM POST WHERE POST_ID = ?";
//	private static final String FIND_BY_PK = "SELECT POST_ID,MEM_ID,POST_CON,to_char(Post_Time,'YYYY-MM-DD'),POST_VIEW,SPTYPE_ID,POST_STATUS FROM POST WHERE POST_ID = ?";
	private static final String GET_ALL = "SELECT * FROM POST";
	//改變貼文狀態碼
	private static final String UPDATE_POST_STATUS = "UPDATE POST SET POST_STATUS = ? WHERE POST_ID = ?";

	private static final String FIND_BY_MEM_ID=	"SELECT * FROM POST WHERE MEM_ID = ?";
	//顯示會員單一貼文(未被封禁或刪除)
	private static final String FIND_BY_MEM_ID_TO_DISPLAY= "SELECT POST_ID,MEM_ID, POST_CON, POST_TIME,POST_VIEW,SPTYPE_ID,POST_STATUS,POST_TITLE,POST_PRIVACY FROM POST WHERE MEM_ID = ? AND POST_STATUS = 'POS0'";
	@Override
	public void add(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,postVO.getMem_id());
			pstmt.setString(2,postVO.getPost_con());
			pstmt.setTimestamp(3,postVO.getPost_time());
			pstmt.setInt(4,postVO.getPost_view());
			pstmt.setString(5,postVO.getSptype_id());		
			pstmt.setString(6,postVO.getPost_title());
			pstmt.setString(7, postVO.getPost_privacy());
			pstmt.executeUpdate();
		
//		catch (IOException ie) {
//			System.out.println(ie);} 
		
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
	public void update(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			

			pstmt.setString(1,postVO.getMem_id());
			pstmt.setString(2,postVO.getPost_con());
			pstmt.setTimestamp(3,postVO.getPost_time());
			pstmt.setInt(4,postVO.getPost_view());
			pstmt.setString(5,postVO.getSptype_id());
			pstmt.setString(6, postVO.getPost_status());
			pstmt.setString(7,postVO.getPost_title());
			pstmt.setString(8, postVO.getPost_privacy());
			pstmt.setString(9,postVO.getPost_id());
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
	public void delete(String post_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE_STMT);
				
				
				pstmt.setString(1,post_id);	
				pstmt.executeUpdate();
				
			
			}
//			catch (IOException ie) {
//				System.out.println(ie);} 
			
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
	public PostVO findByPK(String post_id) {
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, post_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				postVO = new PostVO();
				postVO.setPost_id(rs.getString("POST_ID"));
				postVO.setMem_id(rs.getString("MEM_ID"));
				postVO.setPost_con(rs.getString("POST_CON"));
				postVO.setPost_time(rs.getTimestamp("POST_TIME"));
				postVO.setPost_view(rs.getInt("POST_VIEW"));
				postVO.setSptype_id(rs.getString("SPTYPE_ID"));
				postVO.setPost_status(rs.getString("POST_STATUS"));
				postVO.setPost_title(rs.getString("POST_TITLE"));
				postVO.setPost_privacy(rs.getString("POST_PRIVACY"));
			}

		
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

		return postVO;
		
	}

	public List<PostVO> getByMemID( String mem_id ){
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MEM_ID);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				postVO = new PostVO();
				postVO.setPost_id(rs.getString("POST_ID"));
				postVO.setMem_id(rs.getString("MEM_ID"));
				postVO.setPost_con(rs.getString("POST_CON"));
				postVO.setPost_time(rs.getTimestamp("POST_TIME"));
				postVO.setPost_view(rs.getInt("POST_VIEW"));
				postVO.setSptype_id(rs.getString("SPTYPE_ID"));
				postVO.setPost_status(rs.getString("POST_STATUS"));
				postVO.setPost_title(rs.getString("POST_TITLE"));
				postVO.setPost_privacy(rs.getString("POST_PRIVACY"));
				postList.add(postVO);
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
		return postList;
	}
	
	@Override
	public List<PostVO> getAll() {
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				postVO = new PostVO();
				postVO.setPost_id(rs.getString("POST_ID"));
				postVO.setMem_id(rs.getString("MEM_ID"));
				postVO.setPost_con(rs.getString("POST_CON"));
				postVO.setPost_time(rs.getTimestamp("POST_TIME"));
				postVO.setPost_view(rs.getInt("POST_VIEW"));
				postVO.setSptype_id(rs.getString("SPTYPE_ID"));
				postVO.setPost_status(rs.getString("POST_STATUS"));
				postVO.setPost_title(rs.getString("POST_TITLE"));
				postVO.setPost_privacy(rs.getString("POST_PRIVACY"));
				postList.add(postVO);
			}

	
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
		return postList;
	}

	@Override
	public void updateStatus(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_POST_STATUS);
				
				pstmt.setString(1,postVO.getPost_status()); 
				pstmt.setString(2,postVO.getPost_id()); 	
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
	
	
	public List<PostVO> getByMemIDToDisplay(String mem_id) {
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MEM_ID_TO_DISPLAY);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				postVO = new PostVO();
				postVO.setPost_id(rs.getString("POST_ID"));
				postVO.setMem_id(rs.getString("MEM_ID"));
				postVO.setPost_con(rs.getString("POST_CON"));
				postVO.setPost_time(rs.getTimestamp("POST_TIME"));
				postVO.setPost_view(rs.getInt("POST_VIEW"));
				postVO.setSptype_id(rs.getString("SPTYPE_ID"));
				postVO.setPost_status(rs.getString("POST_STATUS"));
				postVO.setPost_title(rs.getString("POST_TITLE"));
				postVO.setPost_privacy(rs.getString("POST_PRIVACY"));
				postList.add(postVO);
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
		return postList;
	}
	
	
	}


