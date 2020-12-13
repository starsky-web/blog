package com.blog.util;

import com.blog.entity.indexImg;

import java.util.*;

/**
 * 动态获取首页图片路径
 */
public class indexUtil {
    public static indexImg getImgs(){
        indexImg indexImg = new indexImg();

        indexImg.setFrontImg(getFrontImg());
        indexImg.setPythonImg(getPythonImg());
        indexImg.setOpenSourceImg(getOpenSourceImg());
        indexImg.setAI(getAIImg());
        indexImg.setHotTopic(getHotImg());
        indexImg.setHeadLineLeft(getHeadLineLeft());
        indexImg.setHeadLineRight(getHeadLineRight());
        indexImg.setJava(getJava());
        //VIP
        indexImg.setRecommend(getRecommend());
        indexImg.setLife(getLift());

        return indexImg;
    }

    private static List<String> getJava() {
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> java = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<2;i++){
            int i1 = rd.nextInt(2)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            java.add(integer.toString());
        }


        return java;
    }

    private static List<String> getLift() {
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> Left = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<2;i++){
            int i1 = rd.nextInt(2)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            Left.add(integer.toString());
        }


        return Left;
    }

    private static List<String> getRecommend() {
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> Recommend = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<8;i++){
            int i1 = rd.nextInt(8)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            Recommend.add(integer.toString());
        }


        return Recommend;
    }

    private static List<String> getVIP() {
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> VIP = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<4;i++){
            int i1 = rd.nextInt(4)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            VIP.add(integer.toString());
        }


        return VIP;
    }

    private static List<String> getHeadLineRight() {
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> HeadLineRight = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<4;i++){
            int i1 = rd.nextInt(4)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            HeadLineRight.add(integer.toString());
        }


        return HeadLineRight;
    }

    private static List<String> getHeadLineLeft() {
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> HeadLineLeft = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<1;i++){
            int i1 = rd.nextInt(1)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            HeadLineLeft.add(integer.toString());
        }


        return HeadLineLeft;

    }

    public static List<String> getHotImg(){
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> hotImg = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<4;i++){
            int i1 = rd.nextInt(4)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            hotImg.add(integer.toString());
        }


        return hotImg;
    }
    public static List<String> getPythonImg(){
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> pythonImg = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<8;i++){
            int i1 = rd.nextInt(8)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            pythonImg.add(integer.toString());
        }


        return pythonImg;
    }
    public static List<String> getFrontImg(){
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> FrontImg = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<8;i++){
            int i1 = rd.nextInt(8)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            FrontImg.add(integer.toString());
        }


        return FrontImg;
    }
    public static List<String> getOpenSourceImg(){
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> OpenSourceImg = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<8;i++){
            int i1 = rd.nextInt(8)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            OpenSourceImg.add(integer.toString());
        }


        return OpenSourceImg;
    }
    public static List<String> getAIImg(){
        Set<Integer> Img = new LinkedHashSet<>();//存储四个不重复的随机数
        List<String> AIImg = new ArrayList<>();
        Random rd = new Random();
        //循环将随机数输入set集合，避免重复
        for (int i = 0;Img.size()<8;i++){
            int i1 = rd.nextInt(8)+1;
            Img.add(i1);
        }
        //将set集合转换为string类型并输入至List集合
        for (Integer integer : Img) {
            AIImg.add(integer.toString());
        }


        return AIImg;
    }
}
