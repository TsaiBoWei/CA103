package com.courboar.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

public class CourBoarTest {
	public static void main(String[] args) {
		// add
//	   COURBOAR_VO courboar_vo=new COURBOAR_VO();
//	   courboar_vo.setCour_id("COUR000001");
//	   courboar_vo.setCrpos_tit("強度持之以恆的訓練千萬不要心急？");
//	   courboar_vo.setCrpos_time(new Timestamp(System.currentTimeMillis()));
//	   courboar_vo.setMem_id("M000002");
//	   courboar_vo.setCrpos_text("伏地挺身可以當作一個基礎適應期的基本能力訓練，由於強度不是太高，也可以作為刺激肌腱韌帶適應的基礎適應訓練");
//	   courboar_vo.setCrpos_sta("CP1");//直接SQL預設

	   CourBoarDAO courboar_dao = new CourBoarDAO();
//	   courboar_dao.add(courboar_vo);

		// update
//	   COURBOAR_VO courboar_vo1=new COURBOAR_VO();
//	   courboar_vo1.setCrpost_id("CP000001");
//	   courboar_vo1.setCrpos_tit("為什麼每一個人都需要學會伏地？");
//	   courboar_vo1.setCrpos_text("伏地挺身可以透過不同的強度，循序漸進的讓肌力慢慢進步，例從手抬高式的伏地挺身，到標準的伏地挺身");
//	   courboar_dao.update(courboar_vo1);

		// findByCour_id
		List<CourBoarVO> COURBOAR_list = courboar_dao.findByCour_id("COUR000001");
		for (CourBoarVO courboarVO : COURBOAR_list) {
			System.out.print(courboarVO.getCrpost_id() + ",");
			System.out.print(courboarVO.getCrpos_tit() + ",");
			
			//取出一整串
			SimpleDateFormat sdf = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss", Locale.US); 
			System.out.print(sdf.format(courboarVO.getCrpos_time())+ ",");
			//取出所需要的
			SimpleDateFormat date = new SimpleDateFormat("d", Locale.US); 
			SimpleDateFormat month = new SimpleDateFormat("MMM", Locale.US); 
			SimpleDateFormat year = new SimpleDateFormat("yyyy", Locale.US); 
			System.out.print(date.format(courboarVO.getCrpos_time())+ ",");
			System.out.print((month.format(courboarVO.getCrpos_time())).toString().toUpperCase()+ ",");
			System.out.print(year.format(courboarVO.getCrpos_time())+ ",");
			//直接取出
//			System.out.print(courboarVO.getCrpos_time() + ",");
			System.out.print("COUR000001"+ ",");
			System.out.print(courboarVO.getMem_id() + ",");
			System.out.print(courboarVO.getCrpos_text() + ",");
			System.out.print(courboarVO.getCrpos_sta());
			System.out.println("");
		}
//		
		// findByKeyWord
//		List<CourBoarVO>CourBoar_list = courboar_dao.findByKeyWord("沖","COUR000001");
//		for (CourBoarVO courboar_vo1 : CourBoar_list) {
//			System.out.print(courboar_vo1.getCrpost_id() + ",");
//			System.out.print(courboar_vo1.getCrpos_tit() + ",");
//			System.out.print(courboar_vo1.getCrpos_time() + ",");
//			System.out.print("COUR000001"+ ",");
//			System.out.print(courboar_vo1.getMem_id() + ",");
//			System.out.print(courboar_vo1.getCrpos_text() + ",");
//			System.out.print(courboar_vo1.getCrpos_sta());
//			System.out.println("");
//		}
	   
	   //hide
	   
	   
//	   courboar_dao.hide("CP2","CP000002");
	}
}
