package com.magicbeans.banjiuwan.filter;

import com.magicbeans.banjiuwan.beans.User;
import com.magicbeans.banjiuwan.service.UserService;
import com.magicbeans.banjiuwan.util.CommonUtil;
import com.magicbeans.banjiuwan.util.LoginHelper;
import com.magicbeans.banjiuwan.util.SendRequestUtil;
import com.magicbeans.banjiuwan.wx.WeChatConfig;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/21 0021.
 */

@WebFilter("/app/*")
public class APPFilter implements Filter {


    private Logger logger = Logger.getLogger(this.getClass());
//    @Resource
//    private UserService userService;

    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String ua = request.getHeader("user-agent").toLowerCase();

        logger.debug("UA: "+ua);
        if (ua.indexOf("micromessenger") < 0) {// 非微信浏览器不进行请求
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String url = requestURI.substring(contextPath.length());
        List<String> excludePath = new ArrayList<String>();
        excludePath.add("cook");
        for (String exclude : excludePath) {
            if (exclude.contains(url)) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
        }

        // 不拦截付款回调
        if (url.indexOf("wxPayCallBackApi") >= 0) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        // 不拦截支付宝付款回调
        if (url.indexOf("/app/aliPay") >= 0) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        HttpSession session = request.getSession();
        Object object = session.getAttribute(WeChatConfig.SESSION_WX_USER);
        String code = request.getParameter("code");
        logger.debug("code -------------------： "+code);
        logger.debug("object -------------------： "+object);
        if (null == object && CommonUtil.isEmpty(code)) {
            // 无微信用户信息, 跳转获取code
            logger.debug("无微信用户信息, 跳转获取code -------------------： ");
            String redirectUrl = request.getRequestURL().toString();
//            String redirectUrl = "http://tiger.magic-beans.cn/app/page/index";
            String authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + WeChatConfig.getValue("appId") + "&redirect_uri=" + redirectUrl + "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
            response.sendRedirect(authUrl);
            return;
        } else if (null == object && !CommonUtil.isEmpty(code)) {
            // 已获取code, 调用获取openid
            logger.debug("已获取code, 调用获取openid 开始-------------------： ");
            String requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WeChatConfig.getValue("appId") + "&secret=" + WeChatConfig.getValue("secret") + "&code=" + code + "&grant_type=authorization_code";
//            JSONObject result = HttpClientUtil.httpRequest(requestUrl);
            logger.debug("获取openId URI:  "+requestUrl);
            try {
                String resultStr = SendRequestUtil.sendRequest(requestUrl,"GET");
                logger.debug("resultStr -------------------： "+resultStr);
                JSONObject result = JSONObject.fromObject(resultStr);
                logger.debug("请求openid结果： "+result);
                String openId = result.getString("openid");
                User wxUser = new User();
                wxUser.setOpenId(openId);
                session.setAttribute(WeChatConfig.SESSION_WX_USER, wxUser);
            }catch (Exception e){
                logger.error("请求appid异常.",e);
            }
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    public void destroy() {

    }
}
