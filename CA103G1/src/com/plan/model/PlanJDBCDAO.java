package com.plan.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//JDBCDAO 使用建立連線 連線。
//plan_view 計畫瀏覽次數需在點擊該計畫時，自行加1，尚未確認。
//plan_start_date  ,  plan_end_date  時間表示方法還未健全。
//沒有刪除方法，使用計畫名稱關鍵字找到該計畫之方法尚未完成。

public class PlanJDBCDAO implements PlanDAO_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA103";
	String password = "123456";

	private static final String INSERT_STMT = "INSERT INTO plan(plan_id,mem_id,plan_name,plan_vo,plan_cover,plan_start_date,plan_end_date,sptype_id,plan_view,plan_privacy,plan_create_time,plan_status) VALUES ('PLAN'||LPAD(to_char(plan_seq.NEXTVAL),6,'0'),?,?,?,?,?,?,?,0,?,sysdate,'PLANST0')";
	private static final String UPDATE = "UPDATE plan set plan_name=?, plan_vo=?, plan_cover=?,plan_start_date=? ,plan_end_date=? , sptype_id=?, plan_privacy=?, plan_status=? where plan_id = ? ";
	private static final String GET_ONE_STMT = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date ,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd')plan_create_time,plan_status FROM plan where plan_id = ?";
	private static final String DELETE = "DELETE FROM plan where plan_id=?";

	// 自訂方法(尚未完成)
	private static final String GET_ONE_STMT2 = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd'),plan_create_time,plan_status FROM plan where plan_name =?";

	private static final String GET_ALL_STMT = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date ,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd')plan_create_time,plan_status FROM plan order by plan_id ";

	@Override
	public void insert(PlanVO planVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, password);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, planVO.getMem_id());
			pstmt.setString(2, planVO.getPlan_name());
			pstmt.setString(3, planVO.getPlan_vo());
			pstmt.setBytes(4, planVO.getPlan_cover());
			pstmt.setTimestamp(5, planVO.getPlan_start_date());
			pstmt.setTimestamp(6, planVO.getPlan_end_date());
			pstmt.setString(7, planVO.getSptype_id());
			pstmt.setString(8, planVO.getPlan_privacy());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(PlanVO planVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, password);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, planVO.getPlan_name());
			pstmt.setString(2, planVO.getPlan_vo());
			pstmt.setBytes(3, planVO.getPlan_cover());
			pstmt.setTimestamp(4, planVO.getPlan_start_date());
			pstmt.setTimestamp(5, planVO.getPlan_end_date());
			pstmt.setString(6, planVO.getSptype_id());
			pstmt.setString(7, planVO.getPlan_privacy());
			pstmt.setString(8, planVO.getPlan_status());
			pstmt.setString(9, planVO.getPlan_id());

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

	public void delete(String plan_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, password);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, "plan_id");
			pstmt.executeUpdate();

		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("Couldn't load database driver. " + ce.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}

		}

	}

	@Override
	public PlanVO findByPrimaryKey(String plan_id) {

		PlanVO planVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, plan_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				planVO = new PlanVO();
				planVO.setPlan_id(rs.getString("plan_id"));
				planVO.setMem_id(rs.getString("mem_id"));
				planVO.setPlan_name(rs.getString("plan_name"));
				planVO.setPlan_vo(rs.getString("plan_vo"));
				planVO.setPlan_cover(rs.getBytes("plan_cover"));
				planVO.setPlan_start_date(rs.getTimestamp("plan_start_date"));
				planVO.setPlan_end_date(rs.getTimestamp("plan_end_date"));
				planVO.setSptype_id(rs.getString("sptype_id"));
				planVO.setPlan_view(rs.getInt("plan_view"));
				planVO.setPlan_privacy(rs.getString("plan_privacy"));
				planVO.setPlan_create_time(rs.getDate("plan_create_time"));
				planVO.setPlan_status(rs.getString("plan_status"));
			}
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}

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

		return planVO;
	}

	// 子串比對找出關鍵字，未完成。
	@Override
	public PlanVO findPlanByKeyWord(String plan_name) {

//		PlanVO planVO = null;
//		String keyWord = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ONE_STMT2);
//		
//			
//		} catch (ClassNotFoundException ce) {
//			ce.printStackTrace();
//		}catch(SQLException se) {
//			throw new RuntimeException("A database error occurred. " + se.getMessage());
//		}			
		return null;
	}

	@Override
	public List<PlanVO> getAll() {

		List<PlanVO> list = new ArrayList<PlanVO>();
		PlanVO planVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, password);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				planVO = new PlanVO();
				planVO.setPlan_id(rs.getString("plan_id"));
				planVO.setMem_id(rs.getString("mem_id"));
				planVO.setPlan_name(rs.getString("plan_name"));
				planVO.setPlan_vo(rs.getString("plan_vo"));
				planVO.setPlan_cover(rs.getBytes("plan_cover"));
				planVO.setPlan_start_date(rs.getTimestamp("plan_start_date"));
				planVO.setPlan_end_date(rs.getTimestamp("plan_end_date"));
				planVO.setSptype_id(rs.getString("sptype_id"));
				planVO.setPlan_view(rs.getInt("plan_view"));
				planVO.setPlan_privacy(rs.getString("plan_privacy"));
				planVO.setPlan_create_time(rs.getDate("plan_create_time"));
				planVO.setPlan_status(rs.getString("plan_status"));
				list.add(planVO);
			}
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		} catch (SQLException se) {
			se.printStackTrace();
//			throw new RuntimeException("A database error occurred. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

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
		return list;
	}

	public static void main(String[] args) {
		PlanJDBCDAO dao = new PlanJDBCDAO();

		try {
			File file = new File("WebContent/front_end/plan/images/workitout2.png");
			FileInputStream fis = new FileInputStream(file);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();

			int i;
			while ((i = fis.read()) != -1) {
				baos.write(i);
			}

			byte[] bt = baos.toByteArray();

			// 新增
			PlanVO planVO1 = new PlanVO();
			planVO1.setMem_id("M000003");
			planVO1.setPlan_name("計畫名稱不得超過中文20字剛剛好20字測試中");
			planVO1.setPlan_vo("計畫內容測試");
			planVO1.setPlan_cover(bt);
			planVO1.setPlan_start_date(java.sql.Timestamp.valueOf("2018-09-09 22:22:22"));
			planVO1.setPlan_end_date(java.sql.Timestamp.valueOf("2018-10-10 22:22:22"));
			planVO1.setSptype_id("SP000001");
			planVO1.setPlan_privacy("PLANPR1");
			dao.insert(planVO1);

			baos.close();
			fis.close();

		} catch (FileNotFoundException e) {
			throw new RuntimeException("File not found." + e.getMessage());
		} catch (IOException e) {
			e.getMessage();
		}

		// 修改
		PlanVO planVO2 = new PlanVO();
		planVO2.setPlan_name("計畫名稱修改中1......");
		planVO2.setPlan_vo("計畫內容修改中1.....");
		planVO2.setPlan_cover(null);
		planVO2.setPlan_start_date(java.sql.Timestamp.valueOf("2018-09-10 15:15:15"));
		planVO2.setPlan_end_date(java.sql.Timestamp.valueOf("2018-09-10 16:16:16"));
		planVO2.setSptype_id("SP000003");
		planVO2.setPlan_privacy("PLANPR2");
		planVO2.setPlan_status("PLANST1");
		planVO2.setPlan_id("PLAN000001");
		dao.update(planVO2);

		// 查詢
		PlanVO planVO3 = dao.findByPrimaryKey("PLAN000002");
		System.out.print(planVO3.getPlan_id() + "\t");
		System.out.print(planVO3.getMem_id() + "\t");
		System.out.print(planVO3.getPlan_name() + "\t");
		System.out.print(planVO3.getPlan_vo() + "\t");
		System.out.print(planVO3.getPlan_cover() + "\t");
		System.out.print(planVO3.getPlan_start_date() + "\t");
		System.out.print(planVO3.getPlan_end_date() + "\t");
		System.out.print(planVO3.getSptype_id() + "\t");
		System.out.print(planVO3.getPlan_view() + "\t");
		System.out.print(planVO3.getPlan_privacy() + "\t");
		System.out.print(planVO3.getPlan_create_time() + "\t");
		System.out.print(planVO3.getPlan_status() + "\t");
		System.out.println("\n----------------------");

		// 查詢
		List<PlanVO> list = dao.getAll();
		for (PlanVO aPlan : list) {
			System.out.print(aPlan.getPlan_id() + "\t");
			System.out.print(aPlan.getMem_id() + "\t");
			System.out.print(aPlan.getPlan_name() + "\t");
			System.out.print(aPlan.getPlan_vo() + "\t");
			System.out.print(aPlan.getPlan_cover() + "\t");
			System.out.print(aPlan.getPlan_start_date() + "\t");
			System.out.print(aPlan.getPlan_end_date() + "\t");
			System.out.print(aPlan.getSptype_id() + "\t");
			System.out.print(aPlan.getPlan_view() + "\t");
			System.out.print(aPlan.getPlan_privacy() + "\t");
			System.out.print(aPlan.getPlan_create_time() + "\t");
			System.out.print(aPlan.getPlan_status() + "\t");
			System.out.println();
		}

	}

}
