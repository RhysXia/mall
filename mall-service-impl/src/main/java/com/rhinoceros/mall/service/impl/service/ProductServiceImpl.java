package com.rhinoceros.mall.service.impl.service;


import com.rhinoceros.mall.core.po.Product;
import com.rhinoceros.mall.core.query.PageQuery;
import com.rhinoceros.mall.dao.dao.ProductDao;
import com.rhinoceros.mall.manager.manager.ProductManager;
import com.rhinoceros.mall.service.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author Rhys Xia
 */
@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;

    @Autowired
    private ProductManager productManager;


    /**
     * 根据商品id获取商品信息，并封装成商品展示信息对象
     *
     * @param id 商品id号
     * @return 商品信息展示对象
     */
    @Transactional
    @Override
    public Product findById(Long id) {
        return productDao.findById(id);
    }

    @Transactional
    @Override
    public List<Product> findDeepByCategoryId(Long categoryId, PageQuery pageQuery) {
        return productManager.findDeepByCategoryId(categoryId, pageQuery);
    }

    /**
     * 找寻商品的方法
     *
     * @param pageQuery
     * @return
     */
    @Transactional
    @Override
    public List<Product> findAll(PageQuery pageQuery) {
        return productDao.findAll(pageQuery);
    }


}
