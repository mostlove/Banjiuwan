package com.magicbeans.banjiuwan.controller.web;

import com.magicbeans.banjiuwan.beans.*;
import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.enumutil.FoodCategoryEnum;
import com.magicbeans.banjiuwan.service.*;
import com.magicbeans.banjiuwan.util.CookCacheUtil;
import com.magicbeans.banjiuwan.util.LoginHelper;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by yuan on 2017/2/14 0014.
 */
@Controller
@RequestMapping("/web")
public class PageController extends BaseController {

    @Resource
    private SingleFoodService singleFoodService;
    @Resource
    private PackageCaterService packageCaterService;
    @Resource
    private SpecialServiceService specialServiceService;
    @Resource
    private HomeBannerService homeBannerService;
    @Resource
    private SpecialActService specialActService;
    @Resource
    private WeddingCategoryService weddingCategoryService;

    @Resource
    private SpecialWeddingService specialWeddingService;
    @Resource
    private NewsService newsService;

    @Resource
    private FoodCategoryService foodCategoryService;
    @Resource
    private MapListService mapListService;
    @Resource
    private AllConfigService allConfigService;
    @Resource
    private CookService cookService;
    @Resource
    private AgreementTextService agreementTextService;

    /**
     * 主页面
     * @return
     */
    @RequestMapping("/index")
    public String index(HttpServletRequest request, Model model){
        AdminUser user = LoginHelper.getCurrentAdmin(request);
        model.addAttribute("user",user);
        return "/index";
    }

    /**
     * 欢迎页面
     * @return
     */
    @RequestMapping("/main")
    public String main(HttpServletRequest request, Model model){
        AdminUser user = LoginHelper.getCurrentAdmin(request);
        model.addAttribute("user",user);
        return "/main";
    }

    /**
     * 用户列表
     * @return
     */
    @RequestMapping("/user/list")
    public String userList(){
        return "/user/list";
    }
    /**
     * 用户消费统计列表
     * @return
     */
    @RequestMapping("/userStatistics/list")
    public String userStatisticsList(){
        return "/userStatistics/list";
    }

    /**
     * 厨师列表
     * @return
     */
    @RequestMapping("/cook/list")
    public String cookList(){
        return "/cook/list";
    }

    /**
     * 添加厨师列表
     * @return
     */
    @RequestMapping("/cook/addPage")
    public String cookAdd(){
        return "/cook/add";
    }

    /**
     * 添加厨师列表
     * @return
     */
    @RequestMapping("/cook/editPage")
    public String cookEdit(Integer id,ModelMap modelMap){
        modelMap.put("id",id);
        return "/cook/add";
    }

    /**
     *  首页Banner
     * @return
     */
    @RequestMapping("/homeBanner/list")
    public String homeBannerList(){
        return "/homeBanner/list";
    }

    /**
     *  添加首页Banner
     * @return
     */
    @RequestMapping("/homeBanner/add")
    public String homeBannerAdd(){
        return "/homeBanner/add";
    }


    /**
     *  修改首页Banner
     * @return
     */
    @RequestMapping("/homeBanner/edit")
    public String homeBannerEdit(Integer id,Model model){
        model.addAttribute("homeBanner",homeBannerService.queryById(id));
        return "/homeBanner/edit";
    }

    /**
     *  分类首页
     * @return
     */
    @RequestMapping("/foodCategory/list")
    public String foodCategoryList(){
        return "/foodCategory/list";
    }
    /**
     *  分类首页
     * @return
     */
    @RequestMapping("/categoryFood/addPage")
    public String foodCategoryaddPage(){
        return "/foodCategory/add";
    }

    /**
     *  修改 菜品分类
     * @return
     */
    @RequestMapping("/foodCategory/editPage")
    public String foodCategoryEdit(Integer id,Model model){
        model.addAttribute("food",foodCategoryService.queryCategoryById(id));
        return "/foodCategory/edit";
    }

