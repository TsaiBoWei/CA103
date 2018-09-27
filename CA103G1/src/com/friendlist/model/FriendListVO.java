package com.friendlist.model;

public class FriendListVO implements java.io.Serializable {
	private String fl_memA_id;
	private String fl_memB_id;
	private String fl_friend_name;
	private String fl_status;
	private String fl_block;
	
//	2018/9/20新增
	public FriendListVO() {
		super();
	}
	
//	2018/9/20新增
	public FriendListVO(String fl_memA_id, String fl_memB_id, String fl_friend_name, String fl_status,
			String fl_block) {
		super();
		this.fl_memA_id = fl_memA_id;
		this.fl_memB_id = fl_memB_id;
		this.fl_friend_name = fl_friend_name;
		this.fl_status = fl_status;
		this.fl_block = fl_block;
	}


	public String getFl_memA_id() {
		return fl_memA_id;
	}
	public void setFl_memA_id(String fl_memA_id) {
		this.fl_memA_id = fl_memA_id;
	}
	public String getFl_memB_id() {
		return fl_memB_id;
	}
	public void setFl_memB_id(String fl_memB_id) {
		this.fl_memB_id = fl_memB_id;
	}
	public String getFl_friend_name() {
		return fl_friend_name;
	}
	public void setFl_friend_name(String fl_friend_name) {
		this.fl_friend_name = fl_friend_name;
	}
	public String getFl_status() {
		return fl_status;
	}
	public void setFl_status(String fl_status) {
		this.fl_status = fl_status;
	}
	public String getFl_block() {
		return fl_block;
	}
	public void setFl_block(String fl_block) {
		this.fl_block = fl_block;
	}
	 
}
