package com.rhinoceros.mall.service.service;
/* created at 10:02 PM 3/17/2018  */

import com.rhinoceros.mall.core.po.Order;

import java.io.InputStream;
import java.util.Map;

public interface PayService {

    /**
     * 付款
     *
     * @param order
     * @return
     */
    String toPay(Order order);

    /**
     * 支付回调处理
     *
     * @param parameter
     * @param inputStream
     * @return
     */
    Long payBack(Map<String, String[]> parameter, InputStream inputStream);

}