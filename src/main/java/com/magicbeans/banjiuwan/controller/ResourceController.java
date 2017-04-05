package com.magicbeans.banjiuwan.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.magicbeans.banjiuwan.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



/**
 * Created by flyong86 on 2016/5/6.
 */
@Controller
@RequestMapping("/res")
public class ResourceController extends BaseController {


    @RequestMapping("/upload")
    @ResponseBody
    public ViewData upload(@RequestParam(value = "type" ,defaultValue = "other") String type, HttpServletRequest request){

        Calendar ca = Calendar.getInstance(); 
        if (request instanceof MultipartHttpServletRequest) {
            String url = "";
            MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
            Map<String, MultipartFile> multipartFileMap = multipartHttpServletRequest.getFileMap();
            if (multipartFileMap != null) {
                for (Map.Entry<String, MultipartFile> entry : multipartFileMap.entrySet()) {
                    MultipartFile multipartFile = entry.getValue();
//                    String filename = multipartFile.getOriginalFilename();
                    String filePath = "upload/" + ca.get(Calendar.YEAR) + "/" + ca.get(Calendar.MONTH) + "/" + ca.get(Calendar.DAY_OF_MONTH) + "/";
                    String resName = FileUpload.fileUp(multipartFile, filePath, UuidUtil.get32UUID());

                    StringBuffer picURL = new StringBuffer();
//                    picURL.append(request.getScheme() + "://");
//                    picURL.append(request.getServerName() + ":");
//                    picURL.append(request.getServerPort() + "");
//                    picURL.append(request.getContextPath() + "/");
                    picURL.append(filePath + resName);
                    url = picURL.toString();
					if (null != type && type.trim().length() > 0 && "1".equals(type)) {
						String path = request.getSession().getServletContext().getRealPath("/");
						String iconPath = path + "/" + filePath + "/icon";
						File file = new File(iconPath);
						if (!file.isDirectory()) {
							file.mkdir();
						}
						//压缩图片
						ImgCompress.reduceImg(path+"/"+url,iconPath+"/"+resName,32,32,null);

					}
                }
            }
            Map<String,Object> data = new HashMap<String, Object>();
            data.put("url", url);
            return buildSuccessJson(StatusConstant.SUCCESS_CODE,"上传成功", data);
        }
            return buildFailureJson(ViewData.FlagEnum.ERROR, 202,"上传失败");

    }
    
    
    /**
     * 存号码
     * @param request
     * @param phone
     * @return
     * @throws IOException
     */
    @RequestMapping("/saveContactUs")
    @ResponseBody
    public ViewData saveContactUs(HttpServletRequest request,String phone) throws IOException{
    	try {
    		String saveRealPath = request.getSession().getServletContext().getRealPath("/")+"//contactUs";
        	File file = new File(saveRealPath);
        	if (!file.exists()) {
        		file.mkdirs();
    		}
        	String phonePath = saveRealPath+"//phone.txt";
        	File phonefile = new File(phonePath);
        	if (!phonefile.exists()) {
        		phonefile.createNewFile();
    		}
        	BufferedWriter output = new BufferedWriter(new FileWriter(phonePath));  
        	output.write(phone);  
        	output.close();  
		} catch (Exception e) {
			e.printStackTrace();
			return buildFailureJson(StatusConstant.Fail_CODE, "操作失败");
		}
    	return buildFailureJson(StatusConstant.SUCCESS_CODE, "操作成功");
    }
    /**
     * 读取号码
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/readContactUs")
    @ResponseBody
    public ViewData readContactUs(HttpServletRequest request) throws IOException{
    	try {
    		String phone = "";
    		String saveRealPath = request.getSession().getServletContext().getRealPath("/")+"//contactUs";
    		String read;
        	File file = new File(saveRealPath);
        	if (!file.exists()) {
        		return buildFailureJson(StatusConstant.Fail_CODE, "暂无联系方式");
    		}
        	String phonePath = saveRealPath+"//phone.txt";
        	File filePhone = new File(phonePath);
        	if (!filePhone.exists()) {
        		return buildFailureJson(StatusConstant.Fail_CODE, "暂无联系方式");
    		}
        	BufferedReader readPhone = new BufferedReader(new FileReader(phonePath)); 
        	while((read=readPhone.readLine())!=null){  
        		phone=phone+read;  
        	   }  
        	return buildSuccessJson(StatusConstant.SUCCESS_CODE, "获取成功",phone);
		} catch (Exception e) {
			e.printStackTrace();
			return buildFailureJson(StatusConstant.Fail_CODE, "操作失败");
		}
    }


	@RequestMapping("/testExcel")
	public void testExcel(HttpServletResponse response){
		List<String> titles = new ArrayList<String>();
		titles.add("用户名");
		titles.add("余额");
		titles.add("密码");

		List<String> data1 = new ArrayList<String>();
		data1.add("admin1");
		data1.add("12");
		data1.add("pwd");

		List<String> data2 = new ArrayList<String>();
		data2.add("admin2");
		data2.add("1222");
		data2.add("pwd2");

		List<List<String>> contents = new ArrayList<List<String>>();
		contents.add(data1);
		contents.add(data2);
		ExcelUtil.createExcel(response,titles,contents);
	}
    
}
