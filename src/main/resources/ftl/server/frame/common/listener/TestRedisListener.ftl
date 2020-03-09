package ${project.pkg!}.common.listener;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;

import com.alibaba.fastjson.JSON;

public class TestRedisListener implements MessageListener {

	@Override
	public void onMessage(Message message, byte[] pattern) {
		// TODO Auto-generated method stub
		System.out.println(new String(message.getBody()));
	}

}
