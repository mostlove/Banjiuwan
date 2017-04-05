package com.magicbeans.banjiuwan.util;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.magicbeans.banjiuwan.beans.AdminUser;
import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.cache.MemcachedUtil;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;




public class LoginHelper {
	
	public static final String TOKEN = "token";
	public static boolean isLogin=false;
	public static final String LOGIN_PATH="cookLogin.jsp";

	/**SESSION USER*/
	public static final String SESSION_USER = "admin_user";
	

	public static void delObject(String token){
		MemcachedUtil.getInstance().delObj(token);
	}

	public static Object getCurrentUser(){
		HttpServletRequest req = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getRequest();
		Object obj = req.getSession().getAttribute(SESSION_USER);
		if(null == obj){
			String token = req.getHeader("token");
			Object user = MemcachedUtil.getInstance().get(token);
			if(null == user){
				return null;
			}else{
				return user;
			}
		}
		return obj;
	}
	
	public static Object getCurrentUser(String token){
		Object tempObj = MemcachedUtil.getInstance().get(token);
		return tempObj;
	}
	
	public static boolean clearToken(){
		HttpServletRequest req = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getRequest();
		Object obj = req.getSession().getAttribute(SESSION_USER);
		if(null != obj ){
			req.getSession().invalidate();
			return true;
		}else{
			String token = req.getHeader("token");
			return MemcachedUtil.getInstance().delObj(token);
		}
		
	}
	
	public static String addToken(Object obj){
		String token = null;
		if(obj instanceof User){
			User user = (User)obj;
			// 用户
			if(user.getToken() != null){
				Object tempObj = MemcachedUtil.getInstance().get(user.getToken());
				if(null != tempObj){
					MemcachedUtil.getInstance().delObj(user.getToken());
				}
			}
			token = UUID.randomUUID().toString().replaceAll("-", "");
			user.setToken(token);
			MemcachedUtil.getInstance().add(token, user);
		}else if(obj instanceof Cook){
			// 厨师
			Cook user = (Cook)obj;
			// 司机
			if(user.getToken() != null){
				Object tempObj = MemcachedUtil.getInstance().get(user.getToken());
				if(null != tempObj){
					MemcachedUtil.getInstance().delObj(user.getToken());
				}
			}
			token = UUID.randomUUID().toString().replaceAll("-", "");
			user.setToken(token);
			MemcachedUtil.getInstance().add(token, user);
		}
		return token;
	}
	
	public static boolean  replaceToken(String token,Object obj){
		return MemcachedUtil.getInstance().set(token, obj);
	}

	public static AdminUser getCurrentAdmin(HttpServletRequest req){
		Object obj = req.getSession().getAttribute(SESSION_USER);
		if(null == obj){
			return null;
		}
		return (AdminUser)obj;
	}
	
	public static void main(String[] args) {
		MemcachedUtil.getInstance().add("123",123);

		System.out.println(MemcachedUtil.getInstance().get("123"));
	}
	
}