    /**
     *  首页字体
     * @return
     */
    @RequestMapping("/homeFont/list")
    public String homeFontList(){
        return "/homeFont/list";
    }


    /**
     * 用户编辑
     * @return
     */
    @RequestMapping("/user/edit")
    public String userEdit(Integer id,ModelMap modelMap){
        modelMap.put("id",id);
        return "/user/info";
    }

    /**
     * 登录页面
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "login";
    }
    /**
     * 登出页面
     * @return
     */
    @RequestMapping("/logout")
    public String logout(){
        LoginHelper.clearToken();
        return "login";
    }

    /**
     *  菜品 列表页
     * @return
     */
    @RequestMapping("/food/list")
    public String foodList(Model model){
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/food/list";
    }

    /**
     *  菜品(促销) 列表页
     * @return
     */
    @RequestMapping("/food/foodPromotionList")
    public String foodPromotionList(Model model){
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/food/promotionList";
    }

    /**
     *  菜品(推荐) 列表页
     * @return
     */
    @RequestMapping("/food/foodRecommendList")
    public String foodRecommendList(Model model){
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/food/recommendList";
    }

    /**
     *  新增菜品 列表页
     * @return
     */
    @RequestMapping("/food/addPage")
    public String foodAdd(Model model){
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/food/add";
    }

    /**
     *  新增菜品 列表页
     * @return
     */
    @RequestMapping("/food/editPage")
    public String foodEdit(Model model,Integer id){
        SingleFood food = singleFoodService.queryById(id);
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        model.addAttribute("food",food);
        return "/food/edit";
    }

    /**
     *  套餐 坝坝宴 列表页
     * @return
     */
    @RequestMapping("/package/list")
    public String packageCaterList(){
        return "/packageCater/list";
    }
    /**
     *  套餐 坝坝宴 新增页
     * @return
     */
    @RequestMapping("/package/addPage")
    public String packageCaterAdd(Model model){
        List<SingleFood> data = singleFoodService.queryByCategory(FoodCategoryEnum.COLD_DISHES.ordinal());
        model.addAttribute("singleFoods",data);
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/packageCater/add";
    }
    /**
     *  套餐 坝坝宴 新增页
     * @return
     */
    @RequestMapping("/package/editPage")
    public String packageCaterEdit(Integer id,Model model){
        PackageCater packageCater = packageCaterService.queryById(id);
        model.addAttribute("packageCater",packageCater);
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/packageCater/edit";
    }

    /**
     *  专业服务
     * @return
     */
    @RequestMapping("/special/service")
    public String specialService(Model model){
        SpecialService specialService = specialServiceService.querySpecial(null);
        model.addAttribute("service",specialService);
        return "/specialService/index";
    }

    /**
     * 伴餐演奏 列表
     * @return
     */
    @RequestMapping("/act/list")
    public String specialActList(){
        return "/act/list";
    }

    /**
     * 新增伴餐演奏 页
     * @return
     */
    @RequestMapping("/act/addPage")
    public String specialActAdd(){
        return "/act/add";
    }
    /**
     * 修改伴餐演奏 页
     * @return
     */
    @RequestMapping("/act/editPage")
    public String specialActEdit(Integer id,Model model){
        model.addAttribute("act",specialActService.queryById(id));
        return "/act/edit";
    }

    /**
     * 婚庆预约 列表
     * @return
     */
    @RequestMapping("/wedding/list")
    public String specialWeddingList(){
        return "/wedding/list";
    }

    /**
     * 婚庆预约 添加页面
     * @return
     */
    @RequestMapping("/wedding/addPage")
    public String specialWeddingAdd(Model model){
        model.addAttribute("cates",weddingCategoryService.queryAllCategory());
        return "/wedding/add";
    }
    /**
     * 婚庆预约 修改页面
     * @return
     */
    @RequestMapping("/wedding/editPage")
    public String specialWeddingEdit(Integer id,Model model){
        model.addAttribute("wedding",specialWeddingService.queryWeddingById(id));
        model.addAttribute("cates",weddingCategoryService.queryAllCategory()); // 大分类列表
        return "/wedding/edit";
    }


