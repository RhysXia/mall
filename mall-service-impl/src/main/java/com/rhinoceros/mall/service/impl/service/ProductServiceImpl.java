package com.rhinoceros.mall.service.impl.service;

/* created at 4:12 PM 2/28/2018  */

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhinoceros.mall.core.pojo.Product;
import com.rhinoceros.mall.core.query.PageQuery;
import com.rhinoceros.mall.core.vo.ProductVo;
import com.rhinoceros.mall.dao.dao.DescriptionDao;
import com.rhinoceros.mall.dao.dao.ProductDao;
import com.rhinoceros.mall.service.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private DescriptionDao descriptionDao;

    /**
     * 根据商品id获取商品信息，并封装成商品展示信息对象
     *
     * @param id 商品id号
     * @return 商品信息展示对象
     */
    @Override
    public ProductVo findProductVoById(Long id) {
        Product product = productDao.findById(id);
        ProductVo productVo = new ProductVo();
        /*String params = product.getParams();
        try {
            if (params != null) {
                ObjectMapper mapper = new ObjectMapper();
                Map<String, String> map = mapper.readValue(params, Map.class);
                productVo.setParams(map);
            }
        } catch (IOException e) {
            log.error(e.getMessage());
            e.printStackTrace();
        }*/
        //获取商品图片url数组
        productVo.setImagesUrls(product.getImageUrls().split(Product.IMAGE_SEPARATION));
        productVo.setFirstImageUrl(productVo.getImagesUrls()[0]);
        //获取商品详情
        productVo.setDescription(descriptionDao.findByProductId(product.getId()));
        productVo.setProduct(product);
        return productVo;

    }

    @Override
    public List<Product> findByCategoryId(Long categoryId, PageQuery pageQuery) {
        return productDao.findByCategoryId(categoryId, pageQuery);
    }

    /**
     * 找寻商品的方法
     * @param pageQuery
     * @return
     */
    @Override
    public List<Product> findProduct(PageQuery pageQuery) {
        return productDao.findProduct(pageQuery);
    }
}
