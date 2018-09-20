package com.memreport.model_cancel;

import java.util.List;

public interface MemReportDAO_interface {

	public void insert(MemReportVO memreportVO);
	public void update(MemReportVO memreportVO);
	public MemReportVO findByPrimaryKey(String memre_id);
	public List<MemReportVO> getAll();
}
