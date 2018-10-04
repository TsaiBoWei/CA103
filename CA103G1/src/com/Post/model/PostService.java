package com.Post.model;

import java.sql.Timestamp;
import java.util.List;



public class PostService {
	private PostDAO_interface dao;
	public PostService() {
		dao = new PostDAO();
	}
	
   public PostVO addPost(String post_id,String mem_id,String post_con,Timestamp post_time,
		Integer post_view,String sptype_id,String post_title,String post_privacy) {
		PostVO postVO = new PostVO();
		
		postVO.setPost_id(post_id);
		postVO.setMem_id(mem_id);
		postVO.setPost_con(post_con);
		postVO.setPost_time(post_time);
		postVO.setPost_view(post_view);
		postVO.setSptype_id(sptype_id);
		postVO.setPost_title(post_title);
		postVO.setPost_privacy(post_privacy);
		dao.add(postVO);
		
		return postVO;
	}
	
   public PostVO updatePost(String post_id,String mem_id,String post_con,Timestamp post_time,Integer post_view,
			String sptype_id,String post_status,String post_title,String post_privacy)
		{
		
		PostVO postVO = new PostVO();
		postVO.setPost_id(post_id);
		postVO.setMem_id(mem_id);
		postVO.setPost_con(post_con);
		postVO.setPost_time(post_time);
		postVO.setPost_view(post_view);
		postVO.setSptype_id(sptype_id);
		postVO.setPost_status(post_status);
		postVO.setPost_title(post_title);
		postVO.setPost_privacy(post_privacy);
		
		dao.update(postVO);
		
		return postVO;
	}
	
   public void deletePost(String post_id) {
		 dao.delete(post_id);
	}
	
   public PostVO getOnePost(String post_id) {
		return dao.findByPK(post_id);
		
	}
	
   public List<PostVO> getAll(){
		return dao.getAll();
	}
	
   public PostVO updatePostStatus(String post_id,String post_status) 
	
		{
		PostVO postVO = new PostVO();
		postVO.setPost_id(post_id);
		postVO.setPost_status(post_status);
		dao.updateStatus(postVO);
		
		
		return postVO;
	}
	
   public List<PostVO> getByMemID( String mem_id ) {
		return dao.getByMemID(mem_id);
   } 
}
