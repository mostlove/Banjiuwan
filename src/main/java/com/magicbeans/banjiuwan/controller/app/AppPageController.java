package com.magicbeans.banjiuwan.controller.app;

import com.magicbeans.banjiuwan.controller.BaseController;
import com.magicbeans.banjiuwan.service.AgreementTextService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * app页面跳转--控制器
 * Created by yuan on 2017/2/14 0014.
 */
@Controller
@RequestMapping("/app/page")
public class AppPageController extends BaseController {

    @Resource
    private AgreementTextService agreementTextService;

    /**
     * 登录
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "/app/login";
    }

    /**
     * 首页
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "/app/index";
    }


    /***
     * 购物车页面
     * @return
     */
    @RequestMapping("/car")
    public String car(){
        return "/app/car";
    }

    /***
     * 发现页面
     * @return
     */
    @RequestMapping("/find")
    public String find(){
        return "/app/find";
    }

    /***
     * 客服页面
     * @return
     */
    @RequestMapping("/customer")
    public String customer(){
        return "/app/customer";
    }

    /***
     * 个人中心页面
     * @return
     */
    @RequestMapping("/my")
    public String my(){
        return "/app/person/my";
    }

    /***
     * 修改个人中心页面
     * @return
     */
    @RequestMapping("/personData")
    public String personData(){
        return "/app/person/personData";
    }

    /***
     * 添加收货地址页面
     * @return
     */
    @RequestMapping("/addAddress")
    public String addAddress(){
        return "/app/person/addAddress";
    }

    /***
     * 会员卡页面
     * @return
     */
    @RequestMapping("/memberCard")
    public String memberCard(){
        return "/app/person/memberCard";
    }

    /***
     * 我的积分页面
     * @return
     */
    @RequestMapping("/integration")
    public String integration(){
        return "/app/person/integration";
    }

    /***
     * 抵用券页面
     * @return
     */
    @RequestMapping("/voucher")
    public String voucher(){
        return "/app/person/voucher";
    }

    /***
     * 地址管理页面
     * @return
     */
    @RequestMapping("/address")
    public String address(){
        return "/app/person/address";
    }

    /***
     * 菜谱页面
     * @return
     */
    @RequestMapping("/cookbook")
    public String cookbook(){
        return "/app/cookbook/cookbook";
    }

    /***
     * 菜谱详情页面
     * @return
     */
    @RequestMapping("/cookbookDetail")
    public String cookbookDetail(){
        return "/app/cookbook/cookbookDetail";
    }

    /***
     * 套餐页面
     * @return
     */
    @RequestMapping("/setMeal")
    public String setMeal(){
        return "/app/setMeal/setMeal";
    }

    /***
     * 套餐详情页面
     * @return
     */
    @RequestMapping("/setMealDetail")
    public String setMealDetail(){
        return "/app/setMeal/setMealDetail";
    }

    /***
     * 坝坝宴页面
     * @return
     */
    @RequestMapping("/bamYan")
    public String bamYan(){
        return "/app/bamYan/bamYan";
    }

    /***
     * 坝坝宴详情页面
     * @return
     */
    @RequestMapping("/bamYanDetail")
    public String bamYanDetail(){
        return "/app/bamYan/bamYanDetail";
    }

    /***
     * 专业服务详情页面
     * @return
     */
    @RequestMapping("/serviceDetail")
    public String serviceDetail(){
        return "/app/service/serviceDetail";
    }

    /***
     * 伴餐演奏页面
     * @return
     */
    @RequestMapping("/dinner")
    public String dinner(){
        return "/app/service/dinner";
    }

    /***
     * 伴餐演奏详情页面
     * @return
     */
    @RequestMapping("/dinnerDetail")
    public String dinnerDetail(){
        return "/app/service/dinnerDetail";
    }

    /***
     * 婚庆预约页面
     * @return
     */
    @RequestMapping("/wedding")
    public String wedding(){
        return "/app/service/wedding";
    }

    /***
     * 婚庆预约详情页面
     * @return
     */
    @RequestMapping("/weddingDetail")
    public String weddingDetail(){
        return "/app/service/weddingDetail";
    }

    /***
     * 实时菜价页面
     * @return
     */
    @RequestMapping("/foodPrice")
    public String foodPrice(){
        return "/app/service/foodPrice";
    }

