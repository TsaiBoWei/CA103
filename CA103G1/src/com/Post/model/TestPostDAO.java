package com.Post.model;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import com.Post.model.PostDAOJDBC;

public class TestPostDAO {

	public static void main(String[] args) throws IOException{
		PostDAOJDBC dao = new PostDAOJDBC();
		Timestamp time= new Timestamp(System.currentTimeMillis());
		// 新增
		PostVO post1 = new PostVO();
		post1.setMem_id("M000004");
		post1.setPost_con("安安你好");
		post1.setPost_time(time);
		post1.setPost_view(15);
		post1.setSptype_id("SP000003");
		dao.add(post1);
		
		//修改
//		PostVO post2 = new PostVO();
//		post2.setPost_id("20180909-PO000001");
//		post2.setMem_id("M000001");
//		post2.setPost_con("不要封鎖我QQQQ");
//		post2.setPost_time(time);
//		post2.setPost_view(15);
//		post2.setSptype_id("SP000003");
//		post2.setPost_status("POS1");
//		dao.update(post2);
		
		//刪除
//		dao.delete("20180910-PO000004");
		
		
//		查詢
//		PostVO post4 = dao.findByPK("20180909-PO000001");
//		System.out.print(post4.getMem_id() + ",");
//		System.out.print(post4.getPost_con() + ",");
//		System.out.print(post4.getPost_time() + ",");
//		System.out.print(post4.getPost_view() + ",");
//		System.out.print(post4.getSptype_id() + ",");
//		System.out.println(post4.getPost_status());
//		System.out.println("---------------------");
////		
		// 查詢
//		List<PostVO> list = dao.getAll();
//		for (PostVO post5 : list) {
//			System.out.print(post5.getMem_id() + ",");
//			System.out.print(post5.getPost_con() + ",");
//			System.out.print(post5.getPost_time() + ",");
//			System.out.print(post5.getPost_view() + ",");
//			System.out.print(post5.getSptype_id() + ",");
//			System.out.println(post5.getPost_status());
//			System.out.println();}

		
	}

	
}
