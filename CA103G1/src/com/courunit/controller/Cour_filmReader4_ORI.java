package com.courunit.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class Cour_filmReader4_ORI extends HttpServlet {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		Connection con = null;
		ServletOutputStream out = res.getOutputStream();
		String contentType=null;

		try {
			con = ds.getConnection();
			Statement stmt = con.createStatement();
			String cour_unit_id=req.getParameter("cour_unit_id").trim();
			ResultSet rs = stmt.executeQuery(
				"SELECT COUR_FILM_BLOB , COUR_VTYPE FROM COURUNIT WHERE COUR_UNIT_ID ='"+cour_unit_id+"'");

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("COUR_FILM_BLOB"));
//				BufferedInputStream in = (BufferedInputStream) rs.getBinaryStream("PICTURE");
				contentType= rs.getString("COUR_VTYPE");
				res.setContentType(contentType);
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
//				in.close();
				
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
//				InputStream in= getServletContext().getResourceAsStream("/NoData/no.png");
//			    byte[] b=new byte[in.available()];
//			    in.read(b);
//			    out.write(b);
//			    in.close();
			
			}
//			rs.close();
//			stmt.close();
		} catch (Exception e) {
			System.out.println("??");
			System.out.println(e);
//			InputStream in= getServletContext().getResourceAsStream("/NoData/null.png");
//		    byte[] b=new byte[in.available()];
//		    in.read(b);
//		    out.write(b);
//		    in.close();
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
//
//	public void destroy() {
//		try {
//			if (con != null) con.close();
//		} catch (SQLException e) {
//			System.out.println(e);
//		}
//	}

}