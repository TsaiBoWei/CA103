package com.Mgr.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

/*********************將後台管理員的大頭貼推送到管理員mgrview頁面****************************************/

public class MgrPhototest extends HttpServlet {
	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Statement stmt = con.createStatement();
			String mgr_id = req.getParameter("mgr_id").trim();
			ResultSet rs = stmt.executeQuery("SELECT MGR_PHOTO FROM MGR WHERE MGR_ID ='" +mgr_id + "'");

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("MGR_PHOTO"));
//	    BufferedInputStream in = (BufferedInputStream) rs.getBinaryStream("PICTURE");
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				InputStream in = getServletContext().getResourceAsStream("/img/index/user.png");
				byte[]b=new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();

			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
System.out.println(e);
			InputStream in = getServletContext().getResourceAsStream("/img/index/user.png");
			byte[]b=new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();
		}
	}

	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println(e);

		}
	}
}
