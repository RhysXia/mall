package com.rhinoceros.mall.web.controller;

import com.rhinoceros.mall.core.pojo.User;
import com.rhinoceros.mall.service.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class TestController {

    @Autowired
    private UserService userService;

    @RequestMapping("/test11")
    public ModelAndView test() {

        List<User> users = userService.findAll();

        ModelAndView modelAndView = new ModelAndView("/test");
        modelAndView.addObject("users", users);
        return modelAndView;
    }
}
