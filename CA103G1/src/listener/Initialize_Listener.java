package listener;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.evechat.controller.JedisPoolUtil;

public class Initialize_Listener implements ServletContextListener{
	
	
	public void contextInitialized(ServletContextEvent event) {
		
		
		ServletContext context = event.getServletContext();
		Map<String,String> sportTypeColor=null;    
		  sportTypeColor=new LinkedHashMap<>();
		  sportTypeColor.put("SP000001", "#f70655");
		  sportTypeColor.put("SP000002", "#1a4876");
		  sportTypeColor.put("SP000003", "#16a085");
		  sportTypeColor.put("SP000004", "#009ac0");
		  sportTypeColor.put("SP000005", "#8A2BE2");
		  sportTypeColor.put("SP000006", "#edd163");
		  sportTypeColor.put("SP000007", "#a068b7");
		  sportTypeColor.put("SP000008", "#AAB7B8");
		  context.setAttribute("sportTypeColor", sportTypeColor);
		
		
		
		Map<String,String> eveStatusMap=new LinkedHashMap<>();
			eveStatusMap.put("E0", "下架");
			eveStatusMap.put("E1", "待審核");
			eveStatusMap.put("E2", "人數尚未達成"); 
			eveStatusMap.put("E3", "人數達成 接受報名");
			eveStatusMap.put("E4", "報名已結束");//人數達成 活動未開始or報名時間結束未開始
			eveStatusMap.put("E5", "活動已結束");
			eveStatusMap.put("E6", "審核未通過");
			eveStatusMap.put("E7", "取消活動作業中");
			eveStatusMap.put("E8", "活動已取消");
			context.setAttribute("eveStatusMap", eveStatusMap);
		
		
		Map<String,String> sportTypeMap=null;				
<<<<<<< HEAD
		sportTypeMap=new LinkedHashMap<>();
		sportTypeMap.put("SP000001", "田徑");
		sportTypeMap.put("SP000002", "單車");
		sportTypeMap.put("SP000003", "球類");
		sportTypeMap.put("SP000004", "重訓");
		sportTypeMap.put("SP000005", "有氧");
		sportTypeMap.put("SP000006", "武術");
		sportTypeMap.put("SP000007", "水上");
		sportTypeMap.put("SP000008", "其他");
		context.setAttribute("sportTypeMap", sportTypeMap);
		
		Map<String,String> sportTypeColor=null;				
		sportTypeMap=new LinkedHashMap<>();
		sportTypeMap.put("SP000001", "#f70655");
		sportTypeMap.put("SP000002", "#1a4876");
		sportTypeMap.put("SP000003", "#16a085");
		sportTypeMap.put("SP000004", "#009ac0");
		sportTypeMap.put("SP000005", "#8A2BE2");
		sportTypeMap.put("SP000006", "#F1C40F");
		sportTypeMap.put("SP000007", "#9B59B6");
		sportTypeMap.put("SP000008", "#AAB7B8");
		context.setAttribute("sportTypeColor", sportTypeColor);
=======
			sportTypeMap=new LinkedHashMap<>();
			sportTypeMap.put("SP000001", "田徑");
			sportTypeMap.put("SP000002", "單車");
			sportTypeMap.put("SP000003", "球類");
			sportTypeMap.put("SP000004", "重訓");
			sportTypeMap.put("SP000005", "有氧");
			sportTypeMap.put("SP000006", "武術");
			sportTypeMap.put("SP000007", "水上");
			sportTypeMap.put("SP000008", "其他");
			context.setAttribute("sportTypeMap", sportTypeMap);
>>>>>>> 3e61623f3a650f11d7d8ae17efa918aeef15c120

		
		Map<String,String> eveListStatusMap=null;
			eveListStatusMap=new HashMap<>();
			eveListStatusMap.put("EL0", "不須付款");
			eveListStatusMap.put("EL1", "未付款");
			eveListStatusMap.put("EL2", "已付款未確認");
			eveListStatusMap.put("EL3", "確認已付款");
			eveListStatusMap.put("EL4", "退款未處理");
			eveListStatusMap.put("EL5", "已退款 待確認");
			eveListStatusMap.put("EL6", "退款已確認");
	//		eveListStatusMap.put("EL7", "已退出");//不須付款
			eveListStatusMap.put("EL9", "隱藏");
			context.setAttribute("eveListStatusMap", eveListStatusMap);
		
		System.out.println("ServletContextListener通知: Map存入context");
		
	}
	
	
	
	public void contextDestroyed(ServletContextEvent event) {
		//關閉redis連線池 
		JedisPoolUtil.shutdownJedisPool();
		System.out.println("ServletContextListener通知: shutdownJedisPool");
	}

}
