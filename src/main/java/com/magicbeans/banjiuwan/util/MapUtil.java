package com.magicbeans.banjiuwan.util;

import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 *  百度地图API 接口
 * @author QimouXie
 *
 */
public class MapUtil {
	
	private static Logger logger = Logger.getLogger(MapUtil.class);
	/** push.properties文件路径 */
	public static final String PROPERTIES_PATH = "map.properties";
	
	private static Map<String, String> result = new HashMap<String, String>();
	static {
		init();
	}
	private MapUtil(){
		// 私有构造
	}

	private static void init() {
		try {
			Properties properties = new Properties();
			// 获取配置文件
			InputStream inputStream = MapUtil.class.getClassLoader().getResourceAsStream(PROPERTIES_PATH);
			properties.load(inputStream);
			Enumeration<Object> enumerations = properties.keys();
			
			while (enumerations.hasMoreElements()) {
				// 拿到配置文件中类型名称
				Object object = enumerations.nextElement();
				String key = object.toString();
				String value = properties.getProperty(key);
				result.put(key, value);
			}
		} catch (Exception e) {
			logger.debug("初始化配置失败!",e);
		}
	}
	
	public static String getValue(String key){
		return result.get(key);
	}
	
	public static Map<String,String>  getMap(){
		if (result != null && result.size() > 0) {
			Iterator<String> iterator = result.keySet().iterator();
			while(iterator.hasNext()){
				String key = iterator.next();
				if(null == result.get(key) ||result.get(key).trim().length() ==0 ){
					iterator.remove();
					result.remove(key);
				}
			}
		}
		return result;
	}

}
