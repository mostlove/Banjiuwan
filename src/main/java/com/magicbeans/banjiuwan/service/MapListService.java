package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.MapList;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.IMapListMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/2 0002.
 */
@Service
public class MapListService {

    @Resource
    private IMapListMapper mapListMapper;

    public void addMapList(MapList mapList){
        mapListMapper.addMapList(mapList);
    }


    public void updateMapList(MapList mapList){
        mapListMapper.updateMapList(mapList);
    }

    public Page<MapList> queryMapListPage(Integer pageNO,Integer pageSize){
        List<MapList> dataList = mapListMapper.queryMapListPage((pageNO - 1) * pageSize,pageSize);
        Integer count = mapListMapper.countMapListPage();
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<MapList>(dataList,count,totalPage);
    }

    public void delMapList(Integer id){
        mapListMapper.delMapList(id);
    }


    public MapList queryMapListById(Integer id){
        return mapListMapper.queryMapListById(id);
    }


    public List<MapList> queryAllMapList(){
        return mapListMapper.queryMapListPage(null,null);
    }
}
