package com.Mgr.model;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.Mgr.model.MgrDAO_interface;

public class MgrJNDIDAO  implements MgrDAO_interface {
	 private static DataSource ds = null;
	 static {
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
	 

	private static final String INSERT_STMT = 
		"INSERT INTO MGR(mgr_id,mgr_account,mgr_name,mgr_password,mgr_photo,mgr_Mail,mgr_status)values('MGR'||LPAD(to_char(mgr_seq.NEXTVAL),6,'0'),?,?,?,?,?,'MGS0')";
	
	
	private static final String UPDATE_STMT = 
		"UPDATE MGR SET MGR_ACCOUNT = ?, MGR_NAME = ?, MGR_PASSWORD = ?,mgr_photo = ?,mgr_Mail = ?,mgr_status = ? WHERE MGR_ID = ?";
	private static final String DELETE_STMT = 
		"DELETE FROM MGR WHERE MGR_ID = ?";
	private static final String FIND_BY_PK = 
		"SELECT * FROM MGR WHERE MGR_ID = ?";
	private static final String GET_ALL = 
		"SELECT * FROM MGR";
	private static final String UPDATE_MGR_STATUS = "UPDATE MGR SET MGR_STATUS = ? WHERE MGR_ID = ?";
	private static final String FIND_BY_LOGIN = 
		"SELECT * FROM MGR WHERE MGR_ACCOUNT = ? AND MGR_PASSWORD = ?";
	
	private static final String INSERT_MGRRG_STMT = 
			"INSERT INTO MGR(mgr_id,mgr_account,mgr_name,mgr_password,mgr_photo,mgr_Mail,mgr_status)values('MGR'||LPAD(to_char(mgr_seq.NEXTVAL),6,'0'),?,?,?,?,?,'MGS0')";
	
	private static final String FIND_BY_LOST_PASSWORD = 
			"SELECT * FROM MGR WHERE MGR_ACCOUNT = ? AND MGR_MAIL = ?";
	
	
	@Override
	public void add(MgrVO mgrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			pstmt.setString(1,mgrVO.getMgr_account());
			pstmt.setString(2,mgrVO.getMgr_name());
			pstmt.setString(3,mgrVO.getMgr_password());
			pstmt.setBytes(4,mgrVO.getMgr_photo());
			pstmt.setString(5,mgrVO.getMgr_mail());
//			pstmt.setString(6,mgrVO.getMgr_status());
			pstmt.executeUpdate();
			
		
		}
		
		catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
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
	public void update(MgrVO mgrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1,mgrVO.getMgr_account());
			pstmt.setString(2,mgrVO.getMgr_name());
			pstmt.setString(3,mgrVO.getMgr_password());
			pstmt.setBytes(4,mgrVO.getMgr_photo());
			pstmt.setString(5,mgrVO.getMgr_mail());
			pstmt.setString(6,mgrVO.getMgr_status()); 
			pstmt.setString(7,mgrVO.getMgr_id()); 
			
			pstmt.executeUpdate();
		}
		
		catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
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
	public void delete(String mgr_id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				
				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE_STMT);
				
				
				pstmt.setString(1,mgr_id);	
				pstmt.executeUpdate();
				
			
			}
