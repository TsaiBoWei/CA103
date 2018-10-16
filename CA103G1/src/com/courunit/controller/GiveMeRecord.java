package com.courunit.controller;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.watchedhr.model.WatchedhrService;

public class GiveMeRecord extends HttpServlet {
	private static final String UPDATE_STMT = "UPDATE WATCHEDHR SET WATCHED_HR = ? , BROWS_TIME = ? WHERE COUR_UNIT_ID = ? AND CRORDER_ID=?";
	private static final String GET_WATCH_TIME = "SELECT WATCHED_HR FROM WATCHEDHR WHERE COUR_UNIT_ID = ? AND CRORDER_ID=?";
	private static final String GET_COUR_UNIT_BY_CRORDER_ID= "SELECT COUR_UNIT_ID FROM WATCHEDHR WHERE CRORDER_ID=?" ;
	private static final String INSERT_STMT= 
			"INSERT INTO WATCHEDHR(COUR_UNIT_ID, CRORDER_ID, WATCHED_HR,BROWS_TIME) VALUES(?, ?, ?, ?)";

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	
	
	
	


	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		Connection con=null;
		
		Double watched_hr = (Double.valueOf(req.getParameter("maxcurrentTime")));
        String cour_unit_id=req.getParameter("cour_unit_id");
        String crorder_id=req.getParameter("crorder_id");
        Timestamp brows_time = new Timestamp(System.currentTimeMillis());

       
System.out.println("maxTime" + watched_hr);
System.out.println("cour_unit_id" + cour_unit_id);
System.out.println("crorder_id" +  crorder_id);
	
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		

		try {
			con = ds.getConnection();
			List<String> unitlist = new ArrayList<>();
			
			//取得比對list
				pstmt2 = con.prepareStatement(GET_COUR_UNIT_BY_CRORDER_ID);
				pstmt2.setString(1, crorder_id);
				rs2 = pstmt2.executeQuery();
				while (rs2.next()) {
					String cour_unit_id_check=rs2.getString("COUR_UNIT_ID");
					unitlist.add(cour_unit_id_check);
				}
System.out.println("unitlist=" + unitlist);				
			
            if(unitlist.size()!=0&&unitlist.contains(cour_unit_id)) {
	            	pstmt = con.prepareStatement(GET_WATCH_TIME);
	    			pstmt.setString(1, cour_unit_id);
	    			pstmt.setString(2, crorder_id);
	    			rs = pstmt.executeQuery();
	    			rs.next();
	    			Double oriWatchTime = rs.getDouble("WATCHED_HR");
    		
System.out.println("oriWatchTime" +oriWatchTime);
            	
	                if (oriWatchTime < watched_hr) {
	            		pstmt1 = con.prepareStatement(UPDATE_STMT);
						pstmt1.setDouble(1, watched_hr);
						pstmt1.setTimestamp(2, brows_time);
						pstmt1.setString(3, cour_unit_id);
						pstmt1.setString(4, crorder_id);
						pstmt1.executeUpdate();
System.out.println("update");   
	                }
            }else {
            	    pstmt1 = con.prepareStatement(INSERT_STMT);
	            	
					pstmt1.setString(1, cour_unit_id);
					pstmt1.setString(2, crorder_id);
					pstmt1.setDouble(3, watched_hr);
					pstmt1.setTimestamp(4, brows_time);
	    			pstmt1.executeUpdate();
System.out.println("INSERT");            	
            }
            
            
          
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
System.out.println("===================================="); 
			}
		}
	}
		
	

//	public void init() throws ServletException {
//		
//		try {
//			Context ctx = new javax.naming.InitialContext();
//			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
//			con = ds.getConnection();
//		} catch (NamingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//	}

	

}