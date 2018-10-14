package com.courlist.controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.servlet.annotation.WebServlet;
import com.courunit.model.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import com.purchcour.model.*;
import com.util.ImageUtil;
import com.courlist.model.*;
import com.purchcour.model.*;

@WebServlet(name="CourAndroidServlet",urlPatterns= {"/CourAndroidServlet"})
public class CourAndroidServlet  extends HttpServlet  {
	
	Connection con;
	DataSource ds;
	
	public void init() throws ServletException {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private String TAG = "CourAndroidServlet";
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	String sql = "SELECT COUR_FILM_BLOB FROM COURUNIT WHERE COUR_UNIT_ID = ?";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = req.getParameter("cour_unit_id").trim();
		System.out.println("id" + id);
		ServletOutputStream out = res.getOutputStream();
		
//		try {
//			Statement stmt = con.createStatement();
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		InputStream is = findMp4ById(id);
//		int size = is.available();
//		System.out.println(size);
//		byte[] buffer = new byte[size];
//		is.read(buffer, 0, size);
	
		byte[] buffer = findMp4ByteArray(id);
		res.setContentType("video/mp4");
		res.setContentLength(buffer.length);		
		
		out.write(buffer);		
		out.close();		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		// 透過GSON做WebSocket
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		
		while ( (line = br.readLine()) != null )
			jsonIn.append(line);
		
		System.out.println("task" + TAG +"input: " + jsonIn);

		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);

		String action = jsonObject.get("action").getAsString();
				
		PurchcourService purchcourservice = new PurchcourService();
		CourlistService courlistservice = new CourlistService(); 
		
		if ( "get_all_cour".equals(action) ) {
			List<CourlistVO> courlists = new ArrayList<CourlistVO>();
			courlists = courlistservice.getAll();
			for ( CourlistVO vo : courlists ) {
				vo.setCour_pho(null);
			}
			writeText(res, courlists == null? "" : gson.toJson(courlists));
		}
		
		
		if ( "get_purch_cour_by_mem_id".equals(action) ) {
			String mem_id = jsonObject.get("mem_id").getAsString();
			List<PurchCourVO> purchcourlist = purchcourservice.getMemPurchCour(mem_id);
			List<CourlistVO> courlists = new ArrayList<CourlistVO>();
			for ( PurchCourVO purVO : purchcourlist ) {
				CourlistVO temp = courlistservice.getOneCourlist(purVO.getCour_id());
				temp.setCour_pho(null);
				temp.setCour_text(null);
				courlists.add( temp );
			}			
			writeText(res, courlists == null? "" : gson.toJson(courlists));
		}
		
		CourunitService unitser = new CourunitService();
		if ( "get_cour_units_by_cour_id".equals(action) ) {
			String cour_id = jsonObject.get("cour_id").getAsString();
			List<CourunitVO> courunitVOs = unitser.getCourUnit(cour_id);		
			writeText(res, courunitVOs == null? "" : gson.toJson(courunitVOs));
		}
		
		if ( "getImage".equals(action) ) {
			OutputStream os = res.getOutputStream();
			String cour_id = jsonObject.get("id").getAsString();
			System.out.println(cour_id);
			int imageSize = jsonObject.get("imageSize").getAsInt();	
			
			byte[] image = findPhotoById(cour_id);
			if ( image != null ) {
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/png");
				res.setContentLength(image.length);
			}
			// 回傳查詢結果
			os.write(image);
		}
		
		if ( "buy_cour".equals(action) ) {
			String cour_id = jsonObject.get("cour_id").getAsString();
			String mem_id = jsonObject.get("mem_id").getAsString();
			PurchcourService purchService = new PurchcourService();
			List<String> list_buy = purchService.findMemOwnCourse(mem_id);
			
			boolean buyed = false;
			PurchCourVO vo = null;
			for ( String buyed_cour : list_buy ) {
				System.out.println("buyed" + buyed_cour);
				if ( buyed_cour.equals(cour_id) ) {
					buyed = true;
				}
			}
			
			if ( !buyed ) {
				vo = new PurchCourVO();
				vo.setCour_id(cour_id);
				vo.setMem_id(mem_id);
				Date date = new Date(System.currentTimeMillis());
				purchService.addPurchCour(date, mem_id, cour_id);
			}			
			writeText(res, vo == null ? "":gson.toJson(vo));
		}
		
		
	}
	
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);
	}
	
	public InputStream findMp4ById(String id) {
		String sql = "SELECT COUR_FILM_BLOB FROM COURUNIT WHERE COUR_UNIT_ID = ?";
		PreparedStatement ps = null;
		try {
			con = ds.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				//System.out.println( rs.getMetaData().getColumnType(1) == Types.BLOB );
				// video file
				InputStream videoStream = rs.getBinaryStream("COUR_FILM_BLOB");
				//System.out.println(videoStream.available());
				//InputStream videoStream = rs.getBlob(1).getBinaryStream();
				if ( videoStream.available() == 0 )
					System.out.println("取得失敗");
				return videoStream;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		finally {
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public byte[] findMp4ByteArray(String id) {
		String sql = "SELECT COUR_FILM_BLOB FROM COURUNIT WHERE COUR_UNIT_ID = ?";
		PreparedStatement ps = null;
		byte[] result;
		try {
			con = ds.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				//System.out.println( rs.getMetaData().getColumnType(1) == Types.BLOB );
				// video file
				 result = rs.getBytes(1);
				 return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		finally {
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
		
	}

	public byte[] findPhotoById(String id) {
		String sql = "SELECT COUR_PHO FROM COURLIST WHERE COUR_ID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		byte[] result = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getBytes(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		finally {
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
		return result;		
	}
}