    /**
     * 婚庆预约 子项管理 列表
     * @return
     */
    @RequestMapping("/wedding/son/list")
    public String specialWeddingSonList(){
        return "/wedding/son/list";
    }

    /**
     * 婚庆预约 子项分类管理 列表
     * @return
     */
    @RequestMapping("/wedding/category/list")
    public String specialWeddingCategoryList(){
        return "/wedding/category/list";
    }

    /**
     * 婚庆预约 子项分类 子类管理 列表
     * @return
     */
    @RequestMapping("/wedding/category/child/list")
    public String specialWeddingCategoryChildList(Integer weddingCategoryId,Model model,String categoryName){
        model.addAttribute("weddingCategoryId",weddingCategoryId);
        model.addAttribute("categoryName",categoryName);
        return "/wedding/category/child/list";
    }

    /**
     * 新增子类 管理页面
     * @param weddingCategoryId
     * @param model
     * @param categoryName
     * @return
     */
    @RequestMapping("/wedding/category/child/addPage")
    public String specialWeddingCategoryChildAdd(Integer weddingCategoryId,Model model,String categoryName){
        model.addAttribute("weddingCategoryId",weddingCategoryId);
        model.addAttribute("categoryName",categoryName);
        return "/wedding/category/child/add";
    }

    /**
     *  修改 子类
     * @param weddingCategoryId
     * @param model
     * @param categoryName
     * @return
     */
    @RequestMapping("/wedding/category/child/edit")
    public String specialWeddingCategoryChildEdit(String name,String img,Integer weddingCategoryId,Model model,String categoryName,Integer id){
        model.addAttribute("weddingCategoryId",weddingCategoryId);
        model.addAttribute("categoryName",categoryName);
        model.addAttribute("id",id);
        model.addAttribute("name",name);
        model.addAttribute("img",img);
        return "/wedding/category/child/edit";
    }

    /**
     * 查看绑定的子项 页面
     * @param
     * @param model
     * @return
     */
    @RequestMapping("/wedding/category/child/sonChildlist")
    public String specialWeddingsonChildList(Integer weddingSonCategoryId,Model model){
        model.addAttribute("weddingSonCategoryId",weddingSonCategoryId);
        return "/wedding/category/child/sonChildlist";
    }

    /**
     * 精品生活 列表页
     * @return
     */
    @RequestMapping("/news/list")
    public String newsList(){
        return "/news/list";
    }

    /**
     * 精品生活 列表页
     * @return
     */
    @RequestMapping("/news/addPage")
    public String newsAdd(){
        return "/news/add";
    }
    /**
     * 精品生活 修改页
     * @return
     */
    @RequestMapping("/news/editPage")
    public String newsEdit(Integer id,Model model){
        model.addAttribute("news",newsService.queryById(id));
        return "/news/edit";
    }


    /**
     * 订单溢价配置 列表页
     * @return
     */
    @RequestMapping("/timeConfig/list")
    public String timeConfigList(){
        return "/timeConfig/list";
    }
    /**
     * 地图围栏管理
     * @return
     */
    @RequestMapping("/mapList/list")
    public String mapListList(){
        return "/mapList/list";
    }

    /**
     * 地图围栏管理
     * @return
     */
    @RequestMapping("/mapList/addPage")
    public String mapListAdd(){
        return "/mapList/edit";
    }

    /**
     * 查看修改 地图围栏管理
     * @return
     */
    @RequestMapping("/mapList/editPage")
    public String mapListEdit(Integer id,Model model){
        model.addAttribute("mapList",mapListService.queryMapListById(id));
        return "/mapList/edit";
    }

    /**
     * 交通费用配置页
     * @return
     */
    @RequestMapping("/transportationCost/list")
    public String transportationCostList(){
        return "/transportationCost/list";
    }


