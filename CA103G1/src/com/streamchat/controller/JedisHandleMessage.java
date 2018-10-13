package com.streamchat.controller;

import java.util.List;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleMessage {
	// ���d��key���]�p��(�o�e�̦W��:�����̦W��)�A������ĥ�(�o�e�̷|���s��:�����̷|���s��)

	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public static List<String> getHistoryMsg(String chat_id) {

		String key = chat_id;
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange(key, 0, jedis.llen(key) - 1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String chat_id, String message) {
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.rpush(chat_id, message);

		jedis.close();
	}

}

