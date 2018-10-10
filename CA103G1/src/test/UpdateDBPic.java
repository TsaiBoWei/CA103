package test;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class UpdateDBPic {
	
	static String driver = "oracle.jdbc.driver.OracleDriver";
	static String url = "jdbc:oracle:thin:@localhost:1521:XE";
	static String userid = "CA103";
	static String passwd = "123456";
	
	private static final String UPDATE_PIC="UPDATE EVENT SET EVE_LOGO=? WHERE EVE_ID=?";
	
	public static void main(String args[]) {
		updatePic();
	}
	
	//假資料圖片用
	public  static void updatePic(){
		int row=5;	//要更新的table的總筆數
		Connection con = null;
		PreparedStatement pstmt = null;
		FileInputStream fi=null;
		ByteArrayOutputStream baos=null;
		byte[] pic=null;			
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_PIC);
			//存放圖片的資料夾路徑
			File[] files=new File("C:\\Users\\Java\\Desktop\\images\\chat").listFiles();
			for(int i=1;i<=row;i++) {
				File file=files[i];
				System.out.println(file.getName());
				
				fi=new FileInputStream(file);
				baos=new ByteArrayOutputStream();
				
				byte[] buffer=new byte[fi.available()];
				fi.read(buffer);
				baos.write(buffer);
				pic=baos.toByteArray();	
				
				pstmt.setBytes(1,pic);
				pstmt.setString(2,"E00000"+7);				
				pstmt.executeUpdate();				
			}
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			
			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
			if(baos!=null) {
				try {
					baos.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
			if (fi != null) {
				try {
					fi.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

}
