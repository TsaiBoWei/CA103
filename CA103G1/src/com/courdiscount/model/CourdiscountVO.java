package com.courdiscount.model;

public class CourdiscountVO implements java.io.Serializable{
	String discountkey;
	String finaldiscount;
	String discountcour_id;
	String expiredateval;
	
	
	public String getDiscountkey() {
		return discountkey;
	}
	public void setDiscountkey(String discountkey) {
		this.discountkey = discountkey;
	}
	public String getFinaldiscount() {
		return finaldiscount;
	}
	public void setFinaldiscount(String finaldiscount) {
		this.finaldiscount = finaldiscount;
	}
	public String getDiscountcour_id() {
		return discountcour_id;
	}
	public void setDiscountcour_id(String discountcour_id) {
		this.discountcour_id = discountcour_id;
	}
	public String getExpiredateval() {
		return expiredateval;
	}
	public void setExpiredateval(String expiredateval) {
		this.expiredateval = expiredateval;
	}

}
