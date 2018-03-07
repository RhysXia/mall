package com.rhinoceros.mall.web.controller;

import com.rhinoceros.mall.core.pojo.Category;
import com.rhinoceros.mall.core.pojo.Product;
import com.rhinoceros.mall.core.query.PageQuery;
import com.rhinoceros.mall.core.vo.ProductVo;
import com.rhinoceros.mall.service.service.CategoryService;
import com.rhinoceros.mall.service.service.ProductService;
import com.rhinoceros.mall.web.support.web.annotation.PageDefault;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.LinkedList;
import java.util.List;

/**
 * @author Rhys Xia
 * <p>
 * 2018/03/05 09:57
 */
@Controller
public class CategoryController {

    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;

    /**
     * 获取商品分类下的商品列表
     *
     * @param cid    商品id
     * @param page   第几页
     * @param pageQuery 以什么字段进行排序
     *               field,DESC:按照field降序
     *               field,ASC:按照field升序排序
     * @param model
     * @return
     */
    @RequestMapping("/category")
    public String list(@RequestParam("cid") Long cid,
                       @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
                       @PageDefault PageQuery pageQuery,
                       Model model) {


        List<Product> products = productService.findByCategoryId(cid, new PageQuery(page, 10));

        List<ProductVo> productVos = new LinkedList<ProductVo>();
        for (Product p : products) {
            ProductVo productVo = new ProductVo();
            productVo.setProduct(p);
//            productVo.setDescriptionImagesUrls(p.getDescriptionImageUrls().split(Product.IMAGE_SEPARATION));
            productVo.setImagesUrls(p.getImageUrls().split(Product.IMAGE_SEPARATION));
            productVo.setFirstImageUrl(productVo.getImagesUrls()[0]);
            productVos.add(productVo);
        }

        model.addAttribute("products", productVos);

        Category category = categoryService.findById(cid);
        model.addAttribute("category", category);

        return "category";
    }
}
