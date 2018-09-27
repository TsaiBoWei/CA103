package com.postreport.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class PostReportJDBCDAO implements PostReportDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "CA103";
	String password = "123456";

	private static final String INSERT_STMT = "INSERT INTO postreport(postre_id,post_id,mem_id,postre_item,postre_cont,postre_time,postre_status,reply_mgr_id) VALUES('PSRE'||LPAD(to_char(postreport_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-PO000001',?,?,?,sysdate,'PSREST1',?)";
	private static final String UPDATE_STMT = "UPDATE postreport set postre_item=?,postre_status = ? where postre_id=?";
	private static final String GET_ONE_STMT = "SELECT post_id ,mem_id,postre_item,postre_cont,to_char(postre_time,'yyyy-mm-dd hh24:mi:ss')postre_time,postre_status,reply_mgr_id FROM postreport where postre_id=? ";
	private static final String DELETE = "DELETE FROM postre_id = ?";
	private static final String GET_ALL_STMT = "SELECT post_id,mem_id,postre_item,postre_cont,to_char(postre_time , 'yyyy-mm-dd hh24:mi:ss' )postre_time,postre_status,reply_mgr_id FROM postreport order by postre_status ";

	@Override
	public void insert(PostReportVO postReportVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, postReportVO.getMem_id());
			pstmt.setString(2, postReportVO.getPostre_item());
			pstmt.setString(3, postReportVO.getPostre_cont());
			pstmt.setString(4, postReportVO.getReply_mgr_id());
			pstmt.executeQuery();

		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
			;
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}

	}

	@Override
	public void update(PostReportVO postReportVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, postReportVO.getPostre_item());
			pstmt.setString(2, postReportVO.getPostre_status());
			pstmt.setString(3, postReportVO.getPostre_id());

			pstmt.executeUpdate();
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}

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

	public static void main(String[] args) {

		PostReportJDBCDAO dao = new PostReportJDBCDAO();

		// 新增
		PostReportVO postreportVO = new PostReportVO();

		postreportVO.setMem_id("M000001");
		postreportVO.setPostre_item("PSREIT1");
		postreportVO.setPostre_cont("貼文檢舉內容測試中4");
		postreportVO.setReply_mgr_id("MGR000001");
		dao.insert(postreportVO);
		System.out.println("都流進去資料庫惹>///<");

		// 修改

		PostReportVO postreportVO2 = new PostReportVO();

		postreportVO2.setPostre_item("PSTRIT3");
		postreportVO2.setPostre_status("PSREST3");
		postreportVO2.setReply_mgr_id("M000001");
		dao.update(postreportVO2);
		System.out.println("資料都流進去資料庫鬧了");
	}

}
