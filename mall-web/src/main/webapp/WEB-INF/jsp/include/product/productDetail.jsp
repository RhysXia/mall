
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

	
<div class="productDetailDiv" >
	<div class="productDetailTopPart">
		<a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
		<a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span class="productDetailTopReviewLinkNumber">${productVo.product.commentNum}</span> </a>
	</div>
	
	<div>
        ${productVo.description}
    </div>

	<%--<div class="productParamterPart">

				<div class="productParamter">产品参数：</div>
		
		<div class="productParamterList">
			<c:forEach items="${productVo.params}" var="productItem">
				<span>${productItem.key}:  ${productItem.value} </span>
			</c:forEach>
		</div>
		<div style="clear:both"></div>
	</div>
	
	<div class="productDetailImagesPart">

		<c:forEach items="${productVo.descriptionImagesUrls}" var="pi">
			<img src="${pi}">
		</c:forEach>
	</div>--%>
</div>

