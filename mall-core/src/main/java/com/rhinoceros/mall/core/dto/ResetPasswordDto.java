package com.rhinoceros.mall.core.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
@Getter
@Setter
public class ResetPasswordDto {


    private String secret;

    //重置登陆密码
    @NotBlank(message = "重置登陆密码不能为空")
    @Size(min=6,max=20,message = "密码长度不少于6位且不大于20位")
    private String password;
    //确认登陆密码
    private String rePassword;
    //验证码
    @NotBlank(message = "验证码不能为空")
    private String code;

}
