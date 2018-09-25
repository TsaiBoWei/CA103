package com.mem.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.*;


public class MemJDBCDAO implements MemDAO_interface{
	
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String userId = "CA103";
	private static final String psw = "123456";
	
	private static final String INSERT_mem = 
			"INSERT INTO MEM (MEM_ID, MEM_ACCOUNT, MEM_NAME, MEM_PASSWORD, MEM_BIRTH,MEM_PHOTO ,MEM_EMAIL, MEM_STATUS, MEM_INTRO) VALUES ('M'||LPAD(to_char(mem_seq.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?)";
	
	private static final String GET_ONE_mem = 
			"SELECT MEM_ID,MEM_ACCOUNT,MEM_NAME,MEM_PASSWORD,to_char(MEM_BIRTH,'yyyy-mm-dd') MEM_BIRTH,MEM_PHOTO,MEM_EMAIL,MEM_STATUS,MEM_INTRO FROM MEM where MEM_ID = ?";
	
	private static final String UPDATE_mem = 
			"UPDATE MEM set MEM_ACCOUNT=?, MEM_NAME=?, MEM_PASSWORD=?, MEM_BIRTH=?, MEM_PHOTO=?, MEM_EMAIL=?, MEM_INTRO=? where MEM_ID=?";
	
	private static final String GET_ALL_mem = 
			"SELECT MEM_ID,MEM_ACCOUNT,MEM_NAME,MEM_PASSWORD,to_char(MEM_BIRTH,'yyyy-mm-dd') MEM_BIRTH,MEM_PHOTO,MEM_EMAIL,MEM_STATUS,MEM_INTRO FROM MEM order by MEM_ID";
	
	private static final String DELETE_mem = 
			"DELETE FROM MEM WHERE MEM_ID=?";
	
	private static final String UPDATE_STATUS = 
			"UPDATE MEM set MEM_STATUS=? where MEM_ID=?";
	//Web
	private static final String MEMBER_LOGINT = 
			"SELECT * FROM MEM WHERE MEM_ACCOUNT=? AND MEM_PASSWORD=?";
	
	//Android
	private static final String GET_ONE_BY_ACCOUNT_AND_PASSWORD=
			"SELECT * FROM MEM WHERE MEM_ACCOUNT=? AND MEM_PASSWORD=?";

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
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(INSERT_mem);
			
			pstmt.setString(1, memVO.getMem_account());
			pstmt.setString(2, memVO.getMem_name());			
			pstmt.setString(3, memVO.getMem_password());
			pstmt.setDate(4, new java.sql.Date(memVO.getMem_birth().getTime()));
			pstmt.setBytes(5, memVO.getMem_photo());
			pstmt.setString(6, memVO.getMem_email());
			pstmt.setString(7, memVO.getMem_status());
			pstmt.setString(8, memVO.getMem_intro());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A DB error occured.");
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
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(UPDATE_mem);
			
			
			
