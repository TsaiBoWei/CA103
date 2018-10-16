package com.watchedhr.model;
import java.util.*;

public interface WatchedhrDAO_interface {
	
	public void insert(WatchedhrVO watchedhrVO);
    public void update(WatchedhrVO watchedhrVO);
    
    
  //ashley
    public Double getWatchSum(String crorder_id);
    public List <String> getCour_unit_idByCrorder_id(String crorder_id);
    public Double getWatched_hr(String crorder_id, String cour_unit_id );
    public WatchedhrVO getFirstByCrorder_id(String crorder_id);
}
