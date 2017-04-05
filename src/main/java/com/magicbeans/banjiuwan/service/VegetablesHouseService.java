package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.VegetablesHouse;
import com.magicbeans.banjiuwan.mapper.IVegetablesHouseMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/10 0010.
 */
@Service
public class VegetablesHouseService {

    @Resource
    private IVegetablesHouseMapper vegetablesHouseMapper;



    public Page<VegetablesHouse> queryVegetablesHouseByItem(String dishName,Integer pageNO,Integer pageSize){
        List<VegetablesHouse> dataList = vegetablesHouseMapper.queryVagetablesByItem(dishName,(pageNO - 1) * pageSize, pageSize);
        Integer count = vegetablesHouseMapper.countVagetablesByItem(dishName);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<VegetablesHouse>(dataList,count,totalPage);
    }


    public void addVegetablesHouse(VegetablesHouse vegetablesHouse){
        vegetablesHouseMapper.addVegetablesHouse(vegetablesHouse);
    }


    public void  updateVegetablesHouse(VegetablesHouse vegetablesHouse){
        vegetablesHouseMapper.updateVegetablesHouse(vegetablesHouse);
    }


    public void  delVegetablesHouse(Integer id){
        vegetablesHouseMapper.delVegetablesHouse(id);
    }


    public List<VegetablesHouse> getAllVegetablesHouse(){
        return vegetablesHouseMapper.queryVagetablesByItem(null,null,null);
    }


}
