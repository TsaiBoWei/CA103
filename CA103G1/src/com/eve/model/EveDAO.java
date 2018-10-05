package com.eve.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EveDAO implements EventDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
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
				"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE MEM_ID=? AND EVE_STATUS !='E0' order by EVE_ID";
		private static final String GET_EVES_IN_VIEW_PAGE = 
				"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
				"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS='E2' OR EVE_STATUS='E3' OR EVE_STATUS='E4' order by eve_view desc";
		private static final String GET_REVIEW_EVES = 
				"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
						"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS='E1'";
		
		private static final String UPDATE_PIC="UPDATE EVENT SET EVE_PHOTO=? WHERE EVE_ID=?";
		//查詢審核過的結果
		private static final String GET_REVIEWE_END_EVES =
						"SELECT EVE_ID,MEM_ID,EVE_PHOTO,EVE_LOGO,EVE_PTYPE,EVE_TITLE,EVE_CONTENT, EVE_STARTDATE, EVE_ENDDATE,to_char( EREG_STARTDATE,'yyyy-mm-dd') EREG_STARTDATE,to_char( EREG_ENDDATE,'yyyy-mm-dd') EREG_ENDDATE," + 
								"ESTART_LIMIT,ESTART_MAX,EVE_STATUS,EVE_LOCATION,EVE_LONG,EVE_LAT,CITY_ID,SPTYPE_ID,EVE_VIEW,EVE_CHARGE,ECONTACT_INFO,EESTABLISH_DATE FROM EVENT WHERE EVE_STATUS='E2' OR EVE_STATUS='E3' OR EVE_STATUS='E6'";


		@Override
		public void insert(EventVO eventVO) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con=ds.getConnection();
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
				con=ds.getConnection();
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
				con=ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_STATUS);		
				pstmt.setString(1, eve_status);		
				pstmt.setString(2, eve_id);
				pstmt.executeUpdate();

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

				con=ds.getConnection();
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
			
					String eve_status=rs.getString("Eve_status");
					if(rs.getDate("Ereg_enddate").getTime()<System.currentTimeMillis()&&rs.getTimestamp("Eve_enddate").getTime()<System.currentTimeMillis()&&(eve_status.equals("E2")||eve_status.equals("E3"))) {		
						update_status(eve_id,"E4"); 
						eve_status="E4";
					}
					if(rs.getTimestamp("Eve_enddate").getTime()<System.currentTimeMillis()&&(eve_status.equals("E2")||eve_status.equals("E3")||eve_status.equals("E4"))) {		
						update_status(eve_id,"E5"); 
						eve_status="E5";
					}			
					eventVO.setEve_status(eve_status);
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

				con=ds.getConnection();
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
					
					eventVO=checkEveStatus(eventVO);
					if(!eventVO.getEve_status().equals("E5")) {
						list.add(eventVO); // Store the row in the list
					}
					list.add(eventVO); // Store the row in the list
				}

				
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
		public List<EventVO> getEvesByMem(String mem_id) {
			List<EventVO> list = new ArrayList<EventVO>();
			EventVO eventVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con=ds.getConnection();
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
					
					eventVO=checkEveStatus(eventVO);
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
		public List<EventVO> getAllinViewPage() {
			
			List<EventVO> list = new ArrayList<EventVO>();
			EventVO eventVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con=ds.getConnection();
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
					
					eventVO=checkEveStatus(eventVO);
					if(!eventVO.getEve_status().equals("E5")) {
						list.add(eventVO); // Store the row in the list
					}
//					System.out.println("getALLView dao:"+eventVO.getEve_status());
					 // Store the row in the list
				}

				
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
		public List<EventVO> getReviewEves() {
			
			List<EventVO> list = new ArrayList<EventVO>();
			EventVO eventVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				
				con=ds.getConnection();
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
				con=ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_PIC);
				
				pstmt.setBytes(1,eve_photo);
				pstmt.setString(2, eve_id);				
				pstmt.executeUpdate();
					
				
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
				
				con = ds.getConnection();
				String finalSQL = "select * from EVENT JOIN mem using(mem_id) JOIN city using(city_id) JOIN sptype using(sptype_id) WHERE (EVE_STATUS='E2' OR EVE_STATUS='E3' OR EVE_STATUS='E4') "
			          + JdbcUtil_CompositeQuery_Eve.get_WhereCondition(map);
				pstmt = con.prepareStatement(finalSQL);
//				System.out.println("●●finalSQL(by DAO) = "+finalSQL);
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
					
					eventVO=checkEveStatus(eventVO);
					if(!eventVO.getEve_status().equals("E5")) {
						list.add(eventVO); // Store the row in the list
					}
//					System.out.println("getALLMap dao:"+eventVO.getEve_status());				
				}
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
		
		
		public EventVO checkEveStatus(EventVO eveVO) {
		
			String eve_id=eveVO.getEve_id();
			Date ereg_enddate=eveVO.getEreg_enddate();
			Timestamp eve_enddate=eveVO.getEve_enddate();
			String eve_status=eveVO.getEve_status();
			
			if(ereg_enddate.getTime()<System.currentTimeMillis()&&eve_enddate.getTime()>System.currentTimeMillis()&&(eve_status.equals("E2")||eve_status.equals("E3"))) {		
				update_status(eve_id,"E4"); 
				eveVO.setEve_status("E4");
//				System.out.println("checkEveStatus"+eveVO.getEve_status());
			}
			if(eve_enddate.getTime()<System.currentTimeMillis()&&(eve_status.equals("E2")||eve_status.equals("E3")||eve_status.equals("E4"))) {		
				update_status(eve_id,"E5"); 
				eveVO.setEve_status("E5");
			}
			
			return eveVO;
		}
		
		public List<EventVO> getReviewEndEves() {
			List<EventVO> list = new ArrayList<EventVO>();
			EventVO eventVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con=ds.getConnection();
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



