package com.plan.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//DAO與JNDIDAO相同，只差在類別名稱不同。
//plan_start_date  ,  plan_end_date  , plan_create_time  時間表示方法還未健全。
//沒有刪除方法，使用計畫名稱關鍵字找到該計畫之方法尚未完成。

public class PlanDAO implements PlanDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO plan(plan_id,mem_id,plan_name,plan_vo,plan_cover,plan_start_date,plan_end_date,sptype_id,plan_view,plan_privacy,plan_create_time,plan_status) VALUES (plan_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,sysdate,'PLANST0')";
	private static final String UPDATE = "UPDATE plan set plan_name=?, plan_vo=?, plan_cover=?,plan_start_date=? ,plan_end_date=? , sptype_id=?, plan_privacy=?, plan_status=? where plan_id = ? ";
	private static final String GET_ONE_STMT = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd')plan_create_time,plan_status FROM plan where plan_id = ?";
	private static final String DELETE = "DELETE FROM plan where plan_id=?";
	private static final String GET_ALL_STMT = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date ,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd')plan_create_time,plan_status FROM plan order by plan_id ";
	private static final String GET_ALL_FOR_VISITOR = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date ,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd')plan_create_time,plan_status  FROM plan  where plan_privacy = 'PLANPR0' order by plan_id";
	
	/********************* 1010 首頁用 *****************/
	private static final String GET_NEW_PLAN="select * from" + 
			"(select plan_id,mem_id,plan_name,plan_view,sptype_id from plan order by plan_id desc)" + 
			"where rownum < 7";
	private static final String GET_POPULAR_PLAN="select * from" + 
			"(select plan_id,mem_id,plan_name,plan_view,sptype_id  from plan order by plan_view desc)" + 
			"where rownum < 7";
	/*************************************************/
	
	//以會員id查詢計畫
		private static final String GET_PLAN_BY_MEM_ID = "SELECT plan_id,mem_id,plan_name,plan_vo,plan_cover,to_char(plan_start_date ,'yyyy-mm-dd hh24:mi:ss')plan_start_date,to_char(plan_end_date,'yyyy-mm-dd hh24:mi:ss')plan_end_date,sptype_id,plan_view,plan_privacy,to_char(plan_create_time,'yyyy-mm-dd')plan_create_time,plan_status FROM plan where mem_id=? AND plan_STATUS != 'PLANST2'";
		//更新計畫(行事曆)
		private static final String UPDATE_CAL = "UPDATE plan set plan_name=?, plan_vo=?,plan_start_date=? ,plan_end_date=?  where plan_id = ? ";
		//刪除計畫(行事曆)
		private static final String UPDATE_PLAN_STATUS_CAL = "UPDATE plan set plan_status=? where plan_id=?";

	
	@Override
	public void insert(PlanVO planVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, planVO.getMem_id());
			pstmt.setString(2, planVO.getPlan_name());
			pstmt.setString(3, planVO.getPlan_vo());
			pstmt.setBytes(4, planVO.getPlan_cover());
			pstmt.setTimestamp(5, planVO.getPlan_start_date());
			pstmt.setTimestamp(6, planVO.getPlan_end_date());
			pstmt.setString(7, planVO.getSptype_id());
			pstmt.setInt(8, planVO.getPlan_view());
			pstmt.setString(9, planVO.getPlan_privacy());

			pstmt.executeUpdate();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, planVO.getPlan_name());
			pstmt.setString(2, planVO.getPlan_vo());
			pstmt.setBytes(3, planVO.getPlan_cover());
			pstmt.setTimestamp(4, planVO.getPlan_start_date());
			pstmt.setTimestamp(5, planVO.getPlan_end_date());
			pstmt.setString(6, planVO.getSptype_id());
			pstmt.setString(7, planVO.getPlan_privacy());
			pstmt.setString(8, planVO.getPlan_status());

			pstmt.executeUpdate();

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
	public void delete(String plan_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, "plan_id");

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
			con = ds.getConnection();
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

	@Override
	public List<PlanVO> getAllforVisitor() {
		List<PlanVO> list = new ArrayList<PlanVO>();
		PlanVO planVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_FOR_VISITOR);
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

		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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

	@Override
	public List<PlanVO> getAll() {
		List<PlanVO> list = new ArrayList<PlanVO>();
		PlanVO planVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
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

		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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
	
	
	/**************** 1004增加計畫dao(僅於PlanDAO增加實際方法) ******************/
	@Override
	public List<PlanVO> getPlansByMem(String mem_id) {
		List<PlanVO> list = new ArrayList<PlanVO>();
		PlanVO planVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_PLAN_BY_MEM_ID);
			pstmt.setString(1,mem_id);
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

		} catch (SQLException se) {
			throw new RuntimeException("A database error occurred. " + se.getMessage());
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

	@Override
	public void updateInCal(PlanVO planVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_CAL);

			pstmt.setString(1, planVO.getPlan_name());
			pstmt.setString(2, planVO.getPlan_vo());			
			pstmt.setTimestamp(3, planVO.getPlan_start_date());
			pstmt.setTimestamp(4, planVO.getPlan_end_date());
			pstmt.setString(5, planVO.getPlan_id());

			pstmt.executeUpdate();

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
	public void updatePlanStatusCal(String plan_id, String plan_status) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PLAN_STATUS_CAL);
			
			pstmt.setString(1, plan_status);
			pstmt.setString(2, plan_id);		
			
			pstmt.executeUpdate();
			
			// Handle any SQL errors
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

	/***************************************************************/

	@Override
	public List<PlanVO> getAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/********************* 1010 首頁用 *********************************/
	@Override
	public List<PlanVO> getNewPlan(){
		List<PlanVO> list = new ArrayList<PlanVO>();
		PlanVO planVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_NEW_PLAN);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				planVO = new PlanVO();
				planVO.setPlan_id(rs.getString("plan_id"));
				planVO.setMem_id(rs.getString("mem_id"));
				planVO.setPlan_name(rs.getString("plan_name"));
				planVO.setSptype_id(rs.getString("sptype_id"));
				planVO.setPlan_view(rs.getInt("plan_view"));
				list.add(planVO);
			}
		
		} catch (SQLException se) {
			se.printStackTrace();
//			throw new RuntimeException("A database error occurred. " + se.getMessage());
		} finally {
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
		return list;
		
	};
	
	@Override
    public List<PlanVO> getPopularPlan(){
		List<PlanVO> list = new ArrayList<PlanVO>();
		PlanVO planVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_POPULAR_PLAN);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				planVO = new PlanVO();
				planVO.setPlan_id(rs.getString("plan_id"));
				planVO.setMem_id(rs.getString("mem_id"));
				planVO.setPlan_name(rs.getString("plan_name"));
				planVO.setSptype_id(rs.getString("sptype_id"));
				planVO.setPlan_view(rs.getInt("plan_view"));
				list.add(planVO);
			}
		
		} catch (SQLException se) {
			se.printStackTrace();
//			throw new RuntimeException("A database error occurred. " + se.getMessage());
		} finally {
			
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
		return list;
		
	};
	
	/******************************************************************/

}
