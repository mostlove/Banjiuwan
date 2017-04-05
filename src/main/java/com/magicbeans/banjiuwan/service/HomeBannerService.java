package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.HomeBanner;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.IHomeBannerMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/2/16 0016.
 */
@Service
public class HomeBannerService {

    @Resource
    private IHomeBannerMapper homeBannerMapper;


    /**
     *  获取所有的 首页banner
     * @return
     */
    public Page<HomeBanner> queryBannerByPage(){
        List<HomeBanner> banners = homeBannerMapper.queryAllHomeBanner(null);
        return new Page<HomeBanner>(banners,banners.size(),1);
    }

    public List<HomeBanner> queryBannerByType(Integer type){
        return homeBannerMapper.queryAllHomeBanner(type);
    }

    /**
     *  统计类型banner数量
     * @param type
     * @return
     */
    public Integer countBanner(Integer type){
        List<HomeBanner> banners = homeBannerMapper.queryAllHomeBanner(type);
        return banners == null ? 0 : banners.size();
    }

    public void addHomeBanner(HomeBanner banner){
        homeBannerMapper.addHomeBanner(banner);
    }


    public void delHomeBanner(Integer id){
        homeBannerMapper.delHomeBanner(id);
    }

    public HomeBanner queryById(Integer id){
        return homeBannerMapper.queryHomeBannerById(id);
    }

    public void updateHomeBanner(HomeBanner homeBanner){
        homeBannerMapper.updateHomeBanner(homeBanner);
    }

}
