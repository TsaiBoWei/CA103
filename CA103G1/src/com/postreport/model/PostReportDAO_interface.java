package com.postreport.model;

import java.util.List;

public interface PostReportDAO_interface {

	public void insert(PostReportVO postReportVO);

	public void update(PostReportVO postReportVO);

	public void delete(PostReportVO postReportVO);

	public PostReportVO findByPrimaryKey(String postre_id);

	public List<PostReportVO> getAll();

}
