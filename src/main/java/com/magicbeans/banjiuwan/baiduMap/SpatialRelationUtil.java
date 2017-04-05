package com.magicbeans.banjiuwan.baiduMap;

import java.util.List;

/**
 * Created by Administrator on 2017/3/2.
 */

public class SpatialRelationUtil {

    public static boolean isPolygonContainsPoint(List<LatLng> var0, LatLng var1) {
        if (var0 != null && var0.size() != 0 && var1 != null) {
            int var2;
            for (var2 = 0; var2 < var0.size(); ++var2) {
                if (var1.longitude == ((LatLng) var0.get(var2)).longitude && var1.latitude == ((LatLng) var0.get(var2)).latitude) {
                    return true;
                }
            }

            var2 = 0;
            boolean var3 = false;
            LatLng var4 = null;
            LatLng var5 = null;
            double var6 = 0.0D;
            int var8 = var0.size();

            for (int var9 = 0; var9 < var8; ++var9) {
                var4 = (LatLng) var0.get(var9);
                var5 = (LatLng) var0.get((var9 + 1) % var8);
                if (var4.latitude != var5.latitude && var1.latitude >= Math.min(var4.latitude, var5.latitude) && var1.latitude <= Math.max(var4.latitude, var5.latitude)) {
                    var6 = (var1.latitude - var4.latitude) * (var5.longitude - var4.longitude) / (var5.latitude - var4.latitude) + var4.longitude;
                    if (var6 == var1.longitude) {
                        return true;
                    }

                    if (var6 < var1.longitude) {
                        ++var2;
                    }
                }
            }

            return var2 % 2 == 1;
        } else {
            return false;
        }
    }
}
