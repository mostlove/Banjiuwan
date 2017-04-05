package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.SpecialAct;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.mapper.IShopCarMapper;
import com.magicbeans.banjiuwan.mapper.ISpecialActMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 伴餐演奏 业务层
 * Created by Eric Xie on 2017/2/22 0022.
 */

@Service
public class SpecialActService {

    @Resource
    private ISpecialActMapper specialActMapper;
    @Resource
    private IShopCarMapper shopCarMapper;

    public void addAct(SpecialAct act){
        act.setFoodCategoryId(FoodCategoryEnum.SPECIAL_ACT.ordinal());
        int index = act.getBanners().lastIndexOf(",");
        String banners = act.getBanners().substring(0,index);
        act.setBanners(banners);
        specialActMapper.addSpecialAct(act);
    }

    /**
     *  分页条件查询
     * @param name
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<SpecialAct> queryPage(String name,Integer pageNO,Integer pageSize){
        List<SpecialAct> dataList = specialActMapper.queryByName(name,(pageNO - 1) * pageSize, pageSize);
        Integer count = specialActMapper.countByName(name);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<SpecialAct>(dataList,count,totalPage);
    }

    public void updateAct(SpecialAct act){
        int index = act.getBanners().lastIndexOf(",");
        String banners = act.getBanners().substring(0,index);
        act.setBanners(banners);
        specialActMapper.updateSpecialAct(act);
    }

    @Transactional
    public void delAct(Integer id){
        specialActMapper.delSpecialAct(id);
        shopCarMapper.delShopByItem(id,FoodCategoryEnum.SPECIAL_ACT.ordinal());
    }


    public SpecialAct queryById(Integer id){
        return specialActMapper.queryActById(id);
    }


    public List<SpecialAct> queryByAct(){
        return specialActMapper.queryAllAct();
    }


    public SpecialAct querySpecialActOtherInfo(Integer userId,Integer actId){
        return specialActMapper.querySpecialActOtherInfo(userId,actId);
    }

}
