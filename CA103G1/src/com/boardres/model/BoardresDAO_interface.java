package com.boardres.model;

import java.util.List;

public interface BoardresDAO_interface {
	
		  String add(BoardresVO boardResVO);
		  void update(BoardresVO boardResVO);
		  void hide(String crres_sta,String crres_id);
		  void hideByCrostId(String crpost_id);
		  List<BoardresVO> findByCrpostId(String crpost_id);
		  BoardresVO findByPK(String crres_id);
		  Integer getCountByCrostId(String crpost_id);
		 
}