    /***
     * 填写订单页面
     * @return
     */
    @RequestMapping("/orderEdit")
    public String orderEdit(){
        return "/app/order/orderEdit";
    }

    /***
     * 我的订单页面
     * @return
     */
    @RequestMapping("/myOrder")
    public String myOrder(){
        return "/app/order/myOrder";
    }

    /***
     * 订单详情页面
     * @return
     */
    @RequestMapping("/orderDetail")
    public String orderDetail(){
        return "/app/order/orderDetail";
    }

    /***
     * 订单评价页面
     * @return
     */
    @RequestMapping("/orderEvaluate")
    public String orderEvaluate(){
        return "/app/order/orderEvaluate";
    }

    /***
     * 商品评价页面
     * @return
     */
    @RequestMapping("/orderGoodsEvaluate")
    public String orderGoodsEvaluate(){
        return "/app/order/orderGoodsEvaluate";
    }

    /***
     * 换一换页面
     * @return
     */
    @RequestMapping("/exchange")
    public String exchange(){
        return "/app/exchange";
    }


    /***************************************************厨师端**************************************************/
    /***
     * 厨师端登录页面
     * @return
     */
    @RequestMapping("/cookLogin")
    public String cookLogin(){
        return "/app/cook/cookLogin";
    }

    /***
     * 找回密码页面
     * @return
     */
    @RequestMapping("/forgetPassword")
    public String forgetPassword(){
        return "/app/cook/forgetPassword";
    }

    /***
     * 厨师端个人中心页面
     * @return
     */
    @RequestMapping("/cookMy")
    public String cookMy(){
        return "/app/cook/cookMy";
    }

    /***
     * 厨师端订单页面
     * @return
     */
    @RequestMapping("/cookMyOrder")
    public String cookMyOrder(){
        return "/app/cook/cookMyOrder";
    }

    /***
     * 厨师端订单详情页面
     * @return
     */
    @RequestMapping("/cookOrderDetail")
    public String cookOrderDetail(){
        return "/app/cook/cookOrderDetail";
    }

    /***
     * 厨师端个人中心页面
     * @return
     */
    @RequestMapping("/cookPersonData")
    public String cookPersonData(){
        return "/app/cook/cookPersonData";
    }

    /***
     * 404页面
     * @return
     */
    @RequestMapping("/notExistent")
    public String notExistent(){
        return "/app/notExistent";
    }

    /***
     * 错误页面
     * @return
     */
    @RequestMapping("/error")
    public String error(){
        return "/app/error";
    }

    /***
     * 搜索页面
     * @return
     */
    @RequestMapping("/search")
    public String search(){
        return "/app/search";
    }

    /***
     * 选择地址页面
     * @return
     */
    @RequestMapping("/selectAddress")
    public String selectAddress(){
        return "/app/map/selectAddress";
    }

    /***
     * 更多地址页面
     * @return
     */
    @RequestMapping("/moreAddress")
    public String moreAddress(){
        return "/app/map/moreAddress";
    }

    /***
     * 分享页面
     * @return
     */
    @RequestMapping("/share")
    public String share(String code, Model model){
        model.addAttribute("code",code);
        return "/app/share";
    }

    /***
     * 精品生活文章详情--页面
     * @return
     */
    @RequestMapping("/news")
    public String news(){
        return "/app/news";
    }

    /***
     * banner文章详情--页面
     * @return
     */
    @RequestMapping("/bannerNews")
    public String bannerNews(){
        return "/app/bannerNews";
    }

    /***
     * banner详情--页面
     * @return
     */
    @RequestMapping("/bannerDetail")
    public String bannerDetail(){
        return "/app/bannerDetail";
    }


    /***
     * 用户协议-页面
     * @return
     */
    @RequestMapping("/userAgreement")
    public String agreement(Model mode){
        mode.addAttribute("agreement",agreementTextService.queryAgreementTextById(2));
        return "/app/agreement";
    }

    /***
     * 会员充值-页面
     * @return
     */
    @RequestMapping("/recharge")
    public String recharge(Model mode){
        mode.addAttribute("agreement",agreementTextService.queryAgreementTextById(1));
        return "/app/agreement";
    }


}
