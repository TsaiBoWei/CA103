package com.plancollection.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PlanCollectionDAO implements PlanCollectionDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, plan_col_status);
			pstmt.setString(2, plan_col_id);
	
			pstmt.executeUpdate();
			
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setString(1, plan_col_id);
			
			pstmt.executeUpdate();
			
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

}
