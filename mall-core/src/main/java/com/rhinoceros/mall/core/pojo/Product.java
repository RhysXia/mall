package com.rhinoceros.mall.core.pojo;

import com.rhinoceros.mall.core.enumeration.ProductStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 商品实体
 */
@Data
public class Product {

    /**
     * 多个image url隔开符号
     */
    public static final String IMAGE_SEPARATION = ";";

    /**
     * 商品id
     */
    private Long id;
    /**
     * 商品名称
     */
    private String name;
    /**
     * 价格
     */
    private BigDecimal price;
    /**
     * 优惠价
     */
    private BigDecimal discount;
    /**
     * 商品状态
     */
    private ProductStatus status;
    /**
     * 商品分类id
     */
    private Long categoryId;

    /**
     * 商品分类id
     */
    private Long rootCategoryId;

    /**
     * 商品库存总量
     */
    private Integer storeNum;

    /**
     * 商品销售总量
     */
    private Integer saleNum;

    /**
     * 商品图片url,多个url则以{@link IMAGE_SEPARATION}隔开
     */
    private String imageUrls;

    /**
     * 产品参数，json数据格式
     */
    private Long descriptionId;
    /**
     * 商品总评论数
     */
    private Long commentNum;

    /**
     * 上架时间
     */
    private Date saleDate;
}
