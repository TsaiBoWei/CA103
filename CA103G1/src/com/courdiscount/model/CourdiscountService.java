package com.courdiscount.model;



 public class CourdiscountService {
	 private CourdiscountDAO_interface dao;

		public CourdiscountService() {
			dao = new CourdiscountDAO();
		}
	 
	 
	public CourdiscountVO getOneCourdiscount(String discountkey) {
		return dao.findByPK(discountkey);
	}

}
