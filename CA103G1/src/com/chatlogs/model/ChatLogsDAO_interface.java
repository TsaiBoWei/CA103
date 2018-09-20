package com.chatlogs.model;

import java.util.List;

public interface ChatLogsDAO_interface {
	public void insert(ChatLogsVO chatlogsVO);
	public void update(ChatLogsVO chatlogsVO);
	public void delete(String chat_id);
	public ChatLogsVO findByPrimaryKey(String chat_id);
	public List<ChatLogsVO> getAll();
}
