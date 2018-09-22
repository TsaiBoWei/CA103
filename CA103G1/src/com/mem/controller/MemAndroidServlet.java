package com.mem.controller;

import com.mem.model.MemDAO;
import com.mem.model.MemJDBCDAO;
import com.mem.model.MemVO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class MemAndroidServlet extends HttpServlet {
	private final static String CONTENT_TYPE
	="text/html; charset=UTF-8";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		// 透過GSON做WebSocket
		Gson gson = new Gson();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		
		while ( (line = br.readLine()) != null )
			jsonIn.append(line);
		
		System.out.println("input:" + jsonIn);
		MemJDBCDAO memDAO = new MemJDBCDAO();
		// Gson object to json object
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		// 取得請求
		String action = jsonObject.get("action").getAsString();
		
		// login active
		if ( "login".equals(action) ) {
			String account= jsonObject.get("account").getAsString();
			String password = jsonObject.get("password").getAsString();
			MemVO memVO = memDAO.findByAccountAndPassword(account, password);
			writeText(res, memDAO == null? "" : gson.toJson(memVO));
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
