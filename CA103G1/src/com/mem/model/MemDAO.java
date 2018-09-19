package com.mem.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
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

public class MemDAO implements MemDAO_interface{
	
	private static final String INSERT_mem = 
			"INSERT INTO MEM (MEM_ID, MEM_ACCOUNT, MEM_NAME, MEM_PASSWORD, MEM_BIRTH,MEM_PHOTO ,MEM_MAIL, MEM_STATUS, MEM_INTRO) VALUES ('M'||LPAD(to_char(mem_seq.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?)";
	
	private static final String GET_ONE_mem = 
			"SELECT MEM_ID,MEM_ACCOUNT,MEM_NAME,MEM_PASSWORD,to_char(MEM_BIRTH,'yyyy-mm-dd') MEM_BIRTH,MEM_PHOTO,MEM_MAIL,MEM_STATUS,MEM_INTRO FROM MEM where MEM_ID = ?";
	
	private static final String UPDATE_mem = 
			"UPDATE MEM set MEM_ACCOUNT=?, MEM_NAME=?, MEM_PASSWORD=?, MEM_BIRTH=?, MEM_PHOTO=?, MEM_MAIL=?, MEM_INTRO=? where MEM_ID=?";
	
	private static final String GET_ALL_mem = 
			"SELECT MEM_ID,MEM_ACCOUNT,MEM_NAME,MEM_PASSWORD,to_char(MEM_BIRTH,'yyyy-mm-dd') MEM_BIRTH,MEM_PHOTO,MEM_MAIL,MEM_STATUS,MEM_INTRO FROM MEM order by MEM_ID";
	
	private static final String DELETE_mem = 
			"DELETE FROM MEM WHERE MEM_ID=?";
	
	private static final String UPDATE_STATUS = 
			"UPDATE MEM set MEM_STATUS=? where MEM_ID=?";
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public static byte[] getPictureByteArray(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = fis.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();

		return baos.toByteArray();
	}
	
	@Override
	public void insert(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_mem);
			
			pstmt.setString(1, memVO.getMemAcccount());
			pstmt.setString(2, memVO.getMemName());
			pstmt.setString(3, memVO.getMemPsw());
			pstmt.setDate(4, memVO.getMemBirDay());
			pstmt.setBytes(5, memVO.getMemPhoto());
			pstmt.setString(6, memVO.getMemMail());
			pstmt.setString(7, memVO.getMemStatus());
			pstmt.setString(8, memVO.getMemIntro());
			
			pstmt.executeUpdate();
			
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured."+ se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					 pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					 con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	
	@Override
 	public void update(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_mem);
			
			pstmt.setString(1, memVO.getMemAcccount());
			pstmt.setString(2, memVO.getMemName());
			pstmt.setString(3, memVO.getMemPsw());
			pstmt.setDate(4, memVO.getMemBirDay());
			pstmt.setBytes(5, memVO.getMemPhoto());
			pstmt.setString(6, memVO.getMemMail());
			
			pstmt.setString(7, memVO.getMemIntro());
			pstmt.setString(8, memVO.getMemID());
			
			pstmt.executeUpdate();
			

		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured."+ se.getMessage());
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
	public void updateStatus(String memID, String status) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, status);
			pstmt.setString(2, memID);
	
			pstmt.executeUpdate();
			

		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured."+ se.getMessage());
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
	public MemVO findByPrimaryKey(String memID) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_mem);
			
			pstmt.setString(1, memID);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				memVO = new MemVO();
				memVO.setMemID(rs.getString("MEM_ID"));
				memVO.setMemAcccount(rs.getString("MEM_ACCOUNT"));
				memVO.setMemName(rs.getString("MEM_NAME"));
				memVO.setMemPsw(rs.getString("MEM_PASSWORD"));
				memVO.setMemBirDay(rs.getDate("MEM_BIRTH"));
				memVO.setMemPhoto(rs.getBytes("MEM_PHOTO"));
				memVO.setMemMail(rs.getString("MEM_MAIL"));
				memVO.setMemStatus(rs.getString("MEM_STATUS"));
				memVO.setMemIntro(rs.getString("MEM_INTRO"));
			}
			

		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured."+ se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se){
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
		return memVO;
	}

	@Override
	public List<MemVO> getAll() {
		List<MemVO> list = new ArrayList<MemVO>();
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_mem);
			

			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				memVO = new MemVO();
				memVO.setMemID(rs.getString("MEM_ID"));
				memVO.setMemAcccount(rs.getString("MEM_ACCOUNT"));
				memVO.setMemName(rs.getString("MEM_NAME"));
				memVO.setMemPsw(rs.getString("MEM_PASSWORD"));
				memVO.setMemBirDay(rs.getDate("MEM_BIRTH"));
				memVO.setMemPhoto(rs.getBytes("MEM_PHOTO"));
				memVO.setMemMail(rs.getString("MEM_MAIL"));
				memVO.setMemStatus(rs.getString("MEM_STATUS"));
				memVO.setMemIntro(rs.getString("MEM_INTRO"));
				list.add(memVO);
			}
			
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured."+ se.getMessage());
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se){
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
	
	public void delete(String memID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_mem);
			
			pstmt.setString(1, memID);
			
			pstmt.executeUpdate();
			

		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured."+ se.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					 pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					 con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	
}
