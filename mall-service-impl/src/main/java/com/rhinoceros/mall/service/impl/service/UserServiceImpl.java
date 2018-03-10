package com.rhinoceros.mall.service.impl.service;

import com.rhinoceros.mall.core.dto.LoginUserDto;
import com.rhinoceros.mall.core.dto.RegisterUserDto;
import com.rhinoceros.mall.core.dto.ResetPasswordDto;
import com.rhinoceros.mall.core.dto.RetrievePasswordDto;
import com.rhinoceros.mall.core.enumeration.Gender;
import com.rhinoceros.mall.core.enumeration.UserStatus;
import com.rhinoceros.mall.core.po.User;
import com.rhinoceros.mall.core.utils.SecurityUtils;
import com.rhinoceros.mall.dao.dao.UserDao;
import com.rhinoceros.mall.service.impl.exception.common.ParameterIsNullException;
import com.rhinoceros.mall.service.impl.exception.user.*;
import com.rhinoceros.mall.service.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
@Slf4j
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    /**
     * 用户注册，注册失败抛出{@link UserException}
     *
     * @param userDto
     */
    @Transactional
    @Override
    public void register(RegisterUserDto userDto) {
        //设置变量获取注册时输入的用户名
        String username = userDto.getUsername();
        //设置变量获取注册时输入的邮箱
        String email = userDto.getEmail();

        if (username == null) {
            log.info("用户名不能为null");
            throw new ParameterIsNullException("用户名不能为null");
        }
        //通过输入的用户名查询数据库
        User user = userDao.findByUsername(username);
        //如果用户已存在，程序抛出异常
        if (user != null) {
            log.info("用户已经存在");
            throw new UserHasFoundException("用户已经存在");
        }

        if (email == null) {
            log.info("邮箱不能为null");
            throw new ParameterIsNullException("邮箱不能为null");
        }
        //通过输入的邮箱查询数据库
        user = userDao.findByEmail(email);
        //如果用户已存在，程序抛出异常
        if (user != null) {
            log.info("邮件已经注册过");
            throw new EmailHasFoundException("邮箱已经注册过");
        }

        //创建用户
        User u = new User();

        //录入用户名
        u.setUsername(username);
        //录入登陆密码(加密)
        u.setPassword(SecurityUtils.encrypt(userDto.getPassword()));
        //初始邮件设置为空
        u.setEmail(userDto.getEmail());
        //注册时昵称默认使用用户名
        u.setNickname(userDto.getUsername());
        //初始性别初始为空
        u.setGender(Gender.UNKNOWN);
        //初始电话为空
        u.setTelephone(null);
        //初始生日为空
        u.setBirthday(null);
        //初始头像为空
        u.setAvatar(null);
        //记录注册时间
        u.setCreateAt(new Date());
        //上次登陆时间为空
        u.setLastLoginAt(null);
        //上次登陆ip地址为空
        u.setLastLoginIp(null);
        //设置用户状态为激活
        u.setStatus(UserStatus.ACTIVATED);
        //将用户信息录入数据库
        userDao.add(u);
    }


    /**
     * 用户登录，登录失败抛出{@link UserException}
     *
     * @param userDto
     * @return user 登录成功返回的用户信息
     */
    @Transactional
    @Override
    public User login(LoginUserDto userDto) {
        String username = userDto.getUsername();
        if (username == null) {
            log.info("用户名不能为null");
            throw new ParameterIsNullException("用户名不能为null");
        }
        //根据用户名从dao中查询用户信息
        User user = userDao.findByUsername(username);
        //判断用户是否存在,不存在则返回null
        if (user == null) {
            log.info("用户不存在");
            throw new UserNotFoundException("用户不存在");
        }
        // 用户存在，比较密码是否匹配，如果不匹配，则抛出异常
        if (!user.getPassword().equals(SecurityUtils.encrypt(userDto.getPassword()))) {
            log.info("密码输入错误");
            throw new PsaawordNotMatchException("密码输入错误");
        }

        //更新用户登陆信息
        Date date = new Date();
        User u = new User();
        u.setId(user.getId());
        u.setLastLoginIp(userDto.getIp());
        u.setLastLoginAt(date);
        //保存到数据库
        userDao.updateSelectionById(u);

        user.setLastLoginAt(date);
        user.setLastLoginIp(userDto.getIp());
        //返回用户信息
        return user;
    }

    @Override
    public void retrievePassword(RetrievePasswordDto retrievePasswordDto) {
        //通过输入的邮箱查询数据库
        User user = userDao.findByEmail(retrievePasswordDto.getEmail());
        //如果用户不存在，程序抛出异常
        if (user == null) {
            log.info("该邮箱还未注册");
            throw new EmailHasFoundException("该邮箱还未注册");
        }
    }

    public void resetPassword(ResetPasswordDto resetPasswordDto) {

    }

    @Override
    public User findById(Long userId) {
        return userDao.findById(userId);
    }

    private JavaMailSenderImpl mailSender = null;
    public MailSender getMailSender() {
        if(mailSender == null){
            mailSender = new JavaMailSenderImpl();
            mailSender.setHost("smtp.163.com");//指定用来发送Email的邮件服务器主机名
            mailSender.setPort(25);//默认端口，标准的SMTP端口
            mailSender.setUsername("mytestlong@163.com");//用户名
            mailSender.setPassword("feilong770");//密码
        }
        return mailSender;
    }

    /**
     * 根据用户名查找用户
     * @param resetPasswordDto
     */
    @Transactional
    @Override
    public void updateSelectionById(ResetPasswordDto resetPasswordDto) {
        String email = SecurityUtils.encode(resetPasswordDto.getSecret());
        User user = userDao.findByEmail(email);
        if(user == null){
            log.info("用户名不存在");
            throw new UserNotFoundException("用户名不存在");
        }
        String password = resetPasswordDto.getPassword();
        user.setPassword(SecurityUtils.encrypt(password));
        userDao.updateSelectionById(user);
    }

    public void sendSimpleEmail(String text){
        System.out.println("邮件发送开始");
        SimpleMailMessage message = new SimpleMailMessage();//消息构造器
        message.setFrom("mytestlong@163.com");//发件人
        message.setTo("969564376@qq.com");//收件人
        message.setSubject("MySendMail");//主题
        message.setText(text);//正文
        MailSender sender = getMailSender();
        getMailSender().send(message);
        System.out.println("邮件发送完毕");
    }

}
