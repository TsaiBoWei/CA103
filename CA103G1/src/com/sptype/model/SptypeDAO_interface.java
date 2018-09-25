package com.sptype.model;
import java.util.*;

public interface SptypeDAO_interface {
	public void insert(SptypeVO sptypeVO);
    public void update(SptypeVO sptypeVO);
    public void delete(String sptype_id);
    public SptypeVO findByPK(String sptype_id);
    public List<SptypeVO> getAll();
}
