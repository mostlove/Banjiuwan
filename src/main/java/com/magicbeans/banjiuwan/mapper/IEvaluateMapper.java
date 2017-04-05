package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.Evaluate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * dao层接口 -- 评论
 * @author lzh
 * @create 2017/3/9 16:04
 */
public interface IEvaluateMapper {

    /**
     * 新增评价
     * @param evaluate
     */
    void save(@Param("evaluate")Evaluate evaluate);

    /**
     * 更新 评价是否通过
     * @param isPass
     * @param id
     */
    void updateIsPass(@Param("isPass") Integer isPass ,@Param("id") Integer id);


    /**
     * 评论列表
     * @param type 评论类型
     * @param objectId 被评论的id
     * @param limit 页码
     * @param limitSize 条数
     * @return
     */
    List<Evaluate> list(@Param("type")Integer type,@Param("objectId")Integer objectId,@Param("limit") Integer limit,@Param("limitSize") Integer limitSize);


    /**
     * 获取平均评分
     * @param type
     * @param objectId
     * @return
     */
    Evaluate getAvgScore(@Param("type")Integer type,@Param("objectId")Integer objectId);


    /**
     * 菜品评价列表 web
     * @param objectIds
     * @param foodCategoryIds
     * @param isPass
     * @param userType
     * @param limit
     * @param limitSize
     * @return
     */
    List<Evaluate> getFoodListForWeb(@Param("objectIds")Integer[] objectIds,
                                     @Param("foodCategoryIds") Integer[] foodCategoryIds,
                                     @Param("isPass") Integer isPass,
                                     @Param("userType") Integer userType,
                                     @Param("evaluateLevel") Integer evaluateLevel,
                                     @Param("limit") Integer limit,
                                     @Param("limitSize") Integer limitSize);

    /**
     * 菜品评价列表 总条数
     * @param objectIds
     * @param foodCategoryIds
     * @param isPass
     * @param userType
     * @return
     */
    Integer getFoodListForWebCount(@Param("objectIds")Integer[] objectIds,
                                   @Param("foodCategoryIds") Integer[] foodCategoryIds,
                                   @Param("isPass") Integer isPass,
                                   @Param("userType") Integer userType,
                                   @Param("evaluateLevel") Integer evaluateLevel);



    /**
     * 订单评价列表 web
     * @param orderNumber
     * @param isPass
     * @param userType
     * @param limit
     * @param limitSize
     * @return
     */
    List<Evaluate> getOrderListForWeb(@Param("orderNumber")String orderNumber,
                                     @Param("isPass") Integer isPass,
                                     @Param("userType") Integer userType,
                                     @Param("evaluateLevel") Integer evaluateLevel,
                                     @Param("limit") Integer limit,
                                     @Param("limitSize") Integer limitSize);

    /**
     * 订单评价列表 总条数
     * @param orderNumber
     * @param isPass
     * @param userType
     * @return
     */
    Integer getOrderListForWebCount(@Param("orderNumber")String orderNumber,
                                   @Param("isPass") Integer isPass,
                                   @Param("userType") Integer userType,
                                   @Param("evaluateLevel") Integer evaluateLevel);
}



