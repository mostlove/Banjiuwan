package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.VegetablesPrice;
import com.magicbeans.banjiuwan.mapper.IVegetablesPriceMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/10 0010.
 */
@Service
public class VegetablesPriceService {

    @Resource
    private IVegetablesPriceMapper vegetablesPriceMapper;



    public Page<VegetablesPrice> queryVegetablesPriceByItemForWeb(String vegetablesName,Date time,Integer pageNO,Integer pageSize){
        List<VegetablesPrice> dataList = vegetablesPriceMapper.queryVegetablesPriceByItemForWeb(vegetablesName,time,
                (pageNO - 1) * pageSize ,pageSize);
        Integer count = vegetablesPriceMapper.countVegetablesPriceByItemForWeb(vegetablesName,time);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<VegetablesPrice>(dataList,count,totalPage);

    }

    public void addVegetablesPrice(VegetablesPrice vegetablesPrice){
        vegetablesPrice.setTime(new Date(vegetablesPrice.getTimeLong()));
        vegetablesPriceMapper.addVegetablesPrice(vegetablesPrice);
    }

    public void updateVegetablesPrice(VegetablesPrice vegetablesPrice){
        vegetablesPrice.setTime(new Date(vegetablesPrice.getTimeLong()));
        vegetablesPriceMapper.updateVegetablesPrice(vegetablesPrice);
    }

    public void delVegetablesPrice(Integer id){
        vegetablesPriceMapper.delVegetablesPrice(id);
    }

    public List<VegetablesPrice> queryVegetablesPriceByItem( Integer vegetablesId, Date time){
        return vegetablesPriceMapper.queryVegetablesPriceByItem(vegetablesId,time);
    }



}
