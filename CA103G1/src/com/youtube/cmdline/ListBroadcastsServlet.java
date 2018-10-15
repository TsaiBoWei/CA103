package com.youtube.cmdline;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.youtube.cmdline.Auth;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.LiveBroadcast;
import com.google.api.services.youtube.model.LiveBroadcastListResponse;
import com.google.common.collect.Lists;


public class ListBroadcastsServlet extends HttpServlet {
	private static YouTube youtube;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		ServletContext context = req.getServletContext();
		context.setAttribute("Stream_id", "");
		
		List<String> scopes = Lists.newArrayList("https://www.googleapis.com/auth/youtube.readonly");
		try {
			// Authorize the request.
			Credential credential = Auth.authorize(scopes, "listbroadcasts");
			// This object is used to make YouTube Data API requests.
			youtube = new YouTube.Builder(Auth.HTTP_TRANSPORT, Auth.JSON_FACTORY, credential)
                    .setApplicationName("youtube-cmdline-listbroadcasts-sample").build();

			// Create a request to list broadcasts.
            YouTube.LiveBroadcasts.List liveBroadcastRequest =
                    youtube.liveBroadcasts().list("id,snippet");
            
            liveBroadcastRequest.setBroadcastType("all").setBroadcastStatus("all");
            LiveBroadcastListResponse returnedListResponse = liveBroadcastRequest.execute();
            List<LiveBroadcast> returnedList = returnedListResponse.getItems();
            
            // ¥[¤Jcontext
            if ( returnedList != null ) {
            	context.setAttribute("Stream_id", returnedList.get(0).getId() );      
            	System.out.println("ytStream id = " + returnedList.get(0).getId());
            }
            
		} catch (GoogleJsonResponseException e) {
            System.err.println("GoogleJsonResponseException code: " + e.getDetails().getCode() + " : "
                    + e.getDetails().getMessage());
            e.printStackTrace();

        } catch (IOException e) {
            System.err.println("IOException: " + e.getMessage());
            e.printStackTrace();
        } catch (Throwable t) {
            System.err.println("Throwable: " + t.getMessage());
            t.printStackTrace();
        }

	}
	
	
}
