package com.courlist.controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.courlist.*;
import com.courunit.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

public class CourAndroidServlet  extends HttpServlet  {

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
		
		System.out.println("input:" + jsonIn);
		// Gson object to json object
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		// 取得請求
		String action = jsonObject.get("action").getAsString();
		
		if ( "get_all_cour".equals(action) ) {
			
		}
		
	}
	

}
