package com.courunit.controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/VideoUpload")
public class VideoUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "PROJECTTEST";
	private static final String PASSWORD = "123456";
	
	private static final String UPDATE_STMT = "UPDATE COURUNIT SET COUR_FILM = ? WHERE COUR_UNIT_ID = ? ";
	private static final String SELECT_STMT = "SELECT COUR_FILM FROM COURUNIT WHERE COUR_UNIT_ID = ? ";
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs=null;
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			//存影片進資料庫
//			Part part = request.getPart("videofile");
//			String type=part.getContentType();//要加欄位存入
			Collection<Part> parts = request.getParts();
			for (Part part : parts) {
				System.out.println(part.getSize());
				}
			
//			System.out.println(type);
			
//			
//		    InputStream in = part.getInputStream();
//			byte[] buf = new byte[in.available()]; // buffer
//			in.read(buf);
//
//			pstmt = con.prepareStatement(UPDATE_STMT);
//			pstmt.setBytes(1, buf);
//			pstmt.setString(2, "CU000003");
//			int count = pstmt.executeUpdate();
//			System.out.print(count);
			
			//讀出影片
			
			ServletOutputStream out = response.getOutputStream();
//			response.setContentType(type); //"video/mp4"
			response.setContentType("video/mp4"); //"video/mp4"
			pstmt1 = con.prepareStatement(SELECT_STMT);
			pstmt1.setString(1, "CU000001");
			rs = pstmt1.executeQuery();
		    
			
			if (rs.next()) {
				BufferedInputStream bi = new BufferedInputStream(rs.getBinaryStream("COUR_FILM"));
			    System.out.println(bi);
//				BufferedInputStream in = (BufferedInputStream) rs.getBinaryStream("PICTURE");
				byte[] buf1 = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = bi.read(buf1)) != -1) {
					out.write(buf1, 0, len);
				}
				bi.close();
			}
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();

		} catch (SQLException e) {
			e.printStackTrace();
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
}