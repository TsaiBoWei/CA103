package com.plancollection.model;

import java.util.List;

public interface PlanCollectionDAO_interface {
    public void insert(PlanCollectionVO planCollectionVO);
    public void update(PlanCollectionVO planCollectionVO);
    public void update_states(String plan_col_id , String plan_col_status);
    public void delete(String plan_col_id);
    public PlanCollectionVO findByPrimaryKey(String plan_col_id);
    public List<PlanCollectionVO> getAll();

}
