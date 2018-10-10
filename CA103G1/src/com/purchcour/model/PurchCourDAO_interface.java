package com.purchcour.model;

import java.util.List;

public interface PurchCourDAO_interface {
  String add(PurchCourVO purchcourVO);
  void updateScore(Double coursco,String crorder_id);
  void updateRefund(String refund,String crorder_id);
  PurchCourVO findByPK(String crorder_id);
  List<PurchCourVO> findByMem_id(String mem_id);
  List<String> findMemOwnCourse(String mem_id);
  List<PurchCourVO> findByKeyWord(String keyWord,String mem_id);
  String findByCourId_MenId(String cour_id,String mem_id);
 
  
  
  Integer getCountByNotRefundCourId(String cour_id);
  Integer getCountByRefundCourId(String cour_id);
  List<PurchCourVO> findByCour_id(String cour_id);

  
}