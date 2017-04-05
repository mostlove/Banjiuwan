package com.magicbeans.banjiuwan.util;

import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/10 0010.
 */
public class SendEmailThread implements Runnable {

    private List<String> emails = new ArrayList<String>();

    private String content;
    private String subject;

    private static String mailSmtpAuth = "true";

    private static String hostName = "smtp.exmail.qq.com";

    private static String userName = "chushizhuanyong@ban9wan.com";

    private static String password = "Cszy123";

    private static String port = "465";

    private Logger logger = Logger.getLogger(this.getClass());

    public SendEmailThread(List<String> emails,String subject,String content){
        this.emails = emails;
        this.content = content;
        this.subject = subject;
    }

    public void run() {
        try {
            for (String email : emails){
                SendEmail sendEmail = new SendEmail(hostName,userName,password,mailSmtpAuth,port);
                sendEmail.send(email,subject,content);
            }
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
    }




}
