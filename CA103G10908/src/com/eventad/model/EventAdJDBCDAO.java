package com.eventad.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class EventAdJDBCDAO implements EventAdDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"Insert into EVENTAD(EAD_ID ,MEM_ID,EAD_PIC, EAD_STATUS )values ('EAD'||LPAD(to_char(eventad_seq.NEXTVAL), 6, '0'),?,?,?)";
	
	private static final String GET_ALL_STMT = 
		"SELECT EAD_ID ,MEM_ID,EAD_PIC, EAD_STATUS FROM EVENTAD order by EAD_ID";
	
	private static final String GET_ONE_STMT ="SELECT EAD_ID ,MEM_ID,EAD_PIC, EAD_STATUS FROM EVENTAD WHERE EAD_ID=?" ;
		
	private static final String UPDATE = 
		"UPDATE EVENTAD set MEM_ID=?,EAD_PIC=?,EAD_STATUS=?  where EAD_ID = ? ";

	@Override
	public void insert(EventAdVO eventAdVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,eventAdVO.getMem_id());
			pstmt.setBytes(2, eventAdVO.getEad_pic());
			pstmt.setString(3, eventAdVO.getEad_status());

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
	public void update(EventAdVO eventAdVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,eventAdVO.getMem_id());
			pstmt.setBytes(2, eventAdVO.getEad_pic());
			pstmt.setString(3, eventAdVO.getEad_status());
			pstmt.setString(4, eventAdVO.getEad_id());

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
	public EventAdVO findByPrimaryKey(String ead_id) {
		EventAdVO eventAdVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, ead_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventAdVO = new EventAdVO();
				eventAdVO.setEad_id(rs.getString("EAD_ID"));
				eventAdVO.setMem_id(rs.getString("MEM_ID"));
				eventAdVO.setEad_pic(rs.getBytes("EAD_PIC"));	
				eventAdVO.setEad_status(rs.getString("EAD_STATUS"));
				
			}

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
		return eventAdVO;
	}

	@Override
	public List<EventAdVO> getAll() {
		List<EventAdVO> list=new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {				
				EventAdVO eventAdVO = new EventAdVO();
				eventAdVO.setEad_id(rs.getString("EAD_ID"));
				eventAdVO.setMem_id(rs.getString("MEM_ID"));
				eventAdVO.setEad_pic(rs.getBytes("EAD_PIC"));	
				eventAdVO.setEad_status(rs.getString("EAD_STATUS"));
				list.add(eventAdVO);
				
			}

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
	
	public static void main(String args[]) {
		EventAdJDBCDAO dao=new EventAdJDBCDAO();
		//新增
//		EventAdVO eventAdVO1=new EventAdVO();
//		byte[] bannerpic=getPicBytes("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\run\\banner_maokong_run.jpg");
//		eventAdVO1.setEad_pic(bannerpic);
//		eventAdVO1.setMem_id("M000002");
//		eventAdVO1.setEad_status("EAD1");
//		dao.insert(eventAdVO1);
		//修改
//		EventAdVO eventAdVO2=new EventAdVO();
//		byte[] bannerpic2=getPicBytes("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\run\\banner_maokong_run.jpg");
//		eventAdVO2.setEad_pic(bannerpic2);
//		eventAdVO2.setMem_id("M000003");
//		eventAdVO2.setEad_status("EAD1");
//		eventAdVO2.setEad_id("EAD000001");
//		dao.update(eventAdVO2);
		
		//查一
//		EventAdVO eventAdVO3=dao.findByPrimaryKey("EAD000001");
//		System.out.println(eventAdVO3.getEad_id());
//		System.out.println(eventAdVO3.getEad_status());
//		System.out.println(eventAdVO3.getMem_id());
//		byte[] photo=eventAdVO3.getEad_pic();
//		readpic(photo,"C:\\Users\\user\\Desktop\\專題\\images\\eventad_photo1.jpg");
//		System.out.println("===============================");
		
		//查全部
		List<EventAdVO> list=dao.getAll();
		for(EventAdVO eventAdVO:list) {
			System.out.println(eventAdVO.getEad_id());
			System.out.println(eventAdVO.getEad_status());
			System.out.println(eventAdVO.getMem_id());
			byte[] photo1=eventAdVO.getEad_pic();
			readpic(photo1,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventAdVO.getEad_id()+".jpg");
			System.out.println("===============================");
			
		}
		
	}
	
	public  static byte[] getPicBytes(String filepath) {
		File file=new File(filepath);
		byte[] pic=null;
		FileInputStream fi=null;
		ByteArrayOutputStream baos=null;
		try{
			fi =new FileInputStream(file);
			baos=new ByteArrayOutputStream();
			byte[] buffer=new byte[fi.available()];
			fi.read(buffer);
			baos.write(buffer);
			pic=baos.toByteArray();
			
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			if(baos!=null) {
				try {
					baos.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(fi!=null) {
				try {
					fi.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
					
		}
		
		return pic;
	}
	public static void readpic(byte[] bytes,String filepath) {
		try{
			FileOutputStream fo=new FileOutputStream(new File(filepath));
			fo.write(bytes);
		
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}


}
