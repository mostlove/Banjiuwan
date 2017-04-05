package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.CallMyAM;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.ICallMyAMMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/2/28 0028.
 */
@Service
public class CallMyAMService {

    @Resource
    private ICallMyAMMapper callMyAMMapper;

    public void addCallMyAM(CallMyAM callMyAM){
        callMyAMMapper.addCallMyAM(callMyAM);
    }

    public void updateCallMyAM(CallMyAM callMyAM){
        callMyAMMapper.updateCallMyAM(callMyAM);
    }


    public Page<CallMyAM> getCallMyAM(Integer pageNO,Integer pageSize){
        List<CallMyAM> dataList = callMyAMMapper.queryCallNyAMPage((pageNO - 1) * pageSize, pageSize);
        Integer count = callMyAMMapper.countCallMyAM();
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<CallMyAM>(dataList,count,totalPage);
    }


}
