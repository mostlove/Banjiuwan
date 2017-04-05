package com.magicbeans.banjiuwan.baiduMap;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/3/2.
 */

public class LatLng implements Serializable{
    public final double latitude;
    public final double longitude;

    public LatLng(double var1, double var3) {
        this.latitude = var1;
        this.longitude = var3;
    }
}
