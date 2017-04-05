package com.magicbeans.banjiuwan.util;

import com.magicbeans.banjiuwan.beans.Cook;
import com.magicbeans.banjiuwan.cache.MemcachedUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * 厨师 实时更新坐标工具类
 * Created by Eric Xie on 2017/3/15 0015.
 */
public class CookCacheUtil {


    private static MemcachedUtil memcachedUtil = MemcachedUtil.getInstance();

    private static String cookLatLng = "cookLatLng";


    public static synchronized boolean updateCookLatLng(Cook cook){

        List<Cook> cooks = (List<Cook>) memcachedUtil.get(cookLatLng);
        if(null == cooks){
            cooks = new ArrayList<Cook>();
            cooks.add(cook);
            return memcachedUtil.add(cookLatLng,cooks);
        }
        else{
            if(!cooks.contains(cook)){
                cooks.add(cook);
            }else{
                for (Cook cook1 : cooks){
                    if(cook.getId().equals(cook1.getId())){
                        cook1.setLatLng(cook.getLatLng());
                        cook1.setAvatar(cook.getAvatar());
                        cook1.setMapIcon(cook.getMapIcon());
                        cook1.setRealName(cook.getRealName());
                        cook1.setPhoneNumber(cook.getPhoneNumber());
                        break;
                    }
                }
            }
            return memcachedUtil.replace(cookLatLng,cooks);
        }
    }

    public static synchronized void removedCook(Cook cook){
        List<Cook> cooks = (List<Cook>) memcachedUtil.get(cookLatLng);
        if(null == cooks){
            return;
        }
        for (Cook cook1 : cooks){
            if(cook1.getId().equals(cook.getId())){
                cooks.remove(cook1);
                break;
            }
        }
        memcachedUtil.replace(cookLatLng,cooks);
    }

    public static List<Cook> getCacheCooks(){
        List<Cook> cooks = (List<Cook>) memcachedUtil.get(cookLatLng);
        return cooks == null ? new ArrayList<Cook>() : cooks;
    }




}
