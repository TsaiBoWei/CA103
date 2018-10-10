package com.courboar.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

public class Mem_DBGifReader4 extends HttpServlet {

	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Statement stmt = con.createStatement();
			String mem_id=req.getParameter("mem_id").trim();
			ResultSet rs = stmt.executeQuery(
				"SELECT MEM_PHOTO FROM MEM WHERE MEM_ID ='"+mem_id+"'");

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("MEM_PHOTO"));
//				BufferedInputStream in = (BufferedInputStream) rs.getBinaryStream("PICTURE");
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
//				InputStream in= getServletContext().getResourceAsStream("/NoData/no.png");
//			    byte[] b=new byte[in.available()];
//			    in.read(b);
//			    out.write(b);
//			    in.close();
			
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e);
//			InputStream in= getServletContext().getResourceAsStream("/NoData/null.png");
//		    byte[] b=new byte[in.available()];
//		    in.read(b);
//		    out.write(b);
//		    in.close();
		}
	}

	public void init() throws ServletException {
		
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
			con = ds.getConnection();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public void destroy() {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

}