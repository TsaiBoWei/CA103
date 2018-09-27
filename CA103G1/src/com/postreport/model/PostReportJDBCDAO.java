package com.postreport.model;

import java.util.List;

public class PostReportJDBCDAO implements PostReportDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "CA103";
	String password = "123456";

	private static final String INSERT_STMT = "INSERT INTO postreport(postre_id,post_id,mem_id,postre_item,postre_cont,postre_time,postre_status) VALUES('PSRE'||LPAD(to_char(postreport_seq.NEXTVAL),6,'0'),?,?,?,?,?,'PSREST1',?)";
	private static final String UPDATE_STMT = "UPDATE postreport set postre_item=?,postre_status where postre_id=?";
	private static final String GET_ONE_STMT = "SELECT post_id ,mem_id,postre_item,postre_cont,to_char(postre_time,'yyyy-mm-dd hh24:mi:ss')postre_time,postre_status,reply_mgr_id FROM postreport where postre_id=? ";
	private static final String DELETE = "DELETE FROM postre_id = ?";
	private static final String GET_ALL_STMT = "SELECT post_id,mem_id,postre_item,postre_cont,to_char(postre_time , 'yyyy-mm-dd hh24:mi:ss' )postre_time,postre_status,reply_mgr_id FROM postreport order by postre_status ";

	@Override
	public void insert(PostReportVO postReportVO) {

	}

	@Override
	public void update(PostReportVO postReportVO) {

	}

	@Override
	public void delete(PostReportVO postReportVO) {

	}

	@Override
	public PostReportVO findByPrimaryKey(String postre_id) {
		return null;
	}

	@Override
	public List<PostReportVO> getAll() {
		return null;
	}

}
