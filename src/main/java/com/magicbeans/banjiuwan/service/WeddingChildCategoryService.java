package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.WeddingChildCategory;
import com.magicbeans.banjiuwan.mapper.IWeddingChildCategoryMapper;
import com.magicbeans.banjiuwan.mapper.IWeddingSonChildCategoryMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 婚庆 子分类 业务层
 * Created by Eric Xie on 2017/2/23 0023.
 */
@Service
public class WeddingChildCategoryService {


    @Resource
    private IWeddingChildCategoryMapper weddingChildCategoryMapper;

    @Resource
    private IWeddingSonChildCategoryMapper weddingSonChildCategoryMapper;

    /**
     *  新增
     * @param weddingChildCategory
     */
    public void addWeddingChildCategory(WeddingChildCategory weddingChildCategory){
        weddingChildCategoryMapper.addWeddingChildCategory(weddingChildCategory);
    }

    /**
     *  删除
     * @param id
     */
    @Transactional
    public void delWeddingChildCategory(Integer id){
        weddingChildCategoryMapper.delWeddingChildCategory(id);
        weddingSonChildCategoryMapper.delWeddingSonChildCategoryByChildCategory(id);
    }

    /**
     * 修改
     * @param weddingChildCategory
     */
    public void updateWeddingChildCategory(WeddingChildCategory weddingChildCategory){
        weddingChildCategoryMapper.updateWeddingChildCategory(weddingChildCategory);
    }

    /**
     *  分页获取
     * @param name
     * @param weddingCategoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<WeddingChildCategory> queryWeddingChildCategory(String name,Integer weddingCategoryId,Integer pageNO,Integer pageSize){
        List<WeddingChildCategory> dataList = weddingChildCategoryMapper.queryChildCategoryPage(name,weddingCategoryId,(pageNO - 1) * pageSize,pageSize);
        Integer count = weddingChildCategoryMapper.countChildCategoryPage(name,weddingCategoryId);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<WeddingChildCategory>(dataList,count,totalPage);

    }

    /**
     * 获取所有的子分类 通过 分类ID
     * @param categoryId
     * @return
     */
    public List<WeddingChildCategory> queryAllChildCategoryBycategoryId(Integer categoryId){
        return weddingChildCategoryMapper.queryChildCategoryPage(null,categoryId,null,null);
    }



}