    /**
     * 优惠券列表页
     * @return
     */
    @RequestMapping("/coupon/list")
    public String couponList(){
        return "/coupon/list";
    }
    /**
     * 优惠券使用情况列列表页
     * @return
     */
    @RequestMapping("/coupon/detail")
    public String couponDetail(){
        return "/coupon/detail";
    }
    /**
     * 优惠券列表页
     * @return
     */
    @RequestMapping("/coupon/AddPage")
    public String couponAddPage(Model model){
        List<FoodCategory> categories = foodCategoryService.queryAllFoodCategory();
        Iterator<FoodCategory> iterator = categories.iterator();
        while (iterator.hasNext()){
            FoodCategory c = iterator.next();
            if(c.getId().equals(12) || c.getId().equals(14)){
                iterator.remove();
            }
        }
        model.addAttribute("categorys",categories);
        return "/coupon/add";
    }


    /**
     * 全局配置项
     * @return
     */
    @RequestMapping("/allConfig/list")
    public String allConfigList(Model model){
        model.addAttribute("config",allConfigService.getAllConfig());
        return "/allConfig/list";
    }

    /**
     * 服务费配置项
     * @return
     */
    @RequestMapping("/serviceConfig/list")
    public String serviceConfigList(){
        return "/serviceConfig/list";
    }


    /**
     * 订单管理
     * @return
     */
    @RequestMapping("/order/list")
    public String orderList(Model model,HttpServletRequest req){
        model.addAttribute("roleId",LoginHelper.getCurrentAdmin(req).getRoleId());
        return "/order/list";
    }

    /**
     * 订单管理（已成交）
     * @return
     */
    @RequestMapping("/order/dealList")
    public String dealList(Model model,HttpServletRequest req){
        model.addAttribute("roleId",LoginHelper.getCurrentAdmin(req).getRoleId());
        return "/order/dealList";
    }

    /**
     * 订单管理（未成交）
     * @return
     */
    @RequestMapping("/order/unDealList")
    public String unDealList(Model model,HttpServletRequest req){
        model.addAttribute("roleId",LoginHelper.getCurrentAdmin(req).getRoleId());
        return "/order/unDealList";
    }



    /**
     * 订单详情
     * @return
     */
    @RequestMapping("/order/orderInfoWeb")
    public String orderInfoWeb(Integer id,Model model){
        model.addAttribute("id",id);
        return "/order/info";
    }

    /**
     * 订单管理（回收站）
     * @return
     */
    @RequestMapping("/order/recycleBinList")
    public String recycleBinList(Model model,HttpServletRequest req){
        model.addAttribute("roleId",LoginHelper.getCurrentAdmin(req).getRoleId());
        return "/order/recycleBinList";
    }

    /**
     * 厨师分配
     * @return
     */
    @RequestMapping("/order/cookPage")
    public String orderCook(Long serviceDate,Model model,Integer id,HttpServletRequest req){
        model.addAttribute("cooks",cookService.queryCookByServiceDate(new Date(serviceDate)));
        model.addAttribute("orderId",id);
        return "/order/cook";
    }
    /**
     * 后台用户管理 页面
     * @return
     */
    @RequestMapping("/adminUser/list")
    public String adminUserList(){
        return "/adminUser/list";
    }
    /**
     * 后台用户管理 新增 页面
     * @return
     */
    @RequestMapping("/adminUser/editPage")
    public String adminUserEditPage(Integer id, ModelMap modelMap){
        modelMap.put("id",id);
        return "/adminUser/add";
    }

    /**
     * 后台用户管理 新增 页面
     * @return
     */
    @RequestMapping("/adminUser/addPage")
    public String adminUseraddPage(){
        return "/adminUser/add";
    }

    /**
     * 充值参数配置 页面
     * @return
     */
    @RequestMapping("/rechargeConfig/list")
    public String rechargeConfigList(){
        return "/rechargeConfig/list";
    }


