package com.eve.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eve.model.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import com.util.*;

@WebServlet("/EveAndroidServlet")
public class EveAndroidServlet extends HttpServlet {
	private String TAG = "EveAndroidServlet";

	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		EveAndroidDAO evedao = new EveAndroidDAO();
		
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		
		System.out.println("task" + TAG +"input: " + jsonIn);
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		
		String action = jsonObject.get("action").getAsString();
		
		if ( "get_one_eve".equals(action) ) {
			String eve_id = jsonObject.get("eve_id").getAsString();
			EventVO evevo = evedao.findByPrimaryKey(eve_id);
			writeText(res, evevo == null? "":gson.toJson(evevo));			
		}
		
		if ( "get_all_eve".equals(action) ) {
			List<EventVO> list = evedao.getAll();
			writeText(res, list == null? "":gson.toJson(list));			
		}
		
		if ("get_image".equals(action)) {
			OutputStream os = res.getOutputStream();
			String eve_id = jsonObject.get("eve_id").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			
			byte[] image = evedao.getEvePhotoByEveId(eve_id);
			if ( image != null ) {
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(image.length);
			}
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
