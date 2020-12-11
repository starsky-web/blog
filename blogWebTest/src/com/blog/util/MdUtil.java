package com.blog.util;

import java.io.*;

public class MdUtil {
    public static int storeMd(String mdContent,String mdTitle){

        String savePath = "F:\\blogWebTest\\web\\UserFile\\md";
        File file = new File(savePath);


        try {
            file=new File(file,mdTitle+".md");
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

}

