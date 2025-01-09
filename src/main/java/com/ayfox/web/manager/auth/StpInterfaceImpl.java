package com.ayfox.web.manager.auth;

import cn.dev33.satoken.stp.StpInterface;
import cn.hutool.core.util.StrUtil;
import com.ayfox.web.common.exception.BusinessException;
import com.ayfox.web.common.exception.ErrorCode;
import com.ayfox.web.model.entity.system.User;
import com.ayfox.web.service.system.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.awt.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * sa-token
 *
 * @author yovvis
 * @date 2025/1/4
 */
@Component
public class StpInterfaceImpl implements StpInterface {

    @Autowired
    private UserService userService;

    /**
     * 返回一个账号所拥有的权限码集合
     */
    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        return null;
    }

    /**
     * 返回一个账号所拥有的角色标识集合 (权限与角色可分开校验)
     */
    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        // 本 list 仅做模拟，实际项目中要根据具体业务逻辑来查询角色
        List<String> list = new ArrayList<String>();
        list.add("admin");
        list.add("super-admin");
        return list;
    }
}
