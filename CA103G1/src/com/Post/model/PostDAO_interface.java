package com.Post.model;

import java.util.List;


public interface PostDAO_interface {
	void add(PostVO postVO);
	void update(PostVO postVO);
	void delete(String post_id);
	PostVO findByPK(String post_id);
	List<PostVO> getAll();
	
	void updateStatus(PostVO postVO);
	public List<PostVO> getByMemID( String mem_id );
}
