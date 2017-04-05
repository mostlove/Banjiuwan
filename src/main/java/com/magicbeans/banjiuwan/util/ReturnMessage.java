package com.magicbeans.banjiuwan.util;

/**
 * Created by Eric Xie on 2017/2/14 0014.
 */
public enum ReturnMessage {

    MSG_SUCCESS("获取成功"),
    MSG_SUCCESS_UPDATE("操作成功"),
    MSG_SUCCESS_REGISTER("注册成功"),
    MSG_SUCCESS_LOGIN("登录成功"),


    MSG_FAIL("获取失败"),
    MSG_FAIL_ACC_PWD_ERROR("用户名或密码错误"),
    MSG_ACCOUNT_NON_VALID("帐号无效"),
    MSG_NOT_LOGIN("未登录"),
    MSG_NON_ALLOW("没有权限"),
    MSG_ARGUMENTS_EXCEPTION("参数异常"),
    MSG_MESSAGE_FAIL("短信发送失败"),
    MSG_DATA_FAIL("数据不合法"),
    MSG_FIELD_NOT_NULL("字段不能为空"),
    ORDER_STATUS_ABNORMITY("订单状态异常"),
    MSG_OBJECT_NOT_EXIST("对象不存在");





    private String name;

    private ReturnMessage(String name){
        this.name = name;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
