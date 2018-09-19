package com.evecomment.model;

import java.util.List;

public interface EveCommentDAO_interface {
    public void insert(EveCommentVO eveCommentVO);
    public void update(EveCommentVO eveCommentVO);
    public void updateStatus(String ecomment_id,String ecom_status);
    public EveCommentVO findByPrimaryKey(String ecomment_id);
    public List<EveCommentVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EveCommentVO> getAll(Map<String, String[]> map); 
//  public void delete(String ecomment_id);

}
