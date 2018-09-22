package com.Post_Col.model;

import java.util.List;


import com.Post_Col.model.Post_ColVO;

public interface Post_ColDAO_interface {
	void add(Post_ColVO post_colVO);
	void update(Post_ColVO post_colVO);
	void delete(String post_id,String mem_id);
	Post_ColVO findByPK(String post_id,String mem_id);
	List<Post_ColVO> getAll();


}
