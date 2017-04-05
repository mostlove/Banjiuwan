package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.ChangeFood;
import com.magicbeans.banjiuwan.beans.SingleFood;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/8 0008.
 */
public interface IChangeFoodMapper {


    Integer batchAddChangeFood(@Param("changeFoods") List<ChangeFood> changeFoods);


    Integer delChangeFood(@Param("foodId") Integer foodId);


    List<SingleFood> querySingleFoodByFoodId(@Param("id") Integer id);


    /**
     *  换一换获取
     * @param foodId
     * @param userId
     * @return
     */
    List<SingleFood> querySingleFoodByFoodIdForApp(@Param("foodId") Integer foodId,@Param("userId") Integer userId);





}
