package com.courlist.controller;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
import com.courlist.*;
import com.courunit.model.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import com.purchcour.model.*;


import com.courlist.model.*;

@WebServlet(name="CourAndroidServlet",urlPatterns= {"/CourAndroidServlet"})
public class CourAndroidServlet  extends HttpServlet  {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private String TAG = "CourAndroidServlet";
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = req.getParameter("cour_unit_id");
		System.out.println("id" + id);
		InputStream is = findMp4ById(id);
		int size = is.available();
		System.out.println(size);
		byte[] buffer = new byte[size];
		is.read(buffer, 0, size);

		res.setContentType("video/mp4");
		res.setContentLength(buffer.length);
		ServletOutputStream out = res.getOutputStream();
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
		// Gson object to json object
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		// 取得請求
		String action = jsonObject.get("action").getAsString();
				
		PurchcourService purchcourservice = new PurchcourService();
		CourlistService courlistservice = new CourlistService(); 
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
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}		
		String sql = "SELECT COUR_FILM_BLOB FROM COURUNIT WHERE COUR_UNIT_ID = ?";

		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ds.getConnection();			
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				// video file
				InputStream videoStream = rs.getBinaryStream(1);
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
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
