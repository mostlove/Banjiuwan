package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.News;
import com.magicbeans.banjiuwan.beans.Page;
import com.magicbeans.banjiuwan.mapper.INewsMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 精品生活 业务层
 * Created by Eric Xie on 2017/2/27 0027.
 */
@Service
public class NewsService {

    @Resource
    private INewsMapper newsMapper;

    public void addNews(News news){
        newsMapper.addNews(news);
    }

    public void updateNews(News news){
        newsMapper.updateNews(news);
    }

    public Page<News> queryByItem(String title,Integer pageNO,Integer pageSize){
        List<News> dataList = newsMapper.queryByItems(title,(pageNO - 1) * pageSize, pageSize);
        Integer count = newsMapper.countByItems(title);
        Integer totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        return new Page<News>(dataList,count,totalPage);
    }

    public News queryById(Integer id){
        return newsMapper.queryNewsById(id);
    }

    public void delNews(Integer id){
        newsMapper.delNews(id);
    }

    public List<News> queryNewsPage(Integer pageNO,Integer pageSize){
        return newsMapper.queryByItems(null,(pageNO - 1) * pageSize, pageSize);
    }

}
