package com.blog.entity;

import java.util.List;

public class indexImg {
    private List hotTopic;
    private List HeadLineLeft;
    private List HeadLineRight;
    private List VIP;
    private List recommend;
    private List PythonImg;
    private List Life;
    private List FrontImg;
    private List java;
    private List OpenSourceImg;
    private List AI;

    public indexImg(List hotTopic, List headLineLeft, List headLineRight, List VIP, List recommend, List pythonImg, List life, List frontImg, List java, List openSourceImg, List AI) {
        this.hotTopic = hotTopic;
        HeadLineLeft = headLineLeft;
        HeadLineRight = headLineRight;
        this.VIP = VIP;
        this.recommend = recommend;
        PythonImg = pythonImg;
        Life = life;
        FrontImg = frontImg;
        this.java = java;
        OpenSourceImg = openSourceImg;
        this.AI = AI;
    }

    public indexImg() {
    }

    @Override
    public String toString() {
        return "indexImg{" +
                "hotTopic=" + hotTopic +
                ", HeadLineLeft=" + HeadLineLeft +
                ", HeadLineRight=" + HeadLineRight +
                ", VIP=" + VIP +
                ", recommend=" + recommend +
                ", PythonImg=" + PythonImg +
                ", Life=" + Life +
                ", FrontImg=" + FrontImg +
                ", java=" + java +
                ", OpenSourceImg=" + OpenSourceImg +
                ", AI=" + AI +
                '}';
    }

    public List getHotTopic() {
        return hotTopic;
    }

    public void setHotTopic(List hotTopic) {
        this.hotTopic = hotTopic;
    }

    public List getHeadLineLeft() {
        return HeadLineLeft;
    }

    public void setHeadLineLeft(List headLineLeft) {
        HeadLineLeft = headLineLeft;
    }

    public List getHeadLineRight() {
        return HeadLineRight;
    }

    public void setHeadLineRight(List headLineRight) {
        HeadLineRight = headLineRight;
    }

    public List getVIP() {
        return VIP;
    }

    public void setVIP(List VIP) {
        this.VIP = VIP;
    }

    public List getRecommend() {
        return recommend;
    }

    public void setRecommend(List recommend) {
        this.recommend = recommend;
    }

    public List getPythonImg() {
        return PythonImg;
    }

    public void setPythonImg(List pythonImg) {
        PythonImg = pythonImg;
    }

    public List getLife() {
        return Life;
    }

    public void setLife(List life) {
        Life = life;
    }

    public List getFrontImg() {
        return FrontImg;
    }

    public void setFrontImg(List frontImg) {
        FrontImg = frontImg;
    }

    public List getJava() {
        return java;
    }

    public void setJava(List java) {
        this.java = java;
    }

    public List getOpenSourceImg() {
        return OpenSourceImg;
    }

    public void setOpenSourceImg(List openSourceImg) {
        OpenSourceImg = openSourceImg;
    }

    public List getAI() {
        return AI;
    }

    public void setAI(List AI) {
        this.AI = AI;
    }
}
