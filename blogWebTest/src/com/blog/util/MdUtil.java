package com.blog.util;

import java.io.*;

public class MdUtil {
    public static int PAGE_COUNT = 40;
    public static int storeMd(String mdContent,String mdTitle){

        String savePath = "F:\\blogWebTest\\web\\UserFile\\md";
        File file = new File(savePath);


        try {
            file=new File(file,mdTitle+".md");
            if (file.exists()){
                file.delete();
            }
            System.out.println(file.getAbsolutePath());
            file.createNewFile();
            OutputStreamWriter w = new OutputStreamWriter(new FileOutputStream(file),"utf-8");
            w.write(mdContent);
            w.flush();
            return 1;
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }
    public static String mdToPreview(String mdContent){
        String preview = mdContent.replace("#", "").replace("`", "")
                .replace("/s","").replace("/n","").replaceAll("[&nbsp;]+","")
                .replaceAll("[<br>]{0,}","").replaceAll("(?m)^\\s*$(\\n|\\r\\n)", "")
                .replaceAll("\r|\n", "").trim();
        try {
            preview = preview.substring(0,120);
        }catch (StringIndexOutOfBoundsException e){
            preview = preview.substring(0,preview.length()-1);
            return preview;
        }



        return preview;
    }
    public static String mdFullText(String mdPath){
        FileInputStream fis = null;
        File savePath = new File("F:\\blogWebTest\\web\\UserFile\\md");
        File file = new File(savePath,mdPath);
        System.out.println("文件路径"+file);
        String md = null;
        StringBuilder s = new StringBuilder();

        try {
            fis = new FileInputStream(file);
            int len = 0;
            while((len = fis.read())!=-1){
                s.append((char)len);
            }
            md=new String(s.toString().getBytes("ISO-8859-1"),"utf-8");
            System.out.println(md);
        } catch (FileNotFoundException e) {
            System.out.println("修改时文件找不到");
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

//        try {
//            fis = new FileInputStream(file);
//            byte[] buffer = new byte[1024];
//            int num = fis.read(buffer,5,buffer.length-5);
//            md = new String(buffer);
//            System.out.println(md);
//        } catch (FileNotFoundException e) {
//            System.out.println("修改时文件找不到");
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

        return md;
    }

}

