package com.mem.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;



public class MemJDBCDAO implements MemDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"Insert into MEM (MEM_ID ,MEM_ACCOUNT,MEM_NAME,MEM_PASSWARD,MEM_BIRTH,MEM_PHOTO,MEM_MAIL,MEM_STATUS,MEM_LIKE_TYPE,MEM_INTRO,CREATE_TIME)"+
		" values ('M'||LPAD(to_char(mem_seq.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,sysdate)";
	private static final String GET_ALL_STMT = 
		"SELECT MEM_ID ,MEM_ACCOUNT,MEM_NAME,MEM_PASSWARD,to_char(MEM_BIRTH,'yyyy-mm-dd') MEM_BIRTH,MEM_PHOTO,MEM_MAIL,MEM_STATUS,MEM_LIKE_TYPE,"+
		"MEM_INTRO,to_char(CREATE_TIME,'yyyy-mm-dd') CREATE_TIME FROM MEM order by MEM_ID";
	private static final String GET_ONE_STMT = 
		"SELECT MEM_ID ,MEM_ACCOUNT,MEM_NAME,MEM_PASSWARD,to_char(MEM_BIRTH,'yyyy-mm-dd') MEM_BIRTH,MEM_PHOTO,MEM_MAIL,MEM_STATUS,MEM_LIKE_TYPE,"+
		"MEM_INTRO,to_char(CREATE_TIME,'yyyy-mm-dd') CREATE_TIME FROM MEM WHERE MEM_ID= ?";
		
	private static final String DELETE = 
		"DELETE FROM MEM where MEM_ID = ?";
	private static final String UPDATE = 
		"UPDATE MEM set MEM_ACCOUNT=?, MEM_NAME=?, MEM_PASSWARD=?, MEM_BIRTH=?, MEM_PHOTO=?, MEM_MAIL=?,MEM_STATUS=?, MEM_LIKE_TYPE=?  where MEM_ID = ?";

	@Override
	public void insert(MemVO memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, memVO.getMem_account());
			pstmt.setString(2, memVO.getMem_name());
			pstmt.setString(3, memVO.getMem_passward());
			pstmt.setDate(4, memVO.getMem_birth());
			pstmt.setBytes(5, memVO.getMem_photo());
			pstmt.setString(6,memVO.getMem_mail());
			pstmt.setString(7,memVO.getMem_status());
			pstmt.setInt(8,memVO.getMem_like_type());
			pstmt.setString(9, memVO.getMem_intro());
			

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String mem_id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemVO findByPrimaryKey(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	public static void main(String[] args) {

		MemJDBCDAO dao = new MemJDBCDAO();

		// 新增
		MemVO memVO1 = new MemVO();
		memVO1.setMem_account("tombear");
		memVO1.setMem_name("湯姆熊");
		memVO1.setMem_passward("111");
		memVO1.setMem_birth(java.sql.Date.valueOf("1999-09-21"));
		File file=new File("C:\\CA103_WebApp\\apache-tomcat-9.0.8\\webapps\\ROOT\\tomcat.gif");
		byte[] pic=null;
		try{
			FileInputStream fi =new FileInputStream(file);
			ByteArrayOutputStream baos=new ByteArrayOutputStream();
			byte[] buffer=new byte[fi.available()];
			fi.read(buffer);
			baos.write(buffer);
			pic=baos.toByteArray();
			memVO1.setMem_photo(pic);
			baos.close();
			fi.close();
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		memVO1.setMem_mail("ccc@123");
		memVO1.setMem_status("M0");
		memVO1.setMem_like_type(new Integer(1));
		memVO1.setMem_intro("你好! 我是湯姆狗'");
	
		dao.insert(memVO1);
	}	

}
