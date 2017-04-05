package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.mapper.IShopCarMapper;
import com.magicbeans.banjiuwan.mapper.ISpecialWeddingChildCategoryMapper;
import com.magicbeans.banjiuwan.mapper.ISpecialWeddingMapper;
import com.magicbeans.banjiuwan.mapper.IWeddingChildCategoryMapper;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 婚庆预约 业务层
 * Created by Eric Xie on 2017/2/22 0022.
 */
@Service
public class SpecialWeddingService {

    @Resource
    private ISpecialWeddingMapper specialWeddingMapper;

    @Resource
    private ISpecialWeddingChildCategoryMapper specialWeddingChildCategoryMapper;
    @Resource
    private IShopCarMapper shopCarMapper;

    /**
     * 新增婚庆
     * @param wedding
     */
    @Transactional
    public void addWedding(SpecialWedding wedding){
        JSONArray childCategoryArr = JSONArray.fromObject(wedding.getChildCategorys());
        wedding.setFoodCategoryId(FoodCategoryEnum.SPECIAL_WEDDING.ordinal());
        int index = wedding.getBanners().lastIndexOf(",");
        String banners = wedding.getBanners().substring(0,index);
        wedding.setBanners(banners);
        specialWeddingMapper.addSpecialWedding(wedding);
        List<SpecialWeddingChildCategory> specialWeddingChildCategories = new ArrayList<SpecialWeddingChildCategory>();
        for (Object obj : childCategoryArr){
            if(Integer.parseInt(obj.toString()) == 0){
                continue;
            }
            SpecialWeddingChildCategory sc = new SpecialWeddingChildCategory();
            sc.setChildCategoryId(Integer.parseInt(obj.toString()));
            sc.setWeddingId(wedding.getId());
            specialWeddingChildCategories.add(sc);
        }
        if(specialWeddingChildCategories.size() > 0){
            specialWeddingChildCategoryMapper.batchAddWeddingChildCategory(specialWeddingChildCategories);
        }
    }

    @Transactional
    public void delWedding(Integer id){
        specialWeddingMapper.delSpecialWedding(id);
        specialWeddingChildCategoryMapper.delWeddingChildCategoryByWedding(id);
        shopCarMapper.delShopByItem(id,FoodCategoryEnum.SPECIAL_WEDDING.ordinal());
    }

    /**
     *  更新数据
     * @param wedding
     */
    @Transactional
    public void updateWedding(SpecialWedding wedding){
        JSONArray childCategoryArr = JSONArray.fromObject(wedding.getChildCategorys());
        int index = wedding.getBanners().lastIndexOf(",");
        String banners = wedding.getBanners().substring(0,index);
        wedding.setBanners(banners);
        specialWeddingMapper.updateSpecialWedding(wedding);
        // 删除中间表数据
        specialWeddingChildCategoryMapper.delWeddingChildCategoryByWedding(wedding.getId());
        // 新增数据
        List<SpecialWeddingChildCategory> specialWeddingChildCategories = new ArrayList<SpecialWeddingChildCategory>();
        for (Object obj : childCategoryArr){
            if(Integer.parseInt(obj.toString()) == 0){
                continue;
            }
            SpecialWeddingChildCategory sc = new SpecialWeddingChildCategory();
            sc.setChildCategoryId(Integer.parseInt(obj.toString()));
            sc.setWeddingId(wedding.getId());
            specialWeddingChildCategories.add(sc);
        }
        if(specialWeddingChildCategories.size() > 0){
            specialWeddingChildCategoryMapper.batchAddWeddingChildCategory(specialWeddingChildCategories);
        }
    }


    public Page<SpecialWedding> queryWeddingPage(String name,Integer pageNO,Integer pageSize){
        List<SpecialWedding> dataList = specialWeddingMapper.queryPage(name,(pageNO - 1) * pageSize, pageSize);
        Integer count = specialWeddingMapper.countPage(name);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<SpecialWedding>(dataList,count,totalPage);
    }

    /**
     *  通过ID 获取
     * @param id
     * @return
     */
    public SpecialWedding queryWeddingById(Integer id){
        return specialWeddingMapper.queryWeddingById(id);
    }


    public List<SpecialWedding> queryAllWedding(Integer pageNO,Integer pageSize){
        return specialWeddingMapper.queryAllWedding((pageNO - 1) * pageSize, pageSize);
    }


    public SpecialWedding queryWeddingOtherInfo(Integer userId,Integer id){

        SpecialWedding specialWedding =  specialWeddingMapper.queryWeddingOtherInfo(id);

        if(null != userId){
            List<Integer> sonIds = new ArrayList<Integer>();
            if(null == specialWedding.getWeddingChildCategories() || specialWedding.getWeddingChildCategories().size() == 0){
                return specialWedding;
            }
            for (WeddingChildCategory weddingChildCategory : specialWedding.getWeddingChildCategories()){
                if(null == weddingChildCategory.getWeddingSons() || weddingChildCategory.getWeddingSons().size() == 0){
                    continue;
                }
                for (WeddingSon weddingSon : weddingChildCategory.getWeddingSons()){
                    sonIds.add(weddingSon.getId());
                }
            }
            if(sonIds.size() > 0){
                List<ShopCar> shopCarList = shopCarMapper.queryShopCarByItemOtherInfo(sonIds,specialWedding.getId(),userId);
                if(null != shopCarList && shopCarList.size() > 0){
                    s:for (ShopCar shopCar : shopCarList){
                        for (WeddingChildCategory weddingChildCategory : specialWedding.getWeddingChildCategories()){
                            if(weddingChildCategory.getId().equals(shopCar.getChildCategoryId())){
                                for (WeddingSon weddingSon : weddingChildCategory.getWeddingSons()){
                                    if(shopCar.getWeddingSonId().equals(weddingSon.getId())){
                                        weddingSon.setCountNumber(shopCar.getNumber());
                                        continue s;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return specialWedding;
    }




}
