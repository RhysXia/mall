package com.rhinoceros.mall.core.vo;
/* created at 3:27 PM 2/28/2018  */

import com.rhinoceros.mall.core.pojo.Product;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 这个类封装商品展示信息
 */
@Data
public class ProductVo extends Product{

    /**
     * 父类
     */
    private Product product;

    /**
     * 这个变量储存商品图片地址的数组
     */
    private String[] imagesUrls;

    /**
     * 这变量储存商品第一张图片的地址
     */
    private String firstImageUrls;


}
