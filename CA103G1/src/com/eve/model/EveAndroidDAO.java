package com.eve.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EveAndroidDAO implements EventDAO_interface {

	private static final String GET_ONE_STMT = 
			"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT,EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
			"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_ID= ? AND EVE_STATUS != 'E0'";		
		
	private static final String GET_ALL_STMT = 
			"SELECT EVE_ID,MEM_ID,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
			"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS != 'E0' order by EVE_ID";

	private static final String GET_EVENT_PHOTO = "SELECT EVE_PHOTO FROM EVENT WHERE EVE_ID = ?";
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public byte[] getEvePhotoByEveId( String eve_id ) {
		byte[] photo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_EVENT_PHOTO);
			rs = pstmt.executeQuery();
			
			if ( rs.next() ) {
				photo = rs.getBytes(1);
			}
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
		
		return photo;
	}
	
	@Override
	public List<EventVO> getAll() {
		List<EventVO> list = new ArrayList<EventVO>();
		EventVO eventVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(rs.getString("Eve_id"));
				eventVO.setMem_id(rs.getString("Mem_id"));
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
	public void insert(EventVO eventVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(EventVO eventVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updatePhoto(byte[] eve_photo, String eve_id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update_status(String eve_id, String eve_status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public EventVO findByPrimaryKey(String eve_id) {

		EventVO eventVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, eve_id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				eventVO = new EventVO();
				eventVO.setEve_id(eve_id);
				eventVO.setMem_id(rs.getString("Mem_id"));
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
	public List<EventVO> getEvesByMem(String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EventVO> getReviewEves() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EventVO> getAllinViewPage() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EventVO> getAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}
}
