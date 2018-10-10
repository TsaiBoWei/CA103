package com.courunit.model;
import java.util.*;

public interface CourunitDAO_interface {
	public void insert(CourunitVO courunitVO);
    public void update(CourunitVO courunitVO);
    public void delete(String cour_unit_id);
    public CourunitVO findByPK(String cour_unit_id);
    public List<CourunitVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<CourlistVO> getAll(Map<String, String[]> map); 
    
    
    
    //ashley
    public List<CourunitVO> getCourUnitwithoutVideo(String cour_id);
    public Double getUnitSum(String cour_id);


}
