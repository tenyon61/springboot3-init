package com.ayfox.web.service.system;


import com.ayfox.web.model.entity.system.User;
import com.ayfox.web.model.vo.system.user.LoginUserVO;

/**
 * 权限服务
 *
 * @author tenyon
 * @date 2025/1/6
 */
public interface AuthService {

    /**
     * 用户登录
     *
     * @param userAccount  用户账户
     * @param userPassword 用户密码
     * @return 脱敏后的用户信息
     */
    LoginUserVO login(String userAccount, String userPassword);

    /**
     * 用户注册
     *
     * @param userAccount   用户账户
     * @param userPassword  用户密码
     * @param checkPassword 校验密码
     * @return 新用户 id
     */
    long register(String userAccount, String userPassword, String checkPassword);

    /**
     * 获取当前登录用户
     *
     * @return
     */
    User getLoginUser();

    /**
     * 用户注销
     *
     * @return
     */
    boolean logout();

}
