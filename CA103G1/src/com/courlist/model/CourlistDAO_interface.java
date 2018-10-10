package com.courlist.model;
import java.util.*;

public interface CourlistDAO_interface {
	public void insert(CourlistVO courlistVO);
    public void update(CourlistVO courlistVO);
    public void delete(String cour_id);
    public CourlistVO findByPK(String cour_id);
    public List<CourlistVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<CourlistVO> getAll(Map<String, String[]> map); 
    //ashley
    public List<CourlistVO>getCourlistByCoa_id(String coa_id);
}
