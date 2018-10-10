package com.boardres.model;

import java.sql.Timestamp;
import java.util.List;

import com.courboar.model.CourBoarDAO;
import com.courboar.model.CourBoarVO;

public class BoardresService {
	private BoardresDAO_interface dao;

	public BoardresService() {
		dao = new BoardresDAO();
	}

	public String addBoardres(Timestamp crres_time, String crpost_id, String mem_id, String crres_text) {

		BoardresVO boardresVO = new BoardresVO();
		boardresVO.setCrres_time(crres_time);
		boardresVO.setCrpost_id(crpost_id);
		boardresVO.setMem_id(mem_id);
		boardresVO.setCrres_text(crres_text);
		String crres_id=dao.add(boardresVO);

		return crres_id;

	}

	public BoardresVO updateBoardres(String crres_id, String crres_text) {

		BoardresVO boardresVO = new BoardresVO();

		boardresVO.setCrres_id(crres_id);
		boardresVO.setCrres_text(crres_text);

		dao.update(boardresVO);
		return boardresVO;
	}

	public void hideBoardres(String crres_sta, String crres_id) {

		dao.hide(crres_sta, crres_id);
	}

	public List<BoardresVO> getCrpostReply(String crpost_id) {
		return dao.findByCrpostId(crpost_id);
	}

	public BoardresVO getOneBoardres(String crres_id) {
		return dao.findByPK(crres_id);
	}
	
	public Integer getReplyCount(String crpost_id) {
		return dao.getCountByCrostId(crpost_id);
	}

}
