/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *        所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package com.eve.model;

import java.util.*;

public class JdbcUtil_CompositeQuery_Eve {

	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("keyword".equals(columnName)) // 用於varchar
			aCondition = "(eve_title like '%" + value + "%' or eve_location like '%"+ value+ "%' or eve_content like '%"+value+ "%' or mem_name like '%"+value+ "%' or city_name like '%"+value+ "%' or sport like '%"+value+ "%')" ;
		else if("city_id".equals(columnName) || "sptype_id".equals(columnName)) {
			aCondition = columnName + " like '%" + value + "%'";
		}
		return aCondition + " ";
	}
	

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		StringBuffer timeCondition = new StringBuffer();
		
		int count = 0; 
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& ("keyword".equals(key)|| "city_id".equals(key)|| "sptype_id".equals(key))) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				whereCondition.append(" and " + aCondition);
				
//				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		String eve_startdate=map.get("eve_startdate")[0];
		String eve_enddate=map.get("eve_enddate")[0];
		
		if (eve_startdate != null && eve_startdate.trim().length() != 0 && eve_enddate != null && eve_enddate.trim().length() != 0) {
			timeCondition.append(" and ((to_char(eve_startdate,'yyyy-mm-dd hh24:mi')>='"+eve_startdate+"' and to_char(eve_startdate,'yyyy-mm-dd hh24:mi')<='"+eve_enddate+"')");
			timeCondition.append(" or (to_char(eve_enddate,'yyyy-mm-dd hh24:mi')>='"+eve_startdate+"' and to_char(eve_enddate,'yyyy-mm-dd hh24:mi')<='"+eve_enddate+"')");
			timeCondition.append(" or (to_char(eve_startdate,'yyyy-mm-dd hh24:mi')<='"+eve_startdate+"' and to_char(eve_enddate,'yyyy-mm-dd hh24:mi')>='"+eve_enddate+"')) " );
//			System.out.println("timeCondition : "+timeCondition.toString());
			whereCondition.append(timeCondition);			
		}
		
		String eve_charge=map.get("eve_charge")[0];
		if (eve_charge != null && eve_charge.trim().length() != 0 ) {
			switch(eve_charge) {
			case "0": 
				whereCondition.append(" and eve_charge=0 ");
				break;
			case "300":	
				whereCondition.append(" and eve_charge>0 and eve_charge<=300 ");
				break;
			case "500":	
				whereCondition.append(" and eve_charge>=300 and eve_charge<=500 ");
				break;
			case "1000":	
				whereCondition.append(" and eve_charge>=500 and eve_charge<=100 ");
				break;
			case "1001":	
				whereCondition.append(" and eve_charge>=1000 ");
				break;
			}
		}
				
		String orderBy=map.get("orderBy")[0];
		switch(orderBy) {
		case "hot": 
			whereCondition.append(" order by eve_view desc");
			break;
		case "eve_startdate":	
			whereCondition.append(" order by eve_startdate");
			break;
		case "new":	
			whereCondition.append(" order by eve_id desc");
			
		}
		
		
		return whereCondition.toString();
	}

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("keyword", new String[] { "A" });
		map.put("city_id", new String[] { "CITY03" });
		map.put("sptype_id", new String[] { "SP000003" });
		map.put("eve_startdate", new String[] { "2018-08-01 03:00" });
		map.put("eve_enddate", new String[] { "2018-11-30 04:00" });
		map.put("eve_charge", new String[] { "0" });
		map.put("orderBy", new String[] { "hot" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from EVENT JOIN mem using(mem_id) JOIN city using(city_id) JOIN sptype using(sptype_id) WHERE (EVE_STATUS='E2' OR EVE_STATUS='E3' OR EVE_STATUS='E4')"
				          + JdbcUtil_CompositeQuery_Eve.get_WhereCondition(map)
				        ;
//		System.out.println("●●finalSQL = " + finalSQL);

	}
}
