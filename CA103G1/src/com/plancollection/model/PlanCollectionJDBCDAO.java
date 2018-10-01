package com.plancollection.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PlanCollectionJDBCDAO implements PlanCollectionDAO_interface {
	
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String userId = "CA103";
	private static final String psw = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO PLANCOLLECTION(PLAN_COL_ID,PLAN_COL_MEM_ID,CREAT_PLAN_MEM_ID,PLAN_COL_NAME,PLAN_COL_VO,PLAN_COLSTART_DATE,PLAN_COLCREAT_TIME,PLAN_COL_STATUS) VALUES(?,?,?,?,?,?,?,?)";
	private static final String UPDATE_STMT = 
			"UPDATE PLANCOLLECTION SET PLAN_COL_MEM_ID = ?,CREAT_PLAN_MEM_ID = ?,PLAN_COL_NAME = ?,PLAN_COL_VO = ?,PLAN_COLSTART_DATE = ?,PLAN_COLCREAT_TIME = ?,PLAN_COL_STATUS = ? WHERE PLAN_COL_ID = ?";
	private static final String DELETE_STMT = 
			"DELETE FROM  PLANCOLLECTION WHERE PLAN_COL_ID = ?";
	private static final String GET_ONE = 
			"SELECT * FROM  PLANCOLLECTION WHERE PLAN_COL_ID = ?";
	private static final String GET_ALL = 
			"SELECT * FROM  PLANCOLLECTION";
	private static final String UPDATE_STATUS = 
			"UPDATE MEM set plan_col_status=? where plan_col_id=?";
	
	
	@Override
	public void insert(PlanCollectionVO planCollectionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, planCollectionVO.getPlan_col_id());
			pstmt.setString(2, planCollectionVO.getPlan_col_mem_id());			
			pstmt.setString(3, planCollectionVO.getCreat_plan_mem_id());
			pstmt.setString(4, planCollectionVO.getPlan_col_name());
			pstmt.setString(5, planCollectionVO.getPlan_col_vo());
			pstmt.setDate(6, planCollectionVO.getPlan_colstart_date());
			pstmt.setTimestamp(7, planCollectionVO.getplan_colcreat_time());
			pstmt.setString(8, planCollectionVO.getPlan_col_status());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A DB error occured.");
		}finally {
			if (pstmt != null) {
				try {
					 pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					 con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(PlanCollectionVO planCollectionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, planCollectionVO.getPlan_col_mem_id());			
			pstmt.setString(2, planCollectionVO.getCreat_plan_mem_id());
			pstmt.setString(3, planCollectionVO.getPlan_col_name());
			pstmt.setString(4, planCollectionVO.getPlan_col_vo());
			pstmt.setDate(5, planCollectionVO.getPlan_colstart_date());
			pstmt.setTimestamp(6, planCollectionVO.getplan_colcreat_time());
			pstmt.setString(7, planCollectionVO.getPlan_col_status());
			pstmt.setString(8, planCollectionVO.getPlan_col_id());
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A DB error occured.");
		}finally {
			if (pstmt != null) {
				try {
					 pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					 con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update_states(String plan_col_id, String plan_col_status) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, plan_col_status);
			pstmt.setString(2, plan_col_id);
	
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
		}finally {
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
	public PlanCollectionVO findByPrimaryKey(String plan_col_id) {
		PlanCollectionVO planCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(GET_ONE);
			
			pstmt.setString(1, plan_col_id);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				planCollectionVO = new PlanCollectionVO();
				planCollectionVO.setPlan_col_mem_id(rs.getString("PLAN_COL_MEM_ID"));
				planCollectionVO.setCreat_plan_mem_id(rs.getString("CREAT_PLAN_MEM_ID"));
				planCollectionVO.setPlan_col_name(rs.getString("PLAN_COL_NAME"));
				planCollectionVO.setPlan_col_vo(rs.getString("PLAN_COL_VO"));
				planCollectionVO.setPlan_colstart_date(rs.getDate("PLAN_COLSTART_DATE"));
				planCollectionVO.setplan_colcreat_time(rs.getTimestamp("PLAN_COLCREAT_TIME"));
				planCollectionVO.setPlan_col_status(rs.getString("PLAN_COL_STATUS"));

				
			}
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			
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
		return planCollectionVO;
	}

	@Override
	public List<PlanCollectionVO> getAll() {
		List<PlanCollectionVO> list = new ArrayList<PlanCollectionVO>();
		PlanCollectionVO planCollectionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(GET_ALL);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				planCollectionVO = new PlanCollectionVO();
				planCollectionVO.setPlan_col_id(rs.getString("plan_col_id"));
				planCollectionVO.setPlan_col_mem_id(rs.getString("PLAN_COL_MEM_ID"));
				planCollectionVO.setCreat_plan_mem_id(rs.getString("CREAT_PLAN_MEM_ID"));
				planCollectionVO.setPlan_col_name(rs.getString("PLAN_COL_NAME"));
				planCollectionVO.setPlan_col_vo(rs.getString("PLAN_COL_VO"));
				planCollectionVO.setPlan_colstart_date(rs.getDate("PLAN_COLSTART_DATE"));
				planCollectionVO.setplan_colcreat_time(rs.getTimestamp("PLAN_COLCREAT_TIME"));
				planCollectionVO.setPlan_col_status(rs.getString("PLAN_COL_STATUS"));
				list.add(planCollectionVO);
			}
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se){
					se.printStackTrace(System.err);
				}
			}
			
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
		return list;
	}

	@Override
	public void delete(String plan_col_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userId,psw);
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, plan_col_id);
			
			pstmt.executeUpdate();
			
		}catch(ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A DB error occured.");
		}finally {
			if (pstmt != null) {
				try {
					 pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					 con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	
	public static void main(String[] args) {
		
		PlanCollectionJDBCDAO dao = new PlanCollectionJDBCDAO();

		// 新增
		PlanCollectionVO planCollectionVO1 = new PlanCollectionVO();
		planCollectionVO1.setPlan_col_id("PLAN000004");
		planCollectionVO1.setPlan_col_mem_id("M000001");
		planCollectionVO1.setCreat_plan_mem_id("M000002");
		planCollectionVO1.setPlan_col_name("3週打造完美V型人魚線");
		planCollectionVO1.setPlan_col_vo("1000");
		planCollectionVO1.setplan_colcreat_time(java.sql.Timestamp.valueOf("2018-09-09 22:22:22"));
		planCollectionVO1.setPlan_colstart_date(Date.valueOf("1970-01-06"));
		planCollectionVO1.setPlan_col_status("PCS01");
		dao.insert(planCollectionVO1);
		System.out.println("successed");
//		
		//修改
//		PlanCollectionVO planCollectionVO2 = new PlanCollectionVO();
//		planCollectionVO2.setPlan_col_id("PLAN000002");
//		planCollectionVO2.setPlan_col_mem_id("M000001");
//		planCollectionVO2.setCreat_plan_mem_id("M000002");
//		planCollectionVO2.setPlan_col_name("3週打造完美鮪魚肚");
//		planCollectionVO2.setPlan_col_vo("1000");
//		planCollectionVO2.setplan_colcreat_time(java.sql.Timestamp.valueOf("2018-09-09 22:22:22"));
//		planCollectionVO2.setPlan_colstart_date(Date.valueOf("1970-01-06"));
//		planCollectionVO2.setPlan_col_status("PCS01");
//		dao.update(planCollectionVO2);
		
		//刪除
//		dao.delete("PLAN000002");
//		System.out.println("資料庫刪除成功");
		
//		查詢
//		PlanCollectionVO planCollectionVO3 = dao.findByPrimaryKey("PLAN000002");
//		System.out.print(planCollectionVO3.getPlan_col_mem_id()+",");
//		System.out.print(planCollectionVO3.getCreat_plan_mem_id() + ",");
//		System.out.print(planCollectionVO3.getPlan_col_name()+ ",");
//		System.out.print(planCollectionVO3.getPlan_col_vo() + ",");
//		System.out.print(planCollectionVO3.getPlan_colstart_date() + ",");
//		System.out.print(planCollectionVO3.getplan_colcreat_time()+ ",");
//		System.out.println(planCollectionVO3.getPlan_col_status());
//		System.out.println("--------------------------------------------------------------------------");
//		
//		List<PlanCollectionVO> list = dao.getAll();
//		for(PlanCollectionVO planCollectionVO4 : list) {
//			System.out.print(planCollectionVO4.getPlan_col_id()+",");
//			System.out.print(planCollectionVO4.getPlan_col_mem_id()+",");
//			System.out.print(planCollectionVO4.getCreat_plan_mem_id() + ",");
//			System.out.print(planCollectionVO4.getPlan_col_name()+ ",");
//			System.out.print(planCollectionVO4.getPlan_col_vo() + ",");
//			System.out.print(planCollectionVO4.getPlan_colstart_date() + ",");
//			System.out.print(planCollectionVO4.getplan_colcreat_time()+ ",");
//			System.out.println(planCollectionVO4.getPlan_col_status());
//			System.out.println("--------------------------------------------------------------------------");
//		}
	}

}
