package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.ChangeFood;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.SingleFood;
import com.magicbeans.banjiuwan.mapper.IChangeFoodMapper;
import com.magicbeans.banjiuwan.mapper.IShopCarMapper;
import com.magicbeans.banjiuwan.mapper.ISingleFoodMapper;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  菜品类 业务层
 * Created by Eric Xie on 2017/2/20 0020.
 */
@Service
public class SingleFoodService {


    @Resource
    private ISingleFoodMapper singleFoodMapper;
    @Resource
    private IChangeFoodMapper changeFoodMapper;
    @Resource
    private IShopCarMapper shopCarMapper;


    /**
     *  移动端 换一换获取
     * @param foodId
     * @param userId
     * @return
     */
    public List<SingleFood> querySingleFoodByFoodIdForApp(Integer foodId,Integer userId){

        List<SingleFood> singleFoods = changeFoodMapper.querySingleFoodByFoodIdForApp(foodId,userId);

        return singleFoods;
    }

    /**
     * 换一换 菜品绑定
     */
    @Transactional
    public void bindingFood(String secondIds,Integer foodId){
        JSONArray secondIdsArr = JSONArray.fromObject(secondIds);
        List<ChangeFood> changeFoods = new ArrayList<ChangeFood>();
        for (Object obj : secondIdsArr){
            ChangeFood changeFood = new ChangeFood();
            changeFood.setFoodId(foodId);
            changeFood.setSecondFoodId(Integer.valueOf(obj.toString()));
            changeFoods.add(changeFood);
        }
        changeFoodMapper.delChangeFood(foodId);
        if(changeFoods.size() > 0){
            changeFoodMapper.batchAddChangeFood(changeFoods);
        }
    }

    public List<SingleFood> queryChangeFood(Integer foodId){
        return changeFoodMapper.querySingleFoodByFoodId(foodId);
    }



    /**
     *  新增菜品
     * @param food
     */
    public void addSingleFood(SingleFood food){
        singleFoodMapper.addSingleFood(food);
    }


    /**
     *  后台查询 菜品列表
     * @param foodName
     * @param categoryId
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<SingleFood> queryFood(String foodName,String categoryId,
                                      Integer isPromotion,
                                      Integer isRecommendation,
                                      Integer recommendationIndex,
                                      Integer pageNO,Integer pageSize){
        Integer[] categoryIds = null;

        if (null != categoryId && categoryId.trim().length() > 0) {
            String [] c = categoryId.split(",");
            categoryIds = new Integer[c.length];
            for(int i = 0; i < c.length ; i ++) {
                categoryIds[i] = Integer.parseInt(c[i]);
            }
        }

        List<SingleFood> dataList = singleFoodMapper.queryByCategoryForWeb(foodName,categoryIds,isPromotion,
                isRecommendation,recommendationIndex,
                (pageNO - 1) * pageSize,pageSize);
        Integer count = singleFoodMapper.countByCategory(foodName,categoryIds,isPromotion,isRecommendation,recommendationIndex);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<SingleFood>(dataList,count,totalPage);
    }


    public List<SingleFood> searchSingleFood(String foodName,Integer pageNO,Integer pageSize){
        return singleFoodMapper.queryByCategoryForWeb(foodName,null,null,null,null,(pageNO - 1) * pageSize,pageSize);
    }


    /**
     *  通过ID 查询所有基本属性
     * @param id
     * @return
     */
    public SingleFood queryById(Integer id){
        return singleFoodMapper.queryById(id);
    }


    /**
     * @return
     */
    public SingleFood querySingleFoodById(Integer userId,Integer id,Integer foodCategoryId){
        return singleFoodMapper.querySingleFoodById(userId,id,foodCategoryId);
    }




    /**
     *  更新不为空的字段
     * @param food
     */
    public void updateFood(SingleFood food){
        singleFoodMapper.updateSingleFood(food);
    }

    @Transactional
    public void del(Integer id,Integer foodCategoryId){
        singleFoodMapper.delSingleFood(id);
        shopCarMapper.delShopByItem(id,foodCategoryId);
    }

    /**
     *  根据 类型ID 查询
     * @param categoryId
     * @return
     */
    public List<SingleFood> queryByCategory(Integer categoryId){
        return singleFoodMapper.queryByCategory(null,categoryId,null,null);
    }

//    /**
//     *  统计各类菜品 在购物车中的数量
//     * @param singleFoods
//     * @return
//     */
//    public List<SingleFood> countShopCarNumber(List<SingleFood> singleFoods,Integer userId){
//
//
//
//    }

    /**
     * 获取推荐 促销菜品列表
     * @return
     */
    public Map<String ,Object> getRecommendationPromotion(){
        Map<String ,Object> map = new HashMap<String, Object>();
        try {
            map.put("promotion",singleFoodMapper.getRecommendationPromotion(1));
            map.put("recommendation",singleFoodMapper.getRecommendationPromotion(2));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 更新是否促销或推荐
     * @return
     */
    @Transactional
    public void updateRecommendationOrPromotion(Integer type,Boolean bol,Integer id){
        try {
            singleFoodMapper.updateRecommendationOrPromotion(type, bol ,id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
