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
import java.util.Map;




public class EveJDBCDAO implements EventDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"Insert into EVENT (EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT,EVE_STARTDATE,EVE_ENDDATE,EREG_STARTDATE,EREG_ENDDATE,"+
		"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE ) "+
		" values ('E'||LPAD(to_char(event_seq.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,CURRENT_TIMESTAMP)";
	private static final String GET_ALL_STMT = 
		"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
		"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS != 'E0' order by EVE_ID";
	private static final String GET_ONE_STMT = 
		"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT,EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
		"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_ID= ? AND EVE_STATUS != 'E0'";		
	private static final String UPDATE = 
		"UPDATE EVENT set EVE_PHOTO=?,EVE_LOGO=?,EVE_PTYPE=?,EVE_TITLE=?,EVE_CONTENT=?,EVE_STARTDATE=? ,EVE_ENDDATE =?,EREG_STARTDATE =?,EREG_ENDDATE=?," + 
		"ESTART_LIMIT=? ,ESTART_MAX=? ,EVE_STATUS=?,EVE_LOCATION=?,EVE_LONG=?,EVE_LAT=?,CITY_ID=?,SPTYPE_ID=?,EVE_VIEW=?,EVE_CHARGE=?,ECONTACT_INFO=?  where EVE_ID = ?";
	private static final String UPDATE_STATUS = 
			"UPDATE EVENT set EVE_STATUS=? where EVE_ID = ?";
	private static final String GET_EVE_BY_MEM = 
			"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
			"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE MEM_ID=? order by EVE_ID";
	private static final String GET_EVES_IN_VIEW_PAGE = 
			"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
			"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS='E2' OR EVE_STATUS='E3' OR EVE_STATUS='E4' order by eve_view desc";
	private static final String GET_REVIEW_EVES = 
			"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
					"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS='E1'";
	
	private static final String UPDATE_PIC="UPDATE EVENT SET EVE_PHOTO=? WHERE EVE_ID=?";
	private static final String GET_REVIEWE_END_EVES =
			"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
					"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS='E2' OR EVE_STATUS='E3' OR EVE_STATUS='E6'";


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
			pstmt.setString(4,eventVO.getEve_ptype());
			pstmt.setString(5, eventVO.getEve_title());
			pstmt.setString(6,eventVO.getEve_content());			
			pstmt.setTimestamp(7,eventVO.getEve_startdate());
			pstmt.setTimestamp(8,eventVO.getEve_enddate());
			pstmt.setDate(9,eventVO.getEreg_startdate());
			pstmt.setDate(10,eventVO.getEreg_enddate() );
			pstmt.setInt(11, eventVO.getEstart_limit());
			pstmt.setInt(12, eventVO.getEstart_max());
			pstmt.setString(13, eventVO.getEve_status());
			pstmt.setString(14, eventVO.getEve_location());
			pstmt.setDouble(15, eventVO.getEve_long());
			pstmt.setDouble(16, eventVO.getEve_lat());
			pstmt.setString(17, eventVO.getCity_id());
			pstmt.setString(18,eventVO.getSptype_id());
			pstmt.setInt(19, eventVO.getEve_view());
			pstmt.setInt(20, eventVO.getEve_charge());
			pstmt.setString(21, eventVO.getEcontact_info());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
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
			pstmt.setString(3,eventVO.getEve_ptype());
			pstmt.setString(4,eventVO.getEve_title());
			pstmt.setString(5,eventVO.getEve_content());		
			pstmt.setTimestamp(6,eventVO.getEve_startdate());
			pstmt.setTimestamp(7,eventVO.getEve_enddate());
			pstmt.setDate(8,eventVO.getEreg_startdate());
			pstmt.setDate(9,eventVO.getEreg_enddate() );
			pstmt.setInt(10, eventVO.getEstart_limit());
			pstmt.setInt(11, eventVO.getEstart_max());
			pstmt.setString(12, eventVO.getEve_status());
			pstmt.setString(13, eventVO.getEve_location());
			pstmt.setDouble(14, eventVO.getEve_long());
			pstmt.setDouble(15, eventVO.getEve_lat());
			pstmt.setString(16, eventVO.getCity_id());
			pstmt.setString(17,eventVO.getSptype_id());
			pstmt.setInt(18, eventVO.getEve_view());
			pstmt.setInt(19, eventVO.getEve_charge());
			pstmt.setString(20, eventVO.getEcontact_info());
			pstmt.setString(21,eventVO.getEve_id() );
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
	public void update_status(String eve_id,String eve_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_STATUS);		
			pstmt.setString(1, eve_status);		
			pstmt.setString(2, eve_id);
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
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
	
	@Override
	public List<EventVO> getEvesByMem(String mem_id) {
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_EVE_BY_MEM);
			pstmt.setString(1,mem_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
	
	@Override
	public List<EventVO> getAllinViewPage() {
		
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_EVES_IN_VIEW_PAGE);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
	@Override
	public List<EventVO> getReviewEves() {
		
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_REVIEW_EVES);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
	
	@Override
	public void updatePhoto(byte[] eve_photo,String eve_id){
		Connection con = null;
		PreparedStatement pstmt = null;			
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_PIC);
			
			pstmt.setBytes(1,eve_photo);
			pstmt.setString(2, eve_id);				
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
		}  finally {
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
	public List<EventVO> getAll(Map<String, String[]> map){
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			String finalSQL = "select * from EVENT "
		          + JdbcUtil_CompositeQuery_Eve.get_WhereCondition(map)
		          + "order by eve_id";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
//		byte[] photo1=getPicBytes("C:\\Users\\user\\Desktop\\專題\\images\\E000001_photo.jpg");
//		eventVO1.setEve_photo(photo1);
////		eventVO1.setEve_photo(null);
//		byte[] logo1=getPicBytes("C:\\Users\\user\\Desktop\\專題\\images\\E000001_photo.jpg"
//				+ "");
//		eventVO1.setEve_logo(logo1);
////		eventVO1.setEve_logo(null);
//		eventVO1.setEve_ptype("image/jpeg");
//		eventVO1.setEve_title("日月光路跑");
//		eventVO1.setEve_content("由桃園市政府攜手日月光集團共同主辦，堪稱今年必跑、最值得參加的頂規賽事，並透過極地探險家林義傑協助規劃之「桃園日月光半程馬拉松」，訂於今(107)年10月7日選定國立體育大學盛大登場。本賽事規劃3K休閒組、10K挑戰組、21K半馬組等三大組別，報名費依不同組別從200至450元，活動內容十分豐富、有趣，除了有吸睛啦啦隊、在地特色補給站及賽後嘉年華音樂會外，更有超值的活動贈品，名額有限，報名從速！");
//		eventVO1.setEve_startdate(java.sql.Timestamp.valueOf("2018-10-10 08:08:08"));
//		eventVO1.setEve_enddate(java.sql.Timestamp.valueOf("2018-10-10 14:15:16"));
//		eventVO1.setEreg_startdate(java.sql.Date.valueOf("2018-09-13"));
//		eventVO1.setEreg_enddate(java.sql.Date.valueOf("2018-09-30"));
//		eventVO1.setEstart_limit(10);
//		eventVO1.setEstart_max(1000);
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
		
//		// 修改
//		EventVO eventVO2=new EventVO();		
////		byte[] photo=getPicBytes("");
////		eventVO2.setEve_photo(photo);
//		byte[] logo=getPicBytes("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\run\\banner_mioli_marathon.jpg");
////		byte[] logo=getPicBytes("WebContent\\front_end\\event\\eve\\assets\\eventpic\\run\\banner_maokong_run.jpg");
//		eventVO2.setEve_logo(logo);
//		eventVO2.setEve_ptype("image/png");
//		eventVO2.setEve_title("跑2");
//		eventVO2.setEve_content("11111");
//		eventVO2.setEve_startdate(java.sql.Timestamp.valueOf("2018-10-10 09:09:09"));
//		eventVO2.setEve_enddate(java.sql.Timestamp.valueOf("2018-10-10 16:17:18"));
//		eventVO2.setEreg_startdate(java.sql.Date.valueOf("2018-09-10"));
//		eventVO2.setEreg_enddate(java.sql.Date.valueOf("2018-09-30"));
//		eventVO2.setEstart_limit(10);
//		eventVO2.setEstart_max(100);		
//		eventVO2.setEve_status("E3");
//		eventVO2.setEve_location("桃園市中壢區石頭里中和路139號 中壢火車站");
//		eventVO2.setEve_long(121.2237819);
//		eventVO2.setEve_lat(24.9539722);
//		eventVO2.setCity_id("CITY03");
//		eventVO2.setSptype_id("SP000003");
//		eventVO2.setEve_view(3);
//		eventVO2.setEve_charge(50);
//		eventVO2.setEcontact_info("0934-555-678");
//		eventVO2.setMem_id("M000002");
//		eventVO2.setEve_id("E000002");
//		dao.update(eventVO2);
////		
////		// 查詢一個
//		EventVO eventVO3=dao.findByPrimaryKey("E000001");
//		System.out.println(eventVO3.getEve_id());
//		System.out.println(eventVO3.getMem_id());
//		System.out.println(eventVO3.getEve_ptype());
//		System.out.println(eventVO3.getEve_title());
//		System.out.println(eventVO3.getEve_content());
//		System.out.println(eventVO3.getEve_startdate());
//		System.out.println(eventVO3.getEve_enddate());
//		System.out.println(eventVO3.getEreg_startdate());
//		System.out.println(eventVO3.getEreg_enddate());
//		System.out.println(eventVO3.getEstart_limit());
//		System.out.println(eventVO3.getEstart_max());
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
////		// 查詢全部
//		List<EventVO> list = dao.getAll();
//		for (EventVO eventVO : list) {
//			
//			System.out.println(eventVO.getEve_id());
//			System.out.println(eventVO.getMem_id());	
//			System.out.println(eventVO.getEve_ptype());
//			System.out.println(eventVO.getEve_title());
//			System.out.println(eventVO.getEve_content());
//			System.out.println(eventVO.getEve_startdate());
//			System.out.println(eventVO.getEve_enddate());
//			System.out.println(eventVO.getEreg_startdate());
//			System.out.println(eventVO.getEreg_enddate());
//			System.out.println(eventVO.getEstart_limit());
//			System.out.println(eventVO.getEstart_max());
//			System.out.println(eventVO.getEve_status());
//			System.out.println(eventVO.getEve_location());
//			System.out.println(eventVO.getEve_long());
//			System.out.println(eventVO.getEve_lat());
//			System.out.println(eventVO.getCity_id());
//			System.out.println(eventVO.getSptype_id());
//			System.out.println(eventVO.getEve_view());
//			System.out.println(eventVO.getEve_charge());	
//			System.out.println(eventVO.getEcontact_info());
//			System.out.println(eventVO.getEestablish_date());
////			
//			byte[] photo5=eventVO.getEve_photo();
//			readpic(photo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_photo.jpg");
//			byte[] logo5=eventVO.getEve_logo();
//			readpic(logo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_logo.jpg");
//			System.out.println("==================================");
//		}
		//改狀態
//		dao.update_status("E000007", "E0");
		
		// 查詢會員主辦的全部活動
//		List<EventVO> list = dao.getEvesByMem("M000003");
//		for (EventVO eventVO : list) {
//			
//			System.out.println(eventVO.getEve_id());
//			System.out.println(eventVO.getMem_id());	
//			System.out.println(eventVO.getEve_ptype());
//			System.out.println(eventVO.getEve_title());
//			System.out.println(eventVO.getEve_content());
//			System.out.println(eventVO.getEve_startdate());
//			System.out.println(eventVO.getEve_enddate());
//			System.out.println(eventVO.getEreg_startdate());
//			System.out.println(eventVO.getEreg_enddate());
//			System.out.println(eventVO.getEstart_limit());
//			System.out.println(eventVO.getEstart_max());
//			System.out.println(eventVO.getEve_status());
//			System.out.println(eventVO.getEve_location());
//			System.out.println(eventVO.getEve_long());
//			System.out.println(eventVO.getEve_lat());
//			System.out.println(eventVO.getCity_id());
//			System.out.println(eventVO.getSptype_id());
//			System.out.println(eventVO.getEve_view());
//			System.out.println(eventVO.getEve_charge());	
//			System.out.println(eventVO.getEcontact_info());
//			System.out.println(eventVO.getEestablish_date());
//			
//			byte[] photo5=eventVO.getEve_photo();
//			readpic(photo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_photo.jpg");
//			byte[] logo5=eventVO.getEve_logo();
//			readpic(logo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_logo.jpg");
//			System.out.println("==================================");
//		}
//		List<EventVO> list = dao.getAllinViewPage();
//		for (EventVO eventVO : list) {
//			
//			System.out.println(eventVO.getEve_id());
//			System.out.println(eventVO.getMem_id());	
//			System.out.println(eventVO.getEve_ptype());
//			System.out.println(eventVO.getEve_title());
//			System.out.println(eventVO.getEve_content());
//			System.out.println(eventVO.getEve_startdate());
//			System.out.println(eventVO.getEve_enddate());
//			System.out.println(eventVO.getEreg_startdate());
//			System.out.println(eventVO.getEreg_enddate());
//			System.out.println(eventVO.getEstart_limit());
//			System.out.println(eventVO.getEstart_max());
//			System.out.println(eventVO.getEve_status());
//			System.out.println(eventVO.getEve_location());
//			System.out.println(eventVO.getEve_long());
//			System.out.println(eventVO.getEve_lat());
//			System.out.println(eventVO.getCity_id());
//			System.out.println(eventVO.getSptype_id());
//			System.out.println(eventVO.getEve_view());
//			System.out.println(eventVO.getEve_charge());	
//			System.out.println(eventVO.getEcontact_info());
//			System.out.println(eventVO.getEestablish_date());
//			
//			byte[] photo5=eventVO.getEve_photo();
//			readpic(photo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_photo.jpg");
//			byte[] logo5=eventVO.getEve_logo();
//			readpic(logo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_logo.jpg");
//			System.out.println("==================================");
//		}
		
//		List<EventVO> list = dao.getReviewEves();
//		for (EventVO eventVO : list) {
//			
//			System.out.println(eventVO.getEve_id());
//			System.out.println(eventVO.getMem_id());	
//			System.out.println(eventVO.getEve_ptype());
//			System.out.println(eventVO.getEve_title());
//			System.out.println(eventVO.getEve_content());
//			System.out.println(eventVO.getEve_startdate());
//			System.out.println(eventVO.getEve_enddate());
//			System.out.println(eventVO.getEreg_startdate());
//			System.out.println(eventVO.getEreg_enddate());
//			System.out.println(eventVO.getEstart_limit());
//			System.out.println(eventVO.getEstart_max());
//			System.out.println(eventVO.getEve_status());
//			System.out.println(eventVO.getEve_location());
//			System.out.println(eventVO.getEve_long());
//			System.out.println(eventVO.getEve_lat());
//			System.out.println(eventVO.getCity_id());
//			System.out.println(eventVO.getSptype_id());
//			System.out.println(eventVO.getEve_view());
//			System.out.println(eventVO.getEve_charge());	
//			System.out.println(eventVO.getEcontact_info());
//			System.out.println(eventVO.getEestablish_date());
//			
//			byte[] photo5=eventVO.getEve_photo();
//			readpic(photo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_photo.jpg");
//			byte[] logo5=eventVO.getEve_logo();
//			readpic(logo5,"C:\\Users\\user\\Desktop\\專題\\images\\"+eventVO.getEve_id()+"_logo.jpg");
//			System.out.println("==================================");
//		}
		
		
		
//		dao. updatePic();

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
	
	//假資料用
	public void updatePic(){
		int row=7;	//要更新的table的總欄位數量
		Connection con = null;
		PreparedStatement pstmt = null;
		FileInputStream fi=null;
		ByteArrayOutputStream baos=null;
		byte[] pic=null;
			
			
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_PIC);
			//圖片存放路徑
			File[] files=new File("C:\\Users\\user\\Desktop\\SingleEventPage\\assets\\eventpic\\run").listFiles();
			for(int i=1;i<=row;i++) {
				System.out.println(i);
				File file=files[i];
				fi=new FileInputStream(file);
				baos=new ByteArrayOutputStream();
				
				byte[] buffer=new byte[fi.available()];
				fi.read(buffer);
				baos.write(buffer);
				pic=baos.toByteArray();		
				pstmt.setBytes(1,pic);
				pstmt.setString(2,"E00000"+i);				
				pstmt.executeUpdate();
				
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
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
			if(baos!=null) {
				try {
					baos.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
			if (fi != null) {
				try {
					fi.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public List<EventVO> getReviewEndEves() {
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_REVIEWE_END_EVES);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
				eventVO.setEve_photo(rs.getBytes("Eve_photo"));
				eventVO.setEve_logo(rs.getBytes("Eve_logo"));
				eventVO.setEve_ptype(rs.getString("Eve_ptype"));
				eventVO.setEve_title(rs.getString("Eve_title"));
				eventVO.setEve_content(rs.getString("Eve_content"));
				eventVO.setEve_startdate(rs.getTimestamp("Eve_startdate"));
				eventVO.setEve_enddate(rs.getTimestamp("Eve_enddate"));
				eventVO.setEreg_startdate(rs.getDate("Ereg_startdate"));
				eventVO.setEreg_enddate(rs.getDate("Ereg_enddate"));
				eventVO.setEstart_limit(rs.getInt("Estart_limit"));
				eventVO.setEstart_max(rs.getInt("Estart_max"));
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
