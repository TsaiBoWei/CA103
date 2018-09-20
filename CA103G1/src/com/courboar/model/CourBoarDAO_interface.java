package com.courboar.model;

import java.util.List;

public interface CourBoarDAO_interface {
 void add(CourBoarVO courboar_vo);
 void update(CourBoarVO courboar_vo);
 void hide(String crpost_id);
 CourBoarVO findByPK(String crpost_id);
 List<CourBoarVO> findByCour_id(String cour_id);
 List<CourBoarVO> findByKeyWord(String keyWord,String cour_id);
}