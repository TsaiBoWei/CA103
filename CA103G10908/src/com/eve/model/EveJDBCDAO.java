package com.eve.model;


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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class EveJDBCDAO implements EventDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"Insert into EVENT (EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_CONTENT,EVE_STARTDATE,EVE_ENDDATE,EREG_STARTDATE,EREG_ENDDATE,"+
		"ESTART_LIMIT,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE ) "+
		" values ('E'||LPAD(to_char(event_seq.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,CURRENT_TIMESTAMP)";
	private static final String GET_ALL_STMT = 
		"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
		"ESTART_LIMIT,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT order by EVE_ID";
	private static final String GET_ONE_STMT = 
		"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_CONTENT,EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
		"ESTART_LIMIT,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_ID= ?";		
	private static final String UPDATE = 
		"UPDATE EVENT set EVE_PHOTO=?,EVE_LOGO=?,EVE_CONTENT=?,EVE_STARTDATE=? ,EVE_ENDDATE =?,EREG_STARTDATE =?,EREG_ENDDATE=?," + 
		"ESTART_LIMIT=? ,EVE_STATUS=?,EVE_LOCATION=?,EVE_LONG=?,EVE_LAT=?,CITY_ID=?,SPTYPE_ID=?,EVE_VIEW=?,EVE_CHARGE=?,ECONTACT_INFO=?  where EVE_ID = ?";


	@Override
	public void insert(EventVO eventVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			
			pstmt.setString(1,eventVO.getMem_id());
			pstmt.setBytes(2,eventVO.getEve_photo());
			pstmt.setBytes(3,eventVO.getEve_logo());
			pstmt.setString(4,eventVO.getEve_content());
			pstmt.setTimestamp(5,eventVO.getEve_startdate());
			pstmt.setTimestamp(6,eventVO.getEve_enddate());
			pstmt.setDate(7,eventVO.getEreg_startdate());
			pstmt.setDate(8,eventVO.getEreg_enddate() );
			pstmt.setInt(9, eventVO.getEstart_limit());
			pstmt.setString(10, eventVO.getEve_status());
			pstmt.setString(11, eventVO.getEve_location());
			pstmt.setDouble(12, eventVO.getEve_long());
			pstmt.setDouble(13, eventVO.getEve_lat());
			pstmt.setString(14, eventVO.getCity_id());
			pstmt.setString(15,eventVO.getSptype_id());
			pstmt.setInt(16, eventVO.getEve_view());
			pstmt.setInt(17, eventVO.getEve_charge());
			pstmt.setString(18, eventVO.getEcontact_info());
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
	public void update(EventVO eventVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setBytes(1,eventVO.getEve_photo());
			pstmt.setBytes(2,eventVO.getEve_logo());
			pstmt.setString(3,eventVO.getEve_content());
			pstmt.setTimestamp(4,eventVO.getEve_startdate());
			pstmt.setTimestamp(5,eventVO.getEve_enddate());
			pstmt.setDate(6,eventVO.getEreg_startdate());
			pstmt.setDate(7,eventVO.getEreg_enddate() );
			pstmt.setInt(8, eventVO.getEstart_limit());
			pstmt.setString(9, eventVO.getEve_status());
			pstmt.setString(10, eventVO.getEve_location());
			pstmt.setDouble(11, eventVO.getEve_long());
			pstmt.setDouble(12, eventVO.getEve_lat());
			pstmt.setString(13, eventVO.getCity_id());
			pstmt.setString(14,eventVO.getSptype_id());
			pstmt.setInt(15, eventVO.getEve_view());
			pstmt.setInt(16, eventVO.getEve_charge());
			pstmt.setString(17, eventVO.getEcontact_info());
			pstmt.setString(18,eventVO.getEve_id() );
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
	public EventVO findByPrimaryKey(String eve_id) {
		EventVO eventVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, eve_id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(eve_id);
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEve_status(rs.getString("Eve_status"));
				eventVO.setEve_location(rs.getString("Eve_location"));
				eventVO.setEve_long(rs.getDouble("Eve_long"));
				eventVO.setEve_lat(rs.getDouble("Eve_lat"));
				eventVO.setCity_id(rs.getString("City_id"));
				eventVO.setSptype_id(rs.getString("Sptype_id"));
				eventVO.setEve_view(rs.getInt("Eve_view"));
				eventVO.setEve_charge(rs.getInt("Eve_charge"));
				eventVO.setEcontact_info(rs.getString("Econtact_info"));
				eventVO.setEestablish_date(rs.getTimestamp("Eestablish_date"));
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
		return eventVO;
	}
	

	@Override
	public List<EventVO> getAll() {
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEve_status(rs.getString("Eve_status"));
				eventVO.setEve_location(rs.getString("Eve_location"));
				eventVO.setEve_long(rs.getDouble("Eve_long"));
				eventVO.setEve_lat(rs.getDouble("Eve_lat"));
				eventVO.setCity_id(rs.getString("City_id"));
				eventVO.setSptype_id(rs.getString("Sptype_id"));
				eventVO.setEve_view(rs.getInt("Eve_view"));
				eventVO.setEve_charge(rs.getInt("Eve_charge"));
				eventVO.setEcontact_info(rs.getString("Econtact_info"));
				eventVO.setEestablish_date(rs.getTimestamp("Eestablish_date"));
	
				list.add(eventVO); // Store the row in the list
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
	
	public static void main(String[] args) {

		EveJDBCDAO dao = new EveJDBCDAO();
		
		// 新增
//		EventVO eventVO1=new EventVO();
//		eventVO1.setMem_id("M000003");
//		byte[] photo1=getPicBytes("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\run\\banner_maokong_run.jpg");
//		eventVO1.setEve_photo(photo1);
//		byte[] logo1=getPicBytes("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\oripic\\run\\maokong_run.jpg");
//		eventVO1.setEve_logo(logo1);
//		eventVO1.setEve_content("");
//		eventVO1.setEve_startdate(java.sql.Timestamp.valueOf("2018-10-10 08:08:08"));
//		eventVO1.setEve_enddate(java.sql.Timestamp.valueOf("2018-10-10 14:15:16"));
//		eventVO1.setEreg_startdate(java.sql.Date.valueOf("2018-09-13"));
//		eventVO1.setEreg_enddate(java.sql.Date.valueOf("2018-09-30"));
//		eventVO1.setEstart_limit(10);
//		eventVO1.setEve_status("E2");
//		eventVO1.setEve_location("桃園市中壢區石頭里中和路139號 中壢火車站");
//		eventVO1.setEve_long(121.2237819);
//		eventVO1.setEve_lat(24.9539722);
//		eventVO1.setCity_id("CITY03");
//		eventVO1.setSptype_id("SP000001");
//		eventVO1.setEve_view(0);
//		eventVO1.setEve_charge(100);
//		eventVO1.setEcontact_info("0912-345-678");
//		
//		dao.insert(eventVO1);
//		
//		// 修改
//		EventVO eventVO2=new EventVO();		
//		byte[] photo=getPicBytes("");
//		eventVO2.setEve_photo(photo);
//		byte[] logo=getPicBytes("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\oripic\\run\\maokong_run.jpg");
//		eventVO2.setEve_logo(logo);
//		eventVO2.setEve_content("11111");
//		eventVO2.setEve_startdate(java.sql.Timestamp.valueOf("2018-10-10 09:09:09"));
//		eventVO2.setEve_enddate(java.sql.Timestamp.valueOf("2018-10-10 16:17:18"));
//		eventVO2.setEreg_startdate(java.sql.Date.valueOf("2018-09-10"));
//		eventVO2.setEreg_enddate(java.sql.Date.valueOf("2018-09-30"));
//		eventVO2.setEstart_limit(10);
//		eventVO2.setEve_status("E3");
//		eventVO2.setEve_location("桃園市中壢區石頭里中和路139號 中壢火車站");
//		eventVO2.setEve_long(121.2237819);
//		eventVO2.setEve_lat(24.9539722);
//		eventVO2.setCity_id("CITY03");
//		eventVO2.setSptype_id("SP000003");
//		eventVO2.setEve_view(3);
//		eventVO2.setEve_charge(50);
//		eventVO2.setEcontact_info("0934-555-678");
//		eventVO2.setMem_id("M000001");
//		eventVO2.setEve_id("E000001");
//		dao.update(eventVO2);
//		
//		// 查詢一個
//		EventVO eventVO3=dao.findByPrimaryKey("E000002");
//		System.out.println(eventVO3.getEve_id());
//		System.out.println(eventVO3.getMem_id());
//		System.out.println(eventVO3.getEve_content());
//		System.out.println(eventVO3.getEve_startdate());
//		System.out.println(eventVO3.getEve_enddate());
//		System.out.println(eventVO3.getEreg_startdate());
//		System.out.println(eventVO3.getEreg_enddate());
//		System.out.println(eventVO3.getEstart_limit());
//		System.out.println(eventVO3.getEve_status());
//		System.out.println(eventVO3.getEve_location());
//		System.out.println(eventVO3.getEve_long());
//		System.out.println(eventVO3.getEve_lat());
//		System.out.println(eventVO3.getCity_id());
//		System.out.println(eventVO3.getSptype_id());
//		System.out.println(eventVO3.getEve_view());
//		System.out.println(eventVO3.getEve_charge());	
//		System.out.println(eventVO3.getEcontact_info());
//		System.out.println(eventVO3.getEestablish_date());
//		byte[] photo3=eventVO3.getEve_photo();
//		readpic(photo3,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO3.getEve_id()+"_photo3.jpg");
//		byte[] logo3=eventVO3.getEve_logo();
//		readpic(logo3,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO3.getEve_id()+"_logo3.jpg");
//		System.out.println("==================================");
//		
//		// 查詢全部
		List<EventVO> list = dao.getAll();
		for (EventVO eventVO : list) {
			
			System.out.println(eventVO.getEve_id());
			System.out.println(eventVO.getMem_id());
			System.out.println(eventVO.getEve_content());
			System.out.println(eventVO.getEve_startdate());
			System.out.println(eventVO.getEve_enddate());
			System.out.println(eventVO.getEreg_startdate());
			System.out.println(eventVO.getEreg_enddate());
			System.out.println(eventVO.getEstart_limit());
			System.out.println(eventVO.getEve_status());
			System.out.println(eventVO.getEve_location());
			System.out.println(eventVO.getEve_long());
			System.out.println(eventVO.getEve_lat());
			System.out.println(eventVO.getCity_id());
			System.out.println(eventVO.getSptype_id());
			System.out.println(eventVO.getEve_view());
			System.out.println(eventVO.getEve_charge());	
			System.out.println(eventVO.getEcontact_info());
			System.out.println(eventVO.getEestablish_date());
			
			byte[] photo5=eventVO.getEve_photo();
			readpic(photo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_photo.jpg");
			byte[] logo5=eventVO.getEve_logo();
			readpic(logo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_logo.jpg");
			System.out.println("==================================");
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
			//上傳未傳之後在filenotfound那邊不處理 資料庫變null 
			//(修改頁面的一開始會有原本上傳的圖片)
			//或可在FileNotFound放入預設或尚無圖片
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
			if(bytes!=null&&filepath!=null) {
				FileOutputStream fo=new FileOutputStream(new File(filepath));
				fo.write(bytes);	
			}
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

}
