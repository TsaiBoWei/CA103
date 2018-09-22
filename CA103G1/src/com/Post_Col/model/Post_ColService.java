package com.Post_Col.model;

import java.sql.Timestamp;
import java.util.List;



public class Post_ColService {
	private Post_ColDAO_interface dao;
	
	public Post_ColService() {
		dao = new Post_ColDAO();
	}
	
	  public Post_ColVO addPost_Col(String post_id,String mem_id,String post_colStatus) {
		  
				Post_ColVO post_colVO = new Post_ColVO();
				post_colVO.setPost_id(post_id);
				post_colVO.setMem_id(mem_id);
				post_colVO.setPost_colStatus(post_colStatus);
				dao.add(post_colVO);
				
				return post_colVO;
			}
			
			public Post_ColVO updatePost_Col(String post_id,String mem_id,String post_colStatus)
				{
				
				Post_ColVO post_colVO = new Post_ColVO();
				post_colVO.setPost_id(post_id);
				post_colVO.setMem_id(mem_id);
				post_colVO.setPost_colStatus(post_colStatus);
				dao.update(post_colVO);
				
				return post_colVO;
			}
			
			public void deletePost_Col(String post_id,String mem_id) {
				 dao.delete(post_id,mem_id);
			}
			
			public Post_ColVO getOnePost(String post_id,String mem_id) {
				return dao.findByPK(post_id,mem_id);
				
			}
			
			public List<Post_ColVO> getAll(){
				return dao.getAll();
			}
			
			
			
}
