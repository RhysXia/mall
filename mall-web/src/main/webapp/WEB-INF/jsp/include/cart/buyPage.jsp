<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        var total = 0
        var singleSum = $(".orderItemUnitSum").attr("value");
        if (singleSum != null) {
            alert(singleSum);
            total = total + singleSum;
        }
        return total;
    })
    //选中某个地址列表
    $(function () {
        $(".showAddressInfo").click(function () {
            $(".showAddressInfo").each(function (index, item) {
                $(item).removeClass("address_selected")
            })
            $(this).addClass("address_selected")
            $("#address").val($(this).attr("addressId"))
        });
        //提交按钮,所有验证通过方可提交
        $('#order_form').submit(function () {
            var id = $("#address").val()
            if (!id && id.trim() === '') {
                $("#error_message span").html("请选择收货地址")
                $("#error_message").css('display', 'inline-block')
                return false;
            }
            return true;
        })
    })

</script>

<div class="buyPageDiv">
    <form id="order_form" action="${pageContext.request.contextPath}/order/confirm" method="post">
        <div class="buyFlow">
            <img class="pull-left" src="${pageContext.request.contextPath}/static/img/site/logo.jpg">
            <img class="pull-right" src="${pageContext.request.contextPath}/static/img/site/buyflow.png">
            <div style="clear:both"></div>
        </div>
        <div class="address">
            <div class="addressTip">选择收货地址</div>

            <div class="showTable">
                <c:forEach var="address" items="${addressList}" begin="0" end="4">
                    <div class="showAddressInfo" addressId="${address.id}">
                        <div>
                            <span class="addressStyle" type="text">${address.deliveryAddress}</span>
                            <span></span>
                            <span>(</span>
                            <span>${address.deliveryName}</span>
                            <span>收）</span>
                        </div>
                        <div>
                            <span name="detail" type="text">${address.detailAddress}</span>
                            <span name="phone" type="text">${address.phone}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <%--<div class="addressTip">新增收货地址</div>--%>
        </div>
        <%--<div>

            <table class="addressTable">
                <tr>
                    <td class="firstColumn">详细地址<span class="redStar">*</span></td>

                    <td><textarea name="address" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息"></textarea></td>
                </tr>
                <tr>
                    <td>邮政编码</td>
                    <td><input  name="post" placeholder="如果您不清楚邮递区号，请填写000000" type="text"></td>
                </tr>
                <tr>
                    <td>收货人姓名<span class="redStar">*</span></td>
                    <td><input  name="receiver"  placeholder="长度不超过25个字符" type="text"></td>
                </tr>
                <tr>
                    <td>手机号码 <span class="redStar">*</span></td>
                    <td><input name="mobile"  placeholder="请输入11位手机号码" type="text"></td>
                </tr>
            </table>

        </div>--%>
        <input type="hidden" id="address" name="addressId">
        <div class="productList">
            <div class="productListTip">确认订单信息</div>
            <table class="productListTable">
                <thead>
                <tr>
                    <th colspan="2" class="productListTableFirstColumn">
                        <img class="tmallbuy" src="${pageContext.request.contextPath}/static/img/site/tmallbuy.png">
                        <a class="marketLink" href="#nowhere">店铺</a>
                        <a class="wangwanglink" href="#nowhere"> <span class="wangwangGif"></span> </a>
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody class="productListTableTbody">
                <c:forEach items="${orderProducts}" var="orderProduct" varStatus="st">
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD"><img class="orderItemImg"
                                                          src="${orderProduct.productVo.firstImageUrl}"></td>
                        <td class="orderItemProductInfo">
                            <a href="${pageContext.request.contextPath}/product?pid=${orderProduct.productVo.product.id}"
                               class="orderItemProductLink">
                                    ${orderProduct.productVo.product.name}
                            </a>

                            <img src="${pageContext.request.contextPath}/static/img/site/creditcard.png"
                                 title="支持信用卡支付">
                            <img src="${pageContext.request.contextPath}/static/img/site/7day.png"
                                 title="消费者保障服务,承诺7天退货">
                            <img src="${pageContext.request.contextPath}/static/img/site/promise.png"
                                 title="消费者保障服务,承诺如实描述">

                        </td>
                        <td>

                            <span class="orderItemProductPrice">￥<fmt:formatNumber type="number"
                                                                                   value="${orderProduct.productVo.product.discount==null?orderProduct.productVo.product.price:orderProduct.productVo.product.discount}"
                                                                                   minFractionDigits="2"/></span>
                        </td>
                        <td>
                            <span class="orderItemProductNumber">${orderProduct.num}</span>
                        </td>
                        <td><span class="orderItemUnitSum">
						￥<fmt:formatNumber type="number"
                                           value="${orderProduct.num*(orderProduct.productVo.product.discount==null?orderProduct.productVo.product.price:orderProduct.productVo.product.discount)}"
                                           minFractionDigits="2"/>
						</span></td>
                        <c:if test="${st.count==1}">
                            <td rowspan="5" class="orderItemLastTD">
                                <label class="orderItemDeliveryLabel">
                                    <input type="radio" value="" checked="checked">
                                    普通配送
                                </label>

                                <select class="orderItemDeliverySelect" class="form-control">
                                    <option>快递 免邮费</option>
                                </select>

                            </td>
                        </c:if>
                    </tr>
                    <input type="hidden" name="orders[${st.index}].productId"
                           value="${orderProduct.productVo.product.id}">
                    <input type="hidden" name="orders[${st.index}].productNum" value="${orderProduct.num}">
                </c:forEach>

                </tbody>

            </table>
            <div class="orderItemSumDiv">
                <div class="pull-left">
                    <span class="leaveMessageText">给卖家留言:</span>
                    <span>
					<img class="leaveMessageImg"
                         src="${pageContext.request.contextPath}/static/img/site/leaveMessage.png">
				</span>
                    <span class="leaveMessageTextareaSpan">
					<textarea name="userMessage" class="leaveMessageTextarea"></textarea>
					<div>
						<span>还可以输入200个字符</span>
					</div>
				</span>
                </div>

                <span class="pull-right">店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${total}"
                                                                       minFractionDigits="2"/></span>
            </div>
        </div>

        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${total}"
                                                                       minFractionDigits="2"/></span>
            </div>
        </div>

        <input type="hidden" id="product" name="productId">
        <input type="hidden" id="orders" name="cartSubmit" value="${cartSubmit}">
        <div class="alert alert-danger" id="error_message" style="display: none;float:right;width: 200px;padding: 5px;margin: 0;">
            <span class="errorMessage" style="line-height: 20px;height: 20px"></span>
        </div>

        <div style="clear: both"></div>
        <div class="submitOrderDiv">
            <button type="submit" class="submitOrderButton">提交订单</button>
        </div>
    </form>
</div>