			pstmt.setString(2, memVO.getMem_account());
			pstmt.setString(1, memVO.getMem_name());
			pstmt.setString(3, memVO.getMem_password());
			pstmt.setDate(4, new java.sql.Date(memVO.getMem_birth().getTime()));
			pstmt.setBytes(5, memVO.getMem_photo());
			pstmt.setString(6, memVO.getMem_email());
			pstmt.setString(7, memVO.getMem_intro());
			pstmt.setString(8,memVO.getMem_id());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
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
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, status);
			pstmt.setString(2, memID);
	
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
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
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(GET_ONE_mem);
			
			pstmt.setString(1, memID);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				memVO = new MemVO();
				
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
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
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
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(GET_ALL_mem);
			

			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
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
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
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
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(DELETE_mem);
			
			pstmt.setString(1, memID);
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
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
	public MemVO findByAccountAndPassword(String memAccount, String memPassword) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId, psw);
			pstmt = con.prepareStatement(GET_ONE_BY_ACCOUNT_AND_PASSWORD);
			pstmt.setString(1, memAccount);
			pstmt.setString(2, memPassword);
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				memVO = new MemVO();				
				memVO.setMem_id(rs.getString("mem_id"));
				memVO.setMem_name(rs.getString("mem_name"));
				memVO.setMem_account(rs.getString("mem_account"));
				memVO.setMem_password(rs.getString("mem_password"));
				// GSON無法解析SQL_DATE格式				
				memVO.setMem_birth( rs.getDate("mem_birth"));
				memVO.setMem_photo(rs.getBytes("mem_photo"));
				memVO.setMem_email(rs.getString("mem_email"));
				memVO.setMem_status(rs.getString("mem_status"));
				memVO.setMem_intro(rs.getString("mem_intro"));
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
		return memVO;
	}
	@Override
	public MemVO logIn(String mem_account, String mem_password) {
		MemVO memVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(MEMBER_LOGINT);
			
			pstmt.setString(1, mem_account);
			pstmt.setString(2, mem_password);			
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
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
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A DB error occured.");
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
		return memVO;
	}
	
	public static void main(String[] args) {
		MemJDBCDAO dao = new MemJDBCDAO();
		
		//新增
//		MemVO memVO1 = new MemVO();
//		memVO1.setMem_name("Java班6號");
//		memVO1.setMem_account("CA10306");
//		memVO1.setMem_password("123456");
//		memVO1.setMem_birth(Date.valueOf("1970-01-06"));
//		memVO1.setMem_photo(null);
//		memVO1.setMem_email("CA10306@gmail.com");
//		memVO1.setMem_intro("大家好，我是CA103的6號");
//		memVO1.setMem_status("MS0");
//		dao.insert(memVO1);
		
		
		//修改
//		MemVO memVO2 = new MemVO();
//		memVO2.setMem_id("M000007");
//		memVO2.setMem_name("Java班8號");
//		memVO2.setMem_account("CA10306");
//		memVO2.setMem_password("123456");
//		memVO2.setMem_birth(Date.valueOf("1970-01-06"));
//		memVO2.setMem_photo(null);
//		memVO2.setMem_email("CA10306@gmail.com");
//		memVO2.setMem_intro("大家好，我是CA103的6號");
//		dao.update(memVO2);
//		System.out.println("資料庫修改成功");
//		
		
		//刪除
//		dao.delete("M000006");
//		System.out.println("資料庫刪除成功");
		
		//查詢
//		MemVO memVO3 = dao.findByPrimaryKey("M000004");
//		System.out.print(memVO3.getMem_id());
//		System.out.print(memVO3.getMem_name() + ",");
//		System.out.print(memVO3.getMem_account()+ ",");
//		System.out.print(memVO3.getMem_password() + ",");
//		System.out.print(memVO3.getMem_birth() + ",");
//		System.out.print(memVO3.getMem_photo() + ",");
//		System.out.print(memVO3.getMem_email() + ",");
//		System.out.print(memVO3.getMem_status() + ",");
//		System.out.println(memVO3.getMem_intro());
//		System.out.println("---------------------");
		
		//查詢
//		List<MemVO> list = dao.getAll();
//		for (MemVO aMem : list) {
//			System.out.print(aMem.getMem_id() + ",");
//			System.out.print(aMem.getMem_name()+ ",");
//			System.out.print(aMem.getMem_account() + ",");
//			System.out.print(aMem.getMem_password() + ",");
//			System.out.print(aMem.getMem_birth() + ",");
//			System.out.print(aMem.getMem_photo() + ",");
//			System.out.print(aMem.getMem_email() + ",");
//			System.out.print(aMem.getMem_status() + ",");
//			System.out.print(aMem.getMem_intro());
//			System.out.println();
//		}
		
//		dao.updateStatus("M000003", "MS1");
		
		//登入
		MemVO memVO3 = dao.logIn("CA10306@gmail.com", "1234567");
		System.out.print(memVO3.getMem_id()+", ");
		System.out.print(memVO3.getMem_name() + ", ");
		System.out.print(memVO3.getMem_account()+ ", ");
		System.out.print(memVO3.getMem_password() + ", ");
		System.out.print(memVO3.getMem_birth() + ", ");
		System.out.print(memVO3.getMem_photo() + ", ");
		System.out.print(memVO3.getMem_email() + ", ");
		System.out.print(memVO3.getMem_status() + ", ");
		System.out.println(memVO3.getMem_intro());
		System.out.println("---------------------");
		
//		MemVO memvo = dao.findByAccountAndPassword("CA10301", "123456");
//		if ( memvo != null )
//			System.out.println(memvo.getMem_account());
	}


}
