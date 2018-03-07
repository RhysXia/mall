package com.rhinoceros.mall.dao.dao;
/* created at 3:57 PM 3/7/2018  */

public interface DescriptionDao {

    /**
     * 根据产品id查找产品详情
     * @param productId
     * @return
     */
    String findByProductId(Long productId);
}
