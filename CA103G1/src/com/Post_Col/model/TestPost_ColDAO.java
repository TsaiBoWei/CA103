package com.Post_Col.model;

import java.io.IOException;
import java.util.List;


import com.Post_Col.model.Post_ColDAOJDBC;

public class TestPost_ColDAO {
	public static void main(String[] args) throws IOException{
		Post_ColDAOJDBC dao = new Post_ColDAOJDBC();
		
		// �s�W
//		Post_ColVO post_col1 = new Post_ColVO();
//		post_col1.setPost_id("20180909-PO000001");
//		post_col1.setMem_id("M000004");
//		post_col1.setPost_colStatus("POCOS0");
//		dao.add(post_col1);
		
		//�ק�
//		Post_ColVO post_col2 = new Post_ColVO();
//		post_col2.setPost_id("20180909-PO000001");
//		post_col2.setMem_id("M000003");
//		post_col2.setPost_colStatus("POCOS1");
//		dao.update(post_col2);
		
		//�R��
//		dao.delete("20180909-PO000001","M000003");
		
//		�d��
//		Post_ColVO post_col4= dao.findByPK("20180909-PO000001","M000001");
//		System.out.print(post_col4.getPost_id() + ",");
//		System.out.print(post_col4.getMem_id() + ",");
//		System.out.println(post_col4.getPost_colStatus() + ",");
//		System.out.println("---------------------");
		
		// �d��
//		List<Post_ColVO> list = dao.getAll();
//		for (Post_ColVO post_col5 : list) {
//		System.out.print(post_col5.getPost_id() + ",");
//		System.out.print(post_col5.getMem_id() + ",");
//		System.out.print(post_col5.getPost_colStatus() + ",");
//		System.out.println();}
	} 
}
