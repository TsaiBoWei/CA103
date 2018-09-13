package com.city.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class CityJDBCDAO implements CityDAO_interface{
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	String userid="CA103";
	String passwd="123456";
	
	private static final String INSERT_STMT="INSERT INTO CITY(CITY_ID,CITY_NAME) VALUES(?,?)";
	private static final String GET_ALL_STMT="SELECT CITY_ID,CITY_NAME FROM CITY ORDER BY CITY_ID ";
	private static final String GET_ONE_STMT ="SELECT CITY_ID,CITY_NAME FROM CITY WHERE CITY_ID=?";
	private static final String UPDATE = "UPDATE CITY SET CITY_NAME=? WHERE CITY_ID=?";
	private static final String DELETE="DELETE FROM CITY WHERE CITY_ID=?";
	@Override
	public void insert(CityVO cityVO) {
		Connection con=null;
		try{
			Class.forName(driver);
			 con=DriverManager.getConnection(url, userid, passwd);
			PreparedStatement pstmt=con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,cityVO.getCity_id());
			pstmt.setString(2, cityVO.getCity_name());
			pstmt.executeUpdate();
		
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			 con=DriverManager.getConnection(url, userid, passwd);
			PreparedStatement pstmt=con.prepareStatement(UPDATE);			
			pstmt.setString(1, cityVO.getCity_name());
			pstmt.setString(2,cityVO.getCity_id());
			pstmt.executeUpdate();
		
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			 con=DriverManager.getConnection(url, userid, passwd);
			PreparedStatement pstmt=con.prepareStatement(DELETE);			
			pstmt.setString(1, city_id);
			pstmt.executeUpdate();
		
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			con=DriverManager.getConnection(url, userid, passwd);
			PreparedStatement pstmt=con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, city_id);			
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			cityVO.setCity_id(city_id);
			cityVO.setCity_name(rs.getString("CITY_NAME"));
			
			
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			con=DriverManager.getConnection(url, userid, passwd);
			PreparedStatement pstmt=con.prepareStatement(GET_ALL_STMT);			
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				CityVO cityVO=new CityVO();
				cityVO.setCity_id(rs.getString("CITY_ID"));
				cityVO.setCity_name(rs.getString("CITY_NAME"));
				list.add(cityVO);			
			};
						
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
		
		

	public static void main(String args[]) {
		CityJDBCDAO dao=new CityJDBCDAO();
		//新增
//		CityVO cityVO=new CityVO();
//		cityVO.setCity_id("CITY04");
//		cityVO.setCity_name("新竹市");
//		dao.insert(cityVO);
		//修改
//		CityVO cityVO1=new CityVO();
//		cityVO1.setCity_id("CITY04");
//		cityVO1.setCity_name("新竹縣");
//		dao.update(cityVO1);
		
		//刪除
//		dao.delete("CITY04");
		
		//查一	
//		CityVO cityVO2=dao.findByPrimaryKey("CITY01");
//		System.out.println(cityVO2.getCity_id());
//		System.out.println(cityVO2.getCity_name());
		
		//查全部
		List<CityVO> list=dao.getAll();
		for(CityVO cityVO3:list) {
			System.out.println(cityVO3.getCity_id());
			System.out.println(cityVO3.getCity_name());
			System.out.println("======================");
		}
		
		
	}

}
