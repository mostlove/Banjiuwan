package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.baiduMap.LatLng;
import com.magicbeans.banjiuwan.baiduMap.SpatialRelationUtil;
import com.magicbeans.banjiuwan.beans.AllConfig;
import com.magicbeans.banjiuwan.beans.MapList;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.UserAddress;
import com.magicbeans.banjiuwan.mapper.IAllConfigMapper;
import com.magicbeans.banjiuwan.mapper.IMapListMapper;
import com.magicbeans.banjiuwan.mapper.IUserAddressMapper;
import com.magicbeans.banjiuwan.util.MapUtil;
import com.magicbeans.banjiuwan.util.SendRequestUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 *
 * 用户地址管理 业务层
 * Created by Eric Xie on 2017/2/14 0014.
 */

@Service
public class UserAddressService {


    @Resource
    private IUserAddressMapper userAddressMapper;
    @Resource
    private IMapListMapper mapListMapper;
    @Resource
    private IAllConfigMapper allConfigMapper;

    private Logger logger = Logger.getLogger(this.getClass());




    public Page<UserAddress> queryUserAddress(Integer userId,Integer pageNO,Integer pageSize){
        List<UserAddress> dataList = userAddressMapper.queryAddressByUser(userId,(pageNO - 1) * pageSize, pageSize);
        Integer count = userAddressMapper.countAddressByUser(userId);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<UserAddress>(dataList,count,totalPage);
    }

    public void delUserAddress(Integer id){
        userAddressMapper.delUserAddress(id);
    }

    public void add(UserAddress userAddress) {

        userAddressMapper.addAddress(userAddress);
        if (1 == userAddress.getIsDefault()) {
            userAddressMapper.updateIsDefaultOtherObj(userAddress.getId(), userAddress.getUserId());
        }
    }


    /**
     * 更新不为空的字段
     *
     * @param userAddress
     */
    public void updateAddress(UserAddress userAddress) {
        if (1 == userAddress.getIsDefault()) {
            userAddressMapper.updateIsDefaultOtherObj(userAddress.getId(), userAddress.getUserId());
        }
        userAddressMapper.updateAddress(userAddress);
    }

    /**
     * 查询 有效地址
     *
     * @param userId
     * @param pageNO
     * @param pageSize
     * @return
     */
    public List<UserAddress> queryAddress(Integer userId, Integer pageNO, Integer pageSize) {
        return userAddressMapper.queryAddressByUser(userId, (pageNO - 1) * pageSize, pageSize);
    }

    /**
     * 通过ID 获取地址
     *
     * @param id
     * @return
     */
    public UserAddress queryAddressById(Integer id) {
        return userAddressMapper.queryAddressById(id);
    }


