package com.rhinoceros.mall.admin.controller;

import com.rhinoceros.mall.core.pojo.Product;
import com.rhinoceros.mall.core.pojo.ProductDescription;
import com.rhinoceros.mall.core.query.PageQuery;
import com.rhinoceros.mall.service.service.ProductService;
import com.rhinoceros.mall.web.support.web.annotation.PageDefault;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 创建商品控制器
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    //定义要调用的逻辑业务对象
    @Autowired
    private ProductService productService;

    /**
     *定义方法找到商品并转换为json格式返回
     * ?page=1&size=10&sort=saleNum,DESC/ASC&sort=price,DESC
     * @param pageQuery
     * @param categoryId
     * @return
     */
    @ResponseBody
    @RequestMapping("/list")
    public List<Product> productList(@PageDefault(required = false) PageQuery pageQuery, @RequestParam(value = "categoryId") Long categoryId) {
        List<Product> productList = productService.findDeepByCategoryId(categoryId, pageQuery);
        return productList;
    }

    /**
     * 显示商品
     *
     * @return
     */
    @RequestMapping
    public String showProduct() {
        return "include/product";
    }

    /**
     * 通过回传的id查找商品描述信息
     */
    @ResponseBody
    @RequestMapping("/description.json")
    public ProductDescription findDescriptionById(@RequestParam(value="id") Long id){
        return productService.findDescriptionById(id);
    }

}
