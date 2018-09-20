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
//	   courboar_vo.setCrpos_tit("�j�׫����H���V�m�d�U���n�߫�H");
//	   courboar_vo.setCrpos_time(new Timestamp(System.currentTimeMillis()));
//	   courboar_vo.setMem_id("M000002");
//	   courboar_vo.setCrpos_text("��a�����i�H��@�@�Ӱ�¦�A�������򥻯�O�V�m�A�ѩ�j�פ��O�Ӱ��A�]�i�H�@����E�ٸx���a�A������¦�A���V�m");
//	   courboar_vo.setCrpos_sta("CP1");//����SQL�w�]

	   CourBoarDAO courboar_dao = new CourBoarDAO();
//	   courboar_dao.add(courboar_vo);

		// update
//	   COURBOAR_VO courboar_vo1=new COURBOAR_VO();
//	   courboar_vo1.setCrpost_id("CP000001");
//	   courboar_vo1.setCrpos_tit("������C�@�ӤH���ݭn�Ƿ|��a�H");
//	   courboar_vo1.setCrpos_text("��a�����i�H�z�L���P���j�סA�`�Ǻ��i�����٤O�C�C�i�B�A�ұq��ﰪ������a�����A��зǪ���a����");
//	   courboar_dao.update(courboar_vo1);

		// findByCour_id
		List<CourBoarVO> COURBOAR_list = courboar_dao.findByCour_id("COUR000001");
		for (CourBoarVO courboarVO : COURBOAR_list) {
			System.out.print(courboarVO.getCrpost_id() + ",");
			System.out.print(courboarVO.getCrpos_tit() + ",");
			
			//���X�@���
			SimpleDateFormat sdf = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss", Locale.US); 
			System.out.print(sdf.format(courboarVO.getCrpos_time())+ ",");
			//���X�һݭn��
			SimpleDateFormat date = new SimpleDateFormat("d", Locale.US); 
			SimpleDateFormat month = new SimpleDateFormat("MMM", Locale.US); 
			SimpleDateFormat year = new SimpleDateFormat("yyyy", Locale.US); 
			System.out.print(date.format(courboarVO.getCrpos_time())+ ",");
			System.out.print((month.format(courboarVO.getCrpos_time())).toString().toUpperCase()+ ",");
			System.out.print(year.format(courboarVO.getCrpos_time())+ ",");
			//�������X
//			System.out.print(courboarVO.getCrpos_time() + ",");
			System.out.print("COUR000001"+ ",");
			System.out.print(courboarVO.getMem_id() + ",");
			System.out.print(courboarVO.getCrpos_text() + ",");
			System.out.print(courboarVO.getCrpos_sta());
			System.out.println("");
		}
//		
		// findByKeyWord
//		List<CourBoarVO>CourBoar_list = courboar_dao.findByKeyWord("�R","COUR000001");
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
