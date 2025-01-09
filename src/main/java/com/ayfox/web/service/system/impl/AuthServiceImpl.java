package com.ayfox.web.service.system.impl;

import cn.hutool.core.util.StrUtil;
import com.ayfox.web.common.constant.BmsConstant;
import com.ayfox.web.common.constant.UserConstant;
import com.ayfox.web.common.exception.BusinessException;
import com.ayfox.web.common.exception.ErrorCode;
import com.ayfox.web.common.exception.ThrowUtils;
import com.ayfox.web.manager.auth.StpKit;
import com.ayfox.web.model.entity.system.User;
import com.ayfox.web.model.enums.UserRoleEnum;
import com.ayfox.web.model.vo.system.user.LoginUserVO;
import com.ayfox.web.service.system.AuthService;
import com.ayfox.web.service.system.UserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import jakarta.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;


/**
 * 权限服务实现
 *
 * @author tenyon
 * @date 2025/1/6
 */
@Service
public class AuthServiceImpl implements AuthService {
    @Resource
    private UserService userService;

    Logger logger = LoggerFactory.getLogger(AuthServiceImpl.class);

    @Override
    public long register(String userAccount, String userPassword, String checkPassword) {
        // 1. 校验
        if (StrUtil.hasBlank(userAccount, userPassword, checkPassword)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "参数为空");
        }
        if (userAccount.length() < 4) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "用户账号过短");
        }
        if (userPassword.length() < 5 || checkPassword.length() < 5) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "用户密码过短");
        }
        // 密码和校验密码相同
        if (!userPassword.equals(checkPassword)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "两次输入的密码不一致");
        }
        synchronized (userAccount.intern()) {
            // 1.账户不能重复
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("userAccount", userAccount);
            long count = userService.count(queryWrapper);
            if (count > 0) {
                throw new BusinessException(ErrorCode.PARAMS_ERROR, "账号重复");
            }
            // 2.加密
            String encryptPassword = DigestUtils.md5DigestAsHex((BmsConstant.ENCRYPT_SALT + userPassword).getBytes());
            // 3.插入数据
            User user = new User();
            user.setUserAccount(userAccount);
            user.setUserPassword(encryptPassword);
            user.setUserName("游客123");
            user.setUserRole(UserRoleEnum.USER.getValue());
            boolean saveResult = userService.save(user);
            if (!saveResult) {
                throw new BusinessException(ErrorCode.SYSTEM_ERROR, "注册失败，数据库错误");
            }
            return user.getId();
        }
    }

    @Override
    public LoginUserVO login(String userAccount, String userPassword) {
        // 1. 校验
        if (StrUtil.hasBlank(userAccount, userPassword)) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "参数为空");
        }
        if (userAccount.length() < 4) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "账号错误");
        }
        if (userPassword.length() < 5) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "密码错误");
        }
        // 2. 加密
        String encryptPassword = DigestUtils.md5DigestAsHex((BmsConstant.ENCRYPT_SALT + userPassword).getBytes());
        // 查询用户是否存在
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userAccount", userAccount);
        queryWrapper.eq("userPassword", encryptPassword);
        User user = userService.getOne(queryWrapper);
        // 用户不存在
        if (user == null) {
            logger.info("user login failed, userAccount cannot match userPassword");
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "用户不存在或密码错误");
        }
        // 3. 记录用户的登录态
        StpKit.SYSTEM.login(user.getId());
        StpKit.SYSTEM.getSession().set(UserConstant.USER_LOGIN_STATE, user);
        return userService.getLoginUserVO(user);
    }

    /**
     * 获取当前登录用户
     *
     * @return
     */
    @Override
    public User getLoginUser() {
        // 先判断是否已登录
        ThrowUtils.throwIf(!StpKit.SYSTEM.isLogin(), ErrorCode.NOT_LOGIN_ERROR);
        Object userObj = StpKit.SYSTEM.getSession().get(UserConstant.USER_LOGIN_STATE);
        User currentUser = (User) userObj;
        ThrowUtils.throwIf(!StpKit.SYSTEM.isLogin(), ErrorCode.NOT_LOGIN_ERROR);
        if (currentUser == null || currentUser.getId() == null) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }
        // 从数据库查询（追求性能的话可以注释，直接走缓存）
//        long userId = currentUser.getId();
//        currentUser = userService.getById(userId);
//        if (currentUser == null) {
//            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
//        }
        return currentUser;
    }

    @Override
    public boolean logout() {
        ThrowUtils.throwIf(!StpKit.SYSTEM.isLogin(), ErrorCode.NOT_LOGIN_ERROR);
        // 移除登录态
        StpKit.SYSTEM.getSession().removeTokenSign(UserConstant.USER_LOGIN_STATE);
        StpKit.SYSTEM.logout();
        return true;
    }

}
