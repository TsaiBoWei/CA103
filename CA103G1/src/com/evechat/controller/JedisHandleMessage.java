package com.evechat.controller;

import java.util.List;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleMessage {
	// ���d��key���]�p��(�o�e�̦W��:�����̦W��)�A������ĥ�(�o�e�̷|���s��:�����̷|���s��)

	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public static List<String> getHistoryMsg(String eve_id) {
//		String key = new StringBuilder(sender).append(":").append(receiver).toString();
		String key = eve_id;
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange(key, 0, jedis.llen(key) - 1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String eve_id, String message) {
		// ������ӻ��A���n�U�s�۾��v��ѰO��
//		String senderKey = new StringBuilder(sender).append(":").append(receiver).toString();
//		String receiverKey = new StringBuilder(receiver).append(":").append(sender).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
//		jedis.rpush(senderKey, message);
//		jedis.rpush(receiverKey, message);
		jedis.rpush(eve_id, message);

		jedis.close();
	}

}
