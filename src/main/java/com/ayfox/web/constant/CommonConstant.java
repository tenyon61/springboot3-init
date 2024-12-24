package com.ayfox.web.constant;

/**
 * 通用常量
 */
public interface CommonConstant {

    /**
     * 升序
     */
    String SORT_ORDER_ASC = "ascend";

    /**
     * 降序
     */
    String SORT_ORDER_DESC = " descend";

    /**
     * 1
     */
    Integer ONE = 1;

    /**
     * 0
     */
    Integer ZERO = 0;

    /**
     * 10
     */
    Integer TEN = 10;

    /**
     * 6
     */
    Integer six = 6;

    /**
     * 12
     */
    Integer twelve = 12;

    /**
     * 加密盐
     */
    String ENCRYPT_SALT = "ayfox";

    /**
     * 密码的正则
     */
    String REGEX_PASSWORD = "^(?=.*\\d)(?=.*[a-zA-Z])[\\da-zA-Z~!@#$^&*_.]{8,18}$";

    /**
     * 1分钟的过期时间 ms
     */
    Integer EXPIRES_ONE_MIN = 60000;

    /**
     * 1天过期时间 ms
     */
    Integer EXPIRES_ONE_DAY = EXPIRES_ONE_MIN * 60 * 24;

    /**
     * 1天过期时间 s
     */
    Integer TIME_SECONDS_DAY = EXPIRES_ONE_DAY / 1000;

}
