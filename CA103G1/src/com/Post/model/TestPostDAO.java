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
		// �s�W
//		PostVO post1 = new PostVO();
//		post1.setMem_id("M000004");
//		post1.setPost_con("�w�w�A�n");
//		post1.setPost_time(time);
//		post1.setPost_view(15);
//		post1.setSptype_id("SP000003");
//		post1.setPost_title("���ռ��D");
//		post1.setPost_privacy("POSTPR1");
//		dao.add(post1);
		
		//�ק�
//		PostVO post2 = new PostVO();
//		post2.setPost_id("20181004-PO000001");
//		post2.setMem_id("M000001");
//		post2.setPost_con("���n�����QQQQ");
//		post2.setPost_time(time);
//		post2.setPost_view(15);
//		post2.setSptype_id("SP000003");
//		post2.setPost_status("POS1");
//		post2.setPost_title("���ռ��D2");
//		post2.setPost_privacy("POSTPR2");
//		dao.update(post2);
		
		//�R��
//		dao.delete("20181004-PO000003");
		
		
//		�d��
//		PostVO post4 = dao.findByPK("20181004-PO000003");
//		System.out.print(post4.getMem_id() + ",");
//		System.out.print(post4.getPost_con() + ",");
//		System.out.print(post4.getPost_time() + ",");
//		System.out.print(post4.getPost_view() + ",");
//		System.out.print(post4.getSptype_id() + ",");
//		System.out.println(post4.getPost_status());
//		System.out.println(post4.getPost_title());
//		System.out.println(post4.getPost_privacy());
//		System.out.println("---------------------");
////		
		// �d��
//		List<PostVO> list = dao.getAll();
//		for (PostVO post5 : list) {
//			System.out.print(post5.getMem_id() + ",");
//			System.out.print(post5.getPost_con() + ",");
//			System.out.print(post5.getPost_time() + ",");
//			System.out.print(post5.getPost_view() + ",");
//			System.out.print(post5.getSptype_id() + ",");
//			System.out.println(post5.getPost_status());
//			System.out.println(post5.getPost_title());
//			System.out.println(post5.getPost_privacy());
//			System.out.println();}

		
	}

	
}
