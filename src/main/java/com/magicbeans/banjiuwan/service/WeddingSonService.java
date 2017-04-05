package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.beans.WeddingSon;
import com.magicbeans.banjiuwan.mapper.IWeddingSonMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 *
 * 婚庆预约 子项管理 业务层
 *
 * Created by Eric Xie on 2017/2/22 0022.
 */

@Service
public class WeddingSonService {

    @Resource
    private IWeddingSonMapper weddingSonMapper;

    /**
     *  新增 子项
     * @param son
     */
    public void addWeddingSon(WeddingSon son){
        weddingSonMapper.addWeddingSon(son);
    }


    public void delWeddingSon(Integer id){
        weddingSonMapper.delWeddingSon(id);
    }

    public void updateWeddingSon(WeddingSon son){
        weddingSonMapper.updateWeddingSon(son);
    }

    /**
     * 条件分页查询
     * @param name
     * @param pageNO
     * @param pageSize
     * @return
     */
    public Page<WeddingSon> queryPage(String name,Integer pageNO,Integer pageSize){
        List<WeddingSon> dataList = weddingSonMapper.queryPage(name,(pageNO - 1) * pageSize, pageSize);
        Integer count = weddingSonMapper.countPage(name);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<WeddingSon>(dataList,count,totalPage);
    }


    public List<WeddingSon> queryAllWeddingSon(){
        return weddingSonMapper.queryAllWeddingSon();
    }

}
