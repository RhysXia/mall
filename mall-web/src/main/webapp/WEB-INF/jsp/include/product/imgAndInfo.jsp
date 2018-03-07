<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@page import="com.rhinoceros.mall.core.pojo.User" %>
<%@ page import="com.rhinoceros.mall.web.controller.LoginController" %>

<%
    String userKey = LoginController.USERNAME;
    User user = (User) session.getAttribute(userKey);
%>

<script>

    $(function () {
        var isLogin =
        ${!empty user}
        var stock = ${productVo.product.storeNum};
        $(".productNumberSetting").keyup(function () {
            var num = $(".productNumberSetting").val();
            num = parseInt(num);
            if (isNaN(num))
                num = 1;
            if (num <= 0)
                num = 1;
            if (num > stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });

        $(".increaseNumber").click(function () {
            var num = $(".productNumberSetting").val();
            num++;
            if (num > stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });
        $(".decreaseNumber").click(function () {
            var num = $(".productNumberSetting").val();
            --num;
            if (num <= 0)
                num = 1;
            $(".productNumberSetting").val(num);
        });

        /*加入购物车按钮的逻辑*/
        $(".addCartButton").removeAttr("disabled");
        $(".addCartLink").click(function () {
                <c:if test="${not empty user}">

                var pid = ${productVo.product.id};
                var num = $(".productNumberSetting").val();
                var userId = ${user.id};
                var addCartpage = "${pageContext.request.contextPath}/cart/add";
                $.get(
                    addCartpage,
                    {"pid": pid, "num": num},
                    function (result) {
                        if ("success" == result) {
                            $(".addCartButton").html("已加入购物车");
                            $(".addCartButton").attr("disabled", "disabled");
                            $(".addCartButton").css("background-color", "lightgray");
                            $(".addCartButton").css("border-color", "lightgray");
                            $(".addCartButton").css("color", "black");

                        }
                        else {

                        }
                    })
                </c:if>
                <c:if test="${empty user}">

                location.href = "${pageContext.request.contextPath}/login";
                // $("#loginModal").modal('show');
                </c:if>
            }
        );
        return false;
    });
    $(".buyLink").click(function () {
        if (!isLogin) {
            $("#loginModal").modal('show');
            return false;
        }
        return true
    });

    $("button.loginSubmitButton").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();

        if (0 == username.length || 0 == password.length) {
            $("span.errorMessage").html("请输入账号密码");
            $("div.loginErrorMessageDiv").show();
            return false;
        }

        var page = "${pageContext.request.contextPath}/login";

        return true;
    });

    $("img.smallImage").mouseenter(function () {
        var bigImageURL = $(this).attr("bigImageURL");
        $("img.bigImg").attr("src", bigImageURL);
    });

    $("img.bigImg").load(
        function () {
            $("img.smallImage").each(function () {
                var bigImageURL = $(this).attr("bigImageURL");
                img = new Image();
                img.src = bigImageURL;

                img.onload = function () {
                    $("div.img4load").append($(img));
                };
            });
        }
    );


</script>

<div class="imgAndInfo">

    <div class="imgInimgAndInfo">
        <img src="${productVo.firstImageUrl}" class="bigImg">
        <div class="smallImageDiv">
            <c:forEach items="${productVo.imagesUrls}" var="pi">
                <img src="${pi}" bigImageURL="${pi}"
                     class="smallImage">
            </c:forEach>
        </div>
        <div class="img4load hidden"></div>
    </div>

    <div class="infoInimgAndInfo">

        <div class="productTitle">
            ${productVo.product.name}
        </div>
        <br>

        <div class="productPrice">
            <div class="productPriceDiv">
                <div class="originalDiv">
                    <span class="originalPriceDesc">价格</span>
                    <span class="originalPriceYuan">¥</span>
                    <span class="originalPrice">
                     
                        <fmt:formatNumber type="number" value="${productVo.product.price}" minFractionDigits="2"/>
                    </span>
                </div>
                <div class="promotionDiv">
                    <span class="promotionPriceDesc">促销价 </span>
                    <span class="promotionPriceYuan">¥</span>
                    <span class="promotionPrice">
                        <fmt:formatNumber type="number" value="${productVo.product.discount}" minFractionDigits="2"/>
                    </span>
                </div>
            </div>
        </div>
        <div class="productSaleAndReviewNumber">
            <div>销量 <span class="redColor boldWord"> ${productVo.product.saleNum }</span></div>
            <div>累计评价 <span class="redColor boldWord"> ${productVo.product.commentNum}</span></div>
        </div>
        <div class="productNumber">
            <span>数量</span>
            <span>

                <span class="productNumberSettingSpan">
                <input class="productNumberSetting" type="text" value="1">
                </span>
                <span class="arrow">
                    <a href="#nowhere" class="increaseNumber">
                    <span class="updown">
                            <img src="${pageContext.request.contextPath}/static/img/site/increase.png">
                    </span>
                    </a>

                    <span class="updownMiddle"> </span>
                    <a href="#nowhere" class="decreaseNumber">
                    <span class="updown">
                            <img src="${pageContext.request.contextPath}/static/img/site/decrease.png">
                    </span>
                    </a>

                </span>
                     
            件</span>
            <span>库存${productVo.product.storeNum}件</span>
        </div>
        <div class="serviceCommitment">
            <span class="serviceCommitmentDesc">服务承诺</span>
            <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
        </div>

        <div class="buyDiv">
            <a class="buyLink" href="${pageContext.request.contextPath}/forebuyone?pid=${productVo.product.id}">
                <button class="buyButton">立即购买</button>
            </a>
            <a href="#nowhere" class="addCartLink">
                <button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button>
            </a>
        </div>
    </div>

    <div style="clear:both"></div>

</div>