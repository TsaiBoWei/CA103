package com.courlist.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import com.courlist.*;
import com.courunit.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import com.purchcour.model.*;
import com.courlist.model.*;

@WebServlet("/CourAndroidServlet")
public class CourAndroidServlet  extends HttpServlet  {
	
	private String TAG = "CourAndroidServlet";
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
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
}
