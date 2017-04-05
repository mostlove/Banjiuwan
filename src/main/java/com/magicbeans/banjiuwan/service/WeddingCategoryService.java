package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.WeddingCategory;
import com.magicbeans.banjiuwan.mapper.IWeddingCategoryMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 婚庆 子项大分类 业务层
 * Created by Eric Xie on 2017/2/23 0023.
 */

@Service
public class WeddingCategoryService {

    @Resource
    private IWeddingCategoryMapper weddingCategoryMapper;


    public void addWeddingCategory(WeddingCategory weddingCategory){
        weddingCategoryMapper.addWedingCategory(weddingCategory);
    }

    public void delWeddingCategory(Integer id){
        weddingCategoryMapper.delWeddingCategory(id);
    }

    public List<WeddingCategory> queryAllCategory(){
        return weddingCategoryMapper.queryAllWeddingCategory();
    }

    public void updateWeddingCategory(WeddingCategory weddingCategory){
        weddingCategoryMapper.updateWeddingCategory(weddingCategory);
    }


}
