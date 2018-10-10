package com.courdiscount.model;

import redis.clients.jedis.Jedis;

public class CourdiscountDAO implements CourdiscountDAO_interface {
	
	@Override
	public CourdiscountVO findByPK(String discountkey) {
		Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		CourdiscountVO courdiscountVO=new CourdiscountVO();
		courdiscountVO.setFinaldiscount(jedis.hget(discountkey, "finaldiscount"));
		courdiscountVO.setDiscountcour_id(jedis.hget(discountkey, "discountcour_id"));
		courdiscountVO.setDiscountcour_id(jedis.hget(discountkey, "expiredateval"));
		jedis.close();
		return courdiscountVO;
		
	}
   
}
