package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.HomeFont;
import com.magicbeans.banjiuwan.mapper.IHomeFontMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/1 0001.
 */
@Service
public class HomeFontService {


    @Resource
    private IHomeFontMapper homeFontMapper;

    public void updateHomeFont(HomeFont homeFont){
        homeFontMapper.updateHomeFont(homeFont);
    }


    public List<HomeFont> queryAllHomeFont(){
        return homeFontMapper.queryHomeFontAll();
    }

}
