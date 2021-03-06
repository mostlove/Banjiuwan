package com.magicbeans.banjiuwan.util;

import java.util.Map;

import com.magicbeans.banjiuwan.beans.User;
import org.apache.log4j.Logger;

import com.magicbeans.push.bean.DeviceType;
import com.magicbeans.push.bean.Message;
import com.magicbeans.push.bean.NotificationType;
import com.magicbeans.push.queue.PushUtil;

public class PushMessageUtil {

	private static Logger logger = Logger.getLogger(PushMessageUtil.class);
	public static final String APP_TYPE = "member";

	/**
	 *   通知 推送指定
	 * @param user
	 * @param content
	 * @param extend
	 */
	public static void pushMessages(User user, String content, Map<String, String> extend){
		Message message = new Message();
		//设备类型
		Integer type = null;
		String deviceToken = null;
		if(null == user){
			type = 2;
		}else {
			type = user.getDeviceType();
			deviceToken = user.getDeviceToken();
		}
		
		if (type != null) {
			if (type == 1) {
				message.setDeviceType(DeviceType.ios);
			} else if (type == 0) {
				message.setDeviceType(DeviceType.android);
			}else {
				message.setDeviceType(DeviceType.all);
			}
		}else{
			return;
		}
		//token
		
		
		if (deviceToken != null) {
			message.setDeviceId(deviceToken);
		}
		//透传信息
		message.setNotificationType(NotificationType.notification_passthrough);
		//推送内容
		if (content != null) {
			message.setContent(content);
		}
		//用户类型
		message.setAppType(APP_TYPE);
		// 设置扩展参数
		if (extend != null) {
			message.setExtend(extend);
		}
		try {
			PushUtil.pushMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("推动消息失败!",e);
		}

	}
	

	


	
}
