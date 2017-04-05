package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.baiduMap.LatLng;
import com.magicbeans.banjiuwan.beans.SpecialService;
import com.magicbeans.banjiuwan.beans.SpecialServiceChild;
import com.magicbeans.banjiuwan.mapper.ISpecialServiceChildMapper;
import com.magicbeans.banjiuwan.mapper.ISpecialServiceMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * 专业服务 业务层接口
 * Created by Eric Xie on 2017/2/21 0021.
 */
@Service
public class SpecialServiceService {

    @Resource
    private ISpecialServiceMapper specialServiceMapper;
    @Resource
    private ISpecialServiceChildMapper specialServiceChildMapper;

    /**
     *  获取 专业服务
     * @return
     */
    public SpecialService querySpecial(Integer userId){
        SpecialService specialService = specialServiceMapper.queryAll().get(0);
        List<SpecialServiceChild> specialServiceChildren = specialServiceChildMapper.queryAllSpecialServiceChild(userId);

        for (SpecialServiceChild specialServiceChild : specialServiceChildren){
            if(1 == specialServiceChild.getId()){
                specialService.setManServicePrice(specialServiceChild.getPrice());
            }
            else if(2 == specialServiceChild.getId()){
                specialService.setWomanServicePrice(specialServiceChild.getPrice());
            }
            else if(3 == specialServiceChild.getId()){
                specialService.setTablewarePrice(specialServiceChild.getPrice());
            }
        }

        specialService.setSpecialServiceChilds(specialServiceChildren);
        return  specialService;
    }

    public SpecialServiceChild getCJ(Integer userId){
        List<SpecialServiceChild> specialServiceChildren = specialServiceChildMapper.queryAllSpecialServiceChild(userId);
        return specialServiceChildren.get(2);
    }

    /**
     *  更新
     * @param specialService
     */
    @Transactional
    public void updateSpecial(SpecialService specialService){
        int index = specialService.getBanners().lastIndexOf(",");
        String banners = specialService.getBanners().substring(0,index);
        specialService.setBanners(banners);
        specialServiceMapper.updateSpecialService(specialService);
        SpecialServiceChild man = new SpecialServiceChild();
        SpecialServiceChild woman = new SpecialServiceChild();
        SpecialServiceChild tableware = new SpecialServiceChild();
        man.setId(1);
        man.setPrice(specialService.getManServicePrice());
        woman.setId(2);
        woman.setPrice(specialService.getWomanServicePrice());
        tableware.setId(3);
        tableware.setPrice(specialService.getTablewarePrice());

        List<SpecialServiceChild> specialServiceChildren = new ArrayList<SpecialServiceChild>();
        specialServiceChildren.add(man);
        specialServiceChildren.add(woman);
        specialServiceChildren.add(tableware);
        for (SpecialServiceChild specialServiceChild : specialServiceChildren){
            specialServiceChildMapper.updateSpecialServiceChild(specialServiceChild);
        }
    }

}
