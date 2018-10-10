package com.purchcour.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PurchCourDAO implements PurchCourDAO_interface {
//	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
//	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
//	private static final String USER = "PROJECTTEST";
//	private static final String PASSWORD = "123456";

//  SQL
	private static final String INSERT_STMT = "INSERT INTO PURCHCOUR(CRORDER_ID,CRORDER_TIME,COUR_ID,MEM_ID,REFUND)"
			+ "VALUES('CO'||LPAD(to_char(purchcour_seq.NEXTVAL), 6, '0'),?, ?, ?,'CO1')";
	private static final String UPDATE_SCORE_STMT = "UPDATE PURCHCOUR SET COURSCO = ? WHERE CRORDER_ID= ? AND REFUND='CO1'"; // 預設未退訂
	private static final String UPDATE_REFUND_STMT = "UPDATE PURCHCOUR SET REFUND = ? WHERE CRORDER_ID= ? ";
	private static final String FIND_BY_MEM_ID = "SELECT * FROM PURCHCOUR WHERE MEM_ID=? AND NOT REFUND='CO3' ORDER BY CRORDER_ID";// 展示清單用
	private static final String FIND_BY_MEM_ID_FOR_OWNCOURSE = "SELECT COUR_ID FROM PURCHCOUR WHERE MEM_ID=? AND NOT REFUND='CO3' ORDER BY CRORDER_ID";// 偵錯用
	private static final String FIND_BY_PK = "SELECT * FROM PURCHCOUR WHERE CRORDER_ID=?";

	private static final String FIND_BY_KEYWORD = "SELECT COURLIST.CNAME,COURLIST.COUR_COST,SPTYPE.SPORT, MEM.MEM_NAME FROM (((COURLIST LEFT JOIN PURCHCOUR ON COURLIST.COUR_ID=PURCHCOUR.COUR_ID)LEFT JOIN SPTYPE ON COURLIST.SPTYPE_ID=SPTYPE.SPTYPE_ID)LEFT JOIN COACH ON COURLIST.COA_ID=COACH.COA_ID)LEFT JOIN MEM ON COACH.MEM_ID =MEM.MEM_ID WHERE COURLIST.CNAME LIKE ? AND PURCHCOUR.MEM_ID=?";
	private static final String FIND_BY_COURID_MEM_ID = "SELECT CRORDER_ID FROM PURCHCOUR WHERE COUR_ID=? AND MEM_ID=? AND REFUND='CO1'";
	private static final String COUR_COUNT="SELECT COUR_ID, COUNT(*) AS COUNT FROM PURCHCOUR WHERE COUR_ID=? GROUP BY COUR_ID";
	private static final String COUR_COUNT_NOT_REFUND="SELECT COUNT(*) AS COUNT FROM PURCHCOUR WHERE REFUND='CO1'AND COUR_ID=? GROUP BY COUR_ID";
	private static final String COUR_COUNT_REFUND="SELECT COUNT(*) AS COUNT FROM PURCHCOUR WHERE REFUND='CO2'AND COUR_ID=? GROUP BY COUR_ID";
	private static final String FIND_BY_COUR_ID="SELECT * FROM PURCHCOUR WHERE NOT REFUND='CO3'AND COUR_ID=? ORDER BY REFUND DESC";
	
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	@Override
	public String add(PurchCourVO purchcourVo) {
		Connection con = null;
		PreparedStatement pstmt = null;
        String crorder_id=null;
		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			String cols[] = { "crorder_id" };
			pstmt = con.prepareStatement(INSERT_STMT,cols);

			pstmt.setDate(1, purchcourVo.getCrorder_time());
			pstmt.setString(2, purchcourVo.getCour_id());
			pstmt.setString(3, purchcourVo.getMem_id());

			pstmt.executeUpdate();
			
            ResultSet rs = pstmt.getGeneratedKeys();//用rs去取到主鍵值
			
			if (rs.next()) {
				crorder_id = rs.getString(1);
				System.out.println("自增主鍵值 = " + crorder_id );
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
		return crorder_id;
	}

	@Override
	public void updateScore(Double coursco, String crorder_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SCORE_STMT);

			pstmt.setDouble(1, coursco);
			pstmt.setString(2, crorder_id);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void updateRefund(String refund, String crorder_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			Class.forName(DRIVER);
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_REFUND_STMT);

			pstmt.setString(1, refund);
			pstmt.setString(2, crorder_id);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public PurchCourVO findByPK(String crorder_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		PurchCourVO purchcourVO = null;
	

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			
			pstmt.setString(1, crorder_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				purchcourVO = new PurchCourVO();
				purchcourVO.setCrorder_id(rs.getString("CRORDER_ID"));
				purchcourVO.setCrorder_time(rs.getDate("CRORDER_TIME"));
				purchcourVO.setMem_id(rs.getString("MEM_ID"));
				purchcourVO.setCour_id(rs.getString("COUR_ID"));
				purchcourVO.setRefund(rs.getString("REFUND"));
				purchcourVO.setCoursco(rs.getDouble("COURSCO"));
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return purchcourVO;
	}

	@Override
	public List<PurchCourVO> findByMem_id(String mem_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		PurchCourVO purchcourVO = null;
		List<PurchCourVO> purchcour_List = new ArrayList<>();

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MEM_ID);
			
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				purchcourVO = new PurchCourVO();
				purchcourVO.setCrorder_id(rs.getString("CRORDER_ID"));
				purchcourVO.setCrorder_time(rs.getDate("CRORDER_TIME"));
				purchcourVO.setMem_id(rs.getString("MEM_ID"));
				purchcourVO.setCour_id(rs.getString("COUR_ID"));
				purchcourVO.setRefund(rs.getString("REFUND"));
				purchcourVO.setCoursco(rs.getDouble("COURSCO"));
				purchcour_List.add(purchcourVO);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return purchcour_List;

	}

	// join
	@Override
	public List<PurchCourVO> findByKeyWord(String keyWord, String mem_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	 public List<String> findMemOwnCourse(String mem_id) {
	  Connection con = null;
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;

	  String cour_id = null;
	  List<String> courList = new ArrayList<>();

	  try {
	//   con = DriverManager.getConnection(URL, USER, PASSWORD);
	   con = ds.getConnection();
	   pstmt = con.prepareStatement(FIND_BY_MEM_ID_FOR_OWNCOURSE);
	   
	   pstmt.setString(1, mem_id);
	   rs = pstmt.executeQuery();
	   while (rs.next()) {
	    
	    cour_id=rs.getString("COUR_ID");
	    
	    courList.add(cour_id);
	   }

	  } catch (SQLException e) {
	   // TODO Auto-generated catch block
	   e.printStackTrace();
	  } finally {
	   if (pstmt != null) {
	    try {
	     pstmt.close();
	    } catch (SQLException e) {
	     e.printStackTrace();
	    }
	   }

	   if (con != null) {
	    try {
	     con.close();
	    } catch (SQLException e) {
	     e.printStackTrace();
	    }
	   }
	  }

	  return courList;

	 }

	@Override
	public String findByCourId_MenId(String cour_id, String mem_id) {
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;

		  String crorder_id = null;
		

		  try {
		//   con = DriverManager.getConnection(URL, USER, PASSWORD);
		   con = ds.getConnection();
		   pstmt = con.prepareStatement(FIND_BY_COURID_MEM_ID);
		   
		   pstmt.setString(1, cour_id);
		   pstmt.setString(2, mem_id);
		   rs = pstmt.executeQuery();
		   while (rs.next()) {
		    
			 crorder_id=rs.getString("CRORDER_ID");
System.out.println("DAO,crorder_id"+crorder_id);		 
		   }

		  } catch (SQLException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  } finally {
		   if (pstmt != null) {
		    try {
		     pstmt.close();
		    } catch (SQLException e) {
		     e.printStackTrace();
		    }
		   }

		   if (con != null) {
		    try {
		     con.close();
		    } catch (SQLException e) {
		     e.printStackTrace();
		    }
		   }
		  }

		  return crorder_id;

		 }

	

	@Override
	public Integer getCountByNotRefundCourId(String cour_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer count=0;

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(COUR_COUNT_NOT_REFUND);
			pstmt.setString(1, cour_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count=rs.getInt("COUNT");
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return count;
	
	}

	@Override
	public Integer getCountByRefundCourId(String cour_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer count=0;

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(COUR_COUNT_REFUND);
			pstmt.setString(1, cour_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count=rs.getInt("COUNT");
				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return count;
	
	}

	@Override
	public List<PurchCourVO> findByCour_id(String cour_id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		PurchCourVO purchcourVO = null;
		List<PurchCourVO> list = new ArrayList<>();

		try {
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_COUR_ID);
			
			pstmt.setString(1, cour_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				purchcourVO = new PurchCourVO();
				purchcourVO.setCrorder_id(rs.getString("CRORDER_ID"));
				purchcourVO.setCrorder_time(rs.getDate("CRORDER_TIME"));
				purchcourVO.setMem_id(rs.getString("MEM_ID"));
				purchcourVO.setCour_id(rs.getString("COUR_ID"));
				purchcourVO.setRefund(rs.getString("REFUND"));
				purchcourVO.setCoursco(rs.getDouble("COURSCO"));
				list.add(purchcourVO);
				System.out.println("rs.getString(\"REFUND\") = " + rs.getString("REFUND"));
			}
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return list;

	}
	

}