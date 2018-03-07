<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>


<script>
var deleteOrder = false;
var deleteOrderid = 0;

$(function(){
	$("a[orderStatus]").click(function(){
		var orderStatus = $(this).attr("orderStatus");
		if('all'==orderStatus){
			$("table[orderStatus]").show();	
		}
		else{
			$("table[orderStatus]").hide();
			$("table[orderStatus="+orderStatus+"]").show();			
		}
		
		$("div.orderType div").removeClass("selectedOrderType");
		$(this).parent("div").addClass("selectedOrderType");
	});
	
	$("a.deleteOrderLink").click(function(){
		deleteOrderid = $(this).attr("oid");
		deleteOrder = false;
		$("#deleteConfirmModal").modal("show");
	});
	
	$("button.deleteConfirmButton").click(function(){
		deleteOrder = true;
		$("#deleteConfirmModal").modal('hide');
	});	
	
	$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
		if(deleteOrder){
			var page="foredeleteOrder";
			$.post(
				    page,
				    {"oid":deleteOrderid},
				    function(result){
						if("success"==result){
							$("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
						}
						else{
							location.href="login.jsp";
						}
				    }
				);
			
		}
	})		
	
	$(".ask2delivery").click(function(){
		var link = $(this).attr("link");
		$(this).hide();
		page = link;
		$.ajax({
			   url: page,
			   success: function(result){
				alert("卖家已秒发，刷新当前页面，即可进行确认收货")
			   }
			});
		
	});
});

</script>
	
<div class="boughtDiv">
	<div class="orderType">
		<div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
		<div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
		<div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
		<div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
		<div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
		<div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
	</div>
	<div style="clear:both"></div>
	<div class="orderListTitle">
		<table class="orderListTitleTable">
			<tr>
				<td>宝贝</td>
				<td width="100px">单价</td>
				<td width="100px">数量</td>
				<td width="120px">实付款</td>
				<td width="100px">交易操作</td>
			</tr>
		</table>
	
	</div>
	
	<div class="orderListItem">
		<c:forEach items="${orderListVos}" var="o">
			<table class="orderListItemTable" orderStatus="${o.order.status}" oid="${o.order.id}"><%--oid不知道干吗用--%>
				<tr class="orderListItemFirstTR">
					<td colspan="2">
					<b><fmt:formatDate value="${o.order.createAt}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
					<span>订单号: ${o.order.identifier}
					</span>
					</td>
					<td  colspan="2"><img width="13px" src="img/site/orderItemTmall.png">民生商城</td>
					<td colspan="1">
						<a class="wangwanglink" href="#nowhere">
							<div class="orderItemWangWangGif"></div>
						</a>
						
					</td>
					<td class="orderItemDeleteTD">
						<a class="deleteOrderLink" oid="${o.order.id}" href="#nowhere">
							<span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
						</a>
						
					</td>
				</tr>
				<c:forEach items="${o.orderProductVos}" var="oi" varStatus="st">
					<tr class="orderItemProductInfoPartTR" >
						<td class="orderItemProductInfoPartTD"><img width="80" height="80" src="${oi.productVo.firstImageUrl}"></td>
						<td class="orderItemProductInfoPartTD">
							<div class="orderListItemProductLinkOutDiv">
								<a href="${pageContext.request.contextPath}/product?pid=${oi.productVo.product.id}">${oi.productVo.product.name}</a>
								<div class="orderListItemProductLinkInnerDiv">
											<img src="${pageContext.request.contextPath}/static/img/site/creditcard.png" title="支持信用卡支付">
											<img src="${pageContext.request.contextPath}/static/img/site/7day.png" title="消费者保障服务,承诺7天退货">
											<img src="${pageContext.request.contextPath}/static/img/site/promise.png" title="消费者保障服务,承诺如实描述">
								</div>
							</div>
						</td>
						<td  class="orderItemProductInfoPartTD" width="100px">
						
							<div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.productVo.product.price}" minFractionDigits="2"/></div>
							<div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.productVo.product.discount}" minFractionDigits="2"/></div>
		
		
						</td>
						<td align="center" class="orderItemProductInfoPartTD" width="100px">
							<span class="orderListItemNumber" >${oi.num}</span>
						</td>

						<c:if test="${st.count==1}">
							<%--<td valign="top" rowspan="${fn:length(o.orderProductVos)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
								<span class="orderListItemNumber">${oi.num}</span>
							</td>--%>

							<td valign="top" rowspan="${fn:length(o.orderProductVos)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
								<div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.order.totalPrice}"/></div>
								<div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
							</td>
							<td valign="top" rowspan="${fn:length(o.orderProductVos)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
								<c:if test="${o.order.status=='SHIPPED' }">
									<a href="foreconfirmPay?oid=${o.id}">
										<button class="orderListItemConfirm">确认收货</button>
									</a>
								</c:if>
								<c:if test="${o.order.status=='WAIT_PAY' }">
									<a href="forealipay?oid=${o.id}&total=${o.total}">
										<button class="orderListItemConfirm">付款</button>
									</a>								
								</c:if>
								
								<c:if test="${o.order.status=='PAYED' }">
									<span>待发货</span>
<%-- 									<button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">催卖家发货</button> --%>
									
								</c:if>

								<c:if test="${o.order.status=='WAIT_COMMENT' }">
									<a href="forereview?oid=${o.id}">
										<button  class="orderListItemReview">评价</button>
									</a>
								</c:if>
							</td>						
						</c:if>
					</tr>
				</c:forEach>		
				
			</table>
		</c:forEach>
		
	</div>
	
</div>