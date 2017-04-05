package com.magicbeans.banjiuwan.util;

import com.magicbeans.banjiuwan.beans.RechargeRecord;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.List;

/**
 *  数据导出excel工具
 * Created by Eric Xie on 2017/3/15 0015.
 */
public class ExcelUtil {

    private static Logger logger = Logger.getLogger(ExcelUtil.class);



    public static void createExcel(HttpServletResponse resp,List<String> rowTitles,List<List<String>> contents){

        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(); //创建excel文件
        HSSFSheet sheet = hssfWorkbook.createSheet(); // 创建工作簿

        HSSFRow rowFrist = sheet.createRow(0); // 创建第一行
        for (int i = 0; i < rowTitles.size() ; i++) {
            rowFrist.createCell(i).setCellValue(rowTitles.get(i));
        }
        // 创建其他行数据..从第二行开始
        for (int i = 0; i < contents.size(); i++){
            HSSFRow row = sheet.createRow(i+1);
            List<String> rows = contents.get(i);
            for (int j=0; j < rows.size(); j++){
                // 创建单元格数据
                row.createCell(j).setCellValue(rows.get(j));
            }
        }
        OutputStream out = null;
        try {
            out = resp.getOutputStream();
            resp.reset();
            resp.setHeader("Content-disposition", "attachment; filename=details.xls");
            resp.setContentType("application/msexcel");
            hssfWorkbook.write(out);
            out.close();
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
    }


    public static void main(String[] args) throws Exception {
        RechargeRecord rechargeRecord = new RechargeRecord();
        rechargeRecord.setUserName("abc");
        Field field = rechargeRecord.getClass().getDeclaredField("userName");
        field.setAccessible(true);
        System.out.println(field.get(rechargeRecord));
    }

}
