package com.rhinoceros.mall.service.service;


import com.rhinoceros.mall.core.dto.CartProductDto;
import com.rhinoceros.mall.core.pojo.CartProduct;
import com.rhinoceros.mall.core.pojo.Product;

import java.util.List;

/**
 * 购物车业务逻辑接口
 */
public interface CartProductService {
    /**
     * 找到购物车
     * @return
     */
    List<CartProduct> findByUserId(Long userId);


    /**
     * 从购物车删除商品信息
     * @param cartProductId
     */
    void deleteByCartProductId(Long cartProductId);

    /**
     * 统计购物车中购买商品的数量
     * @param cartProductId
     * @return
     */
    Integer updateByCartProductId(long cartProductId,Integer num);
}
