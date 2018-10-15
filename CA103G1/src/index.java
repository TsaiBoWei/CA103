

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
import com.friendlist.model.FriendListService;
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
		String mema_id=req.getParameter("mem_id");
		FriendListService flSvc=new FriendListService();
	
		MemService memSvc=new MemService();
		CityService citySvc=new CityService();
		Map sportTypeMap=(Map)getServletContext().getAttribute("sportTypeMap");
		Map sportTypeColor=(Map)getServletContext().getAttribute("sportTypeColor");
		
		
		if(type2.equals("EVENT")) {
			EveService eveSvc=new EveService();
			List<EventVO> list=new ArrayList<>();
			List<EventVO> list1=new ArrayList<>();
			List<EventVO> list2=new ArrayList<>();
			List<EventVO> list3=new ArrayList<>();
			switch(type1) {
			case "POPULAR":
				list=eveSvc.getPopularEves();
				break;
			case "NEW":
				list=eveSvc.getNewEves();
				break;			
			case "FRIEND":
				list=flSvc.getFriendEves(mema_id);
				list1=flSvc.getFriendEvelist(mema_id);
				break;			
			}
			
			JSONArray jarray=new JSONArray();
			
			if("POPULAR".equals(type1)||"NEW".equals(type1)) {
				for (int i = 0; i < list.size(); i++) {
		        	EventVO eveVO=list.get(i);
		 	        JSONObject jobj=new JSONObject();
		 	        try {		 	        	
		 	        	String mem_name=memSvc.getOneMem(eveVO.getMem_id()).getMem_name();
						String sptype_id=eveVO.getSptype_id();
		 	        	
		 	        	jobj.put("eve_id", eveVO.getEve_id());
						jobj.put("title", eveVO.getEve_title());	
						System.out.println(eveVO.getEve_title());
						jobj.put("mem_name", mem_name);
						jobj.put("view", eveVO.getEve_view());
						jobj.put("sptype_color", sportTypeColor.get(sptype_id));				
						jobj.put("sptype_name",sportTypeMap.get(sptype_id));				
						jarray.put(jobj);
						
					} catch (JSONException e) {
						e.printStackTrace();
					}
	   
	            }
				
			//ね	
			}else {
				int listNum=0; int list1Num=0;
				int frlistNum=0;
				if(list!=null) listNum=list.size();
				if(list1!=null) list1Num=list1.size();
				frlistNum=listNum+list1Num;

				if(listNum>=6) {
					for (int i = 0; i < 6; i++) {
			        	EventVO eveVO=list.get(i);
			 	        JSONObject jobj=new JSONObject();
			 	        try {		 	        	
			 	        	String mem_name=memSvc.getOneMem(eveVO.getMem_id()).getMem_name()+"快";
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
					
				}else if(listNum<6 && frlistNum>=6) {
					if(list!=null) {
						list.addAll(list1);
					}else {
						list=list1;
					}
					for (int i = 0; i < 6; i++) {
			        	EventVO eveVO=list.get(i);
			 	        JSONObject jobj=new JSONObject();
			 	        try {		 	        	
			 	        	String mem_name=memSvc.getOneMem(eveVO.getMem_id()).getMem_name();
			 	        	if(eveSvc.getOneEve(eveVO.getEve_id()).getMem_id().equals(eveVO.getMem_id())) {
			 	        		mem_name+="快";
			 	        	}else {
			 	        		mem_name+="把";
			 	        	}
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
					
				
				}else {
					list2=eveSvc.getPopularEves();
					if(listNum>0) {
						list3.addAll(list);
					}if(list1Num>0) {
						list3.addAll(list1);
					}
					list3.addAll(list2);
					for (int i = 0; i < 6; i++) {
			        	EventVO eveVO=list3.get(i);
			 	        JSONObject jobj=new JSONObject();
			 	        try {		 	        	
			 	        	String mem_name=memSvc.getOneMem(eveVO.getMem_id()).getMem_name();
			 	        	if(eveSvc.getOneEve(eveVO.getEve_id()).getMem_id().equals(eveVO.getMem_id())) {
			 	        		mem_name+="快";
			 	        	}else {
			 	        		mem_name+="把";
			 	        	}
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
					
				}
								
			}	        
            out.print(jarray);
		}
		
		if(type2.equals("COURSE")) {
			List<CourlistVO> list=new ArrayList<>();
			List<CourlistVO> list1=new ArrayList<>();
			List<CourlistVO> list2=new ArrayList<>();
			List<CourlistVO> list3=new ArrayList<>();
			CourlistService courSvc=new CourlistService();
			CoachService coachSvc=new CoachService(); 
			switch(type1) {
			case "POPULAR":
				list=courSvc.getPopularCour();
				break;
			case "NEW":
				list=courSvc.getNewCour();
				break;	
			case "FRIEND":
				list=flSvc.getFriendCour(mema_id);
				list1=flSvc.getFriendPurCour(mema_id);
				break;		
			}
			
			JSONArray jarray=new JSONArray();
			
			if("POPULAR".equals(type1)||"NEW".equals(type1)) {
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
				
				//ね	
			}else {
				int listNum=0; int list1Num=0;
				int frlistNum=0;
				if(list!=null) listNum=list.size();
				if(list1!=null) list1Num=list1.size();
				frlistNum=listNum+list1Num;

				if(listNum>=6) {
					for (int i = 0; i < 6; i++) {
						CourlistVO courVO=list.get(i);
			 	        JSONObject jobj=new JSONObject();
			 	        try {
			 	        	
			 	        	String mem_id=coachSvc.getOneCoach(courVO.getCoa_id()).getMem_id();
			 	        	String mem_name=memSvc.getOneMem(mem_id).getMem_name()+"快";
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
					
				}else if(listNum<6 && frlistNum>=6) {
					if(list!=null) {
						list.addAll(list1);
					}else {
						list=list1;
					}
					for (int i = 0; i < 6; i++) {
						CourlistVO courVO=list.get(i);
			 	        JSONObject jobj=new JSONObject();
			 	        try {
			 	        	
			 	        	String mem_id=coachSvc.getOneCoach(courVO.getCoa_id()).getMem_id();
			 	        	String mem_name;
			 	        	String sptype_id=courVO.getSptype_id();
			 	        	if(courVO.getCour_ann()==null) {
			 	        		mem_name=memSvc.getOneMem(mem_id).getMem_name()+"快";
			 	        	}else {
			 	        		mem_name=memSvc.getOneMem(courVO.getCour_ann()).getMem_name()+"把";
			 	        	}       	
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
					
				
				}else {
					list2=courSvc.getPopularCour();
					if(listNum>0) {
						list3.addAll(list);
					}if(list1Num>0) {
						list3.addAll(list1);
					}
					list3.addAll(list2);
					System.out.println(list3.size());
					for (int i = 0; i < 6; i++) {
						CourlistVO courVO=list3.get(i);
			 	        JSONObject jobj=new JSONObject();
			 	        try {
			 	        	
			 	        	String mem_id=coachSvc.getOneCoach(courVO.getCoa_id()).getMem_id();
			 	        	String mem_name;
							String sptype_id=courVO.getSptype_id();
							if(courVO.getCour_ann()==null) {
			 	        		mem_name=memSvc.getOneMem(mem_id).getMem_name()+"快";
			 	        	}else {
			 	        		mem_name=memSvc.getOneMem(courVO.getCour_ann()).getMem_name()+"把";
			 	        	}  
			 	        	
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
			List<PostVO> list1=new ArrayList<>();
			PostService postSvc=new PostService();
			switch(type1) {
			case "POPULAR":
				list=postSvc.getPopularPost();
				break;
			case "NEW":
				list=postSvc.getNewPost();
				break;
			case "FRIEND":
				list=flSvc.getFriendPost(mema_id);
				break;			
			}
			
			JSONArray jarray=new JSONArray();
			if("POPULAR".equals(type1)||"NEW".equals(type1)) {
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
				
				
				//ね	
				}else {
					int listNum=0; 
					if(list!=null) listNum=list.size();

					if(listNum>=6) {
						for (int i = 0; i < 6; i++) {
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
						
					}else if(listNum<6 && listNum>0) {
						list1=postSvc.getPopularPost();
						list.addAll(list1);
						for (int i = 0; i < 6; i++) {
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
						
					
					}else {
						list=postSvc.getPopularPost();
						for (int i = 0; i < 6; i++) {
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
