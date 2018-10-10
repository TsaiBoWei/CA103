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
			eveStatusMap.put("E0", "�U�[");
			eveStatusMap.put("E1", "�ݼf��");
			eveStatusMap.put("E2", "�H�Ʃ|���F��"); 
			eveStatusMap.put("E3", "�H�ƹF�� �������W");
			eveStatusMap.put("E4", "���W�w����");//�H�ƹF�� ���ʥ��}�lor���W�ɶ��������}�l
			eveStatusMap.put("E5", "���ʤw����");
			eveStatusMap.put("E6", "�f�֥��q�L");
			eveStatusMap.put("E7", "�������ʧ@�~��");
			eveStatusMap.put("E8", "���ʤw����");
			context.setAttribute("eveStatusMap", eveStatusMap);
		
		
		Map<String,String> sportTypeMap=null;				
<<<<<<< HEAD
		sportTypeMap=new LinkedHashMap<>();
		sportTypeMap.put("SP000001", "�Ю|");
		sportTypeMap.put("SP000002", "�樮");
		sportTypeMap.put("SP000003", "�y��");
		sportTypeMap.put("SP000004", "���V");
		sportTypeMap.put("SP000005", "����");
		sportTypeMap.put("SP000006", "�Z�N");
		sportTypeMap.put("SP000007", "���W");
		sportTypeMap.put("SP000008", "��L");
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
			sportTypeMap.put("SP000001", "�Ю|");
			sportTypeMap.put("SP000002", "�樮");
			sportTypeMap.put("SP000003", "�y��");
			sportTypeMap.put("SP000004", "���V");
			sportTypeMap.put("SP000005", "����");
			sportTypeMap.put("SP000006", "�Z�N");
			sportTypeMap.put("SP000007", "���W");
			sportTypeMap.put("SP000008", "��L");
			context.setAttribute("sportTypeMap", sportTypeMap);
>>>>>>> 3e61623f3a650f11d7d8ae17efa918aeef15c120

		
		Map<String,String> eveListStatusMap=null;
			eveListStatusMap=new HashMap<>();
			eveListStatusMap.put("EL0", "�����I��");
			eveListStatusMap.put("EL1", "���I��");
			eveListStatusMap.put("EL2", "�w�I�ڥ��T�{");
			eveListStatusMap.put("EL3", "�T�{�w�I��");
			eveListStatusMap.put("EL4", "�h�ڥ��B�z");
			eveListStatusMap.put("EL5", "�w�h�� �ݽT�{");
			eveListStatusMap.put("EL6", "�h�ڤw�T�{");
	//		eveListStatusMap.put("EL7", "�w�h�X");//�����I��
			eveListStatusMap.put("EL9", "����");
			context.setAttribute("eveListStatusMap", eveListStatusMap);
		
		System.out.println("ServletContextListener�q��: Map�s�Jcontext");
		
	}
	
	
	
	public void contextDestroyed(ServletContextEvent event) {
		//����redis�s�u�� 
		JedisPoolUtil.shutdownJedisPool();
		System.out.println("ServletContextListener�q��: shutdownJedisPool");
	}

}
