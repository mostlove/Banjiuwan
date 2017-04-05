package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.PackageCater;
import com.magicbeans.banjiuwan.beans.PackageSingleFood;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.IPackageCaterMapper;
import com.magicbeans.banjiuwan.mapper.IPackageSingleFoodMapper;
import com.magicbeans.banjiuwan.mapper.IShopCarMapper;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * 套餐坝坝宴 业务层
 * Created by Eric Xie on 2017/2/21 0021.
 */
@Service
public class PackageCaterService {


    @Resource
    private IPackageCaterMapper packageCaterMapper;

    @Resource
    private IPackageSingleFoodMapper packageSingleFoodMapper;
    @Resource
    private IShopCarMapper shopCarMapper;

    /**
     *  新增 套餐、 坝坝宴
     * @param packageCater
     */
    @Transactional
    public Integer addPackageCenter(PackageCater packageCater) throws Exception{
        packageCater.setCreateTime(new Date());
        int index = packageCater.getBanners().lastIndexOf(",");
        String banners = packageCater.getBanners().substring(0,index);
        packageCater.setBanners(banners);
        // 新增 返回ID
        Integer count = packageCaterMapper.addPackageCater(packageCater);
        // 解析后台传输的数据
        JSONArray singleArr = JSONArray.fromObject(packageCater.getSingleFoodIds());
        JSONArray numberArr = JSONArray.fromObject(packageCater.getNumbers());
        if(singleArr.size() != numberArr.size() || singleArr.size() <= 0){
            return 0;
        }
        List<PackageSingleFood> pss = new ArrayList<PackageSingleFood>();
        for(int i=0; i < singleArr.size(); i++){
            PackageSingleFood ps = new PackageSingleFood();
            ps.setNumber(numberArr.getInt(i));
            ps.setSingleFoodId(singleArr.getInt(i));
            ps.setPackageId(packageCater.getId());
            pss.add(ps);
        }
        if(pss.size() > 0){
            packageSingleFoodMapper.batchAdd(pss);
        }
        return count;
    }


    /**
     *  更新不为空的字段
     * @param packageCater
     */
    @Transactional
    public void updatePackageCenter(PackageCater packageCater){
        // 解析后台传输的数据
        JSONArray singleArr = JSONArray.fromObject(packageCater.getSingleFoodIds());
        JSONArray numberArr = JSONArray.fromObject(packageCater.getNumbers());
        if(singleArr.size() != numberArr.size() || singleArr.size() <= 0){
            return;
        }
        List<PackageSingleFood> pss = new ArrayList<PackageSingleFood>();
        for(int i=0; i < singleArr.size(); i++){
            PackageSingleFood ps = new PackageSingleFood();
            ps.setNumber(numberArr.getInt(i));
            ps.setSingleFoodId(singleArr.getInt(i));
            ps.setPackageId(packageCater.getId());
            pss.add(ps);
        }
        int index = packageCater.getBanners().lastIndexOf(",");
        String banners = packageCater.getBanners().substring(0,index);
        packageCater.setBanners(banners);
        // 先清空数据
        packageSingleFoodMapper.delByPackage(packageCater.getId());
        // 更新
        packageCaterMapper.updatePackageCater(packageCater);
        if(pss.size() > 0){
            // 新增数据
            packageSingleFoodMapper.batchAdd(pss);
        }
    }


    /**
     *  删除数据 (非逻辑删除)
     * @param id
     */
    @Transactional
    public void delPackageCater(Integer id,Integer foodCategoryId){
        packageCaterMapper.delPackageCater(id);
        //删除中间表
        packageSingleFoodMapper.delByPackage(id);
        // 删除购物车
        shopCarMapper.delShopByItem(id,foodCategoryId);
    }

    public PackageCater queryById(Integer id){
        return packageCaterMapper.queryById(id);
    }

    /**
     *  条件分页查询
     * @param name
     * @param categoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<PackageCater> queryPage(String name,Integer categoryId,Integer pageNO,Integer pageSize){
        List<PackageCater> dataList = packageCaterMapper.queryByNameOrCategory(name,categoryId,(pageNO - 1) * pageSize,pageSize);
        Integer count = packageCaterMapper.countByNameOrCategory(name,categoryId);
        Integer totalPage  = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<PackageCater>(dataList,count,totalPage);
    }

    public List<PackageCater> queryByCategory(Integer foodCategory){
        return packageCaterMapper.queryByCategory(foodCategory);
    }

    /**
     *  APP端 通过id查询
     * @param categoryId
     * @param foodId
     * @param userId
     * @return
     */
    public PackageCater queryPackageCaterOtherInfo(Integer categoryId,Integer foodId,Integer userId){
        return packageCaterMapper.queryPackageCaterOtherInfo(categoryId,foodId,userId);
    }


}
