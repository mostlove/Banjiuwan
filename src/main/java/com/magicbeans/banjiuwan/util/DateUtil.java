package com.magicbeans.banjiuwan.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *  日期格式化工具
 * @author QimouXie
 *
 */
public class DateUtil {
	
	
	 /**  
     * 计算两个日期之间相差的天数  
     * @param smdate 较小的时间 
     * @param bdate  较大的时间 
     * @return 相差天数 
     * @throws ParseException  
     */    
    public static int daysBetween(Date smdate,Date bdate) throws ParseException   {    
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
       return Integer.parseInt(String.valueOf(between_days));           
    }    

	
	/**
	 *  转换 日期为 yyyyMMdd
	 * @param date
	 * @return
	 */
	public static String DateToyyyyMMdd(Date date){
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		return format.format(date);
	}
	/**
	 *  转换 日期为 yyyyMM
	 * @param date
	 * @return
	 */
	public static String DateToyyyyMM(Date date){
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		return format.format(date);
	}
	
	/**
	 *  将 时间戳转换成指定格式的日期类型
	 * @param millis
	 * @param formats
	 * @return
	 */
	public static Date longToDate(Long millis,String formats){
		Date result = null;
		if(null == millis || 0 == millis){
			return result;
		}
		try {
			Date date = new Date(millis);
			SimpleDateFormat format = new SimpleDateFormat(formats);
			result = format.parse(date.toString());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return result;
	}
	
	
	/**
	 *  转换 日期为 yyyyMM
	 * @param date
	 * @return
	 */
	public static String DateTime(Date date,String formats){
		SimpleDateFormat format = new SimpleDateFormat(formats);
		if(null == date){
			return null;
		}
		return format.format(date);
	}
	
	public static Date stringToDate(String yyyyMMddhhmmss){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			date = format.parse(yyyyMMddhhmmss);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}
	
	public static Date getDate(String dateStr){
		Date date = null;
		if(dateStr !=null && dateStr.matches("\\d{4}-\\d{2}-\\d{2}")){
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
			try {
				date = simple.parse(dateStr);
			} catch (ParseException e) {
				return null;
			}
		}
		return date;
	}
	
	/**
	 *  获取 指定日期的 之后 之前 的几秒时间
	 * @param date
	 * @return
	 */
	public static Date getPreSecondDate(Date date,Integer second){
		if(null == date){
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.SECOND, second);
		return c.getTime();
	}
	
	public static Date getNextDate(Date currentDate,Integer days,Integer hours,Integer mins){
		if(null == currentDate ){
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(currentDate);
		c.add(Calendar.DAY_OF_MONTH, days);
		c.add(Calendar.HOUR_OF_DAY, hours);
		c.add(Calendar.MINUTE, mins);
		return c.getTime();
	}
	
	public static Date getNextDay(Date date,Integer days){
		if(null == date){
			return null;
		}
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH,days);
		return c.getTime();
	}
	public static Date stringToDate_(String yyyyMMddhhmmss){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = null;
		try {
			date = format.parse(yyyyMMddhhmmss);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}


	public static Integer getMill(Date date){

		if(null == date){
			return (int)(System.currentTimeMillis() / 1000);
		}
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY,23);
		calendar.set(Calendar.MINUTE,59);
		calendar.set(Calendar.SECOND,59);
		return (int)(calendar.getTime().getTime() / 1000);
	}

//	public static Date simpleDate(Date date,String format){
//		if(null == date || CommonUtil.isEmpty(format)){
//			return new Date();
//		}
//
//	}
	
	
	public static void main(String[] args)  {

		System.out.println(DateTime(new Date(),"HH:mm"));
	}
	
	
}
