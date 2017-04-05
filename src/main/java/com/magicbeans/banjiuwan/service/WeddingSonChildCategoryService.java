package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.WeddingSonChildCategory;
import com.magicbeans.banjiuwan.mapper.IWeddingSonChildCategoryMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 *
 * 子项 和 子类 业务层
 * Created by Eric Xie on 2017/2/23 0023.
 */

@Service
public class WeddingSonChildCategoryService {


    @Resource
    private IWeddingSonChildCategoryMapper weddingSonChildCategoryMapper;

    /**
     * 分页查询
     * @param childCategoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<WeddingSonChildCategory> queryByPage(Integer childCategoryId,Integer pageNO,Integer pageSize){
        List<WeddingSonChildCategory> dataList = weddingSonChildCategoryMapper.querySonChildCategory(childCategoryId,
                (pageNO - 1) * pageSize, pageSize);
        Integer count = weddingSonChildCategoryMapper.countSonChildCategory(childCategoryId);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<WeddingSonChildCategory>(dataList,count,totalPage);
    }

    /**
     *  根据中间表ID  删除数据
     * @param id
     */
    public void delWeddingSonChildCategory(Integer id){
        weddingSonChildCategoryMapper.delWeddingSonChildCategoryById(id);
    }

    /**
     *  绑定子项
     * @param weddingSonChildCategory
     */
    public void addWeddingSonChildCategory(WeddingSonChildCategory weddingSonChildCategory){
        weddingSonChildCategoryMapper.addWeddingSonChildCategory(weddingSonChildCategory);
    }

}
