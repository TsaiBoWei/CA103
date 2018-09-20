package com.city.model;

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

public class CityDAO implements CityDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA103G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT="INSERT INTO CITY(CITY_ID,CITY_NAME) VALUES(?,?)";
	private static final String GET_ALL_STMT="SELECT CITY_ID,CITY_NAME FROM CITY ORDER BY CITY_ID ";
	private static final String GET_ONE_STMT ="SELECT CITY_ID,CITY_NAME FROM CITY WHERE CITY_ID=?";
	private static final String UPDATE = "UPDATE CITY SET CITY_NAME=? WHERE CITY_ID=?";
	private static final String DELETE="DELETE FROM CITY WHERE CITY_ID=?";
	
	@Override
	public void insert(CityVO cityVO) {
		Connection con=null;
		try{
			con = ds.getConnection();
			PreparedStatement pstmt=con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,cityVO.getCity_id());
			pstmt.setString(2, cityVO.getCity_name());
			pstmt.executeUpdate();
		
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if(con!=null) {
				try{
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}		
	}

	@Override
	public void update(CityVO cityVO) {
		Connection con=null;
		try{
			con = ds.getConnection();
			PreparedStatement pstmt=con.prepareStatement(UPDATE);			
			pstmt.setString(1, cityVO.getCity_name());
			pstmt.setString(2,cityVO.getCity_id());
			pstmt.executeUpdate();
		
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if(con!=null) {
				try{
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void delete(String city_id) {
		Connection con=null;
		try{
			con = ds.getConnection();
			PreparedStatement pstmt=con.prepareStatement(DELETE);			
			pstmt.setString(1, city_id);
			pstmt.executeUpdate();
		
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if(con!=null) {
				try{
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public CityVO findByPrimaryKey(String city_id) {
		CityVO cityVO=new CityVO();
		Connection con=null;
		try{
			con = ds.getConnection();
			PreparedStatement pstmt=con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, city_id);			
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			cityVO.setCity_id(city_id);
			cityVO.setCity_name(rs.getString("CITY_NAME"));
			
			
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if(con!=null) {
				try{
					con.close();
				}catch(SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return cityVO;
	}

	@Override
	public List<CityVO> getAll() {
		List<CityVO> list=new ArrayList<>();
		Connection con=null;
		try{
			con = ds.getConnection();
			PreparedStatement pstmt=con.prepareStatement(GET_ALL_STMT);			
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				CityVO cityVO=new CityVO();
				cityVO.setCity_id(rs.getString("CITY_ID"));
				cityVO.setCity_name(rs.getString("CITY_NAME"));
				list.add(cityVO);			
			};
						
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if(con!=null) {
				try{
					con.close();
				}catch(SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

}
