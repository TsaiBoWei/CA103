package com.memreport.model_cancel;

import java.util.List;

public class MemReportJDBCDAO implements MemReportDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "Practice";
	String password = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO MEMREPORT(memre_id,mem_reporter_id,mem_reported_id,memre_item,memre_cont,memre_time,memre_status,reply_mgrid) values ('MRE'||LPAD(to_char(memreport_seq.NEXTVAL),6,'0'),?,?,?,?,?,?,?)";
	private static final String UPDATE = "UPDATE memreport set";
	private static final String GET_ONE_STMT = "";
	
	
	@Override
	public void insert(MemReportVO memreportVO) {

		
		
	}

	@Override
	public void update(MemReportVO memreportVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemReportVO findByPrimaryKey(String memre_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemReportVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

}
