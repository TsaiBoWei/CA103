

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.Post.model.PostService;
import com.Post.model.PostVO;
import com.city.model.CityService;
import com.coach.model.CoachService;
import com.courlist.model.CourlistService;
import com.courlist.model.CourlistVO;
import com.eve.model.EveService;
import com.eve.model.EventVO;
import com.mem.model.MemService;
import com.plan.model.PlanService;
import com.plan.model.PlanVO;


@WebServlet("/index")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
												throws ServletException, IOException {
		
		res.setContentType("text/html; charset=utf-8");
    	PrintWriter out = res.getWriter();		
		String type1=req.getParameter("reqtype1");
		String type2=req.getParameter("reqtype2");
		
	
		MemService memSvc=new MemService();
		CityService citySvc=new CityService();
		Map sportTypeMap=(Map)getServletContext().getAttribute("sportTypeMap");
		Map sportTypeColor=(Map)getServletContext().getAttribute("sportTypeColor");
		
		
		if(type2.equals("EVENT")) {
			EveService eveSvc=new EveService();
			List<EventVO> list=new ArrayList<>();
			switch(type1) {
			case "POPULAR":
				list=eveSvc.getPopularEves();
				break;
			case "NEW":
				list=eveSvc.getNewEves();
				break;			
			}
			
			JSONArray jarray=new JSONArray();
	        for (int i = 0; i < list.size(); i++) {
	        	EventVO eveVO=list.get(i);
	 	        JSONObject jobj=new JSONObject();
	 	        try {
	 	        	
	 	        	String mem_name=memSvc.getOneMem(eveVO.getMem_id()).getMem_name();
					String sptype_id=eveVO.getSptype_id();
	 	        	
	 	        	jobj.put("eve_id", eveVO.getEve_id());
					jobj.put("title", eveVO.getEve_title());				
					jobj.put("mem_name", mem_name);
					jobj.put("view", eveVO.getEve_view());
					jobj.put("sptype_color", sportTypeColor.get(sptype_id));				
					jobj.put("sptype_name",sportTypeMap.get(sptype_id));				
					jarray.put(jobj);
					
				} catch (JSONException e) {
					e.printStackTrace();
				}
   
            }
            out.print(jarray);
		
		}
		
		if(type2.equals("COURSE")) {
			List<CourlistVO> list=new ArrayList<>();
			CourlistService courSvc=new CourlistService();
			CoachService coachSvc=new CoachService(); 
			switch(type1) {
			case "POPULAR":
//				list=courSvc.getPopularCour();
				break;
			case "NEW":
//				list=courSvc.getNewCour();
				break;			
			}
			
			JSONArray jarray=new JSONArray();
	        for (int i = 0; i < list.size(); i++) {
	        	CourlistVO courVO=list.get(i);
	 	        JSONObject jobj=new JSONObject();
	 	        try {
	 	        	
	 	        	String mem_id=coachSvc.getOneCoach(courVO.getCoa_id()).getMem_id();
	 	        	String mem_name=memSvc.getOneMem(mem_id).getMem_name();
					String sptype_id=courVO.getSptype_id();
	 	        	
	 	        	jobj.put("cour_id", courVO.getCour_id());
					jobj.put("title", courVO.getCname());				
					jobj.put("mem_name", mem_name);
					jobj.put("view", courVO.getCour_view());
					jobj.put("sptype_color", sportTypeColor.get(sptype_id));				
					jobj.put("sptype_name",sportTypeMap.get(sptype_id));				
					jarray.put(jobj);

					
				} catch (JSONException e) {
					e.printStackTrace();
				}
   
            }
            out.print(jarray);
						
		}
		
		
		if(type2.equals("PLAN")) {
			List<PlanVO> list=new ArrayList<>();
			PlanService planSvc=new PlanService();
			switch(type1) {
			case "POPULAR":
				list=planSvc.getPopularPlan();
				break;
			case "NEW":
				list=planSvc.getNewPlan();
				break;			
			}
			
			JSONArray jarray=new JSONArray();
	        for (int i = 0; i < list.size(); i++) {
	        	PlanVO planVO=list.get(i);
	 	        JSONObject jobj=new JSONObject();
	 	        try {
	 	        	
	 	        	String mem_name=memSvc.getOneMem(planVO.getMem_id()).getMem_name();
					String sptype_id=planVO.getSptype_id();
	 	        	
	 	        	jobj.put("plan_id", planVO.getPlan_id());
					jobj.put("title", planVO.getPlan_name());				
					jobj.put("mem_name", mem_name);
					jobj.put("view", planVO.getPlan_view());
					jobj.put("sptype_color", sportTypeColor.get(sptype_id));				
					jobj.put("sptype_name",sportTypeMap.get(sptype_id));				
					jarray.put(jobj);

					
				} catch (JSONException e) {
					e.printStackTrace();
				}
   
            }
            out.print(jarray);
						
		}
		
		if(type2.equals("POST")) {
			List<PostVO> list=new ArrayList<>();
			PostService postSvc=new PostService();
			switch(type1) {
			case "POPULAR":
				list=postSvc.getPopularPost();
				break;
			case "NEW":
				list=postSvc.getNewPost();
				break;			
			}
			
			JSONArray jarray=new JSONArray();
	        for (int i = 0; i < list.size(); i++) {
	        	PostVO postVO=list.get(i);
	 	        JSONObject jobj=new JSONObject();
	 	        try {
	 	        	
	 	        	String mem_name=memSvc.getOneMem(postVO.getMem_id()).getMem_name();
					String sptype_id=postVO.getSptype_id();
	 	        	
	 	        	jobj.put("post_id", postVO.getPost_id());
	 	        	jobj.put("post_img",postVO.getPost_img());
					jobj.put("title", postVO.getPost_title());	
					jobj.put("mem_name", mem_name);
					jobj.put("view", postVO.getPost_view());
					jobj.put("sptype_color", sportTypeColor.get(sptype_id));				
					jobj.put("sptype_name",sportTypeMap.get(sptype_id));				
					jarray.put(jobj);

					
				} catch (JSONException e) {
					e.printStackTrace();
				}
   
            }
            out.print(jarray);
						
		}
		
		
		
		
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
												throws ServletException, IOException {

		doGet(req, res);
	}

}
