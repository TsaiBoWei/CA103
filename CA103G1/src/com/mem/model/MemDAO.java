package com.mem.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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

public class MemDAO implements MemDAO_interface{
	
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
			"INSERT INTO MEM (MEM_ID,  MEM_NAME, MEM_ACCOUNT,MEM_PASSWORD, MEM_BIRTH, MEM_PHOTO ,MEM_EMAIL, MEM_STATUS, MEM_INTRO) VALUES ('M'||LPAD(to_char(mem_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, ?, 'MS0', ?)";
	private static final String UPDATE = 
			"UPDATE MEM SET MEM_NAME = ?,MEM_ACCOUNT = ? , MEM_PASSWORD = ?, MEM_BIRTH = ?, MEM_PHOTO = ?, MEM_EMAIL = ?, MEM_INTRO = ? WHERE MEM_ID = ?";
	private static final String UPDATE_STATUS = 
			"UPDATE MEM SET MEM_STATUS = ? WHERE MEM_ID = ?";
	private static final String DELETE = 
			"DELETE FROM MEM WHERE MEM_ID = ?";
	private static final String GET_ONE_STMT = 
			"SELECT MEM_ID, MEM_NAME, MEM_ACCOUNT,  MEM_PASSWORD, TO_CHAR(MEM_BIRTH, 'yyyy-mm-dd') MEM_BIRTH, MEM_PHOTO, MEM_EMAIL, MEM_STATUS, MEM_INTRO FROM MEM WHERE MEM_ID = ?";
	private static final String GET_ALL_STMT = 
			"SELECT MEM_ID, MEM_NAME, MEM_ACCOUNT,  MEM_PASSWORD, TO_CHAR(MEM_BIRTH, 'yyyy-mm-dd') MEM_BIRTH, MEM_PHOTO, MEM_EMAIL, MEM_STATUS, MEM_INTRO FROM MEM ORDER BY MEM_ID";
	
	
	@Override
	public void insert(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, memVO.getMem_name());
			pstmt.setString(2, memVO.getMem_account());
			pstmt.setString(3, memVO.getMem_password());
			pstmt.setDate(4, memVO.getMem_birth());
			pstmt.setBytes(5, memVO.getMem_photo());
			pstmt.setString(6, memVO.getMem_email());
			pstmt.setString(7, memVO.getMem_intro());
			
			pstmt.executeUpdate();
			
	
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
	public void update(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			
			pstmt.setString(1, memVO.getMem_name());
			pstmt.setString(2, memVO.getMem_account());
			pstmt.setString(3, memVO.getMem_password());
			pstmt.setDate(4, memVO.getMem_birth());
			pstmt.setBytes(5, memVO.getMem_photo());
			pstmt.setString(6, memVO.getMem_email());
			pstmt.setString(7, memVO.getMem_intro());
			pstmt.setString(8,memVO.getMem_id());
			
			
			pstmt.executeUpdate();
			
		
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
	public void updateStatus(String mem_id, String mem_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
				
			pstmt.setString(1, mem_status);
			pstmt.setString(2, mem_id);			
			pstmt.executeUpdate();
			
		
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
	public void delete(String mem_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, mem_id);
			
			pstmt.executeUpdate();
			
		
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
	public MemVO findByPrimaryKey(String mem_id) {
		
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, mem_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// memVo 也稱為 Domain objects
				memVO = new MemVO();
				memVO.setMem_id(rs.getString("mem_id"));
				memVO.setMem_name(rs.getString("mem_name"));
				memVO.setMem_account(rs.getString("mem_account"));
				memVO.setMem_password(rs.getString("mem_password"));
				memVO.setMem_birth(rs.getDate("mem_birth"));
				memVO.setMem_photo(rs.getBytes("mem_photo"));
				memVO.setMem_email(rs.getString("mem_email"));
				memVO.setMem_status(rs.getString("mem_status"));
				memVO.setMem_intro(rs.getString("mem_intro"));
			}

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
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// memVO 也稱為 Domain objects
				memVO = new MemVO();
				memVO.setMem_id(rs.getString("mem_id"));
				memVO.setMem_name(rs.getString("mem_name"));
				memVO.setMem_account(rs.getString("mem_account"));
				memVO.setMem_password(rs.getString("mem_password"));
				memVO.setMem_birth(rs.getDate("mem_birth"));
				memVO.setMem_photo(rs.getBytes("mem_photo"));
				memVO.setMem_email(rs.getString("mem_email"));
				memVO.setMem_status(rs.getString("mem_status"));
				memVO.setMem_intro(rs.getString("mem_intro"));
				list.add(memVO);
				
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
	
}
