package com.rhinoceros.mall.web.controller;

import com.rhinoceros.mall.core.dto.LoginUserDto;
import com.rhinoceros.mall.core.pojo.User;
import com.rhinoceros.mall.service.impl.exception.UserException;
import com.rhinoceros.mall.service.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@Controller
public class LoginController {

    public static final String USERNAME = "user";
    @Autowired
    private UserService userService;

    /**
     * 登录页面展示
     *
     * @return
     */
    @RequestMapping("/login")
    public String login(HttpSession session) {
        // 用户已登录，直接返回首页
        if (session.getAttribute(USERNAME) != null) {
            return "redirect:/index";
        }
        return "login";
    }

    /**
     * 登录表单提交
     *
     * @param userDto
     * @param br
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/loginSubmit")
    public String login(@Validated @ModelAttribute("loginUser") LoginUserDto userDto, BindingResult br, HttpSession session, Model model, HttpServletResponse response, HttpServletRequest request) {
        // 用户已登录，直接返回首页
        if (session.getAttribute(USERNAME) != null) {
            return "redirect:/index";
        }
        // 检查用户输入是否规范，不规范则返回到登录页面
        if (br.hasErrors()) {
            model.addAttribute("error", br.getFieldError().getDefaultMessage());
            return "login";
        }

        //检查输入的用户是否存在，存在则跳转到到主页面，不存在则返回到登录页面
        try {
            User user = userService.login(userDto);
            //创建Cookie
            Cookie nameCookie=new Cookie("name", user.getUsername());
            Cookie pswCookie=new Cookie("psw",user.getPassword());
            //设置Cookie的父路径
            nameCookie.setPath(request.getContextPath()+"/");
            pswCookie.setPath(request.getContextPath()+"/");

            //获取是否保存Cookie
            String rememberMe=request.getParameter("rember");
            if(rememberMe==null || rememberMe.equals(false)){//不保存Cookie
                nameCookie.setMaxAge(0);
                pswCookie.setMaxAge(0);
            }else{//保存Cookie的时间长度，单位为秒
                nameCookie.setMaxAge(7*24*60*60);
                pswCookie.setMaxAge(7*24*60*60);
            }
            //加入Cookie到响应头
            response.addCookie(nameCookie);
            response.addCookie(pswCookie);

            //将用户信息放入session
            session.setAttribute(USERNAME, user);
            return "redirect:/index";
        } catch (UserException e) {
            model.addAttribute("error", e.getMessage());
            return "login";
        }
    }
        /**
         * 退出登录
         * @param userDto
         * @param httpSession
         * @return
         */
    @RequestMapping("/logout")
    public String logout(LoginUserDto userDto,HttpSession httpSession){
        //删除用户的session信息
        httpSession.removeAttribute(USERNAME);
        return "redirect:/index";
    }
}
