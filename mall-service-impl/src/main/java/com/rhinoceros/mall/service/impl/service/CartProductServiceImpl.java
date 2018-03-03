package com.rhinoceros.mall.service.impl.service;

import com.rhinoceros.mall.core.pojo.CartProduct;
import com.rhinoceros.mall.core.pojo.Product;
import com.rhinoceros.mall.dao.dao.CartProductDao;
import com.rhinoceros.mall.dao.dao.ProductDao;
import com.rhinoceros.mall.service.service.CartProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CartProductServiceImpl implements CartProductService{
    @Autowired
    private CartProductDao cartProductDao;
    private ProductDao productDao;
    /**
     * 获取用户的购物车中的商品信息
     * @param userId
     * @return
     */
    @Override
    public List<CartProduct> findByUserId(Long userId) {
        return cartProductDao.findByUserId(userId);
    }
//    @Override
//    public List<Product> findByProductId(Long productId) {
//        return productDao.findByProductId(productId);
//    }
}

