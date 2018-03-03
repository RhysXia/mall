package com.rhinoceros.mall.core.dto;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

/**
 * 登录进行交互的实体
 */
@Getter
@Setter
public class LoginUserDto {

    @NotBlank(message = "用户名不能为空")
    @Size(min=6 ,max= 20 ,message = "用户长度输入在6-20位之间")
    private String username;
    @Size(min=6 ,max= 20 ,message = "密码长度在6-20位之间")
    private String password;
}