    /**
     * 充值记录日志 页面
     * @return
     */
    @RequestMapping("/rechargeRecord/list")
    public String rechargeRecordList(){
        return "/rechargeRecord/list";
    }


    /**
     * 实时菜价 页面
     * @return
     */
    @RequestMapping("/vegetables/list")
    public String vegetablesList(){
        return "/vegetables/list";
    }

    /**
     * 菜品管理 页面
     * @return
     */
    @RequestMapping("/vegetables/dish/list")
    public String vegetablesDishList(){
        return "/vegetables/dish/list";
    }

    /**
     * 召唤我的经理 页面
     * @return
     */
    @RequestMapping("/callMyAM/list")
    public String callMyAMList(){
        return "/callMyAm/list";
    }

    /**
     * 会员地址管理 页面
     * @return
     */
    @RequestMapping("/userAddress/list")
    public String userAddressList(){
        return "/userAddress/list";
    }

    /**
     * 厨师实时地图 页面
     * @return
     */
    @RequestMapping("/cookLatLng/index")
    public String cookLatLngIndex(){
        /*List<Cook> cooks = CookCacheUtil.getCacheCooks();
        List<String> cooksLagLat = new ArrayList<String>();
        if(null != cooks && cooks.size() > 0){
            for (Cook cook : cooks){
                String[] lagLat = cook.getLatLng().split(",");
                cooksLagLat.add(lagLat[0]+":"+lagLat[1]);
            }
        }
        model.addAttribute("mapList", JSONObject.fromObject(cooksLagLat));*/
        return "/cookLatLng/index";
    }


    /**
     * 客户经理销售业绩 页面
     * @return
     */
    @RequestMapping("/orderSales/list")
    public String orderSalesList(){
        return "/orderSales/list";
    }



    /**
     *
     * 权限管理 页面
     * @return
     */
    @RequestMapping("/power/list")
    public String powerList(){
        return "/power/list";
    }

    /**
     *
     * 服务员 页面
     * @return
     */
    @RequestMapping("/waiter/list")
    public String waiterList(){
        return "/waiter/list";
    }


    /**
     *
     * 服务员 页面
     * @return
     */
    @RequestMapping("/waiter/addPage")
    public String waiteraddPage(){
        return "/waiter/add";
    }


    /**
     *
     * 菜品评价列表
     * @return
     */
    @RequestMapping("/evaluate/evaluateFoodList")
    public String evaluateFoodList(Model model){
        model.addAttribute("categorys",foodCategoryService.querySingleFoodCategory());
        return "/evaluate/evaluateFoodList";
    }

    /**
     *
     * 菜品评价列表
     * @return
     */
    @RequestMapping("/evaluate/evaluateOrderList")
    public String evaluateOrderList(){
        return "/evaluate/evaluateOrderList";
    }


    /**
     *
     * 日志列表页
     * @return
     */
    @RequestMapping("/log/listPage")
    public String logList(){
        return "/log/list";
    }



    /**
     * 配置提示语 页面
     * @return
     */
    @RequestMapping("/msgConfig/list")
    public String msgConfigList(){
        return "/msgConfig/list";
    }

    /**
     * 配置提示语 页面
     * @return
     */
    @RequestMapping("/msgConfig/homePower/list")
    public String msgConfigHomePowerList(){
        return "/msgConfig/homePower/list";
    }

    /**
     * 积分使用管理 页面
     * @return
     */
    @RequestMapping("/accumulateDetail/list")
    public String accumulateDetailList(){
        return "/accumulateDetail/list";
    }

    /**
     * 协议管理 页面
     * @return
     */
    @RequestMapping("/agreementText/list")
    public String agreementTextList(){
        return "/agreementText/list";
    }
    /**
     * 协议管理修改 页面
     * @return
     */
    @RequestMapping("/agreementText/editPage")
    public String agreementTextEditPage(Integer id,Model model){
        model.addAttribute("agreementText",agreementTextService.queryAgreementTextById(id));
        return "/agreementText/edit";
    }



}
