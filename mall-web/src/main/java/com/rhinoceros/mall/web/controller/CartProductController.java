package com.rhinoceros.mall.web.controller;

import com.rhinoceros.mall.core.pojo.CartProduct;
import com.rhinoceros.mall.core.pojo.Product;
import com.rhinoceros.mall.core.pojo.User;
import com.rhinoceros.mall.core.vo.ProductVo;
import com.rhinoceros.mall.service.service.CartProductService;
import com.rhinoceros.mall.service.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;

@Controller
public class CartProductController {
    @Autowired
    private CartProductService cartProductService;
    @Autowired
    private  ProductService productService;


    /**
     * 浏览购物车商品信息
     */
    @RequestMapping("/cart/list")
    public String cart( Model model,HttpSession session){
        User user = (User) session.getAttribute(LoginController.USERNAME);
        if(user==null){
            return "redirect:/login";
        }
        List<CartProduct> cartProducts = cartProductService.findByUserId(user.getId());
        List<ProductVo> products = new LinkedList<ProductVo>();
        for(int i=0;i<cartProducts.size();i++){
            Long tempID=cartProducts.get(i).getProductId();
            ProductVo product = productService.findProductVoById(tempID);
            products.add(product);
        }
        model.addAttribute("products",products);
        model.addAttribute("cartProducts",cartProducts);
        return "cart";
    }
    @RequestMapping("/cart/count")
    @ResponseBody
    public  Integer countByCartProductId(@RequestParam("number")Integer number,@RequestParam("pid") Long pid,HttpSession session){
        User user = (User) session.getAttribute(LoginController.USERNAME);
        if (user==null){
            return -1;
        }
        Integer storNum = cartProductService.updateByCartProductId(pid,number);
        return storNum;
    }
    /**
     * 删除购物车商品信息
     * @param cid
     */
    @ResponseBody
    @RequestMapping("/cart/delete")
    public String deleteCartProducts(@RequestParam("cid") Long cid ){
       cartProductService.deleteByCartProductId(cid);
        return "success";
    }


    /**
     * 添加购物车商品
     * @param pid
     * @param num
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping({"/cart/add"})
    public String addToCartProduct(
            @RequestParam("pid") Long pid,
            @RequestParam("num") Integer num,
            HttpSession session
    ){
        User user = (User) session.getAttribute(LoginController.USERNAME);
        if(user==null){
            return "redirect:/login";
        }
        cartProductService.addProduct(pid,user.getId(),num);
        return "success";
    }

}
