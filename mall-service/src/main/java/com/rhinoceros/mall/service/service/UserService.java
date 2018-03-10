package com.rhinoceros.mall.service.service;

import com.rhinoceros.mall.core.dto.LoginUserDto;
import com.rhinoceros.mall.core.dto.RegisterUserDto;
import com.rhinoceros.mall.core.dto.ResetPasswordDto;
import com.rhinoceros.mall.core.dto.RetrievePasswordDto;
import com.rhinoceros.mall.core.po.Product;
import com.rhinoceros.mall.core.po.User;
import org.springframework.mail.MailSender;

/**
 * 用户业务逻辑接口
 */
public interface UserService {

    /**
     * 用户注册
     *
     * @param userDto
     */
    void register(RegisterUserDto userDto);

    /**
     * 用户登录
     *
     * @param userDto
     * @return
     */
    User login(LoginUserDto userDto);

    /**
     * 找回密码登陆提示邮箱是否已经注册
     * @param retrievePasswordDto
     */
    void retrievePassword(RetrievePasswordDto retrievePasswordDto);

    /**
     * 重置密码
     * @param resetPasswordDto
     */
    void resetPassword(ResetPasswordDto resetPasswordDto);

    /**
     * 根据id获取用户
     * @param userId
     * @return
     */
    User findById(Long userId);

    void sendSimpleEmail(String emailText);
    MailSender getMailSender();

    void updateSelectionById(ResetPasswordDto resetPasswordDto);
}
