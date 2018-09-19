package com.member.model;

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
			
			pstmt.setString(1, memVO.getMemAcccount());
			pstmt.setString(2, memVO.getMemName());
			pstmt.setString(3, memVO.getMemPsw());
			pstmt.setDate(4, memVO.getMemBirDay());
			pstmt.setBytes(5, memVO.getMemPhoto());
			pstmt.setString(6, memVO.getMemMail());
			pstmt.setString(7, memVO.getMemStatus());
			pstmt.setString(8, memVO.getMemIntro());
			
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
 	public void update(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
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
	
	public static void main(String[] args) throws IOException {
		MemJDBCDAO dao = new MemJDBCDAO();
		
		//新增
//		byte[] pic =  getPictureByteArray("WebContent/Front-end/Mem_Login_Signup/items/Monet.jpg");
//		MemVO memVO = new MemVO();
//		memVO.setMemAcccount("GILL");
//		memVO.setMemName("Gill");
//		memVO.setMemPsw("GILL0825");
//		memVO.setMemBirDay(java.sql.Date.valueOf("1988-6-20"));
//		memVO.setMemPhoto(pic);
//		memVO.setMemMail("gill@mset.com.tw");
//		memVO.setMemStatus("MS0");
//		memVO.setMemIntro("我是吉兒");
//		dao.insert(memVO);
		
		//修改
//		MemVO memVO2 = new MemVO();
//		memVO2.setMemID("M000002");
//		memVO2.setMemAcccount("abc");
//		memVO2.setMemName("abc");
//		memVO2.setMemPsw("abc");
//		memVO2.setMemBirDay(java.sql.Date.valueOf("2018-9-8"));
//		memVO2.setMemPhoto(null);
//		memVO2.setMemMail("abc");
//		memVO2.setMemIntro("abc");
//		dao.update(memVO2);
		
		//查詢
//		MemVO memVO3 = dao.findByPrimaryKey("M000005");
//		System.out.print(memVO3.getMemID() + ",");
//		System.out.print(memVO3.getMemAcccount() + ",");
//		System.out.print(memVO3.getMemName() + ",");
//		System.out.print(memVO3.getMemPsw() + ",");
//		System.out.print(memVO3.getMemBirDay()+ ",");
//		System.out.print(memVO3.getMemPhoto()+ ",");
//		System.out.print(memVO3.getMemMail()+",");
//		System.out.print(memVO3.getMemStatus()+",");
//		System.out.println(memVO3.getMemIntro());	
//		System.out.println("---------------------");
		
		//修改狀態
		MemVO memVO4 = new MemVO();
		memVO4.setMemID("M000002");
		memVO4.setMemStatus("MS1");
		dao.updateStatus(memVO4.getMemID(), memVO4.getMemStatus());
		
		//查詢ALL
//		List<MemVO> list =dao.getAll();
//		for(MemVO aMem : list) {
//		System.out.print(aMem.getMemID() + ",");
//		System.out.print(aMem.getMemAcccount() + ",");
//		System.out.print(aMem.getMemName() + ",");
//		System.out.print(aMem.getMemPsw() + ",");
//		System.out.print(aMem.getMemBirDay()+ ",");
//		System.out.print(aMem.getMemPhoto()+ ",");
//		System.out.print(aMem.getMemMail()+",");
//		System.out.print(aMem.getMemStatus()+",");
//		System.out.println(aMem.getMemIntro());	
//		System.out.println("---------------------");
//		}
		
		
		//刪除
//		dao.delete("M000011");
		
	}

}
