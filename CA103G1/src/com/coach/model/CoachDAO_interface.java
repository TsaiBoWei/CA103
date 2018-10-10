package com.coach.model;
import java.util.*;

public interface CoachDAO_interface {
	public void insert(CoachVO coachVO);
    public void update(CoachVO coachVO);
    public CoachVO findByPK(String coa_id);
    public List<CoachVO> getAll();
//    public void hide(CoachVO coachVO);
//    public void select(CoachVO coachVO);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<CourlistVO> getAll(Map<String, String[]> map); 
    /*********************�z�g***********************/
    public List<CoachVO> getByReview();
    public List<CoachVO> getByReviewEnd();
    public void updateStatus(String coa_id,String coa_status);
    /*********************�z�g***********************/

}
