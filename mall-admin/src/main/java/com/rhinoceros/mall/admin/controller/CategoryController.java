package com.rhinoceros.mall.admin.controller;

import com.rhinoceros.mall.core.pojo.Category;
import com.rhinoceros.mall.service.service.CategoryService;
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
@RequestMapping("/category")
public class CategoryController {

    //定义要调用的逻辑业务对象
    @Autowired
    private CategoryService categoryService;

    /**
     * 通过id查询商品分类
     * @param id
     * @return
     */
    @RequestMapping
    @ResponseBody
    public Category findById(@RequestParam(value = "id") Long id){
        return categoryService.findById(id);
    }
    /**
     * 获取所有商品分类列表的方法
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/list")
    public List<Category> getList(@RequestParam(value = "id", required = false) Long id) {
        List<Category> categories=null;
        if (id == null) {
            categories = categoryService.findRootCategories();
        } else {
            categories = categoryService.findChildrenById(id);
        }

        return categories;
    }

    @ResponseBody
    @RequestMapping("/add")
    public Category add(Category category) {
        return categoryService.add(category);
    }

//    @ResponseBody
//    @RequestMapping("/delete")
//    public Category delete(Category category){
//        return categoryService.fcategory);
//    }

}
