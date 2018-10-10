package com.Post.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Post.model.PostVO;

public class PostDAOJDBC implements PostDAO_interface {
	
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA103_G1";
	private static final String PASSWORD = "123456";

	private static final String INSERT_STMT = "INSERT INTO POST(POST_ID,MEM_ID,POST_CON,POST_TIME,POST_VIEW,SPTYPE_ID,POST_STATUS)values(to_char(sysdate,'yyyymmdd')||'-'||'PO'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'),?,?,?,?,?,'POS0')";
	private static final String UPDATE_STMT = "UPDATE POST SET MEM_ID = ?, POST_CON = ?, POST_TIME = ?,POST_VIEW = ?,SPTYPE_ID = ?,POST_STATUS = ? WHERE POST_ID = ?";
	private static final String DELETE_STMT = "DELETE FROM POST WHERE POST_ID = ?";
	private static final String FIND_BY_PK = "SELECT * FROM POST WHERE POST_ID = ?";
//	private static final String FIND_BY_PK = "SELECT POST_ID,MEM_ID,POST_CON,to_char(Post_Time,'YYYY-MM-DD'),POST_VIEW,SPTYPE_ID,POST_STATUS FROM POST WHERE POST_ID = ?";
	private static final String GET_ALL = "SELECT * FROM POST";

	private static final String FIND_BY_MEM_ID=
	"SELECT * FROM POST WHERE MEM_ID = ?";
	
	/*********************  首頁用 *****************/
	private static final String GET_NEW_POST="select * from" + 
			"(select post_id,mem_id,post_title,post_view,sptype_id from post where  POST_STATUS = 'POS0' order by post_id desc)" + 
			"where rownum < 7";
	private static final String GET_POPULAR_POST="select * from" + 
			"(select post_id,mem_id,post_title,post_view,sptype_id from post where  POST_STATUS = 'POS0'  order by post_view desc)" + 
			"where rownum < 7";
	/*************************************************/
	
	@Override
	public void add(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			

			pstmt.setString(1,postVO.getMem_id());
			pstmt.setString(2,postVO.getPost_con());
			pstmt.setTimestamp(3,postVO.getPost_time());
			pstmt.setInt(4,postVO.getPost_view());
			pstmt.setString(5,postVO.getSptype_id());
		 
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public void update(PostVO postVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_STMT);
			

			pstmt.setString(1,postVO.getMem_id());
			pstmt.setString(2,postVO.getPost_con());
			pstmt.setTimestamp(3,postVO.getPost_time());
			pstmt.setInt(4,postVO.getPost_view());
			pstmt.setString(5,postVO.getSptype_id());
			pstmt.setString(6,postVO.getPost_status()); 
			pstmt.setString(7,postVO.getPost_id()); 
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
				Class.forName(DRIVER);
				con = DriverManager.getConnection(URL, USER, PASSWORD);
				pstmt = con.prepareStatement(DELETE_STMT);
				
				
				pstmt.setString(1,post_id);	
				pstmt.executeUpdate();
				
			}catch(ClassNotFoundException e){
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
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

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
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

		return postVO;
		
	}

	@Override
	public List<PostVO> getAll() {
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
				postList.add(postVO);
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
		return postList;
	}

	@Override
	public List<PostVO> getByMemID( String mem_id ){
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
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
				postList.add(postVO);
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
		return postList;
	}
	
	@Override
	public void updateStatus(PostVO postVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<PostVO> getByMemIDToDisplay(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PostVO findByPKToDisplay(String post_id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	/*********************  首頁用 *****************/
	@Override
    public List<PostVO> getNewPost(){
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_NEW_POST);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				postVO = new PostVO();
				postVO.setPost_id(rs.getString("POST_ID"));
				postVO.setMem_id(rs.getString("MEM_ID"));
				postVO.setPost_view(rs.getInt("POST_VIEW"));
				postVO.setSptype_id(rs.getString("SPTYPE_ID"));
				postVO.setPost_title(rs.getString("POST_TITLE"));
				postList.add(postVO);
			}

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return postList;
		
	};
	@Override
    public List<PostVO> getPopularPost(){
		List<PostVO> postList = new ArrayList<>();
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_POPULAR_POST);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				postVO = new PostVO();
				postVO.setPost_id(rs.getString("POST_ID"));
				postVO.setMem_id(rs.getString("MEM_ID"));
				postVO.setPost_view(rs.getInt("POST_VIEW"));
				postVO.setSptype_id(rs.getString("SPTYPE_ID"));
				postVO.setPost_title(rs.getString("POST_TITLE"));
				postList.add(postVO);
			}

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return postList;
    
    }

	
	
	/*********************  首頁用 *****************/
	
	
	
	/**********************update view****************/
	@Override
	public void updateView(PostVO postVO) {
		// TODO Auto-generated method stub
		
	}

	
	
}
