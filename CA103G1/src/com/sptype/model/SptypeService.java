package com.sptype.model;
import java.util.List;

import com.sptype.model.SptypeDAO_interface;
import com.sptype.model.SptypeDAO;
import com.sptype.model.SptypeVO;

public class SptypeService {
	private SptypeDAO_interface dao;

	public SptypeService() {
		dao = new SptypeDAO();
	}

	public SptypeVO addSptype(String sport, Byte[] sport_logo) {

		SptypeVO sptypeVO = new SptypeVO();

		sptypeVO.setSport(sport);
		sptypeVO.setSport_logo(sport_logo);
		dao.insert(sptypeVO);

		return sptypeVO;
	}

	public SptypeVO updateSptype(String sptype_id, String sport, Byte[] sport_logo) {

		SptypeVO sptypeVO = new SptypeVO();

		sptypeVO.setSptype_id(sptype_id);
		sptypeVO.setSport(sport);
		sptypeVO.setSport_logo(sport_logo);
		dao.insert(sptypeVO);

		return sptypeVO;
	}

	public void deleteSptype(String sptype_id) {
		dao.delete(sptype_id);
	}

	public SptypeVO getOneSptype(String sptype_id) {
		return dao.findByPK(sptype_id);
	}

	public List<SptypeVO> getAll() {
		return dao.getAll();
	}

}
