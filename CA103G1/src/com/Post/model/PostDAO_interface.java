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
	
	public List<PostVO> getByMemIDToDisplay(String mem_id);
	
	public PostVO findByPKToDisplay(String post_id);
	
    //首頁用
    public List<PostVO> getNewPost();
    //首頁用
    public List<PostVO> getPopularPost();
    
    //update view
    public void updateView(PostVO postVO);
    
    public List<PostVO> getByMemIDToHomePage(String mem_id);
    
    public List<PostVO> getByMemIDToHomePageToFriend(String mem_id);
}
