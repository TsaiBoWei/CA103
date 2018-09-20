package com.purchcour.model;

import java.util.List;

public interface PurchCourDAO_interface {
  void add(PurchCourVO purchcour_vo);
  void updateScore(Integer coursco,String crorder_id);
  void updateRefund(String refund,String crorder_id);
  List<PurchCourVO> findByPK(String crorder_id);
  List<PurchCourVO> findByMem_id(String mem_id);
  List<PurchCourVO> findByKeyWord(String keyWord,String mem_id);
  //顯示進度未加
  
}