    /**
     * 根据地址ID 计算交通费
     *
     * @return  -1: 计算失败 0:在圈内  无需交通费用
     */
    public Integer calculationTransportationCost(UserAddress userAddress) {

        // 查询围栏
        List<MapList> mapLists = mapListMapper.queryMapListPage(null, null);
        if (null == mapLists || mapLists.size() == 0) {
            return -1;
        }
        // 查询地址
        if (null == userAddress) {
            return -1;
        }

        // 装载围栏
        String[] lats = userAddress.getLngLat().split(",");
        LatLng userLatLng = new LatLng(Double.valueOf(lats[1]), Double.valueOf(lats[0]));
        try {
            for (MapList mapList : mapLists) {
                List<LatLng> latLngs = new ArrayList<LatLng>();
                String o = mapList.getMapList().substring(1, mapList.getMapList().length() - 1);
                String[] lngLats = o.split(",");
                for (String str : lngLats) {
                    String tempStr = str.replaceAll("\"", "");
                    String[] lanLat = tempStr.split(":");
                    latLngs.add(new LatLng(Double.valueOf(lanLat[1]), Double.valueOf(lanLat[0])));
                }
                boolean isExist = SpatialRelationUtil.isPolygonContainsPoint(latLngs, userLatLng);
                // 如果存在就返回 0
                if (isExist) {
                    return 0;
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return -1;
        }

        String[] userLats = userAddress.getLngLat().split(",");
        String origins = userLats[1] + "," + userLats[0]; // 起点坐标
        // 如果都不在圈内，则计算就近的点
        // 就近的点集合
        List<LatLng> nwarPonits = new ArrayList<LatLng>();
        List<Integer> nwarDistance = new ArrayList<Integer>();
        for (MapList mapList : mapLists) {
            String destinations ="";
            Map<String, String> data = new HashMap<String, String>();
            String o = mapList.getMapList().substring(1, mapList.getMapList().length() - 1);
            String[] lngLats = o.split(",");
            for (String str : lngLats) {
                String tempStr = str.replaceAll("\"", "");
                String[] lanLat = tempStr.split(":");
                destinations += lanLat[1] + ","+lanLat[0]+"|";
            }
            destinations = destinations.substring(0,destinations.length() - 1);
            // 通过百度地图API发起请求
            data.put("origins", origins);
            data.put("destinations", destinations);
            data.put("output", "json");
            data.put("ak",MapUtil.getValue("ak"));
            String url = SendRequestUtil.geturl(data, MapUtil.getValue("transportURL"));
            Integer distance = handleResult(url, SendRequestUtil.GET);
            if (null == distance) {
                return -1;
            }
            nwarDistance.add(distance);
        }
        return Collections.min(nwarDistance);
    }

    /**
     *  计算 当前坐标 与 配置坐标之间 距离使用车程需花费的时间
     *  加上 配菜所需要的时间 返回
     */
    public double handlePointTime(UserAddress userAddress){
        AllConfig allConfig = allConfigMapper.queryAllConfig();
        String[] startLats = allConfig.getStartPoint().split(",");
        // 起点坐标
        String origins = startLats[1] + "," + startLats[0]; // 起点坐标
        // 终点坐标
        String[] endLats = userAddress.getLngLat().split(",");
        String destinations = endLats[1] + "," + endLats[0];
        Map<String, String> data = new HashMap<String, String>();
        data.put("origins", origins);
        data.put("destinations", destinations);
        data.put("output", "json");
        data.put("ak",MapUtil.getValue("ak"));
        String url = SendRequestUtil.geturl(data, MapUtil.getValue("transportURL"));
        double seconds = handlePointTimeResult(url, SendRequestUtil.GET);
        return seconds / 360 + allConfig.getGarnishTime();
    }

    /**
     * 处理百度api请求结果 并返回距离最短的下标
     *
     * @return 如果返回 时间 单位秒
     */
    private double handlePointTimeResult(String url, String requestMethod) {
        try {
            String result = SendRequestUtil.sendRequest(url, requestMethod);
            JSONObject jsonObject = JSONObject.fromObject(result);
            Integer status = jsonObject.getInt("status");
            if (status != 0) {
                return 0.0;
            }
            JSONArray array = jsonObject.getJSONArray("result");
            // 计算距离最短的下标
            if (null == array || array.size() == 0) {
                return 0.0;
            }
            List<Double> durations = new ArrayList<Double>();
            for (Object object : array) {
                JSONObject obj = (JSONObject) object;
                JSONObject disObject = obj.getJSONObject("duration");
                durations.add(disObject.getDouble("value"));
            }
            return durations.get(0);
        } catch (Exception e) {
            logger.debug("请求失败", e);
            return 0.0;
        }

    }


    /**
     * 处理百度api请求结果 并返回距离最短的下标
     *
     * @param url
     * @param requestMethod
     * @return 如果返回 -1 或者 null 则 发送错误
     */
    private Integer handleResult(String url, String requestMethod) {
        try {
            String result = SendRequestUtil.sendRequest(url, requestMethod);
            JSONObject jsonObject = JSONObject.fromObject(result);
            Integer status = jsonObject.getInt("status");
            if (status != 0) {
                return null;
            }
            JSONArray array = jsonObject.getJSONArray("result");
            // 计算距离最短的下标
            if (null == array || array.size() == 0) {
                return null;
            }
            List<Integer> distances = new ArrayList<Integer>();
            for (Object object : array) {
                JSONObject obj = (JSONObject) object;
                JSONObject disObject = obj.getJSONObject("distance");
                distances.add(disObject.getInt("value"));
            }
            // 获取集合中 值最小的元素
            return Collections.min(distances);
        } catch (Exception e) {
            logger.debug("请求失败", e);
            return null;
        }

    }
}