//			
			
			catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			
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
	public MgrVO findByPK(String mgr_id) {
			MgrVO mgrVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs =null;
			try {

			
				con = ds.getConnection();
				pstmt = con.prepareStatement(FIND_BY_PK);
				pstmt.setString(1, mgr_id);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					mgrVO = new MgrVO();
					mgrVO.setMgr_id(rs.getString("MGR_ID"));
					mgrVO.setMgr_account(rs.getString("MGR_ACCOUNT"));
					mgrVO.setMgr_name(rs.getString("MGR_NAME"));
					mgrVO.setMgr_password(rs.getString("MGR_PASSWORD"));
					mgrVO.setMgr_photo(rs.getBytes("MGR_PHOTO"));
					mgrVO.setMgr_mail(rs.getString("MGR_MAIL"));
					mgrVO.setMgr_status(rs.getString("MGR_STATUS"));
				}

			
				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
				// Clean up JDBC resources
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

			return mgrVO;
	}

	@Override
	public List<MgrVO> getAll() {
		List<MgrVO> mgrList = new ArrayList<>();
		MgrVO mgrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {


			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mgrVO = new MgrVO();
				mgrVO.setMgr_id(rs.getString("MGR_ID"));
				mgrVO.setMgr_account(rs.getString("MGR_ACCOUNT"));
				mgrVO.setMgr_name(rs.getString("MGR_NAME"));
				mgrVO.setMgr_password(rs.getString("MGR_PASSWORD"));
				mgrVO.setMgr_photo(rs.getBytes("MGR_PHOTO"));
				mgrVO.setMgr_mail(rs.getString("MGR_MAIL"));
				mgrVO.setMgr_status(rs.getString("MGR_STATUS"));
				mgrList.add(mgrVO);
			}

		
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
		return mgrList;
		
	}
	
	@Override
	public void updateStatus(MgrVO mgrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MGR_STATUS);
			
			

			
			pstmt.setString(1,mgrVO.getMgr_status()); 
			pstmt.setString(2,mgrVO.getMgr_id()); 
			
			pstmt.executeUpdate();
			
		
		}
		
		catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
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
	public MgrVO findByLogin(String mgr_account, String mgr_password) {
		MgrVO mgrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {

		
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_LOGIN);
			pstmt.setString(1, mgr_account);
			pstmt.setString(2, mgr_password);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mgrVO = new MgrVO();
				mgrVO.setMgr_id(rs.getString("MGR_ID"));
				mgrVO.setMgr_account(rs.getString("MGR_ACCOUNT"));
				mgrVO.setMgr_name(rs.getString("MGR_NAME"));
				mgrVO.setMgr_password(rs.getString("MGR_PASSWORD"));
				mgrVO.setMgr_photo(rs.getBytes("MGR_PHOTO"));
				mgrVO.setMgr_mail(rs.getString("MGR_MAIL"));
				mgrVO.setMgr_status(rs.getString("MGR_STATUS"));
			}

		
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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

		return mgrVO;
	}


	public static byte[] getPictureByteArray(String path) throws IOException {
	File file = new File(path);
	FileInputStream fis = new FileInputStream(file);
	//緩衝區baos預設是32byte
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	byte[] buffer = new byte[8192];
	int i;
	//讀取fis中8192(buffer的length)個byte資料，放入buffer陣列,直到i=-1(取完)
	while ((i = fis.read(buffer)) != -1) {
		baos.write(buffer, 0, i);
	}
	baos.close();
	fis.close();
	
	return baos.toByteArray();
	}	
	
	
//	public static String password() {
//		StringBuffer mgrPassword = new StringBuffer();
//		String str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//		
//		for (int i = 0; i < 10 ; i++) {
//			int n = (int)((Math.random()*61+1));
//			char c = str.charAt(n);
//			mgrPassword.append(c);
//		}
//		
//		mgrPassword.toString();
//		return mgrPassword.toString();
//	}

	@Override
	public void addmgr(MgrVO mgrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_MGRRG_STMT);
			
			
			pstmt.setString(1,mgrVO.getMgr_account());
			pstmt.setString(2,mgrVO.getMgr_name());
			pstmt.setString(3,mgrVO.getMgr_password());
			pstmt.setBytes(4,mgrVO.getMgr_photo());
			pstmt.setString(5,mgrVO.getMgr_mail());
			
			pstmt.executeUpdate();
			
		
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
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
	public MgrVO findByLostPS(String mgr_account, String mgr_mail) {
		MgrVO mgrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {

		
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_LOST_PASSWORD);
			pstmt.setString(1, mgr_account);
			pstmt.setString(2, mgr_mail);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mgrVO = new MgrVO();
				mgrVO.setMgr_id(rs.getString("MGR_ID"));
				mgrVO.setMgr_account(rs.getString("MGR_ACCOUNT"));
				mgrVO.setMgr_name(rs.getString("MGR_NAME"));
				mgrVO.setMgr_password(rs.getString("MGR_PASSWORD"));
				mgrVO.setMgr_photo(rs.getBytes("MGR_PHOTO"));
				mgrVO.setMgr_mail(rs.getString("MGR_MAIL"));
				mgrVO.setMgr_status(rs.getString("MGR_STATUS"));
			}

		
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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

		return mgrVO;
		}
}
