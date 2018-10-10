package com.coach.model;
import java.util.*;

public interface CoachDAO_interface {
	public void insert(CoachVO coachVO);
    public void update(CoachVO coachVO);
    public CoachVO findByPK(String coa_id);
    public List<CoachVO> getAll();
//    public void hide(CoachVO coachVO);
//    public void select(CoachVO coachVO);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<CourlistVO> getAll(Map<String, String[]> map); 
    
    //ashley
    public CoachVO findByMem_Id(String mem_id);
}
